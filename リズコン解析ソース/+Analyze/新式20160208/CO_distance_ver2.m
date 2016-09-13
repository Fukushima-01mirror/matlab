classdef CO_distance_ver2 < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = CO_distance_ver2(config,data)
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
            
            indZC1_1 = zeros(1,1);
            indZC2_1 = zeros(1,1);
            indZC_1 = zeros(1,1);
            
            for f=1:1:N_high
                ZC_1P_1 = (D.data_timeSplit(1,1).player1.zeroCrossData.zeroCrossTime == f);
                 if any(ZC_1P_1)
                     indZC1_1(1,1) = indZC1_1(1,1)+ones(1,1);
                     IndexZCV1P_1(indZC1_1(1,1),1) = f;
                 end
            end
           
            for g=1:1:N_high
                 ZC_2P_1 = (D.data_timeSplit(1,1).player2.zeroCrossData.zeroCrossTime == g);
                 if any(ZC_2P_1)
                     indZC2_1(1,1) = indZC2_1(1,1)+ones(1,1);
                     IndexZCV2P_1(indZC2_1(1,1),1) = g;
                 end
            end
           
            for h=1:1:N_high
                ZC_1P_1 = (D.data_timeSplit(1,1).player1.zeroCrossData.zeroCrossTime == h);
                 ZC_2P_1 = (D.data_timeSplit(1,1).player2.zeroCrossData.zeroCrossTime == h);
                 if any(ZC_1P_1)||any(ZC_2P_1)
                     indZC_1(1,1) = indZC_1(1,1)+ones(1,1);
                     IndexZCV1P2P_1(indZC_1(1,1),1) = h;
                 end
            end
           
            DISTANCE = zeros(N_high,1);
            VELOCITY = zeros(N_high,1);
            
            for i=1:1:length(IndexZCV1P_1)
                DISTANCE1_1(i,1) = abs(D.data_timeSplit(1,1).player2.avatarPosition.highSampled(IndexZCV1P_1(i,1),1)-D.data_timeSplit(1,1).player1.avatarPosition.highSampled(IndexZCV1P_1(i,1),1));
                VELOCITY1_1(i,1) = abs(D.data_timeSplit(1,1).player1.avatarVelocity.highSampled(IndexZCV1P_1(i,1),1));
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
            obj.saveGraphWithName('_距離vs1P速度①');
            %%
             for i=1:1:length(IndexZCV2P_1)
                DISTANCE2_1(i,1) = abs(D.data_timeSplit(1,1).player2.avatarPosition.highSampled(IndexZCV2P_1(i,1),1)-D.data_timeSplit(1,1).player1.avatarPosition.highSampled(IndexZCV2P_1(i,1),1));
                VELOCITY2_1(i,1) = abs(D.data_timeSplit(1,1).player2.avatarVelocity.highSampled(IndexZCV2P_1(i,1),1));
             end
            figure
            plot(VELOCITY2_1,DISTANCE2_1,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
           
            
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('2P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs2P速度①');
            %%
            %%
                    %%
            figure
            plot(VELOCITY1_1,DISTANCE1_1,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY2_1,DISTANCE2_1,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P_2P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs1P2P速度①');
            %%
         if datanumber >1
             %%
            N_low = length(D.data_timeSplit(2,1).player1.time.lowSampled);
            N_high = length(D.data_timeSplit(2,1).player1.time.highSampled);
            
            indZC1_2 = zeros(1,1);
            indZC2_2 = zeros(1,1);
            indZC_2 = zeros(1,1);
            
            for f=1:1:N_high
                ZC_1P_2 = (D.data_timeSplit(2,1).player1.zeroCrossData.zeroCrossTime == f+D.data_timeSplit(2,1).player1.time.highSampled(1)-1);
                 if any(ZC_1P_2)
                     indZC1_2(1,1) = indZC1_2(1,1)+ones(1,1);
                     IndexZCV1P_2(indZC1_2(1,1),1) = f;
                 end
            end
            
            for g=1:1:N_high
                 ZC_2P_2 = (D.data_timeSplit(2,1).player2.zeroCrossData.zeroCrossTime == g+D.data_timeSplit(2,1).player1.time.highSampled(1)-1);
                 if any(ZC_2P_2)
                     indZC2_2(1,1) = indZC2_2(1,1)+ones(1,1);
                     IndexZCV2P_2(indZC2_2(1,1),1) = g;
                 end
            end
            
            for h=1:1:N_high
                ZC_1P_2 = (D.data_timeSplit(2,1).player1.zeroCrossData.zeroCrossTime == h+D.data_timeSplit(2,1).player1.time.highSampled(1)-1);
                 ZC_2P_2 = (D.data_timeSplit(2,1).player2.zeroCrossData.zeroCrossTime == h+D.data_timeSplit(2,1).player1.time.highSampled(1)-1);
                 if any(ZC_1P_2)||any(ZC_2P_2)
                     indZC_2(1,1) = indZC_2(1,1)+ones(1,1);
                     IndexZCV1P2P_2(indZC_2(1,1),1) = h;
                 end
            end
            
            DISTANCE = zeros(N_high,1);
            VELOCITY = zeros(N_high,1);
            
            for i=1:1:length(IndexZCV1P_2)
                DISTANCE1_2(i,1) = abs(D.data_timeSplit(2,1).player2.avatarPosition.highSampled(IndexZCV1P_2(i,1),1)-D.data_timeSplit(2,1).player1.avatarPosition.highSampled(IndexZCV1P_2(i,1),1));
                VELOCITY1_2(i,1) = abs(D.data_timeSplit(2,1).player1.avatarVelocity.highSampled(IndexZCV1P_2(i,1),1));
            end
            
              figure
            
            plot(VELOCITY1_2,DISTANCE1_2,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs1P速度②');
            %%
             for i=1:1:length(IndexZCV2P_2)
                DISTANCE2_2(i,1) = abs(D.data_timeSplit(2,1).player2.avatarPosition.highSampled(IndexZCV2P_2(i,1),1)-D.data_timeSplit(2,1).player1.avatarPosition.highSampled(IndexZCV2P_2(i,1),1));
                VELOCITY2_2(i,1) = abs(D.data_timeSplit(2,1).player2.avatarVelocity.highSampled(IndexZCV2P_2(i,1),1));
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
            obj.saveGraphWithName('_距離vs2P速度②');
            %%
            %%
                    %%
            figure
            plot(VELOCITY1_2,DISTANCE1_2,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
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
            obj.saveGraphWithName('_距離vs1P2P速度②');
         end
        %%
         if datanumber >2
             %%
            N_low = length(D.data_timeSplit(3,1).player1.time.lowSampled);
            N_high = length(D.data_timeSplit(3,1).player1.time.highSampled);
            
            indZC1_3 = zeros(1,1);
            indZC2_3 = zeros(1,1);
            indZC_3 = zeros(1,1);
            
            for f=1:1:N_high
                ZC_1P_3 = (D.data_timeSplit(3,1).player1.zeroCrossData.zeroCrossTime == f+D.data_timeSplit(3,1).player1.time.highSampled(1)-1);
                 if any(ZC_1P_3)
                     indZC1_3(1,1) = indZC1_3(1,1)+ones(1,1);
                     IndexZCV1P_3(indZC1_3(1,1),1) = f;
                 end
            end
            
            for g=1:1:N_high
                 ZC_2P_3 = (D.data_timeSplit(3,1).player2.zeroCrossData.zeroCrossTime == g+D.data_timeSplit(3,1).player1.time.highSampled(1)-1);
                 if any(ZC_2P_3)
                     indZC2_3(1,1) = indZC2_3(1,1)+ones(1,1);
                     IndexZCV2P_3(indZC2_3(1,1),1) = g;
                 end
            end
            
            for h=1:1:N_high
                ZC_1P_3 = (D.data_timeSplit(3,1).player1.zeroCrossData.zeroCrossTime == h+D.data_timeSplit(3,1).player1.time.highSampled(1)-1);
                 ZC_2P_3 = (D.data_timeSplit(3,1).player2.zeroCrossData.zeroCrossTime == h+D.data_timeSplit(3,1).player1.time.highSampled(1)-1);
                 if any(ZC_1P_3)||any(ZC_2P_3)
                     indZC_3(1,1) = indZC_3(1,1)+ones(1,1);
                     IndexZCV1P2P_3(indZC_3(1,1),1) = h;
                 end
            end
            
            DISTANCE = zeros(N_high,1);
            VELOCITY = zeros(N_high,1);
            
            for i=1:1:length(IndexZCV1P_3)
                DISTANCE1_3(i,1) = abs(D.data_timeSplit(3,1).player2.avatarPosition.highSampled(IndexZCV1P_3(i,1),1)-D.data_timeSplit(3,1).player1.avatarPosition.highSampled(IndexZCV1P_3(i,1),1));
                VELOCITY1_3(i,1) = abs(D.data_timeSplit(3,1).player1.avatarVelocity.highSampled(IndexZCV1P_3(i,1),1));
            end
            
              figure
            
            plot(VELOCITY1_3,DISTANCE1_3,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs1P速度③');
            %%
             for i=1:1:length(IndexZCV2P_3)
                DISTANCE2_3(i,1) = abs(D.data_timeSplit(3,1).player2.avatarPosition.highSampled(IndexZCV2P_3(i,1),1)-D.data_timeSplit(3,1).player1.avatarPosition.highSampled(IndexZCV2P_3(i,1),1));
                VELOCITY2_3(i,1) = abs(D.data_timeSplit(3,1).player2.avatarVelocity.highSampled(IndexZCV2P_3(i,1),1));
             end
            figure
            plot(VELOCITY2_3,DISTANCE2_3,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
           
            
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('2P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs2P速度③');
            %%
            %%
                    %%
            figure
            plot(VELOCITY1_3,DISTANCE1_3,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY2_3,DISTANCE2_3,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P_2P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs1P2P速度③');
         end
          %%
         if datanumber >3
             %%
            N_low = length(D.data_timeSplit(4,1).player1.time.lowSampled);
            N_high = length(D.data_timeSplit(4,1).player1.time.highSampled);
            
            indZC1_4 = zeros(1,1);
            indZC2_4 = zeros(1,1);
            indZC_4 = zeros(1,1);
            
            for f=1:1:N_high
                ZC_1P_4 = (D.data_timeSplit(4,1).player1.zeroCrossData.zeroCrossTime == f+D.data_timeSplit(4,1).player1.time.highSampled(1)-1);
                 if any(ZC_1P_4)
                     indZC1_4(1,1) = indZC1_4(1,1)+ones(1,1);
                     IndexZCV1P_4(indZC1_4(1,1),1) = f;
                 end
            end
            
            for g=1:1:N_high
                 ZC_2P_4 = (D.data_timeSplit(4,1).player2.zeroCrossData.zeroCrossTime == g+D.data_timeSplit(4,1).player1.time.highSampled(1)-1);
                 if any(ZC_2P_4)
                     indZC2_4(1,1) = indZC2_4(1,1)+ones(1,1);
                     IndexZCV2P_4(indZC2_4(1,1),1) = g;
                 end
            end
            
            for h=1:1:N_high
                ZC_1P_4 = (D.data_timeSplit(4,1).player1.zeroCrossData.zeroCrossTime == h+D.data_timeSplit(4,1).player1.time.highSampled(1)-1);
                 ZC_2P_4 = (D.data_timeSplit(4,1).player2.zeroCrossData.zeroCrossTime == h+D.data_timeSplit(4,1).player1.time.highSampled(1)-1);
                 if any(ZC_1P_4)||any(ZC_2P_4)
                     indZC_4(1,1) = indZC_4(1,1)+ones(1,1);
                     IndexZCV1P2P_4(indZC_4(1,1),1) = h;
                 end
            end
            
            DISTANCE = zeros(N_high,1);
            VELOCITY = zeros(N_high,1);
            
            for i=1:1:length(IndexZCV1P_4)
                DISTANCE1_4(i,1) = abs(D.data_timeSplit(4,1).player2.avatarPosition.highSampled(IndexZCV1P_4(i,1),1)-D.data_timeSplit(4,1).player1.avatarPosition.highSampled(IndexZCV1P_4(i,1),1));
                VELOCITY1_4(i,1) = abs(D.data_timeSplit(4,1).player1.avatarVelocity.highSampled(IndexZCV1P_4(i,1),1));
            end
            
              figure
            
            plot(VELOCITY1_4,DISTANCE1_4,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs1P速度④');
            %%
             for i=1:1:length(IndexZCV2P_4)
                DISTANCE2_4(i,1) = abs(D.data_timeSplit(4,1).player2.avatarPosition.highSampled(IndexZCV2P_4(i,1),1)-D.data_timeSplit(4,1).player1.avatarPosition.highSampled(IndexZCV2P_4(i,1),1));
                VELOCITY2_4(i,1) = abs(D.data_timeSplit(4,1).player2.avatarVelocity.highSampled(IndexZCV2P_4(i,1),1));
             end
            figure
            plot(VELOCITY2_4,DISTANCE2_4,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
           
            
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('2P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs2P速度④');
            %%
            %%
                    %%
            figure
            plot(VELOCITY1_4,DISTANCE1_4,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY2_4,DISTANCE2_4,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P_2P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs1P2P速度④');
         end
          %%
         if datanumber >4
             %%
            N_low = length(D.data_timeSplit(5,1).player1.time.lowSampled);
            N_high = length(D.data_timeSplit(5,1).player1.time.highSampled);
            
            indZC1_5 = zeros(1,1);
            indZC2_5 = zeros(1,1);
            indZC_5 = zeros(1,1);
            
            for f=1:1:N_high
                ZC_1P_5 = (D.data_timeSplit(5,1).player1.zeroCrossData.zeroCrossTime == f+D.data_timeSplit(5,1).player1.time.highSampled(1)-1);
                 if any(ZC_1P_5)
                     indZC1_5(1,1) = indZC1_5(1,1)+ones(1,1);
                     IndexZCV1P_5(indZC1_5(1,1),1) = f;
                 end
            end
            
            for g=1:1:N_high
                 ZC_2P_5 = (D.data_timeSplit(5,1).player2.zeroCrossData.zeroCrossTime == g+D.data_timeSplit(5,1).player1.time.highSampled(1)-1);
                 if any(ZC_2P_5)
                     indZC2_5(1,1) = indZC2_5(1,1)+ones(1,1);
                     IndexZCV2P_5(indZC2_5(1,1),1) = g;
                 end
            end
            
            for h=1:1:N_high
                ZC_1P_5 = (D.data_timeSplit(5,1).player1.zeroCrossData.zeroCrossTime == h+D.data_timeSplit(5,1).player1.time.highSampled(1)-1);
                 ZC_2P_5 = (D.data_timeSplit(5,1).player2.zeroCrossData.zeroCrossTime == h+D.data_timeSplit(5,1).player1.time.highSampled(1)-1);
                 if any(ZC_1P_5)||any(ZC_2P_5)
                     indZC_5(1,1) = indZC_5(1,1)+ones(1,1);
                     IndexZCV1P2P_5(indZC_5(1,1),1) = h;
                 end
            end
            
            DISTANCE = zeros(N_high,1);
            VELOCITY = zeros(N_high,1);
            
            for i=1:1:length(IndexZCV1P_5)
                DISTANCE1_5(i,1) = abs(D.data_timeSplit(5,1).player2.avatarPosition.highSampled(IndexZCV1P_5(i,1),1)-D.data_timeSplit(5,1).player1.avatarPosition.highSampled(IndexZCV1P_5(i,1),1));
                VELOCITY1_5(i,1) = abs(D.data_timeSplit(5,1).player1.avatarVelocity.highSampled(IndexZCV1P_5(i,1),1));
            end
            
              figure
            
            plot(VELOCITY1_5,DISTANCE1_5,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs1P速度⑤');
            %%
             for i=1:1:length(IndexZCV2P_5)
                DISTANCE2_5(i,1) = abs(D.data_timeSplit(5,1).player2.avatarPosition.highSampled(IndexZCV2P_5(i,1),1)-D.data_timeSplit(5,1).player1.avatarPosition.highSampled(IndexZCV2P_5(i,1),1));
                VELOCITY2_5(i,1) = abs(D.data_timeSplit(5,1).player2.avatarVelocity.highSampled(IndexZCV2P_5(i,1),1));
             end
            figure
            plot(VELOCITY2_5,DISTANCE2_5,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
           
            
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('2P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs2P速度⑤');
            %%
            %%
                    %%
            figure
            plot(VELOCITY1_5,DISTANCE1_5,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY2_5,DISTANCE2_5,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P_2P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs1P2P速度⑤');
         end
         %%
         if datanumber >5
             %%
            N_low = length(D.data_timeSplit(6,1).player1.time.lowSampled);
            N_high = length(D.data_timeSplit(6,1).player1.time.highSampled);
            
            indZC1_6 = zeros(1,1);
            indZC2_6 = zeros(1,1);
            indZC_6 = zeros(1,1);
            
            for f=1:1:N_high
                ZC_1P_6 = (D.data_timeSplit(6,1).player1.zeroCrossData.zeroCrossTime == f+D.data_timeSplit(6,1).player1.time.highSampled(1)-1);
                 if any(ZC_1P_6)
                     indZC1_6(1,1) = indZC1_6(1,1)+ones(1,1);
                     IndexZCV1P_6(indZC1_6(1,1),1) = f;
                 end
            end
            
            for g=1:1:N_high
                 ZC_2P_6 = (D.data_timeSplit(6,1).player2.zeroCrossData.zeroCrossTime == g+D.data_timeSplit(6,1).player1.time.highSampled(1)-1);
                 if any(ZC_2P_6)
                     indZC2_6(1,1) = indZC2_6(1,1)+ones(1,1);
                     IndexZCV2P_6(indZC2_6(1,1),1) = g;
                 end
            end
            
            for h=1:1:N_high
                ZC_1P_6 = (D.data_timeSplit(6,1).player1.zeroCrossData.zeroCrossTime == h+D.data_timeSplit(6,1).player1.time.highSampled(1)-1);
                 ZC_2P_6 = (D.data_timeSplit(6,1).player2.zeroCrossData.zeroCrossTime == h+D.data_timeSplit(6,1).player1.time.highSampled(1)-1);
                 if any(ZC_1P_6)||any(ZC_2P_6)
                     indZC_6(1,1) = indZC_6(1,1)+ones(1,1);
                     IndexZCV1P2P_6(indZC_6(1,1),1) = h;
                 end
            end
            
            DISTANCE = zeros(N_high,1);
            VELOCITY = zeros(N_high,1);
            
            for i=1:1:length(IndexZCV1P_6)
                DISTANCE1_6(i,1) = abs(D.data_timeSplit(6,1).player2.avatarPosition.highSampled(IndexZCV1P_6(i,1),1)-D.data_timeSplit(6,1).player1.avatarPosition.highSampled(IndexZCV1P_6(i,1),1));
                VELOCITY1_6(i,1) = abs(D.data_timeSplit(6,1).player1.avatarVelocity.highSampled(IndexZCV1P_6(i,1),1));
            end
            
              figure
            
            plot(VELOCITY1_6,DISTANCE1_6,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs1P速度⑥');
            %%
             for i=1:1:length(IndexZCV2P_6)
                DISTANCE2_6(i,1) = abs(D.data_timeSplit(6,1).player2.avatarPosition.highSampled(IndexZCV2P_6(i,1),1)-D.data_timeSplit(6,1).player1.avatarPosition.highSampled(IndexZCV2P_6(i,1),1));
                VELOCITY2_6(i,1) = abs(D.data_timeSplit(6,1).player2.avatarVelocity.highSampled(IndexZCV2P_6(i,1),1));
             end
            figure
            plot(VELOCITY2_6,DISTANCE2_6,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
           
            
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('2P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs2P速度⑥');
            %%
            %%
                    %%
            figure
            plot(VELOCITY1_6,DISTANCE1_6,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY2_6,DISTANCE2_6,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P_2P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs1P2P速度⑥');
         end
          %%
         if datanumber ==2
             %%
           
              figure
            
            plot(VELOCITY1_1,DISTANCE1_1,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY1_2,DISTANCE1_2,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            hold off
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs1P速度_All');
            %%

            figure
            
            plot(VELOCITY2_1,DISTANCE2_1,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY2_2,DISTANCE2_2,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
           hold off
            
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('2P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs2P速度_All');
            %%
            %%
                    %%
            figure
            plot(VELOCITY1_1,DISTANCE1_1,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY1_2,DISTANCE1_2,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY2_1,DISTANCE2_1,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY2_2,DISTANCE2_2,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            hold off
            
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P_2P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs1P2P速度_All');
         end
         %%
         if datanumber ==3
             %%
           
              figure
            
            plot(VELOCITY1_1,DISTANCE1_1,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY1_2,DISTANCE1_2,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY1_3,DISTANCE1_3,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            hold off
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs1P速度_All');
            %%

            figure
            
            plot(VELOCITY2_1,DISTANCE2_1,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY2_2,DISTANCE2_2,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY2_3,DISTANCE2_3,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            hold off
            
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('2P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs2P速度_All');
            %%
            %%
                    %%
            figure
            plot(VELOCITY1_1,DISTANCE1_1,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY1_2,DISTANCE1_2,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY2_1,DISTANCE2_1,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY2_2,DISTANCE2_2,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY1_3,DISTANCE1_3,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY2_3,DISTANCE2_3,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            hold off
            
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P_2P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs1P2P速度_All');
         end
          %%
         if datanumber ==4
             %%
           
              figure
            
            plot(VELOCITY1_1,DISTANCE1_1,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY1_2,DISTANCE1_2,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY1_3,DISTANCE1_3,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY1_4,DISTANCE1_4,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            hold off
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs1P速度_All');
            %%

            figure
            
            plot(VELOCITY2_1,DISTANCE2_1,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY2_2,DISTANCE2_2,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY2_3,DISTANCE2_3,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY2_4,DISTANCE2_4,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            hold off
            
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('2P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs2P速度_All');
            %%
            %%
                    %%
            figure
            plot(VELOCITY1_1,DISTANCE1_1,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY1_2,DISTANCE1_2,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY2_1,DISTANCE2_1,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY2_2,DISTANCE2_2,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY1_3,DISTANCE1_3,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY2_3,DISTANCE2_3,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY1_4,DISTANCE1_4,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY2_4,DISTANCE2_4,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            hold off
            
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P_2P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs1P2P速度_All');
         end
         %%
         if datanumber ==5
             %%
           
              figure
            
            plot(VELOCITY1_1,DISTANCE1_1,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY1_2,DISTANCE1_2,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY1_3,DISTANCE1_3,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY1_4,DISTANCE1_4,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY1_5,DISTANCE1_5,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            hold off
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs1P速度_All');
            %%

            figure
            
            plot(VELOCITY2_1,DISTANCE2_1,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY2_2,DISTANCE2_2,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY2_3,DISTANCE2_3,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY2_4,DISTANCE2_4,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY2_5,DISTANCE2_5,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            hold off
            
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('2P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs2P速度_All');
            %%
            %%
                    %%
            figure
            plot(VELOCITY1_1,DISTANCE1_1,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY1_2,DISTANCE1_2,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY2_1,DISTANCE2_1,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY2_2,DISTANCE2_2,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY1_3,DISTANCE1_3,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY2_3,DISTANCE2_3,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY1_4,DISTANCE1_4,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY2_4,DISTANCE2_4,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY1_5,DISTANCE1_5,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY2_5,DISTANCE2_5,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            hold off
            
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P_2P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs1P2P速度_All');
         end
         if datanumber > 5
             %%
           
              figure
            
            plot(VELOCITY1_1,DISTANCE1_1,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY1_2,DISTANCE1_2,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY1_3,DISTANCE1_3,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY1_4,DISTANCE1_4,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY1_5,DISTANCE1_5,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY1_6,DISTANCE1_6,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            hold off
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs1P速度_All');
            %%

            figure
            
            plot(VELOCITY2_1,DISTANCE2_1,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY2_2,DISTANCE2_2,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY2_3,DISTANCE2_3,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY2_4,DISTANCE2_4,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY2_5,DISTANCE2_5,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY2_6,DISTANCE2_6,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            hold off
            
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('2P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs2P速度_All');
            %%
            %%
                    %%
            figure
            plot(VELOCITY1_1,DISTANCE1_1,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY1_2,DISTANCE1_2,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY2_1,DISTANCE2_1,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY2_2,DISTANCE2_2,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY1_3,DISTANCE1_3,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY2_3,DISTANCE2_3,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY1_4,DISTANCE1_4,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY2_4,DISTANCE2_4,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY1_5,DISTANCE1_5,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY2_5,DISTANCE2_5,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY1_6,DISTANCE1_6,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY2_6,DISTANCE2_6,'Color','r','Marker','.','MarkerSize',8,'LineStyle','none');
            hold off
            
%             xlim([7540 7640]);
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P_2P アバタ速度 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
            %%
            obj.saveGraphWithName('_距離vs1P2P速度_All');
         end
        %%
            close all
        end

        
    end
end
