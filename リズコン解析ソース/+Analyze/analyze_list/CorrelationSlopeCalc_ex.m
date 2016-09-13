classdef CorrelationSlopeCalc_ex < Analyze.Base
    %STANDARDDEVIATION ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q
% �A�o�^���x�Ƃ̉�A����

    properties
    end

    methods
        function obj = CorrelationSlopeCalc_ex(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
            
            titleName = [ char(obj.config.examType) ,'��A�W�� ���n��ω�'];
%%      ���ԃX�P�[���̐ݒ�            
            spotTime = 1000;
            startTime = 5000;
            spotTimeSeries = spotTime+startTime : user.time.highSampled(end);
            spotTimeSeries = spotTimeSeries.';

                
%%      �f�[�^�Ǎ�
            if exist( obj.saveFilePath('.mat'), 'file' )
                load( obj.saveFilePath('.mat') );

            else
%%      �X���v�Z

                [period_zx1, peak_zx1] = Rhythm.setZeroCrossPeriodData(user.zeroCrossData);

                startIndex1 = find( user1.zeroCrossData.zeroCrossTime >= startTime ,1 ,'first');
                endIndex1 = find( user1.zeroCrossData.zeroCrossTime < spotTime+startTime ,1 ,'last');   
                fitLineFunc_peak1(1,:) = [0,0];            fitLineFunc_period1(1,:) = [0,0];
                fitLineR_peak1(1,:) = [0,0];            fitLineR_period1(1,:) = [0,0];
                i = 2;

                bNonPlot =1;
                r_fig = 3;  c_fig = 1;

                for spotTimeMax = spotTime+startTime+1 : user.time.highSampled(end)
                    %�@1P�̃[���N���X���Ԃ̃C���f�N�X���i�񂾂�C���֕���
                    if  startIndex1 ~= find( user.zeroCrossData.zeroCrossTime >= ( spotTimeMax - spotTime ) ,1 ,'first') ...
                              || endIndex1 ~= find( user.zeroCrossData.zeroCrossTime < spotTimeMax ,1 ,'last')

                       startIndex1 = find( user.zeroCrossData.zeroCrossTime >= ( spotTimeMax - spotTime ) ,1 ,'first');
                       endIndex1 = find( user.zeroCrossData.zeroCrossTime < spotTimeMax ,1 ,'last');  

                       k=2;
                       zeroCrossTimes1 = zeros(1,2);
                       % �[���N���X�Ԃ̃s�[�N�񐔁@C1:�g�`�̑O�����̃s�[�N�񐔁@C2:�㔼���̃s�[�N��
                       zeroCrossTimes1(1,1) = length( user.zeroCrossData.peak(startIndex1).time );
                       for IndexSeries = startIndex1+1 :endIndex1
                           zeroCrossTimes1(k,1) = length( user.zeroCrossData.peak(IndexSeries).time );
                           zeroCrossTimes1(k,2) = length( user.zeroCrossData.peak(IndexSeries-1).time );
                           k = k+1;
                       end

                       sizeZeroCross1 = find(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2);
                       %�@�s�[�N��2�񖢖��̂Ƃ��̃C���f�b�N�X
                       if length( sizeZeroCross1 ) < 2  %�@�s�[�N��2�񖢖��̃f�[�^����2�����̎������O
                            fitLineFunc_peak1(i,:) = [0,0];
                            fitLineFunc_period1(i,:) = [0,0];
                            fitLineR_peak1(i,:) = [0,0];
                            fitLineR_period1(i,:) = [0,0];
                       else

                            Y = abs( user.zeroCrossData.nonlogAvtVelocity( startIndex1:endIndex1 ) );
                            if bNonPlot == 0
                                subplot(r_fig,c_fig,1);
                                X = period_zx1( startIndex1:endIndex1 ,2 );
                                plot( X(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ,Y(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ,'ob');
                                hold on
                                    plot( X(zeroCrossTimes1(:,1)>1|zeroCrossTimes1(:,2)>1) ,Y(zeroCrossTimes1(:,1)>1|zeroCrossTimes1(:,2)>1) ,'sb');
                                hold off
                                xlabel('�[���N���X�_�Ԋu(1����)'); ylabel('�ΐ����Z�O�A�o�^����');
                                xlim([0,800]);         ylim([0 50000]);
                                title( titleName1 );
                            end

                            X = abs( period_zx1( startIndex1:endIndex1 ,3 ) );
                            fitLineFunc_period1(i,:) = polyfit(X(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ...
                                                         ,Y(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ,1);
                            [R,P] = corrcoef(X(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2),Y(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2));
                            fitLineR_period1(i,:) = [R(1,2), P(1,2)]; 

                            if bNonPlot == 0
                                subplot(r_fig,c_fig,3);
                                fitDataY = polyval( fitLineFunc_period1(i,:) , X );
                                plot( X(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ,Y(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ,'ob');
                                hold on
                                    plot( X(zeroCrossTimes1(:,1)>1|zeroCrossTimes1(:,2)>1) ,Y(zeroCrossTimes1(:,1)>1|zeroCrossTimes1(:,2)>1) ,'sb');
                                    plot( X, fitDataY ,'k');
                                hold off
                                xlabel('�[���N���X�_�Ԋu�̍��i�������j'); ylabel('�ΐ����Z�O�A�o�^����');
                                xlim([0,800]);         ylim([0 50000]);            
                            end

                            X = abs(peak_zx1( startIndex1:endIndex1 ,3) );
                            fitLineFunc_peak1(i,:) = polyfit(X(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ...
                                                         ,Y(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ,1);
                            [R,P] = corrcoef(X(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2),Y(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2));
                            fitLineR_peak1(i,:) = [R(1,2), P(1,2)]; 
                            if bNonPlot == 0
                                subplot(r_fig,c_fig,5);
                                fitDataY = polyval( fitLineFunc_peak1(i,:) , X );
                                plot( X(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ,Y(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ,'ob');
                                hold on
                                    plot( X(zeroCrossTimes1(:,1)>1|zeroCrossTimes1(:,2)>1) ,Y(zeroCrossTimes1(:,1)>1|zeroCrossTimes1(:,2)>1) ,'sb');
                                    plot( X, fitDataY ,'k');
                                hold off
                                xlabel('�s�[�N�l�̍�'); ylabel('�ΐ����Z�O�A�o�^����');
                                xlim([0,400]);            ylim([0 50000]);
                            end
                       end

                    else
                        fitLineFunc_peak1(i,:) = fitLineFunc_peak1(i-1,:);
                        fitLineFunc_period1(i,:) = fitLineFunc_period1(i-1,:);
                        fitLineR_peak1(i,:) = fitLineR_peak1(i-1,:);
                        fitLineR_period1(i,:) = fitLineR_period1(i-1,:);
                    end

                    i = i+1;

                    if mod(i, 1000) == 0
                    end
                    if i==50000

                    end

                end
            end

            
%%          �O���t�`��
            MonitorSize = [ 0, 0, 1200, 1000];
            set(gcf, 'Position', MonitorSize);
            
            subplot(2,1,1,'align')
            [haxes,hline1,hlineR1] = ...
                plotyy(spotTimeSeries, fitLineFunc_peak1(:,1), spotTimeSeries, fitLineR_peak1(:,1));
            set(hline1,'Color','b');            set(hlineR1,'Color','c');
            set(haxes(1),'YColor','k');            set(haxes(2),'YColor','k');
            
            axes(haxes(1))
                 xlabel('����'); ylabel('�s�[�N�l�̍��ƃA�o�^���x�̉�A�����̌X��');
                 ylim([-100 300]);
                 set(haxes(1),'YTick',[-100:100:300]);
            axes(haxes(2))
                 ylabel('���֌W��R');    ylim([-1 1]);
                 set(haxes(2),'YTick',[-1:0.5:1]);
            title(titleName,'Interpreter','none');
                
            subplot(2,1,2,'align')
            [haxes,hline1,hlineR1] = ...
                plotyy(spotTimeSeries, fitLineFunc_period1(:,1), spotTimeSeries, fitLineR_period1(:,1));
            set(hline1,'Color','b');            set(hlineR1,'Color','c');
            set(haxes(1),'YColor','k');            set(haxes(2),'YColor','k');
            
            axes(haxes(1))
                xlabel('����'); ylabel('��������̍��ƃA�o�^���x�̉�A�����̌X��');
                ylim([-100,300]);
                set(haxes(1),'YTick',[-100:100:300]);
            axes(haxes(2))
                 ylabel('���֌W��R');    ylim([-1,1]);
                 set(haxes(2),'YTick',[-1:0.5:1]);
            title(titleName,'Interpreter','none');
                
            obj.saveGraph();
            
        end
        
        function runForPair(obj,user1,user2)
            
            if obj.config.isExistPlayer1
                titleName1 = [ char(obj.config.examType) ,'��A�W�� ���n��ω�'];
            elseif obj.config.filenameForArchive
                titleName1 = [ char(obj.config.examType) ,'(',char(obj.config.archiveDataFileName ),') ��A�W�� ���n��ω�'];
            end

            if obj.config.isExistPlayer2
                titleName2 = [ char(obj.config.examType) ,'��A�W�� ���n��ω�'];
            elseif obj.config.filenameForArchive
                titleName2 = [ char(obj.config.examType) ,'(',char(obj.config.archiveDataFileName ),') ��A�W�� ���n��ω�'];
            end

            if obj.config.isExistArchiveData
                titleName = [ char(obj.config.examType) ,'(',char(obj.config.archiveDataFileName ),') ��A�W�� ���n��ω�'];
            else
                titleName = [ char(obj.config.examType) ,'��A�W�� ���n��ω�'];
            end
            
%%      ���ԃX�P�[���̐ݒ�            
            spotTime = 1000;
            startTime = 5000;
            spotTimeSeries = spotTime+startTime : user1.time.highSampled(end);
            spotTimeSeries = spotTimeSeries.';

                
%%      �f�[�^�Ǎ�
            if exist( obj.saveFilePath('.mat'), 'file' )
                load( obj.saveFilePath('.mat') );

            else
%%      �X���v�Z

                [period_zx1, peak_zx1] = Rhythm.setZeroCrossPeriodData(user1.zeroCrossData);
                [period_zx2, peak_zx2] = Rhythm.setZeroCrossPeriodData(user2.zeroCrossData);

                startIndex1 = find( user1.zeroCrossData.zeroCrossTime >= startTime ,1 ,'first');
                endIndex1 = find( user1.zeroCrossData.zeroCrossTime < spotTime+startTime ,1 ,'last');   
                startIndex2 = find( user2.zeroCrossData.zeroCrossTime > startTime , 1, 'first');
                endIndex2 = find( user2.zeroCrossData.zeroCrossTime < spotTime+startTime , 1, 'last');
                fitLineFunc_peak1(1,:) = [0,0];            fitLineFunc_period1(1,:) = [0,0];
                fitLineFunc_peak2(1,:) = [0,0];            fitLineFunc_period2(1,:) = [0,0];
                fitLineR_peak1(1,:) = [0,0];            fitLineR_period1(1,:) = [0,0];
                fitLineR_peak2(1,:) = [0,0];            fitLineR_period2(1,:) = [0,0];
                i = 2;
                
                bNonPlot =1;
                r_fig = 3;  c_fig = 2;
                
                for spotTimeMax = spotTime+startTime+1 : user1.time.highSampled(end)
                    %�@1P�̃[���N���X���Ԃ̃C���f�N�X���i�񂾂�C���֕���
                    if  startIndex1 ~= find( user1.zeroCrossData.zeroCrossTime >= ( spotTimeMax - spotTime ) ,1 ,'first') ...
                              || endIndex1 ~= find( user1.zeroCrossData.zeroCrossTime < spotTimeMax ,1 ,'last')

                       startIndex1 = find( user1.zeroCrossData.zeroCrossTime >= ( spotTimeMax - spotTime ) ,1 ,'first');
                       endIndex1 = find( user1.zeroCrossData.zeroCrossTime < spotTimeMax ,1 ,'last');  
                       
                       k=2;
                       zeroCrossTimes1 = zeros(1,2);
                       % �[���N���X�Ԃ̃s�[�N�񐔁@C1:�g�`�̑O�����̃s�[�N�񐔁@C2:�㔼���̃s�[�N��
                       zeroCrossTimes1(1,1) = length( user1.zeroCrossData.peak(startIndex1).time );
                       for IndexSeries = startIndex1+1 :endIndex1
                           zeroCrossTimes1(k,1) = length( user1.zeroCrossData.peak(IndexSeries).time );
                           zeroCrossTimes1(k,2) = length( user1.zeroCrossData.peak(IndexSeries-1).time );
                           k = k+1;
                       end
                       
                       sizeZeroCross1 = find(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2);
                       %�@�s�[�N��2�񖢖��̂Ƃ��̃C���f�b�N�X
                       if length( sizeZeroCross1 ) < 2  %�@�s�[�N��2�񖢖��̃f�[�^����2�����̎������O
                            fitLineFunc_peak1(i,:) = [0,0];
                            fitLineFunc_period1(i,:) = [0,0];
                            fitLineR_peak1(i,:) = [0,0];
                            fitLineR_period1(i,:) = [0,0];
                       else

                            Y = abs( user1.zeroCrossData.nonlogAvtVelocity( startIndex1:endIndex1 ) );
                            if bNonPlot == 0
                                subplot(r_fig,c_fig,1);
                                X = period_zx1( startIndex1:endIndex1 ,2 );
                                plot( X(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ,Y(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ,'ob');
                                hold on
                                    plot( X(zeroCrossTimes1(:,1)>1|zeroCrossTimes1(:,2)>1) ,Y(zeroCrossTimes1(:,1)>1|zeroCrossTimes1(:,2)>1) ,'sb');
                                hold off
                                xlabel('�[���N���X�_�Ԋu(1����)'); ylabel('�ΐ����Z�O�A�o�^����');
                                xlim([0,800]);         ylim([0 50000]);
                                title( titleName1 );
                            end

                            X = abs( period_zx1( startIndex1:endIndex1 ,3 ) );
                            fitLineFunc_period1(i,:) = polyfit(X(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ...
                                                         ,Y(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ,1);
                            [R,P] = corrcoef(X(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2),Y(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2));
                            fitLineR_period1(i,:) = [R(1,2), P(1,2)]; 

                            if bNonPlot == 0
                                subplot(r_fig,c_fig,3);
                                fitDataY = polyval( fitLineFunc_period1(i,:) , X );
                                plot( X(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ,Y(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ,'ob');
                                hold on
                                    plot( X(zeroCrossTimes1(:,1)>1|zeroCrossTimes1(:,2)>1) ,Y(zeroCrossTimes1(:,1)>1|zeroCrossTimes1(:,2)>1) ,'sb');
                                    plot( X, fitDataY ,'k');
                                hold off
                                xlabel('�[���N���X�_�Ԋu�̍��i�������j'); ylabel('�ΐ����Z�O�A�o�^����');
                                xlim([0,800]);         ylim([0 50000]);            
                            end

                            X = abs(peak_zx1( startIndex1:endIndex1 ,3) );
                            fitLineFunc_peak1(i,:) = polyfit(X(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ...
                                                         ,Y(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ,1);
                            [R,P] = corrcoef(X(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2),Y(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2));
                            fitLineR_peak1(i,:) = [R(1,2), P(1,2)]; 
                            if bNonPlot == 0
                                subplot(r_fig,c_fig,5);
                                fitDataY = polyval( fitLineFunc_peak1(i,:) , X );
                                plot( X(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ,Y(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ,'ob');
                                hold on
                                    plot( X(zeroCrossTimes1(:,1)>1|zeroCrossTimes1(:,2)>1) ,Y(zeroCrossTimes1(:,1)>1|zeroCrossTimes1(:,2)>1) ,'sb');
                                    plot( X, fitDataY ,'k');
                                hold off
                                xlabel('�s�[�N�l�̍�'); ylabel('�ΐ����Z�O�A�o�^����');
                                xlim([0,400]);            ylim([0 50000]);
                            end
                       end

                    else
                        fitLineFunc_peak1(i,:) = fitLineFunc_peak1(i-1,:);
                        fitLineFunc_period1(i,:) = fitLineFunc_period1(i-1,:);
                        fitLineR_peak1(i,:) = fitLineR_peak1(i-1,:);
                        fitLineR_period1(i,:) = fitLineR_period1(i-1,:);
                    end

                    %�@2P�̃[���N���X���Ԃ̃C���f�N�X���i�񂾂�C���֕���
                    if startIndex2 ~= find( user2.zeroCrossData.zeroCrossTime > ( spotTimeMax - spotTime ) , 1, 'first') ...
                            || endIndex2 ~= find( user2.zeroCrossData.zeroCrossTime < spotTimeMax , 1, 'last')

                        startIndex2 = find( user2.zeroCrossData.zeroCrossTime > ( spotTimeMax - spotTime ) , 1, 'first');
                        endIndex2 = find( user2.zeroCrossData.zeroCrossTime < spotTimeMax , 1, 'last');

                       k=2;
                       zeroCrossTimes2 = zeros(1,2);
                       zeroCrossTimes2(1,1) = length( user2.zeroCrossData.peak(startIndex2).time );
                       for IndexSeries = startIndex2+1 :endIndex2
                           zeroCrossTimes2(k,1) = length( user2.zeroCrossData.peak(IndexSeries).time );
                           zeroCrossTimes2(k,2) = length( user2.zeroCrossData.peak(IndexSeries-1).time );
                           k = k+1;
                       end
                       
                       sizeZeroCross2 = find(zeroCrossTimes2(:,1)<2&zeroCrossTimes2(:,2)<2);
                       if length( sizeZeroCross2 ) < 2
                            fitLineFunc_peak2(i,:) = [0,0];
                            fitLineFunc_period2(i,:) = [0,0];
                            fitLineR_peak2(i,:) = [0,0];
                            fitLineR_period2(i,:) = [0,0];
                       else

                           Y = abs( user2.zeroCrossData.nonlogAvtVelocity( startIndex2:endIndex2 ) );
                            if bNonPlot == 0
                                subplot(r_fig,c_fig,2);
                                X = abs( period_zx2( startIndex2:endIndex2 ,2) );
                                plot( X(zeroCrossTimes2(:,1)<2&zeroCrossTimes2(:,2)<2) ,Y(zeroCrossTimes2(:,1)<2&zeroCrossTimes2(:,2)<2) ,'og');
                                hold on
                                    plot( X(zeroCrossTimes2(:,1)>1|zeroCrossTimes2(:,2)>1) ,Y(zeroCrossTimes2(:,1)>1|zeroCrossTimes2(:,2)>1) ,'sg');
                                hold off
                                xlabel('�[���N���X�_�Ԋu(1����)'); ylabel('�ΐ����Z�O�A�o�^����');
                                xlim([0,600]);         ylim([0 50000]);
                                title( titleName2 );
                            end

                            X = abs( period_zx2( startIndex2:endIndex2 ,3) );
                            fitLineFunc_period2(i,:) = polyfit(X(zeroCrossTimes2(:,1)<2&zeroCrossTimes2(:,2)<2) ...
                                                            ,Y(zeroCrossTimes2(:,1)<2&zeroCrossTimes2(:,2)<2) ,1);
                            [R,P] = corrcoef(X(zeroCrossTimes2(:,1)<2&zeroCrossTimes2(:,2)<2),Y(zeroCrossTimes2(:,1)<2&zeroCrossTimes2(:,2)<2));
                            fitLineR_period2(i,:) = [R(1,2), P(1,2)]; 
                            if bNonPlot == 0
                                subplot(r_fig,c_fig,4);
                                fitDataY = polyval( fitLineFunc_period2(i,:) , X );
                                plot( X(zeroCrossTimes2(:,1)<2&zeroCrossTimes2(:,2)<2) ,Y(zeroCrossTimes2(:,1)<2&zeroCrossTimes2(:,2)<2) ,'og');
                                hold on
                                    plot( X(zeroCrossTimes2(:,1)>1|zeroCrossTimes2(:,2)>1) ,Y(zeroCrossTimes2(:,1)>1|zeroCrossTimes2(:,2)>1) ,'sg');
                                    plot( X, fitDataY ,'k');
                                hold off
                                xlabel('�[���N���X�_�Ԋu�̍��i�������j'); ylabel('�ΐ����Z�O�A�o�^����');
                                xlim([0,600]);         ylim([0 50000]);            
                            end

                            X = abs( peak_zx2( startIndex2:endIndex2 ,3 ) );
                            fitLineFunc_peak2(i,:) = polyfit(X(zeroCrossTimes2(:,1)<2&zeroCrossTimes2(:,2)<2) ...
                                                            ,Y(zeroCrossTimes2(:,1)<2&zeroCrossTimes2(:,2)<2) ,1);
                            [R,P] = corrcoef(X(zeroCrossTimes2(:,1)<2&zeroCrossTimes2(:,2)<2),Y(zeroCrossTimes2(:,1)<2&zeroCrossTimes2(:,2)<2));
                            fitLineR_peak2(i,:) = [R(1,2), P(1,2)]; 
                            if bNonPlot == 0
                                subplot(r_fig,c_fig,6);
                                fitDataY = polyval( fitLineFunc_peak2(i,:) , X );
                                plot( X(zeroCrossTimes2(:,1)<2&zeroCrossTimes2(:,2)<2) ,Y(zeroCrossTimes2(:,1)<2&zeroCrossTimes2(:,2)<2) ,'og');
                                hold on
                                    plot( X(zeroCrossTimes2(:,1)>1|zeroCrossTimes2(:,2)>1) ,Y(zeroCrossTimes2(:,1)>1|zeroCrossTimes2(:,2)>1) ,'sg');
                                    plot( X, fitDataY ,'k');
                                hold off
                                xlabel('�s�[�N�l�̍�'); ylabel('�ΐ����Z�O�A�o�^����');
                                xlim([0,400]);            ylim([0 50000]);
                            end
                       end

                    else
                        fitLineFunc_peak2(i,:) = fitLineFunc_peak2(i-1,:);
                        fitLineFunc_period2(i,:) = fitLineFunc_period2(i-1,:);
                        fitLineR_peak2(i,:) = fitLineR_peak2(i-1,:);
                        fitLineR_period2(i,:) = fitLineR_period2(i-1,:);
                    end

                    i = i+1;

                    if mod(i, 1000) == 0
                    end
                    if i==50000
                        
                    end

                end
    %%         �f�[�^�ۑ�
                name =  obj.saveFilePath('.mat');
                save( name, 'fitLineFunc_peak1' ,'fitLineR_peak1' ,'fitLineFunc_period1','fitLineR_period1', ...
                    'fitLineFunc_peak2', 'fitLineR_peak2', 'fitLineFunc_period2', 'fitLineR_period2');


            end
            
%%          �O���t�`��
            MonitorSize = [ 0, 0, 1200, 1000];
            set(gcf, 'Position', MonitorSize);
            
            
            subplot(2,1,1,'align')
            [haxes,hline1,hlineR1] = ...
                plotyy(spotTimeSeries, fitLineFunc_peak1(:,1), spotTimeSeries, fitLineR_peak1(:,1));
            set(hline1,'Color','b');            set(hlineR1,'Color','c');
            set(haxes(1),'YColor','k');            set(haxes(2),'YColor','k');
            
            hold( haxes(1),'on') % �X���@�d�ˏ������[�h�I��
                hline2 = plot(  haxes(1), spotTimeSeries, fitLineFunc_peak2(:,1),'Color', [0 0.5 0] );
            hold( haxes(2),'on') % ���֌W���@�d�ˏ������[�h�I��
                hlineR2 = plot(  haxes(2), spotTimeSeries, fitLineR_peak2(:,1),'g' );
            hold off
            
            axes(haxes(1))
                 xlabel('����'); ylabel('�s�[�N�l�̍��ƃA�o�^���x�̉�A�����̌X��');
                 ylim([-100 300]);
                 set(haxes(1),'YTick',[-100:100:300]);
            axes(haxes(2))
                 ylabel('���֌W��R');    ylim([-1 1]);
                 set(haxes(2),'YTick',[-1:0.5:1]);
            
            if obj.config.isExistPlayer1
                legName1 = char(obj.config.player1UserName);
            elseif obj.config.filenameForArchive
                legName1 = '�A�[�J�C�u';
            end
            if obj.config.isExistPlayer2
                legName2 = char(obj.config.player2UserName);
            elseif obj.config.filenameForArchive
                legName2 = '�A�[�J�C�u';
            end
            legend( [hline1,hline2], legName1, legName2 ,'Location','NorthEastOutside');
            title(titleName,'Interpreter','none');
                
            subplot(2,1,2,'align')
            [haxes,hline1,hlineR1] = ...
                plotyy(spotTimeSeries, fitLineFunc_period1(:,1), spotTimeSeries, fitLineR_period1(:,1));
            set(hline1,'Color','b');            set(hlineR1,'Color','c');
            set(haxes(1),'YColor','k');            set(haxes(2),'YColor','k');
            
            hold( haxes(1),'on') % �X���@�d�ˏ������[�h�I��
                hline2 = plot(  haxes(1), spotTimeSeries, fitLineFunc_period2(:,1),'Color',[0 0.5 0] );
            hold( haxes(2),'on') % ���֌W���@�d�ˏ������[�h�I��
                hlineR2 = plot(  haxes(2), spotTimeSeries, fitLineR_period2(:,1),'g' );
            hold off
                
            axes(haxes(1))
                xlabel('����'); ylabel('��������̍��ƃA�o�^���x�̉�A�����̌X��');
                ylim([-100,300]);
                set(haxes(1),'YTick',[-100:100:300]);
            axes(haxes(2))
                 ylabel('���֌W��R');    ylim([-1,1]);
                 set(haxes(2),'YTick',[-1:0.5:1]);
            legend( [hline1,hline2], legName1, legName2 ,'Location','NorthEastOutside');
            title(titleName,'Interpreter','none');
                
            obj.saveGraph();


%%      �G�N�Z���f�[�^�o��
            outputTitle = {'�s�[�N�l�̍��Ƃ̉�A�W�����ϒl(1P)','�W���΍�(1P)',...
                            '�s�[�N�l�̍��Ƃ̉�A�W�����ϒl(2P)','�W���΍�(2P)', ...
                            '�s�[�N�l�̍��Ƃ̉�A�W�� �ގ�����',...
                            '��������̍��Ƃ̉�A�W�����ϒl(1P)','�W���΍�(1P)',...
                            '��������̍��Ƃ̉�A�W�����ϒl(2P)','�W���΍�(2P)', ...
                            '��������̍��Ƃ̉�A�W�� �ގ�����'...
                            };
            slopePeakOutput = { mean( fitLineFunc_peak1(:,1) ), std( fitLineFunc_peak1(:,1) ) , ...
                                mean( fitLineFunc_peak2(:,1) ), std( fitLineFunc_peak2(:,1) ) };
            distSlopePeak = abs( fitLineFunc_peak1(:,1) - fitLineFunc_peak2(:,1));
            sameSlopePeakOutput = length( find( distSlopePeak < 10 ) )/60000;
            
            slopePeriodOutput = { mean( fitLineFunc_period1(:,1) ), std( fitLineFunc_period1(:,1) ) , ...
                                mean( fitLineFunc_period2(:,1) ), std( fitLineFunc_period2(:,1) ) };
            distSlopePeriod = abs( fitLineFunc_period1(:,1) - fitLineFunc_period2(:,1));
            sameSlopePeriodOutput = length( find( distSlopePeriod < 10 ) )/60000;
            
            output = horzcat( slopePeakOutput , sameSlopePeakOutput , slopePeriodOutput , sameSlopePeriodOutput );
            obj.outputAllToXls(output , outputTitle);

        end

    end
end
