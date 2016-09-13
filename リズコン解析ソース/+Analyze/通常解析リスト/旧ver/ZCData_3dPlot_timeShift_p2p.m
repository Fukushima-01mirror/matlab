classdef ZCData_3dPlot_timeShift_p2p < Analyze.Base
    %STANDARDDEVIATION ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q

    properties
    end

    methods
        function obj = ZCData_3dPlot_timeShift_p2p(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
           [period_zx, peak_zx] = Rhythm.setZeroCrossPeriodData(user.zeroCrossData);
           %�@�[���N���X�Ԃł̃s�[�N�񐔎擾
           [zeroCrossTimes] = Rhythm.setZeroCrossCount(user.zeroCrossData);
            
            Y = abs( user.zeroCrossData.nonlogAvtVelocity );
            X1 = abs( period_zx );
            X2 = abs( peak_zx );
            
            V_max = 30000;
            dT_max = 300;
            dA_max = 300;
            
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
            X1_zc = X1(IndexZeroCross,:);     X1_nzc = X1(IndexNonZeroCross,:);
            X2_zc = X2(IndexZeroCross,:);     X2_nzc = X2(IndexNonZeroCross,:);

                t_width = 1000;
            avtPos_trend = smooth( user.avatarPosition.highSampled , t_width , 'moving');
            [pks_upper ,locs_upper] = findpeaks( avtPos_trend );
            [pks_lower,locs_lower] = findpeaks( -avtPos_trend );
            peakIndex = sortrows( [locs_upper' ; locs_lower']);

            %�@���ԃX�P�[���̐ݒ�            
            spotTime = 2000;    %  ���ԃX�P�[���̐ݒ�    
            startTime =  500 * floor( obj.data.player1.time.highSampled(1) /500) ;
%             spotTimeSeries = spotTime+startTime : user.time.highSampled(end);
%             spotTimeSeries = spotTimeSeries.';
            Num = 1;

            for i = 1:length(peakIndex)-1
%%         
                subplot(3,3,[2 3])
                %�������ԑS�̂̃A�o�^�ʒu���n��ω�
                plot( user.time.highSampled,  user.avatarPosition.highSampled , 'c');
                hold on 
                    % �A�o�^�ʒu�̃s�[�N��`��
                    for j = 1:length(peakIndex)
                        plot(  [ user.time.highSampled(peakIndex(j)) user.time.highSampled(peakIndex(j))] ,[0 1000] , '-.k');
                    end
                    % ���������̕`��
                    if strcmp( obj.config.examType, '�ǂ����܂����')...
                            || strcmp( obj.config.examType, '�ǂ����ގ���')
                        plot(   obj.data.com.time,  obj.data.com.avatarPosition , 'k:');               
                    elseif ~isempty(  findstr( char( obj.config.examType ) , '���Ǐ]'))
                            plot(   obj.data.task.time,  obj.data.task.avatarPosition , 'k:');   
                    elseif obj.config.isExistPlayer1 && obj.config.isExistPlayer2
                        if obj.currentRunType == obj.runTypePlayer1
                            plot( obj.data.player2.time.highSampled , obj.data.player2.avatarPosition.highSampled , 'k:');
                        elseif obj.currentRunType == obj.runTypePlayer2
                            plot( obj.data.player1.time.highSampled , obj.data.player1.avatarPosition.highSampled , 'k:');
                        end
                    end
                    plot( user.time.highSampled( peakIndex(i) :peakIndex(i+1) ), ...
                        user.avatarPosition.highSampled( peakIndex(i) :peakIndex(i+1) ) , 'b');
                   
                hold off

                title('�A�o�^�ʒu');
                xlabel('����t ms'); ylabel('�A�o�^�ʒu');
                xlim([0,60000]);    ylim([0 1000]);
  
                
                subplot(3,3,[5 6 8 9])
               startIndex1 = find( user.zeroCrossData.zeroCrossTime(IndexZeroCross) >=  user.time.highSampled( peakIndex(i) ) ,1 ,'first');
               endIndex1 = find( user.zeroCrossData.zeroCrossTime(IndexZeroCross) <  user.time.highSampled( peakIndex(i+1) ) ,1 ,'last');  

                plot3( X1_zc(:,3) , X2_zc(:,3), Y_zc,   'Marker','o', 'MarkerEdgeColor' , [.7 .7 .7] ,'LineStyle','none');
                axis square
                grid on
                hold on
                    plot3( X1_nzc(:,3) , X2_nzc(:,3), Y_nzc, 'Marker','.', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none');
    %                 mesh(X1FIT,X2FIT,YFIT, 'faceAlpha',0.5);
                    plot3( X1_zc(startIndex1:endIndex1 ,3) , X2_zc(startIndex1:endIndex1,3), Y_zc(startIndex1:endIndex1),...
                        'Marker','o', 'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'LineStyle','none');
                hold off
                xlabel('����g�` �����̍�');  ylabel('����g�` �U���̍�');  zlabel('�ΐ����Z�O�A�o�^����');
                xlim([0,dT_max]);      ylim([0,dA_max]);         zlim([0 V_max]);
                
                if ~isempty(strfind( char(obj.config.examType) , '�����ΐ�'))
                     title({['GameTime: ' num2str(obj.data.player1.time.highSampled(1)) '�`' num2str( obj.data.player1.time.highSampled(end))];...
                         ['time:' num2str( user.time.highSampled( peakIndex(i) ) ) '�`'  num2str(user.time.highSampled( peakIndex(i+1) ))  ]});
                else
                    title({['time:' num2str( user.time.highSampled( peakIndex(i) ) ) '�`'  num2str(user.time.highSampled( peakIndex(i+1) ))  ]});
                end
%%

                MonitorSize = [ 0, 0, 1200, 800];
                set(gcf, 'Position', MonitorSize);
                     figure(1);
                subplot(3,3,1);
                [ fitParam1, fitLineR1, lineEdgePoint] = Rhythm.approxiLine2d(X1_zc(:,3), Y_zc );
                plot( X1_zc(:,3)  ,Y_zc,  'Marker','o', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none' );
                hold on
                    plot( X1_nzc(:,3)  ,Y_nzc,'Marker','.', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none' );
                    plot( X1_zc(startIndex1:endIndex1 ,3) ,  Y_zc(startIndex1:endIndex1),...
                        'Marker','o', 'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'LineStyle','none');
                hold off
                grid on
                xlabel('����g�` �����̍�'); ylabel('�ΐ����Z�O�A�o�^����');
                xlim([0,dT_max]);         ylim([0 V_max]);
                title({['V =  (' num2str( fitParam1(1) ) ') * dPeriod  + (' num2str(fitParam1(2)) ')']; ...
                        ['���֌W���F' num2str( fitLineR1(1))]} );
                axis square

                %�@�U�����ƃA�o�^�����̑���
                subplot(3,3,4);
                [ fitParam2, fitLineR2, lineEdgePoint] = Rhythm.approxiLine2d(X2_zc(:,3), Y_zc );
                plot( X2_zc(:,3)  ,Y_zc ,  'Marker','o', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none' );
                hold on
                    plot( X2_nzc(:,3)  ,Y_nzc,'Marker','.', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none' );
                    plot(  X2_zc(startIndex1:endIndex1,3), Y_zc(startIndex1:endIndex1),...
                        'Marker','o', 'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'LineStyle','none');
                hold off
                grid on
                xlabel('����g�`�@�U���̍�'); ylabel('�ΐ����Z�O�A�o�^����');
                xlim([0,dA_max]);            ylim([0 V_max]);
                title({['V =  (' num2str( fitParam2(1) ) ') * dPeak  + (' num2str(fitParam2(2)) ')']; ...
                        ['���֌W���F' num2str( fitLineR2(1))]});
                axis square

                %�@�������ƐU�����̑���
                subplot(3,3,7);
                [ fitParam3, fitLineR3, lineEdgePoint] = Rhythm.approxiLine2d(X1_zc(:,3)  ,X2_zc(:,3) );
                plot( X1_zc(:,3)  ,X2_zc(:,3) , 'Marker','o', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none' );
                hold on
                    plot( X1_nzc(:,3)  ,X2_nzc(:,3),'Marker','.', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none' );
                    plot( X1_zc(startIndex1:endIndex1 ,3) , X2_zc(startIndex1:endIndex1,3),...
                        'Marker','o', 'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'LineStyle','none');
                hold off
                grid on
                xlabel('����g�` �����̍�');    ylabel('����g�`�@�U���̍�'); 
                xlim([0,dT_max]);            ylim([0,dA_max]);
                title({['V =  (' num2str( fitParam3(1) ) ') * dPeak  + (' num2str(fitParam3(2)) ')']; ...
                        ['���֌W���F' num2str( fitLineR3(1))]});
                axis square
                
%%

%                 % ����
%                 drawnow             % drawnow������ƃA�j���[�V�����ɂȂ�
%                 movmov(Num) = getframe(gcf,MonitorSize);           % �A�j���[�V�����̃t���[�����Q�b�g����

                % �ꖇ���ۑ�
                if ~isempty(strfind( char(obj.config.examType) , '�����ΐ�'))
                    obj.saveGraphWithNameToFolder( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_'  num2str(Num)]);
                else
                    obj.saveGraphWithNameToFolder( [  num2str(Num) ]);
                end

                Num = Num +1;
            end
%             
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
