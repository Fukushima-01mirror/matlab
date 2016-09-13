classdef ZCDataCorrelation3d_approxiSurf_ex_group < Analyze.Base
    %STANDARDDEVIATION ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q

    properties
    end

    methods
        function obj = ZCDataCorrelation3d_approxiSurf_ex_group(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
            

           [period_zx, peak_zx] = Rhythm.setZeroCrossPeriodData(user.zeroCrossData);
           %�@�[���N���X�Ԃł̃s�[�N�񐔎擾
           [zeroCrossTimes] = Rhythm.setZeroCrossCount(user.zeroCrossData);

           bDirect = mean( obj.data.task.avatarPosition(1:10) ) - obj.data.task.avatarPosition(1) >0;
            swTiming(1,1) = 0;
            j=1;
            for i = 1:length(obj.data.task.time)
                if bDirect && obj.data.task.avatarPosition(i) >= obj.data.task.otherData(i,2)
                    swTiming(j,1) = obj.data.task.time(i);
                    bDirect = false;
                    j=j+1;
                end
                if ~bDirect && obj.data.task.avatarPosition(i) <= obj.data.task.otherData(i,1)
                    swTiming(j,1) = obj.data.task.time(i);
                    bDirect = true;
                    j=j+1;
                end
            end
            
%%        �؂�Ԃ��^�C�~���O���Ƃ�3�����U�z�}     
            for i =3:length(swTiming)
                startIndex1 = find( user.zeroCrossData.zeroCrossTime >= swTiming(i-1) ,1 ,'first');
                endIndex1 = find( user.zeroCrossData.zeroCrossTime < swTiming(i) ,1 ,'last');   
                zcIndex = [startIndex1: endIndex1];

               zeroCrossTimes_local = zeroCrossTimes( startIndex1:endIndex1 ,: );   %�@C1:�g�`�̑O�����̃s�[�N�񐔁@C2:�㔼���̃s�[�N��
               %�@�[���N���X���Ă��鎞�̃C���f�b�N�X
               IndexZeroCross = find(zeroCrossTimes_local(:,1)<2&zeroCrossTimes_local(:,2)<2);
               %�@�[���N���X���Ȃ����̃C���f�b�N�X
               IndexNonZeroCross = find( zeroCrossTimes_local(:,1)>1 | zeroCrossTimes_local(:,2)>1);

                Y = abs( user.zeroCrossData.nonlogAvtVelocity );
                X1 = abs( period_zx );
                X2 = abs( peak_zx );

                Y_zc  = Y( zcIndex(IndexZeroCross) );      Y_nzc  = Y( zcIndex(IndexNonZeroCross) );
                X1_zc = X1(zcIndex(IndexZeroCross),:);     X1_nzc = X1( zcIndex(IndexNonZeroCross) ,:);
                X2_zc = X2(zcIndex(IndexZeroCross),:);     X2_nzc = X2( zcIndex(IndexNonZeroCross) ,:);

                r_fig= 3;
%%                
%                 figure(1);
% %            �A�o�^�ʒu�`��    
%                subplot(r_fig, 2, 1)     
%                plot(   user.time.highSampled,  user.avatarPosition.highSampled);         
%                 % �����A�o�^�̈ʒu�`��
%                 hold on
%                     % ���������̕`��
%                     if strcmp( obj.config.examType, '�ǂ����܂����')...
%                             || strcmp( obj.config.examType, '�ǂ����ގ���')
%                         plot(   obj.data.com.time,  obj.data.com.avatarPosition , 'k:');               
%                     elseif ~isempty(  findstr( char( obj.config.examType ) , '���Ǐ]'))
%                             plot(   obj.data.task.time,  obj.data.task.avatarPosition , 'k:');               
%                     end
%                     %�@�[���N���X���Ȃ��^�C�~���O��`��
%                     for j= 1: length(IndexNonZeroCross)
%                         zeroCrossTime = user.zeroCrossData.zeroCrossTime(IndexNonZeroCross(j) );
%                         plot([zeroCrossTime zeroCrossTime],[0 1000],...
%                             'Color' , [.7 .7 .7] , 'LineStyle', ':');
%                     end
%                 hold off
%                 xlabel('����t ms'); ylabel('�A�o�^�ʒu');
%                 xlim([swTiming(i-1) swTiming(i)]);    ylim([0 1000]);
% 
% %            �R���g���[������`��    
%                 subplot(r_fig,2,3)
%                 plot(   user.time.highSampled,  user.operatePulse.highSampled );               
%                 hold on %�@�[���N���X���Ȃ��^�C�~���O��`��
%                     for j= 1: length(IndexNonZeroCross)
%                         zeroCrossTime = user.zeroCrossData.zeroCrossTime(IndexNonZeroCross(j) );
%                         plot([zeroCrossTime zeroCrossTime],[-400 400],...
%                             'Color' , [.7 .7 .7] , 'LineStyle', ':');
%                     end
%                     plot([0 60000], [0 0] ,'k')
%                 hold off
%                 xlabel('����t ms'); ylabel('�R���g���[������');
%                 xlim([swTiming(i-1) swTiming(i)]);    ylim([-400 400]);
% %                 grid on;
%                 set(gca,'YTick',[-400:100:400]);
% 
% %            �A�o�^���x     
%                 subplot(r_fig,2,5)
%                 plot(   user.time.highSampled,  user.avatarVelocity.highSampled );               
%                 hold on %�@�[���N���X���Ȃ��^�C�~���O��`��
%                     % ���������̕`��
%                     % ���������̕`��
%                     if ~isempty(  findstr( char( obj.config.examType ) , '���Ǐ]'))
%                         if mean( user.avatarVelocity.highSampled(swTiming(i-1):swTiming(i)) ) >0
%                             plot(   obj.data.task.time,  obj.data.task.otherData(:,4) , 'k:');         
%                         else
%                             plot(   obj.data.task.time,  -obj.data.task.otherData(:,4) , 'k:');  
%                         end
%                     end
%                    for j= 1: length(IndexNonZeroCross)
%                         zeroCrossTime = user.zeroCrossData.zeroCrossTime(IndexNonZeroCross(j) );
%                         plot([zeroCrossTime zeroCrossTime],[-0.5 0.5],...
%                             'Color' , [.7 .7 .7] , 'LineStyle', ':');
%                     end
%                     plot([0 60000], [0 0] ,'k')
%                 hold off
%                 xlabel('����t ms'); ylabel('�A�o�^���x');
%                 xlim([swTiming(i-1) swTiming(i)]);    ylim([-0.5 0.5]);
% %                 grid on;
%                 set(gca,'YTick',[-0.5:0.1:0.5]);
%                 
%                 
%                 subplot(1,2,2);
%                 [fitParam1, X1FIT, X2FIT, YFIT ]  = Rhythm.approxiSurface(X1_zc(:,1), X2_zc(:,1), Y_zc );
%                 plot3( X1_zc(:,1) , X2_zc(:,1), Y_zc,   'Marker','*', 'LineStyle','none');
%                 hold on
%                     plot3( X1_nzc(:,1) , X2_nzc(:,1), Y_nzc, 'Marker','o', 'LineStyle','none');
%                      mesh(X1FIT,X2FIT,YFIT);
%                 hold off
%                 grid on
%                 xlabel('����g�` ������'); ylabel('����g�`�@�s�[�N�l');  zlabel('�ΐ����Z�O�A�o�^����');
%                 xlim([0,600]);      ylim([0,600]);         zlim([0 50000]);
%                 title(['V = (' num2str(fitParam1(1)) ') + (' num2str( fitParam1(2) ) ') * dPeriod + (' num2str( fitParam1(3)) ') * dPeak + (' ...
%                     num2str(fitParam1(4)) ') * dPeriod*dPeak']);
%                 axis square
%                 MonitorSize = [ 0, 0, 1280, 800];
%                 set(gcf, 'Position', MonitorSize);
%                 obj.saveGraphWithName(['_halfParam' num2str(i)]);
%                 
% 
% %%
%                 figure(2);
%                subplot(r_fig, 2, 1)     
%                plot(   user.time.highSampled,  user.avatarPosition.highSampled);         
%                 % �����A�o�^�̈ʒu�`��
%                 hold on
%                     % ���������̕`��
%                     if strcmp( obj.config.examType, '�ǂ����܂����')...
%                             || strcmp( obj.config.examType, '�ǂ����ގ���')
%                         plot(   obj.data.com.time,  obj.data.com.avatarPosition , 'k:');               
%                     elseif ~isempty(  findstr( char( obj.config.examType ) , '���Ǐ]'))
%                             plot(   obj.data.task.time,  obj.data.task.avatarPosition , 'k:');               
%                     end
%                     %�@�[���N���X���Ȃ��^�C�~���O��`��
%                     for j= 1: length(IndexNonZeroCross)
%                         zeroCrossTime = user.zeroCrossData.zeroCrossTime(IndexNonZeroCross(j) );
%                         plot([zeroCrossTime zeroCrossTime],[0 1000],...
%                             'Color' , [.7 .7 .7] , 'LineStyle', ':');
%                     end
%                 hold off
%                 xlabel('����t ms'); ylabel('�A�o�^�ʒu');
%                 xlim([swTiming(i-1) swTiming(i)]);    ylim([0 1000]);
% 
% %            �R���g���[������`��    
%                 subplot(r_fig,2,3)
%                 plot(   user.time.highSampled,  user.operatePulse.highSampled );               
%                 hold on %�@�[���N���X���Ȃ��^�C�~���O��`��
%                     for j= 1: length(IndexNonZeroCross)
%                         zeroCrossTime = user.zeroCrossData.zeroCrossTime(IndexNonZeroCross(j) );
%                         plot([zeroCrossTime zeroCrossTime],[-400 400],...
%                             'Color' , [.7 .7 .7] , 'LineStyle', ':');
%                     end
%                     plot([0 60000], [0 0] ,'k')
%                 hold off
%                 xlabel('����t ms'); ylabel('�R���g���[������');
%                 xlim([swTiming(i-1) swTiming(i)]);    ylim([-400 400]);
% %                 grid on;
%                 set(gca,'YTick',[-400:100:400]);
% 
% %            �A�o�^���x     
%                 subplot(r_fig,2,5)
%                 plot(   user.time.highSampled,  user.avatarVelocity.highSampled );               
%                 hold on %�@�[���N���X���Ȃ��^�C�~���O��`��
%                     % ���������̕`��
%                     if ~isempty(  findstr( char( obj.config.examType ) , '���Ǐ]'))
%                         if mean( user.avatarVelocity.highSampled(swTiming(i-1):swTiming(i)) ) >0
%                             plot(   obj.data.task.time,  obj.data.task.otherData(:,4) , 'k:');         
%                         else
%                             plot(   obj.data.task.time,  -obj.data.task.otherData(:,4) , 'k:');  
%                         end
%                     end
%                    for j= 1: length(IndexNonZeroCross)
%                         zeroCrossTime = user.zeroCrossData.zeroCrossTime(IndexNonZeroCross(j) );
%                         plot([zeroCrossTime zeroCrossTime],[-0.5 0.5],...
%                             'Color' , [.7 .7 .7] , 'LineStyle', ':');
%                     end
%                     plot([0 60000], [0 0] ,'k')
%                 hold off
%                 xlabel('����t ms'); ylabel('�A�o�^���x');
%                 xlim([swTiming(i-1) swTiming(i)]);    ylim([-0.5 0.5]);
% %                 grid on;
%                 set(gca,'YTick',[-0.5:0.1:0.5]);
%   
%                 
%                 subplot(1,2,2);
%                 [fitParam2, X1FIT, X2FIT, YFIT ]  = Rhythm.approxiSurface(X1_zc(:,2), X2_zc(:,2), Y_zc );
%                 plot3( X1_zc(:,2) , X2_zc(:,2), Y_zc,   'Marker','*', 'LineStyle','none');
%                 hold on
%                     plot3( X1_nzc(:,2) , X2_nzc(:,2), Y_nzc, 'Marker','o', 'LineStyle','none');
%                     mesh(X1FIT,X2FIT,YFIT);
%                 hold off
%                 grid on
%                 xlabel('����g�` 1����'); ylabel('����g�` �U��');  zlabel('�ΐ����Z�O�A�o�^����');
%                 xlim([0,800]);     ylim([0,800]);   zlim([0 50000]);
%                 title(['V = (' num2str(fitParam2(1)) ') + (' num2str( fitParam2(2) ) ') * dPeriod + (' num2str( fitParam2(3)) ') * dPeak + (' ...
%                     num2str(fitParam2(4)) ') * dPeriod*dPeak']);
%                 axis square
%                 MonitorSize = [ 0, 0, 1280, 800];
%                 set(gcf, 'Position', MonitorSize);
%                 obj.saveGraphWithName(['_sumParam' num2str(i)]);

%%
                figure(3);
               subplot(r_fig, 2, 1)     
               plot(   user.time.highSampled,  user.avatarPosition.highSampled);         
                % �����A�o�^�̈ʒu�`��
                hold on
                    % ���������̕`��
                    if strcmp( obj.config.examType, '�ǂ����܂����')...
                            || strcmp( obj.config.examType, '�ǂ����ގ���')
                        plot(   obj.data.com.time,  obj.data.com.avatarPosition , 'k:');               
                    elseif ~isempty(  findstr( char( obj.config.examType ) , '���Ǐ]'))
                            plot(   obj.data.task.time,  obj.data.task.avatarPosition , 'k:');               
                    end
                    %�@�[���N���X���Ȃ��^�C�~���O��`��
                    for j= 1: length(IndexNonZeroCross)
                        zeroCrossTime = user.zeroCrossData.zeroCrossTime(IndexNonZeroCross(j) );
                        plot([zeroCrossTime zeroCrossTime],[0 1000],...
                            'Color' , [.7 .7 .7] , 'LineStyle', ':');
                    end
                hold off
                xlabel('����t ms'); ylabel('�A�o�^�ʒu');
                xlim([swTiming(i-1) swTiming(i)]);    ylim([0 1000]);

%            �R���g���[������`��    
                subplot(r_fig,2,3)
                plot(   user.time.highSampled,  user.operatePulse.highSampled );               
                hold on %�@�[���N���X���Ȃ��^�C�~���O��`��
                    for j= 1: length(IndexNonZeroCross)
                        zeroCrossTime = user.zeroCrossData.zeroCrossTime(IndexNonZeroCross(j) );
                        plot([zeroCrossTime zeroCrossTime],[-400 400],...
                            'Color' , [.7 .7 .7] , 'LineStyle', ':');
                    end
                    plot([0 60000], [0 0] ,'k')
                hold off
                xlabel('����t ms'); ylabel('�R���g���[������');
                xlim([swTiming(i-1) swTiming(i)]);    ylim([-400 400]);
%                 grid on;
                set(gca,'YTick',[-400:100:400]);

%            �A�o�^���x     
                subplot(r_fig,2,5)
                plot(   user.time.highSampled,  user.avatarVelocity.highSampled );               
         
                hold on %�@�[���N���X���Ȃ��^�C�~���O��`��
                    % ���������̕`��
                    if ~isempty(  findstr( char( obj.config.examType ) , '���Ǐ]'))
                        if mean( user.avatarVelocity.highSampled(swTiming(i-1):swTiming(i)) ) >0
                            plot(   obj.data.task.time,  obj.data.task.otherData(:,4) , 'k:');
%                             opearateError = user.avatarVelocity.lowSampled
                        else
                            plot(   obj.data.task.time,  -obj.data.task.otherData(:,4) , 'k:');  
                        end
                    end
                   for j= 1: length(IndexNonZeroCross)
                        zeroCrossTime = user.zeroCrossData.zeroCrossTime(IndexNonZeroCross(j) );
                        plot([zeroCrossTime zeroCrossTime],[-0.5 0.5],...
                            'Color' , [.7 .7 .7] , 'LineStyle', ':');
                    end
                    plot([0 60000], [0 0] ,'k')
               hold off
                xlabel('����t ms'); ylabel('�A�o�^���x');
                xlim([swTiming(i-1) swTiming(i)]);    ylim([-0.5 0.5]);
%                 grid on;
                set(gca,'YTick',[-0.5:0.1:0.5]);
                
                
                subplot(1,2,2);
                [fitParam3, X1FIT, X2FIT, YFIT ]  = Rhythm.approxiSurface(X1_zc(:,3), X2_zc(:,3), Y_zc );
                plot3( X1_zc(:,3) , X2_zc(:,3), Y_zc,   'Marker','*', 'LineStyle','none');
                hold on
                    plot3( X1_nzc(:,3) , X2_nzc(:,3), Y_nzc, 'Marker','o', 'LineStyle','none');
                    mesh(X1FIT,X2FIT,YFIT);
                hold off
                grid on
                xlabel('����g�` �����̍�');  ylabel('����g�` �U���̍�');  zlabel('�ΐ����Z�O�A�o�^����');
                xlim([0,600]);      ylim([0,600]);         zlim([0 50000]);
                title(['V = (' num2str(fitParam3(1)) ') + (' num2str( fitParam3(2) ) ') * dPeriod + (' num2str( fitParam3(3)) ') * dPeak + (' ...
                    num2str(fitParam3(4)) ') * dPeriod*dPeak']);
                axis square
                MonitorSize = [ 0, 0, 1280, 800];
                set(gcf, 'Position', MonitorSize);
                obj.saveGraphWithName(['_difParam' num2str(i)]);
                
                %%      �ߎ��ʁ@�W���@�G�N�Z���f�[�^�o��  
                stIndex = find( obj.data.task.time == swTiming(i-1) );
                endIndex = find( obj.data.task.time == swTiming(i) );
                % �����x���[�h
                if  std( obj.data.task.otherData(stIndex:endIndex,4) )< 0.01
                    moveMode = mean( obj.data.task.otherData( stIndex:endIndex ,4) );
                else
                    moveMode = 0;
                end
                
                outputTitle = { '�萔��' , '�����̍��̌W��' , '�U���̍��̌W��','�U���̍��Ǝ����̍��̐ς̌W��' , '�����x���[�h'};

                output = num2cell( [ fitParam3'  moveMode]);
                obj.outputAllToXlsWithName(num2str(i) ,output , outputTitle);


            end

        end

        
        
    end
end
