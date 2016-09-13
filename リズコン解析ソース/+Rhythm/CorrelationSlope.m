function [fitLineFunc_peak, fitLineR_peak, fitLineFunc_period, fitLineR_period] ...
                = CorrelationSlope(obj, spotTime)

%%      ���ԃX�P�[���̐ݒ�            
startTime = 5000;
spotTimeSeries = spotTime+startTime : obj.time.highSampled(end);
spotTimeSeries = spotTimeSeries.';

%%      �X���v�Z

%�@�[���N���X�Ԃł̃s�[�N�񐔎擾
zeroCrossTimes = zeros(1,2);   %�@C1:�g�`�̑O�����̃s�[�N�񐔁@C2:�㔼���̃s�[�N��
zeroCrossTimes(1,1) = length( obj.zeroCrossData.peak(1).time );
for j = 2:length( obj.zeroCrossData.peak )
   zeroCrossTimes(j,1) = length(obj.zeroCrossData.peak(j).time );
   zeroCrossTimes(j,2) = length( obj.zeroCrossData.peak(j-1).time );
end

[period_zx1, peak_zx1] = Rhythm.setZeroCrossPeriodData(obj.zeroCrossData);

startIndex1 = find( obj.zeroCrossData.zeroCrossTime >= startTime ,1 ,'first');
endIndex1 = find( obj.zeroCrossData.zeroCrossTime < spotTime+startTime ,1 ,'last');   
fitLineFunc_peak(1,:) = [0,0];            fitLineFunc_period(1,:) = [0,0];
fitLineR_peak(1,:) = [0,0];            fitLineR_period(1,:) = [0,0];
i = 2;

bNonPlot =1;
r_fig = 3;  c_fig = 1;

for spotTimeMax = spotTime+startTime+1 : obj.time.highSampled(end)

    %�@�[���N���X���Ԃ̃C���f�N�X���i�񂾂�C���֕���
    if  startIndex1 ~= find( obj.zeroCrossData.zeroCrossTime >= ( spotTimeMax - spotTime ) ,1 ,'first') ...
              || endIndex1 ~= find( obj.zeroCrossData.zeroCrossTime < spotTimeMax ,1 ,'last')

       startIndex1 = find( obj.zeroCrossData.zeroCrossTime >= ( spotTimeMax - spotTime ) ,1 ,'first');
       endIndex1 = find( obj.zeroCrossData.zeroCrossTime < spotTimeMax ,1 ,'last');  

       %�@�[���N���X�Ԃł̃s�[�N�񐔎擾
       zeroCrossTimes_local = zeroCrossTimes( startIndex1:endIndex1 ,: );   %�@C1:�g�`�̑O�����̃s�[�N�񐔁@C2:�㔼���̃s�[�N��

       %�@�[���N���X���Ă��鎞�̃C���f�b�N�X
       IndexZeroCross = find(zeroCrossTimes_local(:,1)<2&zeroCrossTimes_local(:,2)<2);
       %�@�[���N���X���Ȃ����̃C���f�b�N�X
       IndexNonZeroCross = find( zeroCrossTimes_local(:,1)>1 | zeroCrossTimes_local(:,2)>1);
       
       %�@�s�[�N��2�񖢖��̃f�[�^����2�����̎������O
       if length( IndexZeroCross ) < 2  
            fitLineFunc_peak(i,:) = [0,0];
            fitLineFunc_period(i,:) = [0,0];
            fitLineR_peak(i,:) = [0,0];
            fitLineR_period(i,:) = [0,0];
       else
            MonitorSize = [ 0, 0, 400, 1000];
            set(gcf, 'Position', MonitorSize);
            Y = abs( obj.zeroCrossData.nonlogAvtVelocity( startIndex1:endIndex1 ) );
            if bNonPlot == 0
                figure(150);
                subplot(r_fig,c_fig,1);
                X = period_zx1( startIndex1:endIndex1 ,2 );
%                 plot( X(zeroCrossTimes_local(:,1)<2&zeroCrossTimes_local(:,2)<2) ,Y(zeroCrossTimes_local(:,1)<2&zeroCrossTimes_local(:,2)<2) ,'ob');
                plot( X(IndexZeroCross) ,Y(IndexZeroCross) ,'.b');
                hold on
%                     plot( X(zeroCrossTimes_local(:,1)>1|zeroCrossTimes_local(:,2)>1) ,Y(zeroCrossTimes_local(:,1)>1|zeroCrossTimes_local(:,2)>1) ,'sb');
                    plot( X(IndexNonZeroCross) ,Y(IndexNonZeroCross) ,'ob');
                hold off
                xlabel('�[���N���X�_�Ԋu(1����)'); ylabel('�ΐ����Z�O�A�o�^����');
                xlim([0,800]);         ylim([0 50000]);
%                 title( titleName1 );
            end

            X = abs( period_zx1( startIndex1:endIndex1 ,3 ) );
            fitLineFunc_period(i,:) = polyfit( X ,Y ,1);
            [R,P] = corrcoef( X,Y);
            fitLineR_period(i,:) = [R(1,2), P(1,2)]; 

            if bNonPlot == 0
                subplot(r_fig,c_fig,2);
                fitDataY = polyval( fitLineFunc_period(i,:) , X );
%                 plot( X(zeroCrossTimes_local(:,1)<2&zeroCrossTimes_local(:,2)<2) ,Y(zeroCrossTimes_local(:,1)<2&zeroCrossTimes_local(:,2)<2) ,'ob');
                plot( X(IndexZeroCross) ,Y(IndexZeroCross) ,'.b');
                hold on
%                     plot( X(zeroCrossTimes_local(:,1)>1|zeroCrossTimes_local(:,2)>1) ,Y(zeroCrossTimes_local(:,1)>1|zeroCrossTimes_local(:,2)>1) ,'sb');
                    plot( X(IndexNonZeroCross) ,Y(IndexNonZeroCross) ,'ob');
                    plot( X, fitDataY ,'k');
                hold off
                xlabel('�[���N���X�_�Ԋu�̍��i�������j'); ylabel('�ΐ����Z�O�A�o�^����');
                xlim([0,800]);         ylim([0 50000]);            
            end

            X = abs(peak_zx1( startIndex1:endIndex1 ,3) );
            fitLineFunc_peak(i,:) = polyfit( X ,Y ,1);
            [R,P] = corrcoef( X ,Y );
            fitLineR_peak(i,:) = [R(1,2), P(1,2)]; 
            if bNonPlot == 0
                subplot(r_fig,c_fig,3);
                fitDataY = polyval( fitLineFunc_peak(i,:) , X );
%                 plot( X(zeroCrossTimes_local(:,1)<2&zeroCrossTimes_local(:,2)<2) ,Y(zeroCrossTimes_local(:,1)<2&zeroCrossTimes_local(:,2)<2) ,'ob');
                plot( X(IndexZeroCross) ,Y(IndexZeroCross) ,'.b');
                hold on
%                     plot( X(zeroCrossTimes_local(:,1)>1|zeroCrossTimes_local(:,2)>1) ,Y(zeroCrossTimes_local(:,1)>1|zeroCrossTimes_local(:,2)>1) ,'sb');
                    plot( X(IndexNonZeroCross) ,Y(IndexNonZeroCross) ,'ob');
                    plot( X, fitDataY ,'k');
                hold off
                xlabel('�s�[�N�l�̍�'); ylabel('�ΐ����Z�O�A�o�^����');
                xlim([0,400]);            ylim([0 50000]);
            end
       end

    else
        fitLineFunc_peak(i,:) = fitLineFunc_peak(i-1,:);
        fitLineFunc_period(i,:) = fitLineFunc_period(i-1,:);
        fitLineR_peak(i,:) = fitLineR_peak(i-1,:);
        fitLineR_period(i,:) = fitLineR_period(i-1,:);
    end

    i = i+1;

    if mod(i, 1000) == 0
    end
    if i==50000

    end

end