classdef CO_distance < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = CO_distance(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
       
        end

        function runForPair(obj,user1 ,user2)
            disp('やってます');
            D=load('data_timeSplit.mat');
            datanumber=length(D.data_timeSplit);
            disp(datanumber);
            %%
            N_low = length(D.data_timeSplit(1,1).player1.time.lowSampled);
            N_high = length(D.data_timeSplit(1,1).player1.time.highSampled);
            
            
            
            DISTANCE = zeros(N_high,1);
            VELOCITY = zeros(N_high,1);
            
            
            for i=1:1:N_high
                DISTANCE1_1(i,1) = abs(D.data_timeSplit(1,1).player2.avatarPosition.highSampled(i,1)-D.data_timeSplit(1,1).player1.avatarPosition.highSampled(i,1));
                VELOCITY1_1(i,1) = abs(D.data_timeSplit(1,1).player1.avatarVelocity.highSampled(i,1));
            end
            
              figure
            
            plot(VELOCITY1_1,DISTANCE1_1,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs1P速度�@');
        %%
            
            for i=1:1:N_high
                DISTANCE1_2(i,1) = abs(D.data_timeSplit(1,1).player2.avatarPosition.highSampled(i,1)-D.data_timeSplit(1,1).player1.avatarPosition.highSampled(i,1));
                VELOCITY1_2(i,1) = abs(D.data_timeSplit(1,1).player2.avatarVelocity.highSampled(i,1));
            end
            figure
            
            plot(VELOCITY1_2,DISTANCE1_2,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('2P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
               %%
            obj.saveGraphWithName('_距離vs2P速度�@');
                    %%
            figure
            plot(VELOCITY1_1,DISTANCE1_1,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY1_2,DISTANCE1_2,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P_2P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs1P2P速度�@');
            %%
            if datanumber >1
            N_low = length(D.data_timeSplit(2,1).player1.time.lowSampled);
            N_high = length(D.data_timeSplit(2,1).player1.time.highSampled);
            
            
            
            DISTANCE = zeros(N_high,1);
            VELOCITY = zeros(N_high,1);
            
            
            for i=1:1:N_high
                DISTANCE2_1(i,1) = abs(D.data_timeSplit(2,1).player2.avatarPosition.highSampled(i,1)-D.data_timeSplit(2,1).player1.avatarPosition.highSampled(i,1));
                VELOCITY2_1(i,1) = abs(D.data_timeSplit(2,1).player1.avatarVelocity.highSampled(i,1));
            end
            
              figure
            
            plot(VELOCITY2_1,DISTANCE2_1,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs1P速度�A');
        %%
            
            for i=1:1:N_high
                DISTANCE2_2(i,1) = abs(D.data_timeSplit(2,1).player2.avatarPosition.highSampled(i,1)-D.data_timeSplit(2,1).player1.avatarPosition.highSampled(i,1));
                VELOCITY2_2(i,1) = abs(D.data_timeSplit(2,1).player2.avatarVelocity.highSampled(i,1));
            end
            figure
            
            plot(VELOCITY2_2,DISTANCE2_2,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('2P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
               %%
            obj.saveGraphWithName('_距離vs2P速度�A');
                    %%
            figure
            plot(VELOCITY2_1,DISTANCE2_1,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY2_2,DISTANCE2_2,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P_2P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs1P2P速度�A');
            
            end
               %%
            if datanumber >2
            N_low = length(D.data_timeSplit(3,1).player1.time.lowSampled);
            N_high = length(D.data_timeSplit(3,1).player1.time.highSampled);
            
            
            
            DISTANCE = zeros(N_high,1);
            VELOCITY = zeros(N_high,1);
            
            
            for i=1:1:N_high
                DISTANCE3_1(i,1) = abs(D.data_timeSplit(3,1).player2.avatarPosition.highSampled(i,1)-D.data_timeSplit(3,1).player1.avatarPosition.highSampled(i,1));
                VELOCITY3_1(i,1) = abs(D.data_timeSplit(3,1).player1.avatarVelocity.highSampled(i,1));
            end
            
              figure
            
            plot(VELOCITY3_1,DISTANCE3_1,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs1P速度�B');
        %%
            
            for i=1:1:N_high
                DISTANCE3_2(i,1) = abs(D.data_timeSplit(3,1).player2.avatarPosition.highSampled(i,1)-D.data_timeSplit(3,1).player1.avatarPosition.highSampled(i,1));
                VELOCITY3_2(i,1) = abs(D.data_timeSplit(3,1).player2.avatarVelocity.highSampled(i,1));
            end
            figure
            
            plot(VELOCITY3_2,DISTANCE3_2,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('2P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
               %%
            obj.saveGraphWithName('_距離vs2P速度�B');
                    %%
            figure
            plot(VELOCITY3_1,DISTANCE3_1,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY3_2,DISTANCE3_2,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P_2P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs1P2P速度�B');
            end
                 %%
            if datanumber >3
            N_low = length(D.data_timeSplit(4,1).player1.time.lowSampled);
            N_high = length(D.data_timeSplit(4,1).player1.time.highSampled);
            
            
            
            DISTANCE = zeros(N_high,1);
            VELOCITY = zeros(N_high,1);
            
            
            for i=1:1:N_high
                DISTANCE4_1(i,1) = abs(D.data_timeSplit(4,1).player2.avatarPosition.highSampled(i,1)-D.data_timeSplit(4,1).player1.avatarPosition.highSampled(i,1));
                VELOCITY4_1(i,1) = abs(D.data_timeSplit(4,1).player1.avatarVelocity.highSampled(i,1));
            end
            
              figure
            
            plot(VELOCITY4_1,DISTANCE4_1,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs1P速度�C');
        %%
            
            for i=1:1:N_high
                DISTANCE4_2(i,1) = abs(D.data_timeSplit(4,1).player2.avatarPosition.highSampled(i,1)-D.data_timeSplit(4,1).player1.avatarPosition.highSampled(i,1));
                VELOCITY4_2(i,1) = abs(D.data_timeSplit(4,1).player2.avatarVelocity.highSampled(i,1));
            end
            figure
            
            plot(VELOCITY4_2,DISTANCE4_2,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('2P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
               %%
            obj.saveGraphWithName('_距離vs2P速度�C');
                    %%
            figure
            plot(VELOCITY4_1,DISTANCE4_1,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY4_2,DISTANCE4_2,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P_2P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs1P2P速度�C');
            end
                   %%
            if datanumber >4
            N_low = length(D.data_timeSplit(5,1).player1.time.lowSampled);
            N_high = length(D.data_timeSplit(5,1).player1.time.highSampled);
            
            
            
            DISTANCE = zeros(N_high,1);
            VELOCITY = zeros(N_high,1);
            
            
            for i=1:1:N_high
                DISTANCE5_1(i,1) = abs(D.data_timeSplit(5,1).player2.avatarPosition.highSampled(i,1)-D.data_timeSplit(5,1).player1.avatarPosition.highSampled(i,1));
                VELOCITY5_1(i,1) = abs(D.data_timeSplit(5,1).player1.avatarVelocity.highSampled(i,1));
            end
            
              figure
            
            plot(VELOCITY5_1,DISTANCE5_1,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            
%             xlim([7550 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs1P速度�D');
        %%
            
            for i=1:1:N_high
                DISTANCE5_2(i,1) = abs(D.data_timeSplit(5,1).player2.avatarPosition.highSampled(i,1)-D.data_timeSplit(5,1).player1.avatarPosition.highSampled(i,1));
                VELOCITY5_2(i,1) = abs(D.data_timeSplit(5,1).player2.avatarVelocity.highSampled(i,1));
            end
            figure
            
            plot(VELOCITY5_2,DISTANCE5_2,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            
%             xlim([7550 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('2P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
               %%
            obj.saveGraphWithName('_距離vs2P速度�D');
                    %%
            figure
            plot(VELOCITY5_1,DISTANCE5_1,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY5_2,DISTANCE5_2,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P_2P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs1P2P速度�D');
            end
                               %%
            if datanumber >5
            N_low = length(D.data_timeSplit(6,1).player1.time.lowSampled);
            N_high = length(D.data_timeSplit(6,1).player1.time.highSampled);
            
            
            
            DISTANCE = zeros(N_high,1);
            VELOCITY = zeros(N_high,1);
            
            
            for i=1:1:N_high
                DISTANCE6_1(i,1) = abs(D.data_timeSplit(6,1).player2.avatarPosition.highSampled(i,1)-D.data_timeSplit(6,1).player1.avatarPosition.highSampled(i,1));
                VELOCITY6_1(i,1) = abs(D.data_timeSplit(6,1).player1.avatarVelocity.highSampled(i,1));
            end
            
              figure
            
            plot(VELOCITY6_1,DISTANCE6_1,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            
%             xlim([7550 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs1P速度�E');
        %%
            
            for i=1:1:N_high
                DISTANCE6_2(i,1) = abs(D.data_timeSplit(6,1).player2.avatarPosition.highSampled(i,1)-D.data_timeSplit(6,1).player1.avatarPosition.highSampled(i,1));
                VELOCITY6_2(i,1) = abs(D.data_timeSplit(6,1).player2.avatarVelocity.highSampled(i,1));
            end
            figure
            
            plot(VELOCITY6_2,DISTANCE6_2,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            
%             xlim([7650 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('2P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
               %%
            obj.saveGraphWithName('_距離vs2P速度�E');
                    %%
            figure
            plot(VELOCITY6_1,DISTANCE6_1,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY6_2,DISTANCE6_2,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P_2P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs1P2P速度�E');
            end
                               %%
            if datanumber == 2
            
              figure
            
            plot(VELOCITY1_1,DISTANCE1_1,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY1_2,DISTANCE1_2,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY2_1,DISTANCE2_1,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY2_2,DISTANCE2_2,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            hold off
%             xlim([7550 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs1P2P速度_All');
        
            end
                                %%
            if datanumber == 3
            
              figure
            
            plot(VELOCITY1_1,DISTANCE1_1,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY1_2,DISTANCE1_2,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY2_1,DISTANCE2_1,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY2_2,DISTANCE2_2,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY3_1,DISTANCE3_1,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY3_2,DISTANCE3_2,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            hold off
%             xlim([7550 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs1P2P速度_All');
        
            end
                                  %%
            if datanumber == 4
            
              figure
            
            plot(VELOCITY1_1,DISTANCE1_1,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY1_2,DISTANCE1_2,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY2_1,DISTANCE2_1,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY2_2,DISTANCE2_2,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY3_1,DISTANCE3_1,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY3_2,DISTANCE3_2,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY4_1,DISTANCE4_1,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY4_2,DISTANCE4_2,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            hold off
%             xlim([7550 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs1P2P速度_All');
        
            end
                                      %%
            if datanumber == 5
            
              figure
            
            plot(VELOCITY1_1,DISTANCE1_1,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY1_2,DISTANCE1_2,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY2_1,DISTANCE2_1,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY2_2,DISTANCE2_2,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY3_1,DISTANCE3_1,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY3_2,DISTANCE3_2,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY4_1,DISTANCE4_1,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY4_2,DISTANCE4_2,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY5_1,DISTANCE5_1,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY5_2,DISTANCE5_2,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            hold off
%             xlim([7550 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs1P2P速度_All');
        
            end
                                      %%
            if datanumber == 6
            
              figure
            
            plot(VELOCITY1_1,DISTANCE1_1,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY1_2,DISTANCE1_2,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY2_1,DISTANCE2_1,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY2_2,DISTANCE2_2,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY3_1,DISTANCE3_1,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY3_2,DISTANCE3_2,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY4_1,DISTANCE4_1,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY4_2,DISTANCE4_2,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY5_1,DISTANCE5_1,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY5_2,DISTANCE5_2,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY6_1,DISTANCE6_1,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY6_2,DISTANCE6_2,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            hold off
%             xlim([7550 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs1P2P速度_All');
        
            end
        %%
            close all
        end

        
    end
end
