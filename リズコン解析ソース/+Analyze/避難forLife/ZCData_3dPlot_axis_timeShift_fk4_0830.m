classdef ZCData_3dPlot_axis_timeShift_fk4_0830 < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = ZCData_3dPlot_axis_timeShift_fk4_0830(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
            
        end

        function runForPair(obj,user1 ,user2)

           Time_LowSampled = (20 : 20 : 60000);
           [period_zx, peak_zx] = Rhythm.setZeroCrossPeriodData(user1.zeroCrossData);
           [period_zx2, peak_zx2] = Rhythm.setZeroCrossPeriodData(user2.zeroCrossData);           
          
           %　ゼロクロス間でのピーク回数取得
           [zeroCrossTimes] = Rhythm.setZeroCrossCount(user1.zeroCrossData);
           [zeroCrossTimes2] = Rhythm.setZeroCrossCount(user2.zeroCrossData);

           filterdPul = Rhythm.BPfilter( user1.operatePulse.lowSampled);
           filterdPul2 = Rhythm.BPfilter( user2.operatePulse.lowSampled);
           [timeCorr, AB_Series0, AB_Series_Max] = Rhythm.AllCorr__func(filterdPul, filterdPul2, user2.time.lowSampled, 100);
%            [timeCorr, AB_Series0, AB_Series_Max] = Rhythm.AllCorr__func(user1.operatePulse.lowSampled,user2.operatePulse.lowSampled, user2.time.lowSampled, 100);
%            disp(length(timeCorr));
%            disp(AB_Series_Max);           
%            disp(length(AB_Series_Max(:,2)));
           

            Y = abs( user1.zeroCrossData.nonlogAvtVelocity );
            dT = abs( period_zx(:,3) );
            dA = abs( peak_zx(:,3) );
            Time = abs( user1.zeroCrossData.zeroCrossTime );
            Y2 = abs( user2.zeroCrossData.nonlogAvtVelocity );
            dT2 = abs( period_zx2(:,3) );
            dA2 = abs( peak_zx2(:,3) );
            Time2 = abs( user2.zeroCrossData.zeroCrossTime );
            
           
            
           
                
%                 disp('+_high');
%                 disp(IndexHighPlusSoukan);
%                 disp('low');
%                 disp(IndexLowSoukan);
%                 disp('-_high');
%                 disp(IndexMinusSoukan);
            
%              filename_exam_1p = strcat([ num2str( obj.data.splitTimeInfo.index ) '_1P_' obj.data.splitTimeInfo.state]);
%              A = Y_diff_1P;
%              sheet = 1;
%              xlRange = 'A1';
%              xlswrite(filename_exam_1p,A,sheet,xlRange)
%              
%              filename_exam_2p = strcat([ num2str( obj.data.splitTimeInfo.index ) '_2P_' obj.data.splitTimeInfo.state]);
%              A = Y_diff_2P;
%              sheet = 1;
%              xlRange = 'A1';
%              xlswrite(filename_exam_2p,A,sheet,xlRange)

   
%             
            %               for i =1:60000
%                 if(rem(i,20) == 0)
%                     Exl(i/20,1)=mean(THETA(1,20*((i/20)-1)+1:i));
%                 end
%               end    
%             filename = strcat('回帰直線方位角',dir);
%             A = Exl;
%             sheet = 1;
%             xlRange = 'A1';
%             xlswrite(filename,A,sheet,xlRange)
%             
            
            
            
            V_max = 50000;
            dT_max = 500;
            dA_max = 500;
            
                IndexZeroCross = find(zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2);
                IndexNonZeroCross = find( zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1);
                IndexZeroCross2 = find(zeroCrossTimes2(:,1)<2&zeroCrossTimes2(:,2)<2);
                IndexNonZeroCross2 = find( zeroCrossTimes2(:,1)>1|zeroCrossTimes2(:,2)>1);

            Y_zc  = Y(IndexZeroCross);          Y_nzc  = Y(IndexNonZeroCross);
            dT_zc = dT(IndexZeroCross);         dT_nzc = dT(IndexNonZeroCross);
            dA_zc = dA(IndexZeroCross);         dA_nzc = dA(IndexNonZeroCross);
            Time_zc = Time(IndexZeroCross);     Time_nzc  = Time(IndexNonZeroCross);
            Y_zc2  = Y2(IndexZeroCross2);       Y_nzc2  = Y2(IndexNonZeroCross2);
            dT_zc2 = dT2(IndexZeroCross2);      dT_nzc2 = dT2(IndexNonZeroCross2);
            dA_zc2 = dA2(IndexZeroCross2);      dA_nzc2 = dA2(IndexNonZeroCross2);
            Time_zc2 = Time2(IndexZeroCross2);  Time_nzc2  = Time2(IndexNonZeroCross2);
            
            
            dA_border =300;
            dT_border = 50;
            k_border =2;
            indexG0 = find( dT_zc < dT_border & dA_zc < dA_border);
            indexG01 = find( dT_zc >= dT_border & (dA_zc)./dT_zc <= k_border);
            indexG02 = find( dA_zc >= dA_border & (dA_zc)./dT_zc > k_border);
            indexG1 = sort([indexG0 ; indexG01]);
            indexG2 = sort([indexG0 ; indexG02]);
            indexG0_2 = find( dT_zc2 < dT_border & dA_zc2 < dA_border);
            indexG01_2 = find( dT_zc2 >= dT_border & (dA_zc2)./dT_zc2 <= k_border);
            indexG02_2 = find( dA_zc2 >= dA_border & (dA_zc2)./dT_zc2 > k_border);
            indexG1_2 = sort([indexG0_2 ; indexG01_2]);
            indexG2_2 = sort([indexG0_2 ; indexG02_2]);
            
            Nzc = length(Y_zc) ;            Nnzc = length(Y_nzc) ;
            Nzc2 = length(Y_zc2) ;          Nnzc2 = length(Y_nzc2) ;                       
            %　時間スケールの設定            
%             spotTime = 2000;    
%             startTime =  500 * floor( user1.time.highSampled(1) /500);
%             

                startIndex = find( user1.zeroCrossData.zeroCrossTime(IndexZeroCross) >= 0 ,1 ,'first');
                endIndex = find( user1.zeroCrossData.zeroCrossTime(IndexZeroCross) <60000 ,1 ,'last');  
                startIndex2 = find( user2.zeroCrossData.zeroCrossTime(IndexZeroCross2) >= 0 ,1 ,'first');
                endIndex2 = find( user2.zeroCrossData.zeroCrossTime(IndexZeroCross2) <60000 ,1 ,'last');  
               
                
                
             velocitylength_1P = length(user1.time.lowSampled);
            Y_diff_1P = zeros(velocitylength_1P,3);
            for ii = 1:velocitylength_1P
                Y_diff_1P(ii,1) =  user1.time.lowSampled(ii,1);
                if ii>1 && ii<velocitylength_1P
                    Y_diff_1P(ii,2) = user1.avatarVelocity.highSampled(ii*20,1)...
                        -user1.avatarVelocity.highSampled((ii-1)*20,1);
                    if user1.avatarVelocity.highSampled(ii*20,1) == user1.avatarVelocity.highSampled((ii-1)*20,1)
                        Y_diff_1P(ii,2) = Y_diff_1P((ii-1),2);
                    end
%                     disp(ii);
%                     disp(user1.time.lowSampled(ii,1));
                end
            end
                
            velocitylength_2P = length(user2.time.lowSampled);
            Y_diff_2P = zeros(velocitylength_2P,3);
            for jj = 1:velocitylength_2P
                Y_diff_2P(jj,1) = user2.time.lowSampled(jj,1);
                if jj>1 && jj<velocitylength_2P
                    Y_diff_2P(jj,2) = user2.avatarVelocity.highSampled(jj*20,1)...
                        -user2.avatarVelocity.highSampled((jj-1)*20,1);
                    if user2.avatarVelocity.highSampled(jj*20,1) == user2.avatarVelocity.highSampled((jj-1)*20,1)
                        Y_diff_2P(jj,2) = Y_diff_2P((jj-1),2);
                    end

                end
            end
            
             

            Zone_Start =37000;
            Zone_End =42320;
            
            disp('1P');
            disp(size(Time_zc));
            disp('2P');
            disp(size(Time_zc2));
            
            IndexBef_Zone_1P= find(Time_zc(:,1)<Zone_Start);
            disp(size(IndexBef_Zone_1P));
            Index_Zone_1P = find(Time_zc(:,1)>=Zone_Start & Time_zc(:,1)<=Zone_End);
            disp(size(Index_Zone_1P));
            IndexAft_Zone_1P = find(Time_zc(:,1)>Zone_End);
            IndexBef_Zone_2P= find(Time_zc2(:,1)<Zone_Start);
            Index_Zone_2P = find(Time_zc2(:,1)>=Zone_Start & Time_zc2(:,1)<=Zone_End);
            IndexAft_Zone_2P = find(Time_zc2(:,1)>Zone_End);
            
            disp('1P_B');
            disp(size(IndexBef_Zone_1P));
            disp('1P_Z');
            disp(size(Index_Zone_1P));
            disp('1P_A');
            disp(size(IndexAft_Zone_1P));
            
            disp('2P_B');
            disp(size(IndexBef_Zone_2P));
            disp('2P_Z');
            disp(size(Index_Zone_2P));
            disp('2P_A');
            disp(size(IndexAft_Zone_2P));
            
%             for kk = 1:1:velocitylength_1P
%             
%                 if rem(kk,25)==0
%                     %0704避難したものはrem(kk,10)
%                      SOUKAN=corrcoef(Y_diff_1P((kk-24):kk,2),Y_diff_2P((kk-24):kk,2));
%                      
%                      if SOUKAN(1,2) > 0.6
%                          
%                          IndexSoukanPlus_ZC_1P_Pre = find(Time_zc<= Y_diff_1P(kk,1) & Time_zc >= Y_diff_1P((kk-24),1));
%                          IndexSoukanPlus_ZC_2P_Pre = find(Time_zc2<= Y_diff_1P(kk,1) & Time_zc2 >= Y_diff_1P((kk-24),1));
%                          disp('Plus');
%                          IndexSoukanPlus_ZC_1P = vertcat(IndexSoukanPlus_ZC_1P,IndexSoukanPlus_ZC_1P_Pre);
%                          IndexSoukanPlus_ZC_2P = vertcat(IndexSoukanPlus_ZC_2P,IndexSoukanPlus_ZC_2P_Pre);
%                      end
%                      
%                      if SOUKAN(1,2) < -0.6
%                          
%                          IndexSoukanMinus_ZC_1P_Pre = find(Time_zc<= Y_diff_1P(kk,1) & Time_zc >= Y_diff_1P((kk-24),1));
%                          IndexSoukanMinus_ZC_2P_Pre = find(Time_zc2<= Y_diff_1P(kk,1) & Time_zc2 >= Y_diff_1P((kk-24),1));
%                          disp('Minus');
%                          IndexSoukanMinus_ZC_1P = vertcat(IndexSoukanMinus_ZC_1P,IndexSoukanMinus_ZC_1P_Pre);
%                          IndexSoukanMinus_ZC_2P = vertcat(IndexSoukanMinus_ZC_2P,IndexSoukanMinus_ZC_2P_Pre);
%          
%                      end
%                      
%                      Y_diff_1P((kk-24):kk,3)=SOUKAN(1,2);
%                      Y_diff_2P((kk-24):kk,3)=SOUKAN(2,1);
%                      
%                      
%                 end
%             
%             end
%             disp('1Pzc正');
%             disp(size(IndexSoukanPlus_ZC_1P));
%             disp('1Pzc負');
%             disp(size(IndexSoukanMinus_ZC_1P));
%             disp('2Pzc正');
%             disp(size(IndexSoukanPlus_ZC_2P));
%             disp('2Pzc負');
%             disp(size(IndexSoukanMinus_ZC_2P));
            
%                 IndexHighPlusSoukan = find(Y_diff_1P(:,3)>0.6);
% %                 IndexLowSoukan = find(Y_diff_1P(:,3)<0.6 & Y_diff_1P(:,3)>(-0.6));
%                 IndexMinusSoukan = find(Y_diff_1P(:,3)<(-0.6));
%                 
%              
%              filename_exam_2p = strcat([ num2str( obj.data.splitTimeInfo.index ) '_2P_' obj.data.splitTimeInfo.state]);
%              A = Y_diff_2P;
%              sheet = 1;
%              xlRange = 'A1';
%              xlswrite(filename_exam_2p,A,sheet,xlRange)
                
                
                if length(Y_zc(startIndex:endIndex))>2

%                     MonitorSize = [ 0, 0, 1200, 800];
%                     set(gcf, 'Position', MonitorSize);
                    figure(1);

                    %% ３D散布図1P（距離でグループ分け）_All
                    set(gcf, 'Position', [ 0, 0, 500, 500]);
%                     subplot(4,10,[1:10,11:20]);
                    
                    bFig =0;
            
                    plot3(dT_zc(IndexBef_Zone_1P), dA_zc(IndexBef_Zone_1P) , Y_zc(IndexBef_Zone_1P) ,'MarkerEdgeColor' , 'g' ,'MarkerFaceColor','g', 'Marker','o', 'LineStyle','none','MarkerSize',3);
                    hold on
                    plot3(dT_zc(Index_Zone_1P) , dA_zc(Index_Zone_1P) , Y_zc(Index_Zone_1P) ,'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'Marker','o', 'LineStyle','none','MarkerSize',3);
                    hold on
                    plot3(dT_zc(IndexAft_Zone_1P) , dA_zc(IndexAft_Zone_1P) , Y_zc(IndexAft_Zone_1P) ,'MarkerEdgeColor' , 'r' ,'MarkerFaceColor','r', 'Marker','o', 'LineStyle','none','MarkerSize',3);
%                     plot3(dT_zc(IndexSoukanPlus_ZC_1P) , dA_zc(IndexSoukanPlus_ZC_1P) , Y_zc(IndexSoukanPlus_ZC_1P) ,'MarkerEdgeColor' , 'g' ,'MarkerFaceColor','g', 'Marker','o', 'LineStyle','none','MarkerSize',5);
%                     plot3(dT_zc(IndexSoukanMinus_ZC_1P) , dA_zc(IndexSoukanMinus_ZC_1P) , Y_zc(IndexSoukanMinus_ZC_1P) ,'MarkerEdgeColor' , 'r' ,'MarkerFaceColor','r', 'Marker','o', 'LineStyle','none','MarkerSize',5);
                    
                    %                     plot3(dT_zc(indexGd2_spot) , dA_zc(indexGd2_spot) , Y_zc(indexGd2_spot) ,'MarkerEdgeColor' , [0 .5 0] ,'MarkerFaceColor',[0 .5 0], 'Marker','o', 'LineStyle','none','MarkerSize',5);

% %20160630
% %                     plot3(  [ -100*k1_g1 ; 500*k1_g1 ] + mean(dT_zc) , [ -100*k2_g1 ; 500*k2_g1 ] + mean(dA_zc) , zeros(2,1) , 'r');
% %                     plot3( lineEdgePoint_X1Y_g1(:,1) + mean(dT_zc) , lineEdgePoint_X1Y_g1(:,2) + mean(dA_zc), lineEdgePoint_X1Y_g1(:,3) ,'r' ,'LineWidth',3 );
% %                     plot3( [ lineEdgePoint_X1Y_g1(2,1) + mean(dT_zc) ,lineEdgePoint_X1Y_g1(2,1)+ mean(dT_zc) ] ,...
% %                            [ lineEdgePoint_X1Y_g1(2,2)+ mean(dA_zc) , lineEdgePoint_X1Y_g1(2,2)+ mean(dA_zc) ] ,...
% %                            [0 lineEdgePoint_X1Y_g1(2,3)] ,'--r' );              % 垂線

%                     plot3(  [ -100*k1_g2 ; 500*k1_g2 ] + mean(dT_zc(indexG2)) , [ -100*k2_g2 ; 500*k2_g2 ] + mean(dA_zc(indexG2)) , zeros(2,1) , 'r');
%                     plot3( lineEdgePoint_X1Y_g2(:,1) + mean(dT_zc(indexG2)) , lineEdgePoint_X1Y_g2(:,2) + mean(dA_zc(indexG2)), lineEdgePoint_X1Y_g2(:,3) ,'r' ,'LineWidth',3 );
%                     plot3( [ lineEdgePoint_X1Y_g2(2,1) + mean(dT_zc(indexG2)) , lineEdgePoint_X1Y_g2(2,1) + mean(dT_zc(indexG2)) ] ,...
%                            [ lineEdgePoint_X1Y_g2(2,2) + mean(dA_zc(indexG2))  lineEdgePoint_X1Y_g2(2,2) + mean(dA_zc(indexG2))  ] ,...
%                            [0 lineEdgePoint_X1Y_g2(2,3)] ,'--r' );              % 垂線

                hold off
                grid on
                axis square
                        view(-30,30);
                xlabel('操作波形 周期の差dT');  ylabel('操作波形 振幅の差dA');  zlabel('対数演算前アバタ速さV');
                xlim([0 600]);            ylim([0 600]);          zlim([0 50000]);
  
                
%                 x2 = [ -100*k1_g2 ; 500*k1_g2 ] + mean(dT_zc(indexG2));
%                 y2 = [ -100*k2_g2 ; 500*k2_g2 ] + mean(dA_zc(indexG2));
%                 dx2 = x2(2,1)-x2(1,1);
%                 dy2 = y2(2,1)-y2(1,1);
%                 disp(fitParam_X1Y_g1);
%                 title({ ['player1 θ = ' num2str(atan(dy/dx)*360/2/pi) ' , φ = ' num2str(atan(fitParam_X1Y_g1(1))*360/2/pi) ', 傾き：' num2str( fitParam_X1Y_g1(1) )];...
%                     ['切片：' num2str(fitParam_X1Y_g1(2)) '，相関係数R：' num2str( fitLineR_X1Y_g1(1)) '，決定係数R^2：' num2str( fitLineR_X1Y_g1(1)^2)]});
                
                axis square
%                 obj.saveGraphWithNameToFolder( [ num2str( obj.data.splitTimeInfo.index ) '_1P']);
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_主成分回帰分析1P']);
%                 obj.saveGraphWithNameToFolder('1P');
                
  %% ３D散布図1P（距離でグループ分け）_B
                    set(gcf, 'Position', [ 0, 0, 500, 500]);
%                     subplot(4,10,[1:10,11:20]);
                    
                    bFig =0;
            
                    plot3(dT_zc(IndexBef_Zone_1P), dA_zc(IndexBef_Zone_1P) , Y_zc(IndexBef_Zone_1P) ,'MarkerEdgeColor' , 'g' ,'MarkerFaceColor','g', 'Marker','o', 'LineStyle','none','MarkerSize',3);
                    hold on

                hold off
                grid on
                axis square
                        view(-30,30);
                xlabel('操作波形 周期の差dT');  ylabel('操作波形 振幅の差dA');  zlabel('対数演算前アバタ速さV');
                xlim([0 600]);            ylim([0 600]);          zlim([0 50000]);
  
                
                axis square
%                 obj.saveGraphWithNameToFolder( [ num2str( obj.data.splitTimeInfo.index ) '_1P']);
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_主成分回帰分析1P_B']);
%                 obj.saveGraphWithNameToFolder('1P');
                 %% ３D散布図1P（距離でグループ分け）_Z
                    set(gcf, 'Position', [ 0, 0, 500, 500]);
%                     subplot(4,10,[1:10,11:20]);
                    
                    bFig =0;
            
                    plot3(dT_zc(Index_Zone_1P) , dA_zc(Index_Zone_1P) , Y_zc(Index_Zone_1P) ,'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'Marker','o', 'LineStyle','none','MarkerSize',3);
                    hold on
                   
                hold off
                grid on
                axis square
                        view(-30,30);
                xlabel('操作波形 周期の差dT');  ylabel('操作波形 振幅の差dA');  zlabel('対数演算前アバタ速さV');
                xlim([0 600]);            ylim([0 600]);          zlim([0 50000]);
  
                

                
                axis square
%                 obj.saveGraphWithNameToFolder( [ num2str( obj.data.splitTimeInfo.index ) '_1P']);
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_主成分回帰分析1P_Z']);
%                 obj.saveGraphWithNameToFolder('1P');
                 %% ３D散布図1P（距離でグループ分け）
                    set(gcf, 'Position', [ 0, 0, 500, 500]);
%                     subplot(4,10,[1:10,11:20]);
                    
                    bFig =0;
            
                    plot3(dT_zc(IndexAft_Zone_1P) , dA_zc(IndexAft_Zone_1P) , Y_zc(IndexAft_Zone_1P) ,'MarkerEdgeColor' , 'r' ,'MarkerFaceColor','r', 'Marker','o', 'LineStyle','none','MarkerSize',3);

                hold off
                grid on
                axis square
                        view(-30,30);
                xlabel('操作波形 周期の差dT');  ylabel('操作波形 振幅の差dA');  zlabel('対数演算前アバタ速さV');
                xlim([0 600]);            ylim([0 600]);          zlim([0 50000]);
  
                axis square
%                 obj.saveGraphWithNameToFolder( [ num2str( obj.data.splitTimeInfo.index ) '_1P']);
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_主成分回帰分析1P_A']);
%                 obj.saveGraphWithNameToFolder('1P');
                
%% ３D散布図1P（距離でグループ分け）
                    set(gcf, 'Position', [ 0, 0, 500, 500]);
%                     subplot(4,10,[1:10,11:20]);
                    
                    bFig =0;
            
                    plot3(dT_zc(IndexBef_Zone_1P), dA_zc(IndexBef_Zone_1P) , Y_zc(IndexBef_Zone_1P) ,'MarkerEdgeColor' , 'g' ,'MarkerFaceColor','g', 'Marker','o', 'LineStyle','none','MarkerSize',3);
                    hold on
                    plot3(dT_zc(Index_Zone_1P) , dA_zc(Index_Zone_1P) , Y_zc(Index_Zone_1P) ,'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'Marker','o', 'LineStyle','none','MarkerSize',3);
                    hold on
                    plot3(dT_zc(IndexAft_Zone_1P) , dA_zc(IndexAft_Zone_1P) , Y_zc(IndexAft_Zone_1P) ,'MarkerEdgeColor' , 'r' ,'MarkerFaceColor','r', 'Marker','o', 'LineStyle','none','MarkerSize',3);


                hold off
                grid on
                axis square
                        view(0,90);
                xlabel('操作波形 周期の差dT');  ylabel('操作波形 振幅の差dA');  zlabel('対数演算前アバタ速さV');
                xlim([0 600]);            ylim([0 600]);          zlim([0 50000]);
  
                

                axis square
%                 obj.saveGraphWithNameToFolder( [ num2str( obj.data.splitTimeInfo.index ) '_1P']);
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_主成分回帰分析1P_TOP']);
%                 obj.saveGraphWithNameToFolder('1P');
%% ３D散布図1P（距離でグループ分け）_B
                    set(gcf, 'Position', [ 0, 0, 500, 500]);
%                     subplot(4,10,[1:10,11:20]);
                    
                    bFig =0;
            
                    plot3(dT_zc(IndexBef_Zone_1P), dA_zc(IndexBef_Zone_1P) , Y_zc(IndexBef_Zone_1P) ,'MarkerEdgeColor' , 'g' ,'MarkerFaceColor','g', 'Marker','o', 'LineStyle','none','MarkerSize',3);
                    hold on

                hold off
                grid on
                axis square
                        view(0,90);
                xlabel('操作波形 周期の差dT');  ylabel('操作波形 振幅の差dA');  zlabel('対数演算前アバタ速さV');
                xlim([0 600]);            ylim([0 600]);          zlim([0 50000]);
  
                
                axis square
%                 obj.saveGraphWithNameToFolder( [ num2str( obj.data.splitTimeInfo.index ) '_1P']);
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_主成分回帰分析1P_B_TOP']);
%                 obj.saveGraphWithNameToFolder('1P');
                 %% ３D散布図1P（距離でグループ分け）_Z
                    set(gcf, 'Position', [ 0, 0, 500, 500]);
%                     subplot(4,10,[1:10,11:20]);
                    
                    bFig =0;
            
                    plot3(dT_zc(Index_Zone_1P) , dA_zc(Index_Zone_1P) , Y_zc(Index_Zone_1P) ,'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'Marker','o', 'LineStyle','none','MarkerSize',3);
                    hold on
                   
                hold off
                grid on
                axis square
                        view(0,90);
                xlabel('操作波形 周期の差dT');  ylabel('操作波形 振幅の差dA');  zlabel('対数演算前アバタ速さV');
                xlim([0 600]);            ylim([0 600]);          zlim([0 50000]);
  
                

                
                axis square
%                 obj.saveGraphWithNameToFolder( [ num2str( obj.data.splitTimeInfo.index ) '_1P']);
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_主成分回帰分析1P_Z_TOP']);
%                 obj.saveGraphWithNameToFolder('1P');
  %% ３D散布図1P（距離でグループ分け）
                    set(gcf, 'Position', [ 0, 0, 500, 500]);
%                     subplot(4,10,[1:10,11:20]);
                    
                    bFig =0;
            
                    plot3(dT_zc(IndexAft_Zone_1P) , dA_zc(IndexAft_Zone_1P) , Y_zc(IndexAft_Zone_1P) ,'MarkerEdgeColor' , 'r' ,'MarkerFaceColor','r', 'Marker','o', 'LineStyle','none','MarkerSize',3);

                hold off
                grid on
                axis square
                        view(0,90);
                xlabel('操作波形 周期の差dT');  ylabel('操作波形 振幅の差dA');  zlabel('対数演算前アバタ速さV');
                xlim([0 600]);            ylim([0 600]);          zlim([0 50000]);
  
                axis square
%                 obj.saveGraphWithNameToFolder( [ num2str( obj.data.splitTimeInfo.index ) '_1P']);
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_主成分回帰分析1P_A_TOP']);
%                 obj.saveGraphWithNameToFolder('1P');
                
%% ３D散布図2P（距離でグループ分け）
                    set(gcf, 'Position', [ 0, 0, 500, 500]);
%                      subplot(4,10,[21:30,31:40]);
                    
                    bFig =0;
         
                    plot3(dT_zc2(IndexBef_Zone_2P), dA_zc2(IndexBef_Zone_2P) , Y_zc2(IndexBef_Zone_2P) ,'MarkerEdgeColor' , 'g' ,'MarkerFaceColor','g', 'Marker','o', 'LineStyle','none','MarkerSize',3);
                    hold on
                    plot3(dT_zc2(Index_Zone_2P) , dA_zc2(Index_Zone_2P) , Y_zc2(Index_Zone_2P) ,'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'Marker','o', 'LineStyle','none','MarkerSize',3);
                    hold on
                    plot3(dT_zc2(IndexAft_Zone_2P) , dA_zc2(IndexAft_Zone_2P) , Y_zc2(IndexAft_Zone_2P) ,'MarkerEdgeColor' , 'r' ,'MarkerFaceColor','r', 'Marker','o', 'LineStyle','none','MarkerSize',3);       
%                     plot3(dT_nzc2, dA_nzc2 , Y_nzc2 ,'Marker','.','MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none' );
%                     plot3(dT_zc2 , dA_zc2 , Y_zc2 ,'Marker','o','MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none','MarkerSize',5);                    
%                     plot3(dT_zc2 , dA_zc2 , Y_zc2 ,'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'Marker','o', 'LineStyle','none','MarkerSize',5);
%                     plot3(dT_zc2(IndexSoukanPlus_ZC_2P) , dA_zc2(IndexSoukanPlus_ZC_2P) , Y_zc2(IndexSoukanPlus_ZC_2P) ,'MarkerEdgeColor' , 'g' ,'MarkerFaceColor','g', 'Marker','o', 'LineStyle','none','MarkerSize',5);
%                     plot3(dT_zc2(IndexSoukanMinus_ZC_2P) , dA_zc2(IndexSoukanMinus_ZC_2P) , Y_zc2(IndexSoukanMinus_ZC_2P) ,'MarkerEdgeColor' , 'r' ,'MarkerFaceColor','r', 'Marker','o', 'LineStyle','none','MarkerSize',5);
       
%                     plot3(dT_zc2(indexGd2_spot_2) , dA_zc2(indexGd2_spot_2) , Y_zc2(indexGd2_spot_2) ,'MarkerEdgeColor' , [0 .5 0] ,'MarkerFaceColor',[0 .5 0], 'Marker','o', 'LineStyle','none','MarkerSize',5);
% %20160630
% %                     plot3(  [ -100*k1_g1_2 ; 500*k1_g1_2 ] + mean(dT_zc2) , [ -100*k2_g1_2 ; 500*k2_g1_2 ] + mean(dA_zc2) , zeros(2,1) , 'r');
% %                     plot3( lineEdgePoint_X1Y_g1_2(:,1) + mean(dT_zc2) , lineEdgePoint_X1Y_g1_2(:,2) + mean(dA_zc2), lineEdgePoint_X1Y_g1_2(:,3) ,'r' ,'LineWidth',3 );
% %                     plot3( [ lineEdgePoint_X1Y_g1_2(2,1) + mean(dT_zc2) ,lineEdgePoint_X1Y_g1_2(2,1)+ mean(dT_zc2) ] ,...
% %                            [ lineEdgePoint_X1Y_g1_2(2,2)+ mean(dA_zc2) , lineEdgePoint_X1Y_g1_2(2,2)+ mean(dA_zc2) ] ,...
% %                            [0 lineEdgePoint_X1Y_g1_2(2,3)] ,'--r' );              % 垂線

%                     plot3(  [ -100*k1_g2_2 ; 500*k1_g2_2 ] + mean(dT_zc2(indexG2_2)) , [ -100*k2_g2_2 ; 500*k2_g2_2 ] + mean(dA_zc2(indexG2_2)) , zeros(2,1) , 'r');
%                     plot3( lineEdgePoint_X1Y_g2_2(:,1) + mean(dT_zc2(indexG2_2)) , lineEdgePoint_X1Y_g2_2(:,2) + mean(dA_zc2(indexG2_2)), lineEdgePoint_X1Y_g2_2(:,3) ,'r' ,'LineWidth',3 );
%                     plot3( [ lineEdgePoint_X1Y_g2_2(2,1) + mean(dT_zc2(indexG2_2)) , lineEdgePoint_X1Y_g2_2(2,1) + mean(dT_zc2(indexG2_2)) ] ,...
%                            [ lineEdgePoint_X1Y_g2_2(2,2) + mean(dA_zc2(indexG2_2))  lineEdgePoint_X1Y_g2_2(2,2) + mean(dA_zc2(indexG2_2))  ] ,...
%                            [0 lineEdgePoint_X1Y_g2_2(2,3)] ,'--r' );              % 垂線

                hold off
                grid on
                axis square
                        view(-30,30);
                xlabel('操作波形 周期の差dT');  ylabel('操作波形 振幅の差dA');  zlabel('対数演算前アバタ速さV');
                xlim([0 600]);            ylim([0 600]);          zlim([0 50000]);

                
%                 title({ ['player2 θ = ' num2str(atan(dy_2/dx_2)*360/2/pi) ' , φ = ' num2str(atan(fitParam_X1Y_g1_2(1))*360/2/pi) ', 傾き：' num2str( fitParam_X1Y_g1_2(1) )];...
%                     ['切片：' num2str(fitParam_X1Y_g1_2(2)) '，相関係数R：' num2str( fitLineR_X1Y_g1_2(1)) '，決定係数R^2：' num2str( fitLineR_X1Y_g1_2(1)^2)]});

                axis square
                

%                  obj.saveGraphWithNameToFolder( [ num2str( obj.data.splitTimeInfo.index ) '_2P']);
                 obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_主成分回帰分析2P']);
                 %                 obj.saveGraphWithNameToFolder('2P');
                %% ３D散布図2P（距離でグループ分け）
                    set(gcf, 'Position', [ 0, 0, 500, 500]);
                    
                    bFig =0;
         
                    plot3(dT_zc2(IndexBef_Zone_2P), dA_zc2(IndexBef_Zone_2P) , Y_zc2(IndexBef_Zone_2P) ,'MarkerEdgeColor' , 'g' ,'MarkerFaceColor','g', 'Marker','o', 'LineStyle','none','MarkerSize',3);
                    hold on
                    

                hold off
                grid on
                axis square
                        view(-30,30);
                xlabel('操作波形 周期の差dT');  ylabel('操作波形 振幅の差dA');  zlabel('対数演算前アバタ速さV');
                xlim([0 600]);            ylim([0 600]);          zlim([0 50000]);


                axis square
                

%                  obj.saveGraphWithNameToFolder( [ num2str( obj.data.splitTimeInfo.index ) '_2P']);
                 obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_主成分回帰分析2P_B']);
                 %                 obj.saveGraphWithNameToFolder('2P');
                  %% ３D散布図2P（距離でグループ分け）
                    set(gcf, 'Position', [ 0, 0, 500, 500]);
                    
                    bFig =0;
         
                    plot3(dT_zc2(Index_Zone_2P) , dA_zc2(Index_Zone_2P) , Y_zc2(Index_Zone_2P) ,'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'Marker','o', 'LineStyle','none','MarkerSize',3);
                    hold on

                hold off
                grid on
                axis square
                        view(-30,30);
                xlabel('操作波形 周期の差dT');  ylabel('操作波形 振幅の差dA');  zlabel('対数演算前アバタ速さV');
                xlim([0 600]);            ylim([0 600]);          zlim([0 50000]);


                axis square
                

%                  obj.saveGraphWithNameToFolder( [ num2str( obj.data.splitTimeInfo.index ) '_2P']);
                 obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_主成分回帰分析2P_Z']);
                 %                 obj.saveGraphWithNameToFolder('2P');
                  %% ３D散布図2P（距離でグループ分け）
                    set(gcf, 'Position', [ 0, 0, 500, 500]);
                    
                    bFig =0;
       
                    plot3(dT_zc2(IndexAft_Zone_2P) , dA_zc2(IndexAft_Zone_2P) , Y_zc2(IndexAft_Zone_2P) ,'MarkerEdgeColor' , 'r' ,'MarkerFaceColor','r', 'Marker','o', 'LineStyle','none','MarkerSize',3);       

                hold off
                grid on
                axis square
                        view(-30,30);
                xlabel('操作波形 周期の差dT');  ylabel('操作波形 振幅の差dA');  zlabel('対数演算前アバタ速さV');
                xlim([0 600]);            ylim([0 600]);          zlim([0 50000]);


                axis square
                

%                  obj.saveGraphWithNameToFolder( [ num2str( obj.data.splitTimeInfo.index ) '_2P']);
                 obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_主成分回帰分析2P_A']);
                 %                 obj.saveGraphWithNameToFolder('2P');
                 %% ３D散布図2P（距離でグループ分け）
                    set(gcf, 'Position', [ 0, 0, 500, 500]);
                    
                    bFig =0;
         
                    plot3(dT_zc2(IndexBef_Zone_2P), dA_zc2(IndexBef_Zone_2P) , Y_zc2(IndexBef_Zone_2P) ,'MarkerEdgeColor' , 'g' ,'MarkerFaceColor','g', 'Marker','o', 'LineStyle','none','MarkerSize',3);
                    hold on
                    plot3(dT_zc2(Index_Zone_2P) , dA_zc2(Index_Zone_2P) , Y_zc2(Index_Zone_2P) ,'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'Marker','o', 'LineStyle','none','MarkerSize',3);
                    hold on
                    plot3(dT_zc2(IndexAft_Zone_2P) , dA_zc2(IndexAft_Zone_2P) , Y_zc2(IndexAft_Zone_2P) ,'MarkerEdgeColor' , 'r' ,'MarkerFaceColor','r', 'Marker','o', 'LineStyle','none','MarkerSize',3);       

                hold off
                grid on
                axis square
                        view(0,90);
                xlabel('操作波形 周期の差dT');  ylabel('操作波形 振幅の差dA');  zlabel('対数演算前アバタ速さV');
                xlim([0 600]);            ylim([0 600]);          zlim([0 50000]);

                

                axis square
                

%                  obj.saveGraphWithNameToFolder( [ num2str( obj.data.splitTimeInfo.index ) '_2P']);
                 obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_主成分回帰分析2P_TOP']);
                 %                 obj.saveGraphWithNameToFolder('2P');
                 %% ３D散布図2P（距離でグループ分け）
                    set(gcf, 'Position', [ 0, 0, 500, 500]);
                    
                    bFig =0;
         
                    plot3(dT_zc2(IndexBef_Zone_2P), dA_zc2(IndexBef_Zone_2P) , Y_zc2(IndexBef_Zone_2P) ,'MarkerEdgeColor' , 'g' ,'MarkerFaceColor','g', 'Marker','o', 'LineStyle','none','MarkerSize',3);
                    hold on
                    

                hold off
                grid on
                axis square
                        view(0,90);
                xlabel('操作波形 周期の差dT');  ylabel('操作波形 振幅の差dA');  zlabel('対数演算前アバタ速さV');
                xlim([0 600]);            ylim([0 600]);          zlim([0 50000]);


                axis square
                

%                  obj.saveGraphWithNameToFolder( [ num2str( obj.data.splitTimeInfo.index ) '_2P']);
                 obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_主成分回帰分析2P_B_TOP']);
                 %                 obj.saveGraphWithNameToFolder('2P');
                  %% ３D散布図2P（距離でグループ分け）
                    set(gcf, 'Position', [ 0, 0, 500, 500]);
                    
                    bFig =0;
         
                    plot3(dT_zc2(Index_Zone_2P) , dA_zc2(Index_Zone_2P) , Y_zc2(Index_Zone_2P) ,'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'Marker','o', 'LineStyle','none','MarkerSize',3);
                    hold on

                hold off
                grid on
                axis square
                        view(0,90);
                xlabel('操作波形 周期の差dT');  ylabel('操作波形 振幅の差dA');  zlabel('対数演算前アバタ速さV');
                xlim([0 600]);            ylim([0 600]);          zlim([0 50000]);


                axis square
                

%                  obj.saveGraphWithNameToFolder( [ num2str( obj.data.splitTimeInfo.index ) '_2P']);
                 obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_主成分回帰分析2P_Z_TOP']);
                 %                 obj.saveGraphWithNameToFolder('2P');
                  %% ３D散布図2P（距離でグループ分け）
                    set(gcf, 'Position', [ 0, 0, 500, 500]);
                    
                    bFig =0;
       
                    plot3(dT_zc2(IndexAft_Zone_2P) , dA_zc2(IndexAft_Zone_2P) , Y_zc2(IndexAft_Zone_2P) ,'MarkerEdgeColor' , 'r' ,'MarkerFaceColor','r', 'Marker','o', 'LineStyle','none','MarkerSize',3);       

                hold off
                grid on
                axis square
                        view(0,90);
                xlabel('操作波形 周期の差dT');  ylabel('操作波形 振幅の差dA');  zlabel('対数演算前アバタ速さV');
                xlim([0 600]);            ylim([0 600]);          zlim([0 50000]);


                axis square
                

%                  obj.saveGraphWithNameToFolder( [ num2str( obj.data.splitTimeInfo.index ) '_2P']);
                 obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_主成分回帰分析2P_A_TOP']);
                 %                 obj.saveGraphWithNameToFolder('2P');
                end
                
                %この下なぜかコメントアウトされてた(20160630)
              %% アバタ位置
                MonitorSize = [ 0, 0, 1200, 400];
                %0824 1200→400
                    set(gcf, 'Position', MonitorSize);
                    figure(1);
                
                    subplot(1,10,1:10);
                %1Pグループ補正 
%                     n_group = 1;    %group_dの数　＝　ゼロクロス回数
%                     time_s = zeros(100,1);
%                     time_e = zeros(100,1);
%                     group_d_fixed = zeros(length(user1.time.highSampled),1);    %group_dを1ms単位に補正
%                     times_zc = 1;   %何回目のゼロクロスか
%                     for i = user1.time.highSampled(1)+1 : user1.time.highSampled(end)
%                         group_d_fixed(i-user1.time.highSampled(1)+1)=group_d_fixed(i-user1.time.highSampled(1));
%                         if(i==Time_zc(times_zc))
%                             group_d_fixed(i-user1.time.highSampled(1)+1)=group_d(times_zc);
%                             if(times_zc<length(Time_zc)) times_zc = times_zc + 1;    end
%                         end
%                     end
%                 %直線２の時間帯検出
%                     for i = user1.time.highSampled(1)+1 : user1.time.highSampled(end)
%                         if(group_d_fixed(i-user1.time.highSampled(1)+1) == 2 && group_d_fixed(i-user1.time.highSampled(1)) < 2)
%                                 time_s(n_group) = user1.time.highSampled(i-user1.time.highSampled(1)+1);
%                         elseif(group_d_fixed(i-user1.time.highSampled(1)+1) == 1 && group_d_fixed(i-user1.time.highSampled(1)) == 2)
%                                 time_e(n_group) = user1.time.highSampled(i-user1.time.highSampled(1)+1);
%                         end
%                         
%                         if(i==user1.time.highSampled(end) && time_s(n_group)>0)
%                             time_e(n_group)=user1.time.highSampled(end);
%                             break
%                         end
%                         
% %                         disp(strcat(num2str(time_s(n_group)),',',num2str(time_e(n_group)),',',num2str(n_group)));
% 
%                         if(time_s(n_group)>0 && time_e(n_group)>0)
%                             n_group = n_group + 1;
%                         end
%                     end
% 
%                 %2Pグループ補正
%                     n_group_2 = 1;
%                     time_s_2 = zeros(100,1);
%                     time_e_2 = zeros(100,1);
%                     group_d_fixed2 = zeros(length(user2.time.highSampled),1);
%                     times_zc2=1;
%                     for i=user2.time.highSampled(1)+1:user2.time.highSampled(end)
%                         group_d_fixed2(i-user2.time.highSampled(1)+1)=group_d_fixed2(i-user2.time.highSampled(1));
%                         if(i==Time_zc2(times_zc2))
%                             group_d_fixed2(i-user2.time.highSampled(1)+1)=group_d_2(times_zc2,1);
%                             if(times_zc2<length(Time_zc2))
%                                 times_zc2 = times_zc2 + 1;    
%                             end
%                         end
%                     end
%                 %直線２の時間帯検出
%                     for i = user2.time.highSampled(1)+1 :user2.time.highSampled(end)
%                         if(group_d_fixed2(i-user2.time.highSampled(1)+1) == 2 && group_d_fixed2(i-user2.time.highSampled(1)) < 2)
%                                 time_s_2(n_group_2) = user2.time.highSampled(i-user2.time.highSampled(1)+1);
%                         elseif(group_d_fixed2(i-user2.time.highSampled(1)+1) == 1 && group_d_fixed2(i-user2.time.highSampled(1)) == 2)
%                                 time_e_2(n_group_2) = user2.time.highSampled(i-user2.time.highSampled(1)+1);
%                         end
%                         
%                         if(i==user2.time.highSampled(end) && time_s_2(n_group_2)>0)
%                             time_e_2(n_group_2)=user2.time.highSampled(end);
%                             break
%                         end
%                         
% %                         disp(strcat(num2str(time_s_2(n_group_2)),',',num2str(time_e_2(n_group_2)),',',num2str(n_group_2)));
% % 
%                         if(time_s_2(n_group_2)>0 && time_e_2(n_group_2)>0)
%                             n_group_2 = n_group_2 + 1;
%                         end
%                     end
%                     
%                   %直線2がかぶっている時間帯検出                  
%                     n_group_lap = 1;
%                     time_s_lap = zeros(100,1);
%                     time_e_lap = zeros(100,1);
%                     group_d_lap = zeros(length(group_d_fixed),1);
%                     for i=1:length(group_d_fixed)
%                         if(group_d_fixed(i)==2 && group_d_fixed2(i)==2)
%                             group_d_lap(i)=1;
%                         end
%                     end
%                     for i = 2:length(group_d_lap)
%                         if(group_d_lap(i) == 1 && group_d_lap(i-1) == 0)
%                                 time_s_lap(n_group_lap) = user1.time.highSampled(i);
%                         elseif(group_d_lap(i) == 0 && group_d_lap(i-1) == 1)
%                                 time_e_lap(n_group_lap) = user1.time.highSampled(i);
%                         end
%                         
%                         if(i == length(group_d_lap) && time_s_lap(n_group_lap)>0)
%                             time_e_lap(n_group_lap)=user1.time.highSampled(end);
%                             break
%                         end
%                         
% %                         disp(strcat(num2str(time_s_2(n_group_2)),',',num2str(time_e_2(n_group_2)),',',num2str(n_group_2)));
% 
%                         if(time_s_lap(n_group_lap)>0 && time_e_lap(n_group_lap)>0)
%                             n_group_lap = n_group_lap + 1;
%                         end
%                     end
%                     
                    hold on

%                         for i = 1:n_group
%                            area([time_s(i) time_e(i)],[1000 1000],'FaceColor',[.7 1 1],'EdgeColor','none');
%                         end
%                         for i = 1:n_group_2
%                            area([time_s_2(i) time_e_2(i)],[1000 1000],'FaceColor',[1 1 .7],'EdgeColor',[1 1 .7]);
%                         end
%                         for i = 1:n_group_lap
%                             area([time_s_lap(i) time_e_lap(i)],[1000 1000],'FaceColor',[1 .9 1],'EdgeColor',[1 .9 1]);
%                         end
% 
                           %bar(Y_diff_1P(IndexHighPlusSoukan,1),Y_diff_1P(IndexHighPlusSoukan,3)*1000000,'FaceColor','g','EdgeColor','none');
%                            bar(Y_diff_1P(IndexLowSoukan,1),Y_diff_1P(IndexLowSoukan,3)*1000000,'FaceColor',[1 1 .7],'EdgeColor','none');
                           %bar(Y_diff_1P(IndexMinusSoukan,1),Y_diff_1P(IndexMinusSoukan,3)*(-1000000),'FaceColor','r','EdgeColor','none');
%                          bar(Time_LowSampled(IndexHighPlusSoukan),500,[.7 1 1], 'EdgeColor', 'none');
%                          bar(Time_LowSampled(IndexLowSoukan),[1 1 .7], 'EdgeColor', 'none');
%                          bar(Time_LowSampled(IndexMinusSoukan),[1 .9 1], 'EdgeColor', 'none');
                         
                        a = plot(   user1.time.lowSampled,  user1.avatarPosition.lowSampled , 'color', 'b');
                        
%                       plot([spotTimeMax-spotTime+1 spotTimeMax-spotTime+1],[0 1000],'--k');
  %                      plot([spotTimeMax spotTimeMax],[0 1000],'--k');
                        %plot([0 60000],[100 100],'k:');
                            
                        b = plot(user1.time.highSampled, ...
                            abs(user2.avatarPosition.highSampled - user1.avatarPosition.highSampled),':','Color','r','LineWidth',4);
                        
                        c = plot( user2.time.highSampled , user2.avatarPosition.highSampled , 'g');
                        area([0 60000],[0 0],'FaceColor','k','EdgeColor','k');
                    hold off
                    
                    if ~isempty(  findstr( char( obj.config.examType ) , '剣道'))
                        title({['アバタ位置 アバタ間距離標準偏差:' num2str(std(abs(user2.avatarPosition.highSampled - user1.avatarPosition.highSampled)))]; ...
                            ['アバタ間距離平均:' num2str(mean(abs(user2.avatarPosition.highSampled - user1.avatarPosition.highSampled)))]});
                    end
                    legend([a,c,b],'1P', '2P' ,'距離','Location', 'NorthWest'); 
                    xlabel('時間t ms'); ylabel('アバタ位置');
                    xlim([0 60000]);    ylim([0 1000]);

%                %% コントローラ操作と相関
%                     subplot(3,10,11:20);
%                     
%                     hold on
%                         for i = 1:n_group
%                            area([time_s(i) time_e(i)],[800 800],'FaceColor',[.7 1 1],'EdgeColor','none','basevalue',-400);
%                         end
%                         for i = 1:n_group_2
%                            area([time_s_2(i) time_e_2(i)],[800 800],'FaceColor',[1 1 .7],'EdgeColor','none','basevalue',-400);
%                         end
%                         for i = 1:n_group_lap
%                             area([time_s_lap(i) time_e_lap(i)],[800 800],'FaceColor',[1 .9 1],'EdgeColor','none','basevalue',-400);
%                         end
%                     
%                         plot([0 60000],[0 0],'k');
%                         [haxes,hline1,hline2] = plotyy(user1.time.lowSampled, filterdPul,  timeCorr, AB_Series_Max(:,2));
% 
%                     
%                         set(hline1,'Color','b');
%                         set(hline2,'Color','r');
%                         set(haxes(1),'YColor','k');
%                         set(haxes(2),'YColor','r');
%                         
%                     hold off
% 
%                     hold( haxes(1),'on') % 重ね書きモードオン
% %                         plot([spotTimeMax-spotTime+1 spotTimeMax-spotTime+1],[-400 400],'--k');
% %                         plot([spotTimeMax spotTimeMax],[-400 400],'--k');
% 
%                         a = plot(   haxes(1), user2.time.lowSampled,  filterdPul2 ,'g');
% 
%                     hold( haxes(2),'on') % 重ね書きモードオン
%                         plot( haxes(2),[0 60000], [0.8 0.8],'k:');
%                     hold off
%                     
%                     if ~isempty(  findstr( char( obj.config.examType ) , '剣道'))
%                         title( [ 'コントローラ操作波形　最大相互相関 ']);
%                     end
%                     axes(haxes(1))
%                     xlabel('時間t ms'); ylabel('コントローラ操作');
%                     xlim([0 60000]);    ylim([-400 400]);
%                     set(gca,'YTick',[-400:200:400]);
% 
%                     axes(haxes(2))
%                     legend([hline1,a,hline2],'1P','2P', '最大相互相関','Location', 'NorthWest');
%                     xlabel('時間t ms'); ylabel('最大相互相関');
%                     xlim([0 60000]);    ylim([0 1]);
%                     set(gca,'YTick',[0:0.2:1]);
%                 
%             %% 操作周期差（ΔT）,操作振幅差（ΔA）
%                 subplot(3,10,21:30);
%                 hold on
%                     for i = 1:n_group
%                        area([time_s(i) time_e(i)],[1000 1000],'FaceColor',[.7 1 1],'EdgeColor','none');
%                     end
%                     for i = 1:n_group_2
%                        area([time_s_2(i) time_e_2(i)],[1000 1000],'FaceColor',[1 1 .7],'EdgeColor',[1 1 .7]);
%                     end
%                     for i = 1:n_group_lap
%                         area([time_s_lap(i) time_e_lap(i)],[1000 1000],'FaceColor',[1 .9 1],'EdgeColor',[1 .9 1]);
%                     end
%                     a = plot( user1.zeroCrossData.zeroCrossTime , abs(period_zx(:,3)) , 'b'); 
% %                     plot([spotTimeMax-spotTime+1 spotTimeMax-spotTime+1],[0 1000],'--k');
% %                     plot([spotTimeMax spotTimeMax],[0 1000],'--k');
%                     b = plot( user2.zeroCrossData.zeroCrossTime , abs(period_zx2(:,3)) , 'g');
%                     c = plot( user1.zeroCrossData.zeroCrossTime , abs(peak_zx(:,3)) , 'b:' ,'LineWidth',2.5 );
%                     d = plot( user2.zeroCrossData.zeroCrossTime , abs(peak_zx2(:,3)) , 'g:' ,'LineWidth',2.5 );
% 
%                 hold off

%                 title( [ 'コントローラ操作　周期差  ( ' char( obj.data.splitTimeInfo.state ) ' ）']);
%                 legend([a,b,c,d],'1PΔT', '2PΔT','1PΔA', '2PΔA','Location', 'NorthWest');
%                 xlabel('時間t ms'); ylabel('周期差ΔT ms');
%                 xlim([0 60000]);    ylim([0 600]);

             filename_exam = strcat([ num2str( obj.data.splitTimeInfo.index ) '_1P_' obj.data.splitTimeInfo.state]);
             A = [user1.time.highSampled abs(user2.avatarPosition.highSampled - user1.avatarPosition.highSampled)];
             sheet = 1;
             xlRange = 'A1';
             xlswrite(filename_exam,A,sheet,xlRange)

              % 保存
                    %一枚ずつ保存
                     if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
                        obj.saveGraphWithNameToFolder( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_End justifies means2']);
                     else
                         obj.saveGraphWithNamToFolder('End');
                     end
                     %この上なぜかコメントアウトされてた(20160630)

            %%      近似面　係数　エクセルデータ出力  
% %             VIF = Rhythm.getVIF([X1_zc(:,3), X2_zc(:,3)]);
%             VIF = [ NaN ,NaN ];
%             outputTitle = { '定数項' , '周期差' , '振幅差',...
%                                     'VIF(周期差)', 'VIF（振幅差）','重相関R','重決定R2' };
%             output = num2cell( [fitParam3' VIF fitR fitR2] );
%             
%             if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
%                 obj.outputAllToXlsWithName([ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state ] , output , outputTitle)
%             else
%                 obj.outputAllToXls(output , outputTitle);
%             end
            
        end

        
    end
end
