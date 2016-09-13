classdef CO_distance3 < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = CO_distance3(config,data)
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
            
            
            for i=1:1:N_high
                DISTANCE1(i,1) = abs(D.data_timeSplit(1,1).player2.avatarPosition.highSampled(i,1)-D.data_timeSplit(1,1).player1.avatarPosition.highSampled(i,1));
                VELOCITY_DIFF1(i,1) = D.data_timeSplit(1,1).player1.avatarVelocity.highSampled(i,1)-D.data_timeSplit(1,1).player2.avatarVelocity.highSampled(i,1);
                VELOCITY_DIFF1_2(i,1) = abs(abs(D.data_timeSplit(1,1).player1.avatarVelocity.highSampled(i,1))-abs(D.data_timeSplit(1,1).player2.avatarVelocity.highSampled(i,1)));
            end
      
            N_low = length(D.data_timeSplit(2,1).player1.time.lowSampled);
            N_high = length(D.data_timeSplit(2,1).player1.time.highSampled);
            
            for i=1:1:N_high
                DISTANCE2(i,1) = abs(D.data_timeSplit(2,1).player2.avatarPosition.highSampled(i,1)-D.data_timeSplit(2,1).player1.avatarPosition.highSampled(i,1));
                VELOCITY_DIFF2(i,1) = D.data_timeSplit(2,1).player1.avatarVelocity.highSampled(i,1)-D.data_timeSplit(2,1).player2.avatarVelocity.highSampled(i,1);
                VELOCITY_DIFF2_2(i,1) = abs(abs(D.data_timeSplit(2,1).player1.avatarVelocity.highSampled(i,1))-abs(D.data_timeSplit(2,1).player2.avatarVelocity.highSampled(i,1)));
            end
            
           
            N_low = length(D.data_timeSplit(3,1).player1.time.lowSampled);
            N_high = length(D.data_timeSplit(3,1).player1.time.highSampled);
            
            for i=1:1:N_high
                DISTANCE3(i,1) = abs(D.data_timeSplit(3,1).player2.avatarPosition.highSampled(i,1)-D.data_timeSplit(3,1).player1.avatarPosition.highSampled(i,1));
                VELOCITY_DIFF3(i,1) = D.data_timeSplit(3,1).player1.avatarVelocity.highSampled(i,1)-D.data_timeSplit(3,1).player2.avatarVelocity.highSampled(i,1);
                VELOCITY_DIFF3_2(i,1) = abs(abs(D.data_timeSplit(3,1).player1.avatarVelocity.highSampled(i,1))-abs(D.data_timeSplit(3,1).player2.avatarVelocity.highSampled(i,1)));
            end
            
             
            N_low = length(D.data_timeSplit(4,1).player1.time.lowSampled);
            N_high = length(D.data_timeSplit(4,1).player1.time.highSampled);
            
            for i=1:1:N_high
                DISTANCE4(i,1) = abs(D.data_timeSplit(4,1).player2.avatarPosition.highSampled(i,1)-D.data_timeSplit(4,1).player1.avatarPosition.highSampled(i,1));
                VELOCITY_DIFF4(i,1) = D.data_timeSplit(4,1).player1.avatarVelocity.highSampled(i,1)-D.data_timeSplit(4,1).player2.avatarVelocity.highSampled(i,1);
                VELOCITY_DIFF4_2(i,1) = abs(abs(D.data_timeSplit(4,1).player1.avatarVelocity.highSampled(i,1))-abs(D.data_timeSplit(4,1).player2.avatarVelocity.highSampled(i,1)));
            end
            
             
            N_low = length(D.data_timeSplit(5,1).player1.time.lowSampled);
            N_high = length(D.data_timeSplit(5,1).player1.time.highSampled);
            
            for i=1:1:N_high
                DISTANCE5(i,1) = abs(D.data_timeSplit(5,1).player2.avatarPosition.highSampled(i,1)-D.data_timeSplit(5,1).player1.avatarPosition.highSampled(i,1));
                VELOCITY_DIFF5(i,1) = D.data_timeSplit(5,1).player1.avatarVelocity.highSampled(i,1)-D.data_timeSplit(5,1).player2.avatarVelocity.highSampled(i,1);
                VELOCITY_DIFF5_2(i,1) = abs(abs(D.data_timeSplit(5,1).player1.avatarVelocity.highSampled(i,1))-abs(D.data_timeSplit(5,1).player2.avatarVelocity.highSampled(i,1)));
            end
            
             
            N_low = length(D.data_timeSplit(6,1).player1.time.lowSampled);
            N_high = length(D.data_timeSplit(6,1).player1.time.highSampled);
            
            for i=1:1:N_high
                DISTANCE6(i,1) = abs(D.data_timeSplit(6,1).player2.avatarPosition.highSampled(i,1)-D.data_timeSplit(6,1).player1.avatarPosition.highSampled(i,1));
                VELOCITY_DIFF6(i,1) = D.data_timeSplit(6,1).player1.avatarVelocity.highSampled(i,1)-D.data_timeSplit(6,1).player2.avatarVelocity.highSampled(i,1);
                VELOCITY_DIFF6_2(i,1) = abs(abs(D.data_timeSplit(6,1).player1.avatarVelocity.highSampled(i,1))-abs(D.data_timeSplit(6,1).player2.avatarVelocity.highSampled(i,1)));
            end
            
           N_low = length(D.data_timeSplit(7,1).player1.time.lowSampled);
           N_high = length(D.data_timeSplit(7,1).player1.time.highSampled);
            
            for i=1:1:N_high
                DISTANCE7(i,1) = abs(D.data_timeSplit(7,1).player2.avatarPosition.highSampled(i,1)-D.data_timeSplit(7,1).player1.avatarPosition.highSampled(i,1));
                VELOCITY_DIFF7(i,1) = D.data_timeSplit(7,1).player1.avatarVelocity.highSampled(i,1)-D.data_timeSplit(7,1).player2.avatarVelocity.highSampled(i,1);
                VELOCITY_DIFF7_2(i,1) = abs(abs(D.data_timeSplit(7,1).player1.avatarVelocity.highSampled(i,1))-abs(D.data_timeSplit(7,1).player2.avatarVelocity.highSampled(i,1)));
            end
            N_low = length(D.data_timeSplit(8,1).player1.time.lowSampled);
            N_high = length(D.data_timeSplit(8,1).player1.time.highSampled);
            
            for i=1:1:N_high
                DISTANCE8(i,1) = abs(D.data_timeSplit(8,1).player2.avatarPosition.highSampled(i,1)-D.data_timeSplit(8,1).player1.avatarPosition.highSampled(i,1));
                VELOCITY_DIFF8(i,1) = D.data_timeSplit(8,1).player1.avatarVelocity.highSampled(i,1)-D.data_timeSplit(8,1).player2.avatarVelocity.highSampled(i,1);
                VELOCITY_DIFF8_2(i,1) = abs(abs(D.data_timeSplit(8,1).player1.avatarVelocity.highSampled(i,1))-abs(D.data_timeSplit(8,1).player2.avatarVelocity.highSampled(i,1)));
            end
             N_low = length(D.data_timeSplit(9,1).player1.time.lowSampled);
             N_high = length(D.data_timeSplit(9,1).player1.time.highSampled);
            
            for i=1:1:N_high
                DISTANCE9(i,1) = abs(D.data_timeSplit(9,1).player2.avatarPosition.highSampled(i,1)-D.data_timeSplit(9,1).player1.avatarPosition.highSampled(i,1));
                VELOCITY_DIFF9(i,1) = D.data_timeSplit(9,1).player1.avatarVelocity.highSampled(i,1)-D.data_timeSplit(9,1).player2.avatarVelocity.highSampled(i,1);
                VELOCITY_DIFF9_2(i,1) = abs(abs(D.data_timeSplit(9,1).player1.avatarVelocity.highSampled(i,1))-abs(D.data_timeSplit(9,1).player2.avatarVelocity.highSampled(i,1)));
            end
        %%
            figure
            
            plot(VELOCITY_DIFF1_2,DISTANCE1,'Color','m','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY_DIFF3_2,DISTANCE3,'Color','m','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY_DIFF5_2,DISTANCE5,'Color','m','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY_DIFF7_2,DISTANCE7,'Color','m','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY_DIFF9_2,DISTANCE9,'Color','m','Marker','.','MarkerSize',8,'LineStyle','none');
            hold off
         
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P-2P速さの差 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
               %%
            obj.saveGraphWithName('_距離vs速度の絶対値の差_共有');
            figure
            
            plot(VELOCITY_DIFF2_2,DISTANCE2,'Color','c','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY_DIFF4_2,DISTANCE4,'Color','c','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY_DIFF6_2,DISTANCE6,'Color','c','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY_DIFF8_2,DISTANCE8,'Color','c','Marker','.','MarkerSize',8,'LineStyle','none');
            hold off
         
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P-2P速さの差 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
               %%
            obj.saveGraphWithName('_距離vs速度の絶対値の差_非共有');
              figure
            
            plot(VELOCITY_DIFF2_2,DISTANCE2,'Color','c','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY_DIFF4_2,DISTANCE4,'Color','c','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY_DIFF6_2,DISTANCE6,'Color','c','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY_DIFF8_2,DISTANCE8,'Color','c','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY_DIFF1_2,DISTANCE1,'Color','m','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY_DIFF3_2,DISTANCE3,'Color','m','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY_DIFF5_2,DISTANCE5,'Color','m','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY_DIFF7_2,DISTANCE7,'Color','m','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY_DIFF9_2,DISTANCE9,'Color','m','Marker','.','MarkerSize',8,'LineStyle','none');
            hold off
         
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P-2P速さの差 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
               %%
            obj.saveGraphWithName('_距離vs速度の絶対値の差_全');
            
             figure
            
            plot(VELOCITY_DIFF1_1,DISTANCE1,'Color','g','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY_DIFF3_1,DISTANCE3,'Color','g','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY_DIFF5_1,DISTANCE5,'Color','g','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY_DIFF7_1,DISTANCE7,'Color','g','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY_DIFF9_1,DISTANCE9,'Color','g','Marker','.','MarkerSize',8,'LineStyle','none');
            hold off
         
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P-2P速さの差 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
               %%
            obj.saveGraphWithName('_距離vs速度の差_共有');
            figure
            
            plot(VELOCITY_DIFF2_1,DISTANCE2,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY_DIFF4_1,DISTANCE4,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY_DIFF6_1,DISTANCE6,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY_DIFF8_1,DISTANCE8,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            hold off
         
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P-2P速さの差 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
               %%
            obj.saveGraphWithName('_距離vs速度の差_非共有');
              figure
            
            plot(VELOCITY_DIFF2_1,DISTANCE2,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            hold on
            plot(VELOCITY_DIFF4_1,DISTANCE4,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY_DIFF6_1,DISTANCE6,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY_DIFF8_1,DISTANCE8,'Color','b','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY_DIFF1_1,DISTANCE1,'Color','g','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY_DIFF3_1,DISTANCE3,'Color','g','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY_DIFF5_1,DISTANCE5,'Color','g','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY_DIFF7_1,DISTANCE7,'Color','g','Marker','.','MarkerSize',8,'LineStyle','none');
            plot(VELOCITY_DIFF9_1,DISTANCE9,'Color','g','Marker','.','MarkerSize',8,'LineStyle','none');
            hold off
         
            ylim([0 1000]);
%             set(gca, 'XTick', [7540:10:7640]);
            set(gca, 'YTick', [0:100:1000]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
            set(gca, 'YTickLabel', {'0' '' '' '' '' '500' '' '' '' '' '1000'});
             xlabel('1P-2P速さの差 [px/ms]');  ylabel('1P-2Pアバタ間距離　[px]');
            hold on
               %%
            obj.saveGraphWithName('_距離vs速度の差_全');
        end
        %%
            close all
    end


end
           