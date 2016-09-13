classdef ZCData_3dPlot_axis_timeShift_Kaiki < Analyze.Base
    %STANDARDDEVIATION ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q

    properties
    end

    methods
        function obj = ZCData_3dPlot_axis_timeShift_Kaiki(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
           [period_zx, peak_zx] = Rhythm.setZeroCrossPeriodData(user.zeroCrossData);
           %�@�[���N���X�Ԃł̃s�[�N�񐔎擾
           [zeroCrossTimes] = Rhythm.setZeroCrossCount(user.zeroCrossData);
            
            Y = abs( user.zeroCrossData.nonlogAvtVelocity );
            dT = abs( period_zx(:,3) );
            dA = abs( peak_zx(:,3) );
            
            V_max = 50000;
            dT_max = 500;
            dA_max = 500;
            
            THETA = ones(1,60000);
            Exl = zeros(3000,1);
            
            if obj.currentRunType == obj.runTypePlayer1 ...
                    || ( obj.currentRunType == obj.runTypeArchive && obj.config.isExistPlayer1 )
                IndexZeroCross = find(zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2);
                IndexNonZeroCross = find( zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1);
            elseif obj.currentRunType == obj.runTypePlayer2 ...
                    || ( obj.currentRunType == obj.runTypeArchive && obj.config.isExistPlayer2 )
                IndexZeroCross = find(zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2 );
                IndexNonZeroCross = find( zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1);
            end

            Y_zc  = Y(IndexZeroCross);        Y_nzc  = Y(IndexNonZeroCross);
            dT_zc = dT(IndexZeroCross);     dT_nzc = dT(IndexNonZeroCross);
            dA_zc = dA(IndexZeroCross);     dA_nzc = dA(IndexNonZeroCross);

            %�@���ԃX�P�[���̐ݒ�            
            spotTime = 2000;    %  ���ԃX�P�[���̐ݒ� 
            %2000 �������牺��200�͂��ׂĂ��Ƃ��Ƃ�500
            startTime =  500 * floor( obj.data.player1.time.highSampled(1) /500) ;
            spotTimeSeries = spotTime+startTime : user.time.highSampled(end);
            spotTimeSeries = spotTimeSeries.';
            Num = 1;

            for spotTimeMax =  500 * floor( (spotTime+startTime) /500) : 500: 500 * ceil(user.time.highSampled(end) /500)

                %����������200�͂��ׂĂ��Ƃ���500
                startIndex1 = find( user.zeroCrossData.zeroCrossTime(IndexZeroCross) >= ( spotTimeMax - spotTime +1 ) ,1 ,'first');
                endIndex1 = find( user.zeroCrossData.zeroCrossTime(IndexZeroCross) < spotTimeMax ,1 ,'last');  

                if length(Y_zc(startIndex1:endIndex1))>2

                    MonitorSize = [ 0, 0, 1200, 800];
                    set(gcf, 'Position', MonitorSize);
                         figure(1);

                         %% �A�o�^�ʒu
                    subplot(3,4,[3 4])
                    plot(   user.time.lowSampled,  user.avatarPosition.lowSampled , 'Color', 'c'); 
                    hold on 
                        plot([spotTimeMax-spotTime+1 spotTimeMax-spotTime+1],[0 1000],'--k');
                        plot([spotTimeMax spotTimeMax],[0 1000],'--k');

                        stTimeIndex = find(user.time.highSampled > spotTimeMax-spotTime+1, 1, 'first');
                        endTimeIndex = find(user.time.highSampled < spotTimeMax, 1, 'last');
                        plot(   user.time.highSampled(stTimeIndex:endTimeIndex) ,...
                                    user.avatarPosition.highSampled(stTimeIndex:endTimeIndex) );                     
                        % ���������̕`��
                        if strcmp( obj.config.examType, '�ǂ����܂����')...
                                || strcmp( obj.config.examType, '�ǂ����ގ���')
                            plot(   obj.data.com.time,  obj.data.com.avatarPosition , 'Color' , [.6 .6 .6]);               
                        elseif ~isempty(  findstr( char( obj.config.examType ) , '�Ǐ]'))
                            plot(   obj.data.task.time,  obj.data.task.avatarPosition , 'Color' , [.6 .6 .6]);
                            if ~isempty(  findstr( char( obj.config.examType ) , '�ڕW�Ǐ]'))
                                plot(   obj.data.task.time,  obj.data.task.avatarPosition-150 , 'Color' , [.6 .6 .6]);
                            end
                        elseif obj.config.isExistPlayer1 && obj.config.isExistPlayer2
                            if obj.currentRunType == obj.runTypePlayer1
                                plot( obj.data.player2.time.highSampled , obj.data.player2.avatarPosition.highSampled , 'k:');
                            elseif obj.currentRunType == obj.runTypePlayer2
                                plot( obj.data.player1.time.highSampled , obj.data.player1.avatarPosition.highSampled , 'k:');
                            end
                        end
                    hold off
                    if ~isempty(  findstr( char( obj.config.examType ) , '����'))
                        title( [ '�A�o�^�ʒu  ( ' char( obj.data.splitTimeInfo.state ) ' �j']);
                    end
                    xlabel('����t ms'); ylabel('�A�o�^�ʒu');
                    xlim([0,60000]);    ylim([0 1000]);

                    %%  3D�U�z�}
                    subplot(3,4,[7 8 11 12])

                    dTg_zc = mean(dT_zc(startIndex1:endIndex1));
                    dAg_zc = mean(dA_zc(startIndex1:endIndex1));
                    dT0_zc = dT_zc - dTg_zc;
                    dA0_zc = dA_zc - dAg_zc;
                    [coeff,score,latent,tsquare] = princomp( [dT_zc(startIndex1:endIndex1) dA_zc(startIndex1:endIndex1)] );
                    k1 = abs(coeff(1,1));            k2 = abs(coeff(2,1));
                    theta = atan(k2/k1) *180 / pi ;

                    X1 = k1 * dT0_zc(startIndex1:endIndex1) + k2 * dA0_zc(startIndex1:endIndex1);
                    [ fitParam_X1Y, fitLineR_X1Y, lineEdgePoint_X1Y] = Rhythm.approxiLine2d(X1, Y_zc(startIndex1:endIndex1) );
%                     plot3( dT_zc , dA_zc, Y_zc,   'Marker','o', 'MarkerEdgeColor' , [.7 .7 .7] ,'LineStyle','none');
%                     axis square
%                     grid on
%                     hold on
%                         plot3( dT_nzc , dA_nzc, Y_nzc, 'Marker','.', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none');
%                         plot3( dT_zc(startIndex1:endIndex1) , dA_zc(startIndex1:endIndex1), Y_zc(startIndex1:endIndex1),...
%                             'Marker','o', 'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'LineStyle','none');
%                         plot(  [ -150*coeff(1,1)+dTg_zc ; 150*coeff(1,1)+dTg_zc ] , [ -150*coeff(2,1)+dAg_zc ; 150*coeff(2,1)+dAg_zc ] , 'r')
%                         plot(  [ -50*coeff(1,2)+dTg_zc ; 50*coeff(1,2)+dTg_zc ] , [ -50*coeff(2,2)+dAg_zc ; 50*coeff(2,2)+dAg_zc ] , 'r')
%                         plot3( lineEdgePoint_X1Y(:,1)*k1 +dTg_zc , lineEdgePoint_X1Y(:,1)*k2 +dAg_zc, lineEdgePoint_X1Y(:,2) ,'r' ,'LineWidth',3 );
% 
%                         plot3( [ lineEdgePoint_X1Y(2,1)*k1+dTg_zc lineEdgePoint_X1Y(2,1)*k1+dTg_zc ] ,...
%                                [ lineEdgePoint_X1Y(2,1)*k2+dAg_zc lineEdgePoint_X1Y(2,1)*k2+dAg_zc ] ,...
%                                [0 lineEdgePoint_X1Y(2,2)] ,'--r' );              % ����
%                     hold off
%                     xlabel('����g�` �����̍�');  ylabel('����g�` �U���̍�');  zlabel('�ΐ����Z�O�A�o�^����');
%                     xlim([0,dT_max]);      ylim([0,dA_max]);         zlim([0 V_max]);
% 
%                     if ~isempty(strfind( char(obj.config.examType) , '�����ΐ�'))
%                          title({['GameTime: ' num2str(obj.data.player1.time.highSampled(1)) '�`' num2str( obj.data.player1.time.highSampled(end))];...
%                              ['time:' num2str(spotTimeMax-spotTime ) '�`'  num2str(spotTimeMax)  ]});
%                     else
%                         title({['time:' num2str(spotTimeMax-spotTime ) '�`'  num2str(spotTimeMax)  ]});
%                     end

                    %%  �������ƃA�o�^�����̑���

%                     subplot(3,4,1);
                    [ fitParam1, fitLineR1, lineEdgePoint] = Rhythm.approxiLine2d(dT_zc(startIndex1:endIndex1), Y_zc(startIndex1:endIndex1) );
%                     plot( dT_zc  ,Y_zc,  'Marker','o', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none' );
%                     hold on
%                         plot( dT_nzc  ,Y_nzc,'Marker','.', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none' );
%                         plot( dT_zc(startIndex1:endIndex1) ,  Y_zc(startIndex1:endIndex1),...
%                             'Marker','o', 'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'LineStyle','none');
%                         plot(lineEdgePoint(:,1), lineEdgePoint(:,2), 'r')
%                     hold off
%                     grid on
%                     xlabel('����g�` �����̍�'); ylabel('�ΐ����Z�O�A�o�^����');
%                     xlim([0,dT_max]);         ylim([0 V_max]);
%                     title({['V =  (' num2str( fitParam1(1) ) ') * dPeriod  + (' num2str(fitParam1(2)) ')']; ...
%                             ['����W���F' num2str( fitLineR1(1)^2)]} );
%                     axis square

                    %% �@�U�����ƃA�o�^�����̑���
                    subplot(3,4,5);
                    [ fitParam2, fitLineR2, lineEdgePoint] = Rhythm.approxiLine2d(dA_zc(startIndex1:endIndex1), Y_zc(startIndex1:endIndex1) );
%                     plot( dA_zc  ,Y_zc ,  'Marker','o', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none' );
%                     hold on
%                         plot( dA_nzc  ,Y_nzc,'Marker','.', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none' );
%                         plot(  dA_zc(startIndex1:endIndex1), Y_zc(startIndex1:endIndex1),...
%                             'Marker','o', 'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'LineStyle','none');
%                         plot(lineEdgePoint(:,1), lineEdgePoint(:,2), 'r')
%                     hold off
%                     grid on
%                     xlabel('����g�`�@�U���̍�'); ylabel('�ΐ����Z�O�A�o�^����');
%                     xlim([0,dA_max]);            ylim([0 V_max]);
%                     title({['V =  (' num2str( fitParam2(1) ) ') * dPeak  + (' num2str(fitParam2(2)) ')']; ...
%                             ['���֌W���F' num2str( fitLineR2(1))]});
%                     axis square
% 
%                     %% �@�������ƐU�����̑���
%                     subplot(3,4,9);
%                     [ fitParam3, fitLineR3, lineEdgePoint] = Rhythm.approxiLine2d(dT_zc(startIndex1:endIndex1)  ,dA_zc(startIndex1:endIndex1) );
%                     plot( dT_zc  ,dA_zc , 'Marker','o', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none' );
%                     hold on
%                         plot(  [ -150*coeff(1,1)+dTg_zc ; 150*coeff(1,1)+dTg_zc ] , [ -150*coeff(2,1)+dAg_zc ; 150*coeff(2,1)+dAg_zc ] , 'r')
%                         plot(  [ -50*coeff(1,2)+dTg_zc ; 50*coeff(1,2)+dTg_zc ] , [ -50*coeff(2,2)+dAg_zc ; 50*coeff(2,2)+dAg_zc ] , 'r')
%                         plot( dT_nzc  ,dA_nzc,'Marker','.', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none' );
%                         plot( dT_zc(startIndex1:endIndex1) , dA_zc(startIndex1:endIndex1),...
%                             'Marker','o', 'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'LineStyle','none');
%                     hold off
%                     grid on
%                     xlabel('����g�` �����̍�');    ylabel('����g�`�@�U���̍�'); 
%                     
%                     xlim([0,dT_max]);            ylim([0,dA_max]);
%                     title({ ['���֌W���F' num2str( fitLineR3(1))]});
%                     axis square

                    %%  �����ϐ�X1�ƃA�o�^�����̑���
                    subplot(3,4,6);
                    alpha = fitParam_X1Y(1);   beta = fitParam_X1Y(2);
%                     plot( k1 * dT0_zc + k2 * dA0_zc  ,Y_zc  , 'Marker','o', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none');
%                     hold on
%                         plot( X1   ,Y_zc(startIndex1:endIndex1),...
%                             'Marker','o', 'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'LineStyle','none');
%                         plot(lineEdgePoint_X1Y(:,1), lineEdgePoint_X1Y(:,2), 'r')
%                     hold off
%                     grid on 
%                     axis square
%                     xlabel('X = k1*��T + k2*��A');    ylabel('�ΐ��ϊ��O�A�o�^���x'); 
%                     xlim([-dT_max/2,dT_max/2]);            ylim([0 V_max]);
%                     title({['V =  (' num2str( alpha ) ') * X  + (' num2str( beta ) ')']; ...
%                             ['����W��R^2' num2str( fitLineR_X1Y(1)^2)] });
%                     axis square
% 
%                     %%  �����ϐ�X1
%                     subplot(3,4,10);
%                     plot( dT0_zc , dA0_zc , 'Marker','o', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none');
%                     hold on
%                         plot( dT_nzc - mean(dT_zc(startIndex1:endIndex1)) , dA_nzc - mean(dT_zc(startIndex1:endIndex1)) ,'Marker','.', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none');
%                         plot( dT0_zc(startIndex1:endIndex1) , dA0_zc(startIndex1:endIndex1) ,...
%                             'Marker','o', 'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'LineStyle','none');
%                         plot(  [ -150*coeff(1,1) ; 150*coeff(1,1) ] , [ -150*coeff(2,1) ; 150*coeff(2,1) ] , 'r')
%                         plot(  [ -50*coeff(1,2) ; 50*coeff(1,2) ] , [ -50*coeff(2,2) ; 50*coeff(2,2) ] , 'r')
%                     hold off
%                     grid on
%                     axis square
%                     xlabel('����g�` �����̍��@��T');    ylabel('����g�`�@�U���̍��@��A'); 
%                     xlim([-dT_max/2,dT_max/2]);             xlim([-dA_max/2,dA_max/2]); 
%                     title({['k1 : ' num2str( decround(k1,3) ) ' , k2 : ' num2str( decround(k2,3) )]; ...
%                         ['�@\theta =  (' num2str( decround(theta,3) ) ')[degree]']});
                    
                    disp(spotTimeMax);
                    disp(spotTime);
                    THETA(1,spotTimeMax-spotTime+1:spotTimeMax)=decround(theta,3);
                    %PHI(1,spotTimeMax-spotTime+1:spotTimeMax)=alpha;
                    %VEL(1,spotTimeMax-spotTime:spotTimeMax)= Y_zc(startIndex1:endIndex1);
                    axis square               
                    %%

                    % ����
%                     drawnow             % drawnow������ƃA�j���[�V�����ɂȂ�
%                     movmov(Num) = getframe(gcf,MonitorSize);           % �A�j���[�V�����̃t���[�����Q�b�g����
% 
%                     % �ꖇ���ۑ�
%                     if ~isempty(strfind( char(obj.config.examType) , '�����ΐ�'))
%                         obj.saveGraphWithNameToFolder( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_'  num2str(Num)]);
%                     else
%                         obj.saveGraphWithNameToFolder( [  num2str(Num) ]);
%                     end

                    Num = Num +1;
                end
   
            end
%             
%             MonitorSize = [ 0, 0, 800, 800];
%             set(gcf, 'Position', MonitorSize);
%             a1 = subplot( 2,1,1 );
%             plot(1:1:60000,THETA(1,:),'k');
%             A = std((optiData(1:6000,3)+optiData(1:6000,6)+optiData(1:6000,9)+optiData(1:6000,12))/4);
%             xlabel('����t s'); ylabel('���ʊp��');
%             xlim([0 60000]);ylim([0 90]);
%             title('��A�������ʊp');
%             a2 = subplot( 2,1,2 );
%             plot(1:1:60000,PHI(1,:),'k');
%             xlabel('����t s'); ylabel('�p��');
%             xlim([0 60000]);ylim([0 200]);
%             title('��A�����p');
%              
%             linkaxes([a1 a2],'x');
%             obj.saveGraphWithName('��A�����J��');
                        
              for i =1:60000
                if(rem(i,20) == 0)
                    Exl(i/20,1)=mean(THETA(1,20*((i/20)-1)+1:i));
                end
              end    
              disp(obj.config.fileName);
            filename = [char(obj.config.fileName) '��A�������ʊp'];
            disp(filename);
            A = Exl;
            sheet = 1;
            xlRange = 'A1';
            xlswrite(filename,A,sheet,xlRange)
            
                      
%             if ~isempty(strfind( char(obj.config.examType) , '�����ΐ�'))
%                 saveMovieName = obj.saveFilePath(['_' num2str( obj.data.splitTimeInfo.index ) '.avi']);
%             else
%                 saveMovieName = obj.saveFilePath('.avi');
%             end
%             movie2avi(movmov, saveMovieName,  'compression', 'None', 'fps', 2);

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

        function runForPair(obj,user1 ,user2)
%             obj.runForAlone(user1);
%             obj.runForAlone(user2);
%             
            
        end

        
    end
end
