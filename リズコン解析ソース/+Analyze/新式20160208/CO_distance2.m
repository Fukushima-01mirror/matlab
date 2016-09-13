classdef CO_distance2 < Analyze.Base
    %STANDARDDEVIATION ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q

    properties
    end

    methods
        function obj = CO_distance2(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
       
        end

        function runForPair(obj,user1 ,user2)
                        disp('����Ă܂�');
            D=load('data_timeSplit.mat');
            datanumber=length(D.data_timeSplit);
            disp(datanumber);
            %%
            N_low = length(D.data_timeSplit(1,1).player1.time.lowSampled);
            N_high = length(D.data_timeSplit(1,1).player1.time.highSampled);
            
            
            for i=1:1:N_high
                DISTANCE1(i,1) = abs(D.data_timeSplit(1,1).player2.avatarPosition.highSampled(i,1)-D.data_timeSplit(1,1).player1.avatarPosition.highSampled(i,1));
                VELOCITY_DIFF1(i,1) = D.data_timeSplit(1,1).player1.avatarVelocity.highSampled(i,1)-D.data_timeSplit(1,1).player2.avatarVelocity.highSampled(i,1);
                VELOCITY_DIFF1_2(i,1) = abs(abs(D.data_timeSplit(1,1).player1.avatarVelocity.highSampled(i,1))-abs(D.data_timeSplit(1,1).player2.avatarVelocity.highSampled(i,1)));
            end
              figure
             plot(VELOCITY_DIFF1,DISTANCE1,'Color','g','Marker','.','MarkerSize',8,'LineStyle','none');
            
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P-2P �A�o�^���x_���Α��x [px/ms]');  ylabel('1P-2P�A�o�^�ԋ����@[px]');
            hold on
            %%
            obj.saveGraphWithName('_����vs���Α��x�@');
        %%
            
            figure
            
            plot(VELOCITY_DIFF1_2,DISTANCE1,'Color','m','Marker','.','MarkerSize',8,'LineStyle','none');
            
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P-2P�����̍� [px/ms]');  ylabel('1P-2P�A�o�^�ԋ����@[px]');
            hold on
            %%
            obj.saveGraphWithName('_����vs���x�̐�Βl�̍��@');
            %%
             if datanumber >1
            N_low = length(D.data_timeSplit(2,1).player1.time.lowSampled);
            N_high = length(D.data_timeSplit(2,1).player1.time.highSampled);
            
            for i=1:1:N_high
                DISTANCE2(i,1) = abs(D.data_timeSplit(2,1).player2.avatarPosition.highSampled(i,1)-D.data_timeSplit(2,1).player1.avatarPosition.highSampled(i,1));
                VELOCITY_DIFF2(i,1) = D.data_timeSplit(2,1).player1.avatarVelocity.highSampled(i,1)-D.data_timeSplit(2,1).player2.avatarVelocity.highSampled(i,1);
                VELOCITY_DIFF2_2(i,1) = abs(abs(D.data_timeSplit(2,1).player1.avatarVelocity.highSampled(i,1))-abs(D.data_timeSplit(2,1).player2.avatarVelocity.highSampled(i,1)));
            end
            
              figure
            plot(VELOCITY_DIFF2,DISTANCE2,'Color','g','Marker','.','MarkerSize',8,'LineStyle','none');
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P-2P �A�o�^���x_���Α��x [px/ms]');  ylabel('1P-2P�A�o�^�ԋ����@[px]');
            hold on
            %%
            obj.saveGraphWithName('_����vs���Α��x�A');
        %%
            figure
            
            plot(VELOCITY_DIFF2_2,DISTANCE2,'Color','m','Marker','.','MarkerSize',8,'LineStyle','none');
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P-2P�����̍� [px/ms]');  ylabel('1P-2P�A�o�^�ԋ����@[px]');
            hold on
               %%
            obj.saveGraphWithName('_����vs���x�̐�Βl�̍��A');
            end
          %%
            if datanumber >2
            N_low = length(D.data_timeSplit(3,1).player1.time.lowSampled);
            N_high = length(D.data_timeSplit(3,1).player1.time.highSampled);
            
            for i=1:1:N_high
                DISTANCE3(i,1) = abs(D.data_timeSplit(3,1).player2.avatarPosition.highSampled(i,1)-D.data_timeSplit(3,1).player1.avatarPosition.highSampled(i,1));
                VELOCITY_DIFF3(i,1) = D.data_timeSplit(3,1).player1.avatarVelocity.highSampled(i,1)-D.data_timeSplit(3,1).player2.avatarVelocity.highSampled(i,1);
                VELOCITY_DIFF3_2(i,1) = abs(abs(D.data_timeSplit(3,1).player1.avatarVelocity.highSampled(i,1))-abs(D.data_timeSplit(3,1).player2.avatarVelocity.highSampled(i,1)));
            end
            
              figure
            plot(VELOCITY_DIFF3,DISTANCE3,'Color','g','Marker','.','MarkerSize',8,'LineStyle','none');
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P-2P �A�o�^���x_���Α��x [px/ms]');  ylabel('1P-2P�A�o�^�ԋ����@[px]');
            hold on
            %%
            obj.saveGraphWithName('_����vs���Α��x�B');
        %%
            figure
            
            plot(VELOCITY_DIFF3_2,DISTANCE3,'Color','m','Marker','.','MarkerSize',8,'LineStyle','none');
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P-2P�����̍� [px/ms]');  ylabel('1P-2P�A�o�^�ԋ����@[px]');
            hold on
               %%
            obj.saveGraphWithName('_����vs���x�̐�Βl�̍��B');
            end
            %%
            if datanumber >3
            N_low = length(D.data_timeSplit(4,1).player1.time.lowSampled);
            N_high = length(D.data_timeSplit(4,1).player1.time.highSampled);
            
            for i=1:1:N_high
                DISTANCE4(i,1) = abs(D.data_timeSplit(4,1).player2.avatarPosition.highSampled(i,1)-D.data_timeSplit(4,1).player1.avatarPosition.highSampled(i,1));
                VELOCITY_DIFF4(i,1) = D.data_timeSplit(4,1).player1.avatarVelocity.highSampled(i,1)-D.data_timeSplit(4,1).player2.avatarVelocity.highSampled(i,1);
                VELOCITY_DIFF4_2(i,1) = abs(abs(D.data_timeSplit(4,1).player1.avatarVelocity.highSampled(i,1))-abs(D.data_timeSplit(4,1).player2.avatarVelocity.highSampled(i,1)));
            end
            
              figure
            plot(VELOCITY_DIFF4,DISTANCE4,'Color','g','Marker','.','MarkerSize',8,'LineStyle','none');
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P-2P �A�o�^���x_���Α��x [px/ms]');  ylabel('1P-2P�A�o�^�ԋ����@[px]');
            hold on
            %%
            obj.saveGraphWithName('_����vs���Α��x�C');
        %%
            figure
            
            plot(VELOCITY_DIFF4_2,DISTANCE4,'Color','m','Marker','.','MarkerSize',8,'LineStyle','none');
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P-2P�����̍� [px/ms]');  ylabel('1P-2P�A�o�^�ԋ����@[px]');
            hold on
               %%
            obj.saveGraphWithName('_����vs���x�̐�Βl�̍��C');
            end
                %%
            if datanumber >4
            N_low = length(D.data_timeSplit(5,1).player1.time.lowSampled);
            N_high = length(D.data_timeSplit(5,1).player1.time.highSampled);
            
            for i=1:1:N_high
                DISTANCE5(i,1) = abs(D.data_timeSplit(5,1).player2.avatarPosition.highSampled(i,1)-D.data_timeSplit(5,1).player1.avatarPosition.highSampled(i,1));
                VELOCITY_DIFF5(i,1) = D.data_timeSplit(5,1).player1.avatarVelocity.highSampled(i,1)-D.data_timeSplit(5,1).player2.avatarVelocity.highSampled(i,1);
                VELOCITY_DIFF5_2(i,1) = abs(abs(D.data_timeSplit(5,1).player1.avatarVelocity.highSampled(i,1))-abs(D.data_timeSplit(5,1).player2.avatarVelocity.highSampled(i,1)));
            end
            
              figure
            plot(VELOCITY_DIFF5,DISTANCE5,'Color','g','Marker','.','MarkerSize',8,'LineStyle','none');
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P-2P �A�o�^���x_���Α��x [px/ms]');  ylabel('1P-2P�A�o�^�ԋ����@[px]');
            hold on
            %%
            obj.saveGraphWithName('_����vs���Α��x�D');
        %%
            figure
            
            plot(VELOCITY_DIFF5_2,DISTANCE5,'Color','m','Marker','.','MarkerSize',8,'LineStyle','none');
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P-2P�����̍� [px/ms]');  ylabel('1P-2P�A�o�^�ԋ����@[px]');
            hold on
               %%
            obj.saveGraphWithName('_����vs���x�̐�Βl�̍��D');
            end
                   %%
            if datanumber >5
            N_low = length(D.data_timeSplit(6,1).player1.time.lowSampled);
            N_high = length(D.data_timeSplit(6,1).player1.time.highSampled);
            
            for i=1:1:N_high
                DISTANCE6(i,1) = abs(D.data_timeSplit(6,1).player2.avatarPosition.highSampled(i,1)-D.data_timeSplit(6,1).player1.avatarPosition.highSampled(i,1));
                VELOCITY_DIFF6(i,1) = D.data_timeSplit(6,1).player1.avatarVelocity.highSampled(i,1)-D.data_timeSplit(6,1).player2.avatarVelocity.highSampled(i,1);
                VELOCITY_DIFF6_2(i,1) = abs(abs(D.data_timeSplit(6,1).player1.avatarVelocity.highSampled(i,1))-abs(D.data_timeSplit(6,1).player2.avatarVelocity.highSampled(i,1)));
            end
            
              figure
            plot(VELOCITY_DIFF6,DISTANCE6,'Color','g','Marker','.','MarkerSize',8,'LineStyle','none');
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P-2P �A�o�^���x_���Α��x [px/ms]');  ylabel('1P-2P�A�o�^�ԋ����@[px]');
            hold on
            %%
            obj.saveGraphWithName('_����vs���Α��x�E');
        %%
            figure
            
            plot(VELOCITY_DIFF6_2,DISTANCE6,'Color','m','Marker','.','MarkerSize',8,'LineStyle','none');
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P-2P�����̍� [px/ms]');  ylabel('1P-2P�A�o�^�ԋ����@[px]');
            hold on
               %%
            obj.saveGraphWithName('_����vs���x�̐�Βl�̍��E');
            end
            %%
            if datanumber == 2
              
              figure
            plot(VELOCITY_DIFF1,DISTANCE1,'Color','g','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY_DIFF2,DISTANCE2,'Color','g','Marker','.','MarkerSize',8,'LineStyle','none');
            hold off
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P-2P �A�o�^���x_���Α��x [px/ms]');  ylabel('1P-2P�A�o�^�ԋ����@[px]');
            hold on
            %%
            obj.saveGraphWithName('_����vs���Α��x_All');
        %%
            figure
            
            plot(VELOCITY_DIFF1_2,DISTANCE1,'Color','m','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY_DIFF2_2,DISTANCE2,'Color','m','Marker','.','MarkerSize',8,'LineStyle','none');
            hold off
         
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P-2P�����̍� [px/ms]');  ylabel('1P-2P�A�o�^�ԋ����@[px]');
            hold on
               %%
            obj.saveGraphWithName('_����vs���x�̐�Βl�̍�_All');
            end
            %%
            if datanumber == 3
              
              figure
            plot(VELOCITY_DIFF1,DISTANCE1,'Color','g','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY_DIFF2,DISTANCE2,'Color','g','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY_DIFF3,DISTANCE3,'Color','g','Marker','.','MarkerSize',8,'LineStyle','none');
            hold off
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P-2P �A�o�^���x_���Α��x [px/ms]');  ylabel('1P-2P�A�o�^�ԋ����@[px]');
            hold on
            %%
            obj.saveGraphWithName('_����vs���Α��x_All');
        %%
            figure
            
            plot(VELOCITY_DIFF1_2,DISTANCE1,'Color','m','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY_DIFF2_2,DISTANCE2,'Color','m','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY_DIFF3_2,DISTANCE3,'Color','m','Marker','.','MarkerSize',8,'LineStyle','none');
            hold off
         
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P-2P�����̍� [px/ms]');  ylabel('1P-2P�A�o�^�ԋ����@[px]');
            hold on
               %%
            obj.saveGraphWithName('_����vs���x�̐�Βl�̍�_All');
            end
             %%
            if datanumber == 4
              
              figure
            plot(VELOCITY_DIFF1,DISTANCE1,'Color','g','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY_DIFF2,DISTANCE2,'Color','g','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY_DIFF3,DISTANCE3,'Color','g','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY_DIFF4,DISTANCE4,'Color','g','Marker','.','MarkerSize',8,'LineStyle','none');
            hold off
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P-2P �A�o�^���x_���Α��x [px/ms]');  ylabel('1P-2P�A�o�^�ԋ����@[px]');
            hold on
            %%
            obj.saveGraphWithName('_����vs���Α��x_All');
        %%
            figure
            
            plot(VELOCITY_DIFF1_2,DISTANCE1,'Color','m','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY_DIFF2_2,DISTANCE2,'Color','m','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY_DIFF3_2,DISTANCE3,'Color','m','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY_DIFF4_2,DISTANCE4,'Color','m','Marker','.','MarkerSize',8,'LineStyle','none');
            hold off
         
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P-2P�����̍� [px/ms]');  ylabel('1P-2P�A�o�^�ԋ����@[px]');
            hold on
               %%
            obj.saveGraphWithName('_����vs���x�̐�Βl�̍�_All');
            end
              %%
            if datanumber == 5
              
              figure
            plot(VELOCITY_DIFF1,DISTANCE1,'Color','g','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY_DIFF2,DISTANCE2,'Color','g','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY_DIFF3,DISTANCE3,'Color','g','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY_DIFF4,DISTANCE4,'Color','g','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY_DIFF5,DISTANCE5,'Color','g','Marker','.','MarkerSize',8,'LineStyle','none');
            hold off
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P-2P �A�o�^���x_���Α��x [px/ms]');  ylabel('1P-2P�A�o�^�ԋ����@[px]');
            hold on
            %%
            obj.saveGraphWithName('_����vs���Α��x_All');
        %%
            figure
            
            plot(VELOCITY_DIFF1_2,DISTANCE1,'Color','m','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY_DIFF2_2,DISTANCE2,'Color','m','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY_DIFF3_2,DISTANCE3,'Color','m','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY_DIFF4_2,DISTANCE4,'Color','m','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY_DIFF5_2,DISTANCE5,'Color','m','Marker','.','MarkerSize',8,'LineStyle','none');
            hold off
         
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P-2P�����̍� [px/ms]');  ylabel('1P-2P�A�o�^�ԋ����@[px]');
            hold on
               %%
            obj.saveGraphWithName('_����vs���x�̐�Βl�̍�_All');
            end
        %%
            close all
        end

        
    end
end
           