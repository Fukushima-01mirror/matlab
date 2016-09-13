classdef ZCData_3dPlot_axis_timeShift_sudo_period < Analyze.Base
    %STANDARDDEVIATION ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q

    properties
    end

    methods
        function obj = ZCData_3dPlot_axis_timeShift_sudo_period(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
            
        end

        function runForPair(obj,user1 ,user2)

            Time_LowSampled = (20 : 20 : 60000);
           [period_zx, peak_zx] = Rhythm.setZeroCrossPeriodData(user1.zeroCrossData);
           [period_zx2, peak_zx2] = Rhythm.setZeroCrossPeriodData(user2.zeroCrossData);           
          
           %�@�[���N���X�Ԃł̃s�[�N�񐔎擾
           [zeroCrossTimes] = Rhythm.setZeroCrossCount(user1.zeroCrossData);
           [zeroCrossTimes2] = Rhythm.setZeroCrossCount(user2.zeroCrossData);

           filterdPul = Rhythm.BPfilter( user1.operatePulse.lowSampled);
           filterdPul2 = Rhythm.BPfilter( user2.operatePulse.lowSampled);
           [timeCorr, AB_Series0, AB_Series_Max] = Rhythm.AllCorr__func(filterdPul, filterdPul2, user2.time.lowSampled, 100);

            Y = abs( user1.zeroCrossData.nonlogAvtVelocity );
            dT = abs( period_zx(:,3) );
            dA = abs( peak_zx(:,3) );
            Y2 = abs( user2.zeroCrossData.nonlogAvtVelocity );
            dT2 = abs( period_zx2(:,3) );
            dA2 = abs( peak_zx2(:,3) );
            
            V_max = 50000;
            dT_max = 500;
            dA_max = 500;
            
                IndexZeroCross = find(zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2);
                IndexNonZeroCross = find( zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1);
                IndexZeroCross2 = find(zeroCrossTimes2(:,1)<2&zeroCrossTimes2(:,2)<2);
                IndexNonZeroCross2 = find( zeroCrossTimes2(:,1)>1|zeroCrossTimes2(:,2)>1);

            Y_zc  = Y(IndexZeroCross);      Y_nzc  = Y(IndexNonZeroCross);
            dT_zc = dT(IndexZeroCross);     dT_nzc = dT(IndexNonZeroCross);
            dA_zc = dA(IndexZeroCross);     dA_nzc = dA(IndexNonZeroCross);
            Y_zc2  = Y2(IndexZeroCross2);     Y_nzc2  = Y2(IndexNonZeroCross2);
            dT_zc2 = dT2(IndexZeroCross2);    dT_nzc2 = dT2(IndexNonZeroCross2);
            dA_zc2 = dA2(IndexZeroCross2);    dA_nzc2 = dA2(IndexNonZeroCross2);
                       
            %�@���ԃX�P�[���̐ݒ�            
            spotTime = 2000;    
            startTime =  500 * floor( user1.time.highSampled(1) /500);
            
            Num = 1;

            for spotTimeMax =  500 * floor( (spotTime+startTime) /500) : 500: 500 * ceil(user1.time.highSampled(end) /500);

                startIndex1 = find( user1.zeroCrossData.zeroCrossTime(IndexZeroCross) >= ( spotTimeMax - spotTime +1 ) ,1 ,'first');
                endIndex1 = find( user1.zeroCrossData.zeroCrossTime(IndexZeroCross) < spotTimeMax ,1 ,'last');  
                startIndex2 = find( user2.zeroCrossData.zeroCrossTime(IndexZeroCross2) >= ( spotTimeMax - spotTime +1 ) ,1 ,'first');
                endIndex2 = find( user2.zeroCrossData.zeroCrossTime(IndexZeroCross2) < spotTimeMax ,1 ,'last');  
          
                if length(Y_zc(startIndex1:endIndex1))>2

                    MonitorSize = [ 0, 0, 1200, 800];
                    set(gcf, 'Position', MonitorSize);
                         figure(1);

              %% �A�o�^�ʒu
                    subplot(3,10,[1:5]);
                    bar(Time_LowSampled, user1.avatarSword *500, 'b');
                    hold on
                        bar(Time_LowSampled, user2.avatarSword *500, 'g', 'EdgeColor', 'g');
                        
                        a = plot(   user1.time.lowSampled,  user1.avatarPosition.lowSampled , 'color', 'b');
                        
                        plot([spotTimeMax-spotTime+1 spotTimeMax-spotTime+1],[0 1000],'--k');
                        plot([spotTimeMax spotTimeMax],[0 1000],'--k');
                            
                        b = plot(user1.time.highSampled, ...
                            abs(user2.avatarPosition.highSampled - user1.avatarPosition.highSampled),'r:');
                        
                        c = plot( user2.time.highSampled , user2.avatarPosition.highSampled , 'g');
                    hold off
                    
                    if ~isempty(  findstr( char( obj.config.examType ) , '����'))
                        title( [ '�A�o�^�ʒu  ( ' char( obj.data.splitTimeInfo.state ) ' �j']);
                    end
                    legend([a,c,b],'1P', '2P' ,'����','Location', 'NorthWest'); 
                    xlabel('����t ms'); ylabel('�A�o�^�ʒu');
                    xlim([spotTimeMax-3500-2500+1250 spotTimeMax+3500-2500+1250]);    ylim([0 1000]);

               %% �R���g���[������Ƒ���
                    subplot(3,10,[11:15]);
                    
                    [haxes,hline1,hline2] = plotyy(user1.time.lowSampled, filterdPul,  timeCorr, AB_Series_Max(:,2));
 
                    set(hline1,'Color','b');
                    set(hline2,'Color','r');
                    set(haxes(1),'YColor','k');
                    set(haxes(2),'YColor','r');

                    hold( haxes(1),'on') % �d�ˏ������[�h�I��
                        plot([spotTimeMax-spotTime+1 spotTimeMax-spotTime+1],[-400 400],'--k');
                        plot([spotTimeMax spotTimeMax],[-400 400],'--k');

                        a = plot(   haxes(1), user2.time.highSampled,  user2.operatePulse.highSampled ,'g');

                    hold( haxes(2),'on') % �d�ˏ������[�h�I��
                        plot( haxes(2),[0 60000], [0.8 0.8],'k:');
                    hold off
                    
                    if ~isempty(  findstr( char( obj.config.examType ) , '����'))
                        title( [ '�R���g���[������g�`�@�ő告�ݑ���  ( ' char( obj.data.splitTimeInfo.state ) ' �j']);
                    end
                    axes(haxes(1))
                    xlabel('����t ms'); ylabel('�R���g���[������');
                    xlim([spotTimeMax-3500-2500+1250 spotTimeMax+3500-2500+1250]);    ylim([-400 400]);
                    set(gca,'YTick',[-400:200:400]);

                    axes(haxes(2))
                    legend([hline1,a,hline2],'1P','2P', '�ő告�ݑ���','Location', 'NorthWest');
                    xlabel('����t ms'); ylabel('�ő告�ݑ���');
                    xlim([spotTimeMax-3500-2500+1250 spotTimeMax+3500-2500+1250]);    ylim([0 1]);
                    set(gca,'YTick',[0:0.2:1]);
                
              %% ��������i�������j
%                     subplot(3,10,[11:15]);
%                     plot(   user1.zeroCrossData.zeroCrossTime, period_zx(:,1) , 'Color', 'b'); 
%                     
%                     hold on 
%                         plot([spotTimeMax-spotTime+1 spotTimeMax-spotTime+1],[0 1000],'--k');
%                         plot([spotTimeMax spotTimeMax],[0 1000],'--k');
% 
% %                         stTimeIndex = find(user1.time.highSampled > spotTimeMax-spotTime+1, 1, 'first');
% %                         endTimeIndex = find(user1.time.highSampled < spotTimeMax, 1, 'last');
% %                         plot(   user1.zeroCrossData.zeroCrossTime(stTimeIndex:endTimeIndex) ,...
% %                                     period_zx(stTimeIndex:endTimeIndex,1) );                     
%                         % ���������̕`��
%                         if strcmp( obj.config.examType, '�ǂ����܂����')...
%                                 || strcmp( obj.config.examType, '�ǂ����ގ���')
%                             plot(   obj.data.com.time,  obj.data.com.avatarPosition , 'Color' , [.6 .6 .6]);               
%                         elseif ~isempty(  findstr( char( obj.config.examType ) , '�Ǐ]'))
%                             plot(   obj.data.task.time,  obj.data.task.avatarPosition , 'Color' , [.6 .6 .6]);
%                             if ~isempty(  findstr( char( obj.config.examType ) , '�ڕW�Ǐ]'))
%                                 plot(   obj.data.task.time,  obj.data.task.avatarPosition-150 , 'Color' , [.6 .6 .6]);
%                             end
%                         elseif obj.config.isExistPlayer1 && obj.config.isExistPlayer2
%                             if obj.currentRunType == obj.runTypePlayer1
%                                 plot( user2.zeroCrossData.zeroCrossTime , period_zx2(:,1) , 'g');
%                             elseif obj.currentRunType == obj.runTypePlayer2
%                                 plot( user1.zeroCrossData.zeroCrossTime , period_zx(:,1) , 'g');
%                             end
%                         end
%                     hold off
%                     if ~isempty(  findstr( char( obj.config.examType ) , '����'))
%                         title( [ '�R���g���[������@�����i�������j  ( ' char( obj.data.splitTimeInfo.state ) ' �j']);
%                     end
%                     xlabel('����t ms'); ylabel('����T ms');
%                     xlim([spotTimeMax-3500-2500+1250 spotTimeMax+3500-2500+1250]);    ylim([0 600]);

              %% ����������i��T�j
                subplot(3,10,[21:25]);
      
                a = plot( user1.zeroCrossData.zeroCrossTime , abs(period_zx(:,3)) , 'b');
                    
                hold on 
                    plot([spotTimeMax-spotTime+1 spotTimeMax-spotTime+1],[0 1000],'--k');
                    plot([spotTimeMax spotTimeMax],[0 1000],'--k');
                    b = plot( user2.zeroCrossData.zeroCrossTime , abs(period_zx2(:,3)) , 'g');

                hold off

                title( [ '�R���g���[������@������  ( ' char( obj.data.splitTimeInfo.state ) ' �j']);
                legend([a,b],'1P', '2P','Location', 'NorthWest');
                xlabel('����t ms'); ylabel('��������T ms');
                xlim([spotTimeMax-3500-2500+1250 spotTimeMax+3500-2500+1250]);    ylim([0 600]);

                     %% ����U�����i��A�j
%                 subplot(3,10,[21:25]);
%                 
%                  if obj.currentRunType == obj.runTypePlayer1
%                     plot( user1.zeroCrossData.zeroCrossTime , abs(peak_zx(:,3)) , 'b');
%                  elseif obj.currentRunType == obj.runTypePlayer2
%                     plot( user2.zeroCrossData.zeroCrossTime , abs(peak_zx2(:,3)) , 'b');
%                  end
%                     
%                     hold on 
%                         plot([spotTimeMax-spotTime+1 spotTimeMax-spotTime+1],[0 1000],'--k');
%                         plot([spotTimeMax spotTimeMax],[0 1000],'--k');
% 
% %                         stTimeIndex = find(user1.time.highSampled > spotTimeMax-spotTime+1, 1, 'first');
% %                         endTimeIndex = find(user1.time.highSampled < spotTimeMax, 1, 'last');
% %                         plot(   user1.zeroCrossData.zeroCrossTime(stTimeIndex:endTimeIndex) ,...
% %                                     period_zx(stTimeIndex:endTimeIndex,1) );                     
%                         % ���������̕`��
%                         if strcmp( obj.config.examType, '�ǂ����܂����')...
%                                 || strcmp( obj.config.examType, '�ǂ����ގ���')
%                             plot(   obj.data.com.time,  obj.data.com.avatarPosition , 'Color' , [.6 .6 .6]);               
%                         elseif ~isempty(  findstr( char( obj.config.examType ) , '�Ǐ]'))
%                             plot(   obj.data.task.time,  obj.data.task.avatarPosition , 'Color' , [.6 .6 .6]);
%                             if ~isempty(  findstr( char( obj.config.examType ) , '�ڕW�Ǐ]'))
%                                 plot(   obj.data.task.time,  obj.data.task.avatarPosition-150 , 'Color' , [.6 .6 .6]);
%                             end
%                         elseif obj.config.isExistPlayer1 && obj.config.isExistPlayer2
%                             if obj.currentRunType == obj.runTypePlayer1
%                                 plot( user2.zeroCrossData.zeroCrossTime , abs(peak_zx2(:,3)) , 'g');
%                             elseif obj.currentRunType == obj.runTypePlayer2
%                                 plot( user1.zeroCrossData.zeroCrossTime , abs(peak_zx(:,3)) , 'g');
%                             end
%                         end
%                     hold off
%                     if ~isempty(  findstr( char( obj.config.examType ) , '����'))
%                         title( [ '�R���g���[������@������  ( ' char( obj.data.splitTimeInfo.state ) ' �j']);
%                     end
%                     xlabel('����t ms'); ylabel('��������T ms');
%                     xlim([spotTimeMax-3500-2500+1250 spotTimeMax+3500-2500+1250]);    ylim([0 600]);

                    %%  3D�U�z�}�i�PP�j
                    subplot(4,10,[7:10,17:20]);
                    
                    dTg_zc = mean(dT_zc(startIndex1:endIndex1));
                    dAg_zc = mean(dA_zc(startIndex1:endIndex1));
                    dT0_zc = dT_zc - dTg_zc;
                    dA0_zc = dA_zc - dAg_zc;
                    [coeff,score,latent,tsquare] = princomp( [dT_zc(startIndex1:endIndex1) dA_zc(startIndex1:endIndex1)] );
                    k1 = abs(coeff(1,1));            k2 = abs(coeff(2,1));
                    theta = atan(k2/k1) *180 / pi ;

                    X1 = k1 * dT0_zc(startIndex1:endIndex1) + k2 * dA0_zc(startIndex1:endIndex1);
                    [ fitParam_X1Y, fitLineR_X1Y, lineEdgePoint_X1Y] = Rhythm.approxiLine2d(X1, Y_zc(startIndex1:endIndex1) );
                    plot3( dT_zc , dA_zc, Y_zc,   'Marker','o', 'MarkerEdgeColor' , [.7 .7 .7] ,'LineStyle','none');
                    axis square
                    grid on
                    hold on
                        plot3( dT_nzc , dA_nzc, Y_nzc, 'Marker','.', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none');
                        plot3( dT_zc(startIndex1:endIndex1) , dA_zc(startIndex1:endIndex1), Y_zc(startIndex1:endIndex1),...
                            'Marker','o', 'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'LineStyle','none');
                        plot(  [ -150*coeff(1,1)+dTg_zc ; 150*coeff(1,1)+dTg_zc ] , [ -150*coeff(2,1)+dAg_zc ; 150*coeff(2,1)+dAg_zc ] , 'r')
                        plot(  [ -50*coeff(1,2)+dTg_zc ; 50*coeff(1,2)+dTg_zc ] , [ -50*coeff(2,2)+dAg_zc ; 50*coeff(2,2)+dAg_zc ] , 'r')
                        plot3( lineEdgePoint_X1Y(:,1)*k1 +dTg_zc , lineEdgePoint_X1Y(:,1)*k2 +dAg_zc, lineEdgePoint_X1Y(:,2) ,'r' ,'LineWidth',3 );

                        plot3( [ lineEdgePoint_X1Y(2,1)*k1+dTg_zc lineEdgePoint_X1Y(2,1)*k1+dTg_zc ] ,...
                               [ lineEdgePoint_X1Y(2,1)*k2+dAg_zc lineEdgePoint_X1Y(2,1)*k2+dAg_zc ] ,...
                               [0 lineEdgePoint_X1Y(2,2)] ,'--r' );              % ����
                    hold off
                    
                    xlabel('����g�` �����̍�');  ylabel('����g�` �U���̍�');  zlabel('�ΐ����Z�O�A�o�^����');
                    xlim([0,dT_max]);      ylim([0,dA_max]);         zlim([0 V_max]);

                    title(['Player1 time:' num2str(spotTimeMax-spotTime ) '�`'  num2str(spotTimeMax)  ]);
                    
                    %% �RD�U�z�}�i�QP�j
                    subplot(4,10,[27:30,37:40]);
                    
                    dTg_zc2 = mean(dT_zc2(startIndex2:endIndex2));
                    dAg_zc2 = mean(dA_zc2(startIndex2:endIndex2));
                    dT0_zc2 = dT_zc2 - dTg_zc2;
                    dA0_zc2 = dA_zc2 - dAg_zc2;
                    [coeff2,score2,latent2,tsquare2] = princomp( [dT_zc2(startIndex2:endIndex2) dA_zc2(startIndex2:endIndex2)] );
                    k1 = abs(coeff2(1,1));            k2 = abs(coeff2(2,1));
                    theta = atan(k2/k1) *180 / pi ;

                    X1 = k1 * dT0_zc2(startIndex2:endIndex2) + k2 * dA0_zc2(startIndex2:endIndex2);
                    [ fitParam_X1Y, fitLineR_X1Y, lineEdgePoint_X1Y] = Rhythm.approxiLine2d(X1, Y_zc(startIndex2:endIndex2) );
                    plot3( dT_zc2 , dA_zc2, Y_zc2,   'Marker','o', 'MarkerEdgeColor' , [.7 .7 .7] ,'LineStyle','none');
                    axis square
                    grid on
                    hold on
                        plot3( dT_nzc2 , dA_nzc2, Y_nzc2, 'Marker','.', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none');
                        plot3( dT_zc2(startIndex2:endIndex2) , dA_zc2(startIndex2:endIndex2), Y_zc2(startIndex2:endIndex2),...
                            'Marker','o', 'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'LineStyle','none');
                        plot(  [ -150*coeff(1,1)+dTg_zc2 ; 150*coeff(1,1)+dTg_zc2 ] , [ -150*coeff(2,1)+dAg_zc2 ; 150*coeff(2,1)+dAg_zc2 ] , 'r')
                        plot(  [ -50*coeff(1,2)+dTg_zc2 ; 50*coeff(1,2)+dTg_zc2 ] , [ -50*coeff(2,2)+dAg_zc2 ; 50*coeff(2,2)+dAg_zc2 ] , 'r')
                        plot3( lineEdgePoint_X1Y(:,1)*k1 +dTg_zc2 , lineEdgePoint_X1Y(:,1)*k2 +dAg_zc2, lineEdgePoint_X1Y(:,2) ,'r' ,'LineWidth',3 );

                        plot3( [ lineEdgePoint_X1Y(2,1)*k1+dTg_zc2 lineEdgePoint_X1Y(2,1)*k1+dTg_zc2 ] ,...
                               [ lineEdgePoint_X1Y(2,1)*k2+dAg_zc2 lineEdgePoint_X1Y(2,1)*k2+dAg_zc2 ] ,...
                               [0 lineEdgePoint_X1Y(2,2)] ,'--r' );              % ����
                    hold off
                    xlabel('����g�` �����̍�');  ylabel('����g�` �U���̍�');  zlabel('�ΐ����Z�O�A�o�^����');
                    xlim([0,dT_max]);      ylim([0,dA_max]);         zlim([0 V_max]);

                    title(['Player2 time:' num2str(spotTimeMax-spotTime ) '�`'  num2str(spotTimeMax)  ]);

      
              %% �ۑ�

                    % ����
                    drawnow             % drawnow������ƃA�j���[�V�����ɂȂ�
                    movmov(Num) = getframe(gcf,MonitorSize);           % �A�j���[�V�����̃t���[�����Q�b�g����

                    % �ꖇ���ۑ�
                    if ~isempty(strfind( char(obj.config.examType) , '�����ΐ�'))
                        obj.saveGraphWithNameToFolder( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_'  num2str(Num)]);
                    else
                        obj.saveGraphWithNameToFolder( [  num2str(Num) ]);
                    end

                    Num = Num +1;
                end
            end
            
            saveMovieName = obj.saveFilePath(['_' num2str( obj.data.splitTimeInfo.index ) '.avi']);
            movie2avi(movmov, saveMovieName,  'compression', 'None', 'fps', 2);

            %%      �ߎ��ʁ@�W���@�G�N�Z���f�[�^�o��  
% %             VIF = Rhythm.getVIF([X1_zc(:,3), X2_zc(:,3)]);
%             VIF = [ NaN ,NaN ];
%             outputTitle = { '�萔��' , '������' , '�U����',...
%                                     'VIF(������)', 'VIF�i�U�����j','�d����R','�d����R2' };
%             output = num2cell( [fitParam3' VIF fitR fitR2] );
%             
%             if ~isempty(strfind( char(obj.config.examType) , '�����ΐ�'))
%                 obj.outputAllToXlsWithName([ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state ] , output , outputTitle)
%             else
%                 obj.outputAllToXls(output , outputTitle);
%             end
            
        end

        
    end
end
