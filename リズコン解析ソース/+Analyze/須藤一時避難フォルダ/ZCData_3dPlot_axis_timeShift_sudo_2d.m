classdef ZCData_3dPlot_axis_timeShift_sudo_2d < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = ZCData_3dPlot_axis_timeShift_sudo_2d(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
            
        end

        function runForPair(obj,user1 ,user2)
            
            t_wall = 30000;

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
            
            
            dA_border =100;
            dT_border = 50;
            k_border =2;
            
            for i = 1 : length(IndexZeroCross)
                if Time(IndexZeroCross(i)) < t_wall
                    indexGwall(i) = IndexZeroCross(i);
                end
            end
            for i = 1 : length(IndexZeroCross2)
                if Time2(IndexZeroCross2(i)) < t_wall
                    indexGwall2(i) = IndexZeroCross2(i);
                end
            end
            
            Nzc_wall = length(indexGwall);
%             Nzc_nwall = length(IndexZeroCross(Nzc_wall+1:end));
            Nzc_wall2 = length(indexGwall2);
%             Nzc_nwall = length(IndexZeroCross(Nzc_wall+1:end));
                    indexG0 = find( dT_zc < dT_border & dA_zc < dA_border );
                    indexG01 = find( dT_zc >= dT_border & (dA_zc)./dT_zc <= k_border );
                    indexG02 = find( dA_zc >= dA_border & (dA_zc)./dT_zc > k_border );
            
                    startG0=0;
                    startG01=0;
                    startG02=0;
                    for i = 1 : length(indexG0)
                        if indexG0(i) > indexGwall(end)
                            startG0 = i;
                        end
                    end
                    for i = 1 : length(indexG01)
                        if indexG01(i) > indexGwall(end)
                            startG01 = i;
                        end
                    end
                    for i = 1 : length(indexG02)
                        if indexG02(i) > indexGwall(end)
                            startG02 = i;
                        end
                    end
                    
                    indexG0nwall = indexG0(startG0:end);
                    indexG01nwall = indexG01(startG01:end);
                    indexG02nwall = indexG02(startG02:end);
                    
            indexG1nwall = sort([indexG0nwall ; indexG01nwall]);
            indexG2nwall = sort([indexG0nwall ; indexG02nwall]);
            
%             disp(indexG0);
%             disp(length(indexG0nwall));
%             disp(length(indexG01));
%             disp(length(indexG02));
            
                    indexG0_2 = find( dT_zc2 < dT_border & dA_zc2 < dA_border );
                    indexG01_2 = find( dT_zc2 >= dT_border & (dA_zc2)./dT_zc2 <= k_border );
                    indexG02_2 = find( dA_zc2 >= dA_border & (dA_zc2)./dT_zc2 > k_border );
                    
                    startG0_2=1;
                    startG01_2=1;
                    startG02_2=1;
                    for i = 1 : length(indexG0_2)
                        if indexG0_2(i) > indexGwall2(end)
                            startG0_2 = i;
                        end
                    end
                    for i = 1 : length(indexG01_2)
                        if indexG01_2(i) > indexGwall2(end)
                            startG01_2 = i;
                        end
                    end
                    for i = 1 : length(indexG02_2)
                        if indexG02_2(i) > indexGwall2(end)
                            startG02_2 = i;
                        end
                    end
                    
%                     if(startG0_2 ==~0)     
                        indexG0nwall2 = indexG0_2(startG0_2:end);   
%                     else
%                         indexG0nwall2 = 0;
%                     end
%                     if(startG01_2 ==~0)    
                        indexG01nwall2 = indexG01_2(startG01_2:end);   
%                     else
%                         indexG01nwall2 = 0;    
%                     end
%                     if(startG02_2 ==~0)    
                        indexG02nwall2 = indexG02_2(startG02_2:end);   
%                     else
%                         indexG02nwall2 = 0;    
%                     end
%             
%             if indexG0nwall2==0 && indexG01nwall2==0
%                 indexG1nwall2 = 0;
%             else
                indexG1nwall2 = sort([indexG0nwall2 ; indexG01nwall2]);
%             end
%             if indexG0nwall2==0 && indexG02nwall2==0
%                 indexG2nwall2 = 0;
%             else                
                indexG2nwall2 = sort([indexG0nwall2 ; indexG02nwall2]);
%             end
            
            Nzc = length(Y_zc) ;            Nnzc = length(Y_nzc) ;
            Nzc2 = length(Y_zc2) ;          Nnzc2 = length(Y_nzc2) ;                       
            %　時間スケールの設定            
            spotTime = 2000;    
            startTime =  500 * floor( user1.time.highSampled(1) /500);
            
            Num = 1;

            for spotTimeMax =  500 * floor( (spotTime+startTime) /500) : 500: 500 * ceil(user1.time.highSampled(end) /500);

                startIndex = find( user1.zeroCrossData.zeroCrossTime(IndexZeroCross) >= ( spotTimeMax - spotTime +1 ) ,1 ,'first');
                endIndex = find( user1.zeroCrossData.zeroCrossTime(IndexZeroCross) < spotTimeMax ,1 ,'last');  
                startIndex2 = find( user2.zeroCrossData.zeroCrossTime(IndexZeroCross2) >= ( spotTimeMax - spotTime +1 ) ,1 ,'first');
                endIndex2 = find( user2.zeroCrossData.zeroCrossTime(IndexZeroCross2) < spotTimeMax ,1 ,'last');  
                
                if length(Y_zc(startIndex:endIndex))>2

                    MonitorSize = [ 0, 0, 800, 1200];
                    set(gcf, 'Position', MonitorSize);
                    figure(1);

                    %% ３D散布図1P（距離でグループ分け）
                    subplot(3,2,1);
                    
                    bFig =0;
            % クラスター1
                [k1_g1 , k2_g1, X1_g1, fitParam_X1Y_g1, fitLineR_X1Y_g1] = Rhythm.PCA_regress_3dplot(dT_zc(indexG1nwall) , dA_zc(indexG1nwall) , Y_zc(indexG1nwall) , bFig) ;
            % クラスター2
                [k1_g2 , k2_g2, X1_g2, fitParam_X1Y_g2, fitLineR_X1Y_g2] = Rhythm.PCA_regress_3dplot(dT_zc(indexG2nwall) , dA_zc(indexG2nwall) , Y_zc(indexG2nwall) , bFig) ;
            % クラスターwall
                [k1_gwall , k2_gwall, X1_gwall, fitParam_X1Y_gwall, fitLineR_X1Y_gwall] = Rhythm.PCA_regress_3dplot(dT_zc(indexGwall) , dA_zc(indexGwall) , Y_zc(indexGwall) , bFig) ;                
            % 回帰直線(クラスタ１)との距離(全データ)     
                [vector_HP_g1 , distError_g1 , distMean_g1] = Rhythm.PCA_regDist(dT_zc , dA_zc , Y_zc , k1_g1, k2_g1 , X1_g1, mean([dT_zc , dA_zc]) ,  fitParam_X1Y_g1, bFig );
            % 回帰直線(クラスタ2)との距離(全データ)    
                [vector_HP_g2 , distError_g2 , distMean_g2] = Rhythm.PCA_regDist(dT_zc , dA_zc , Y_zc , k1_g2, k2_g2 , X1_g2, mean([dT_zc , dA_zc]) , fitParam_X1Y_g2, bFig );                
                

%                 disp(distError_g1);
                d_threshold = 12;
                for i = 1:Nzc
                    if i <= Nzc_wall
                        group_d(i,1) = 3;
                    elseif distError_g1(i) - distError_g2(i) < 0
                        group_d(i,1) = 1;
                        if abs( distError_g1(i) - distError_g2(i) ) < d_threshold
                            group_d(i,1) = group_d(i-1,1);
                        end
                    elseif distError_g2(i) - distError_g1(i) < 0
                        group_d(i,1) = 2;
                        if abs( distError_g1(i) - distError_g2(i) ) < d_threshold
                            group_d(i,1) = group_d(i-1,1);
                        end
                    end
                end
                
                group_d_spot = zeros(Nzc,1);
                for i = startIndex:endIndex
                    if i <= Nzc_wall
                        group_d_spot(i,1) = 3;
                    elseif distError_g1(i) - distError_g2(i) < 0
                        group_d_spot(i , 1) = 1;
                        if abs( distError_g1(i) - distError_g2(i) ) < d_threshold
                            group_d_spot(i , 1) = group_d_spot(i-1 , 1);
                        end
                    elseif distError_g2(i) - distError_g1(i) < 0
                        group_d_spot(i , 1) = 2;
                        if abs( distError_g1(i) - distError_g2(i) ) < d_threshold
                            group_d_spot(i , 1) = group_d_spot(i-1 , 1);
                        end
                    end
                end

%                 indexGd1 = find( group_d == 1 );
%                 indexGd2 = find( group_d == 2 );
                indexGd1_spot = find( group_d_spot == 1 );
                indexGd2_spot = find( group_d_spot == 2 );
                indexGdwall_spot = find( group_d_spot == 3 );
                
                disp(indexGd1_spot);
                disp(indexGd2_spot);
                disp(indexGdwall_spot);
                
                lineEdgePoint_X1Y_g1 = [ min(X1_g1)*k1_g1 , min(X1_g1)*k2_g1 , polyval( fitParam_X1Y_g1, min(X1_g1) ) ;...
                                        max(X1_g1)*k1_g1 , max(X1_g1)*k2_g1 , polyval( fitParam_X1Y_g1, max(X1_g1) ) ];
                lineEdgePoint_X1Y_g2 = [ min(X1_g2)*k1_g2 , min(X1_g2)*k2_g2 , polyval( fitParam_X1Y_g2, min(X1_g2) ) ;...
                                        max(X1_g2)*k1_g2 , max(X1_g2)*k2_g2 , polyval( fitParam_X1Y_g2, max(X1_g2) ) ];
                lineEdgePoint_X1Y_gwall = [ min(X1_gwall)*k1_gwall , min(X1_gwall)*k2_gwall , polyval( fitParam_X1Y_gwall, min(X1_gwall) ) ;...
                                        max(X1_gwall)*k1_gwall , max(X1_gwall)*k2_gwall , polyval( fitParam_X1Y_gwall, max(X1_gwall) ) ];
                plot3( [0 0],[0 0],[0 0],'k' );
                hold on
                    plot3(dT_nzc, dA_nzc , Y_nzc ,'Marker','.','MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none' ,'MarkerSize',4);
                    plot3(dT_zc , dA_zc , Y_zc ,'Marker','.','MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none','MarkerSize',4);

                    plot3(dT_zc(indexGdwall_spot) , dA_zc(indexGdwall_spot) , Y_zc(indexGdwall_spot) ,'MarkerEdgeColor' , 'y' ,'MarkerFaceColor','y', 'Marker','o', 'LineStyle','none','MarkerSize',5);
                    plot3(dT_zc(indexGd1_spot) , dA_zc(indexGd1_spot) , Y_zc(indexGd1_spot) ,'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'Marker','o', 'LineStyle','none','MarkerSize',5);
                    plot3(dT_zc(indexGd2_spot) , dA_zc(indexGd2_spot) , Y_zc(indexGd2_spot) ,'MarkerEdgeColor' , [0 .5 0] ,'MarkerFaceColor',[0 .5 0], 'Marker','o', 'LineStyle','none','MarkerSize',5);

                    plot3(  [ -100*k1_g1 ; 500*k1_g1 ] + mean(dT_zc(indexG1nwall)) , [ -100*k2_g1 ; 500*k2_g1 ] + mean(dA_zc(indexG1nwall)) , zeros(2,1) , 'r');
                    plot3( lineEdgePoint_X1Y_g1(:,1) + mean(dT_zc(indexG1nwall)) , lineEdgePoint_X1Y_g1(:,2) + mean(dA_zc(indexG1nwall)), lineEdgePoint_X1Y_g1(:,3) ,'r' ,'LineWidth',3 );
                    plot3( [ lineEdgePoint_X1Y_g1(2,1) + mean(dT_zc(indexG1nwall)) ,lineEdgePoint_X1Y_g1(2,1)+ mean(dT_zc(indexG1nwall)) ] ,...
                           [ lineEdgePoint_X1Y_g1(2,2)+ mean(dA_zc(indexG1nwall)) , lineEdgePoint_X1Y_g1(2,2)+ mean(dA_zc(indexG1nwall)) ] ,...
                           [0 lineEdgePoint_X1Y_g1(2,3)] ,'--r' );              % 垂線

                    plot3(  [ -100*k1_g2 ; 500*k1_g2 ] + mean(dT_zc(indexG2nwall)) , [ -100*k2_g2 ; 500*k2_g2 ] + mean(dA_zc(indexG2nwall)) , zeros(2,1) , 'r');
                    plot3( lineEdgePoint_X1Y_g2(:,1) + mean(dT_zc(indexG2nwall)) , lineEdgePoint_X1Y_g2(:,2) + mean(dA_zc(indexG2nwall)), lineEdgePoint_X1Y_g2(:,3) ,'r' ,'LineWidth',3 );
                    plot3( [ lineEdgePoint_X1Y_g2(2,1) + mean(dT_zc(indexG2nwall)) , lineEdgePoint_X1Y_g2(2,1) + mean(dT_zc(indexG2nwall)) ] ,...
                           [ lineEdgePoint_X1Y_g2(2,2) + mean(dA_zc(indexG2nwall))  lineEdgePoint_X1Y_g2(2,2) + mean(dA_zc(indexG2nwall))  ] ,...
                           [0 lineEdgePoint_X1Y_g2(2,3)] ,'--r' );              % 垂線
                    
                    plot3(  [ -100*k1_gwall ; 500*k1_gwall ] + mean(dT_zc(indexGwall)) , [ -100*k2_gwall ; 500*k2_gwall ] + mean(dA_zc(indexGwall)) , zeros(2,1) , 'm');
                    plot3( lineEdgePoint_X1Y_gwall(:,1) + mean(dT_zc(indexGwall)) , lineEdgePoint_X1Y_gwall(:,2) + mean(dA_zc(indexGwall)), lineEdgePoint_X1Y_gwall(:,3) ,'m' ,'LineWidth',3 );
                    plot3( [ lineEdgePoint_X1Y_gwall(2,1) + mean(dT_zc(indexGwall)) , lineEdgePoint_X1Y_gwall(2,1) + mean(dT_zc(indexGwall)) ] ,...
                           [ lineEdgePoint_X1Y_gwall(2,2) + mean(dA_zc(indexGwall))  lineEdgePoint_X1Y_gwall(2,2) + mean(dA_zc(indexGwall))  ] ,...
                           [0 lineEdgePoint_X1Y_gwall(2,3)] ,'--m' );              % 垂線
                hold off
                grid on
                axis square
                view(2);
                xlabel('操作波形 周期の差dT');  ylabel('操作波形 振幅の差dA');  zlabel('対数演算前アバタ速さV');
                xlim([0 600]);            ylim([0 600]);          zlim([0 50000]);
  
                x = [ -100*k1_g1 ; 500*k1_g1 ] + mean(dT_zc(indexG1nwall));
                y = [ -100*k2_g1 ; 500*k2_g1 ] + mean(dA_zc(indexG1nwall));
                dx = x(2,1)-x(1,1);
                dy = y(2,1)-y(1,1);
                x2 = [ -100*k1_g2 ; 500*k1_g2 ] + mean(dT_zc(indexG2nwall));
                y2 = [ -100*k2_g2 ; 500*k2_g2 ] + mean(dA_zc(indexG2nwall));
                dx2 = x2(2,1)-x2(1,1);
                dy2 = y2(2,1)-y2(1,1);
                
                title( ['player1 θ1 = ' num2str(atan(dy/dx)*360/2/pi) ' , θ2 = ' num2str(atan(dy2/dx2)*360/2/pi) ] );
                
                axis square
                
                %% 
                subplot(3,2,3);
                
                plot3( [0 0],[0 0],[0 0],'k' );
                hold on
                    plot3(dT_nzc, dA_nzc , Y_nzc ,'Marker','.','MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none' ,'MarkerSize',4);
                    plot3(dT_zc , dA_zc , Y_zc ,'Marker','.','MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none','MarkerSize',4);

                    plot3(dT_zc(indexGdwall_spot) , dA_zc(indexGdwall_spot) , Y_zc(indexGdwall_spot) ,'MarkerEdgeColor' , 'y' ,'MarkerFaceColor','y', 'Marker','o', 'LineStyle','none','MarkerSize',5);
                    plot3(dT_zc(indexGd1_spot) , dA_zc(indexGd1_spot) , Y_zc(indexGd1_spot) ,'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'Marker','o', 'LineStyle','none','MarkerSize',5);
                    plot3(dT_zc(indexGd2_spot) , dA_zc(indexGd2_spot) , Y_zc(indexGd2_spot) ,'MarkerEdgeColor' , [0 .5 0] ,'MarkerFaceColor',[0 .5 0], 'Marker','o', 'LineStyle','none','MarkerSize',5);

                    plot3(  [ -100*k1_g1 ; 500*k1_g1 ] + mean(dT_zc(indexG1nwall)) , [ -100*k2_g1 ; 500*k2_g1 ] + mean(dA_zc(indexG1nwall)) , zeros(2,1) , 'r');
                    plot3( lineEdgePoint_X1Y_g1(:,1) + mean(dT_zc(indexG1nwall)) , lineEdgePoint_X1Y_g1(:,2) + mean(dA_zc(indexG1nwall)), lineEdgePoint_X1Y_g1(:,3) ,'r' ,'LineWidth',3 );
                    plot3( [ lineEdgePoint_X1Y_g1(2,1) + mean(dT_zc(indexG1nwall)) ,lineEdgePoint_X1Y_g1(2,1)+ mean(dT_zc(indexG1nwall)) ] ,...
                           [ lineEdgePoint_X1Y_g1(2,2)+ mean(dA_zc(indexG1nwall)) , lineEdgePoint_X1Y_g1(2,2)+ mean(dA_zc(indexG1nwall)) ] ,...
                           [0 lineEdgePoint_X1Y_g1(2,3)] ,'--r' );              % 垂線

                    plot3(  [ -100*k1_g2 ; 500*k1_g2 ] + mean(dT_zc(indexG2nwall)) , [ -100*k2_g2 ; 500*k2_g2 ] + mean(dA_zc(indexG2nwall)) , zeros(2,1) , 'r');
                    plot3( lineEdgePoint_X1Y_g2(:,1) + mean(dT_zc(indexG2nwall)) , lineEdgePoint_X1Y_g2(:,2) + mean(dA_zc(indexG2nwall)), lineEdgePoint_X1Y_g2(:,3) ,'r' ,'LineWidth',3 );
                    plot3( [ lineEdgePoint_X1Y_g2(2,1) + mean(dT_zc(indexG2nwall)) , lineEdgePoint_X1Y_g2(2,1) + mean(dT_zc(indexG2nwall)) ] ,...
                           [ lineEdgePoint_X1Y_g2(2,2) + mean(dA_zc(indexG2nwall))  lineEdgePoint_X1Y_g2(2,2) + mean(dA_zc(indexG2nwall))  ] ,...
                           [0 lineEdgePoint_X1Y_g2(2,3)] ,'--r' );              % 垂線
                    
                    plot3(  [ -100*k1_gwall ; 500*k1_gwall ] + mean(dT_zc(indexGwall)) , [ -100*k2_gwall ; 500*k2_gwall ] + mean(dA_zc(indexGwall)) , zeros(2,1) , 'm');
                    plot3( lineEdgePoint_X1Y_gwall(:,1) + mean(dT_zc(indexGwall)) , lineEdgePoint_X1Y_gwall(:,2) + mean(dA_zc(indexGwall)), lineEdgePoint_X1Y_gwall(:,3) ,'m' ,'LineWidth',3 );
                    plot3( [ lineEdgePoint_X1Y_gwall(2,1) + mean(dT_zc(indexGwall)) , lineEdgePoint_X1Y_gwall(2,1) + mean(dT_zc(indexGwall)) ] ,...
                           [ lineEdgePoint_X1Y_gwall(2,2) + mean(dA_zc(indexGwall))  lineEdgePoint_X1Y_gwall(2,2) + mean(dA_zc(indexGwall))  ] ,...
                           [0 lineEdgePoint_X1Y_gwall(2,3)] ,'--m' );              % 垂線
                hold off
                grid on
                axis square
                view(0,0);
                xlabel('操作波形 周期の差dT');  ylabel('操作波形 振幅の差dA');  zlabel('対数演算前アバタ速さV');
                xlim([0 600]);            ylim([0 600]);          zlim([0 50000]);
                
                axis square
                
                                %% 
                subplot(3,2,5);
                
                plot3( [0 0],[0 0],[0 0],'k' );
                hold on
                    plot3(dT_nzc, dA_nzc , Y_nzc ,'Marker','.','MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none' ,'MarkerSize',4);
                    plot3(dT_zc , dA_zc , Y_zc ,'Marker','.','MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none','MarkerSize',4);

                    plot3(dT_zc(indexGdwall_spot) , dA_zc(indexGdwall_spot) , Y_zc(indexGdwall_spot) ,'MarkerEdgeColor' , 'y' ,'MarkerFaceColor','y', 'Marker','o', 'LineStyle','none','MarkerSize',5);
                    plot3(dT_zc(indexGd1_spot) , dA_zc(indexGd1_spot) , Y_zc(indexGd1_spot) ,'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'Marker','o', 'LineStyle','none','MarkerSize',5);
                    plot3(dT_zc(indexGd2_spot) , dA_zc(indexGd2_spot) , Y_zc(indexGd2_spot) ,'MarkerEdgeColor' , [0 .5 0] ,'MarkerFaceColor',[0 .5 0], 'Marker','o', 'LineStyle','none','MarkerSize',5);

                    plot3(  [ -100*k1_g1 ; 500*k1_g1 ] + mean(dT_zc(indexG1nwall)) , [ -100*k2_g1 ; 500*k2_g1 ] + mean(dA_zc(indexG1nwall)) , zeros(2,1) , 'r');
                    plot3( lineEdgePoint_X1Y_g1(:,1) + mean(dT_zc(indexG1nwall)) , lineEdgePoint_X1Y_g1(:,2) + mean(dA_zc(indexG1nwall)), lineEdgePoint_X1Y_g1(:,3) ,'r' ,'LineWidth',3 );
                    plot3( [ lineEdgePoint_X1Y_g1(2,1) + mean(dT_zc(indexG1nwall)) ,lineEdgePoint_X1Y_g1(2,1)+ mean(dT_zc(indexG1nwall)) ] ,...
                           [ lineEdgePoint_X1Y_g1(2,2)+ mean(dA_zc(indexG1nwall)) , lineEdgePoint_X1Y_g1(2,2)+ mean(dA_zc(indexG1nwall)) ] ,...
                           [0 lineEdgePoint_X1Y_g1(2,3)] ,'--r' );              % 垂線

                    plot3(  [ -100*k1_g2 ; 500*k1_g2 ] + mean(dT_zc(indexG2nwall)) , [ -100*k2_g2 ; 500*k2_g2 ] + mean(dA_zc(indexG2nwall)) , zeros(2,1) , 'r');
                    plot3( lineEdgePoint_X1Y_g2(:,1) + mean(dT_zc(indexG2nwall)) , lineEdgePoint_X1Y_g2(:,2) + mean(dA_zc(indexG2nwall)), lineEdgePoint_X1Y_g2(:,3) ,'r' ,'LineWidth',3 );
                    plot3( [ lineEdgePoint_X1Y_g2(2,1) + mean(dT_zc(indexG2nwall)) , lineEdgePoint_X1Y_g2(2,1) + mean(dT_zc(indexG2nwall)) ] ,...
                           [ lineEdgePoint_X1Y_g2(2,2) + mean(dA_zc(indexG2nwall))  lineEdgePoint_X1Y_g2(2,2) + mean(dA_zc(indexG2nwall))  ] ,...
                           [0 lineEdgePoint_X1Y_g2(2,3)] ,'--r' );              % 垂線
                    
                    plot3(  [ -100*k1_gwall ; 500*k1_gwall ] + mean(dT_zc(indexGwall)) , [ -100*k2_gwall ; 500*k2_gwall ] + mean(dA_zc(indexGwall)) , zeros(2,1) , 'm');
                    plot3( lineEdgePoint_X1Y_gwall(:,1) + mean(dT_zc(indexGwall)) , lineEdgePoint_X1Y_gwall(:,2) + mean(dA_zc(indexGwall)), lineEdgePoint_X1Y_gwall(:,3) ,'m' ,'LineWidth',3 );
                    plot3( [ lineEdgePoint_X1Y_gwall(2,1) + mean(dT_zc(indexGwall)) , lineEdgePoint_X1Y_gwall(2,1) + mean(dT_zc(indexGwall)) ] ,...
                           [ lineEdgePoint_X1Y_gwall(2,2) + mean(dA_zc(indexGwall))  lineEdgePoint_X1Y_gwall(2,2) + mean(dA_zc(indexGwall))  ] ,...
                           [0 lineEdgePoint_X1Y_gwall(2,3)] ,'--m' );              % 垂線
                hold off
                grid on
                axis square
                view(90,0);
                xlabel('操作波形 周期の差dT');  ylabel('操作波形 振幅の差dA');  zlabel('対数演算前アバタ速さV');
                xlim([0 600]);            ylim([0 600]);          zlim([0 50000]);
                
                axis square
                
                %% ３D散布図2P（距離でグループ分け）
                    subplot(3,2,2);
                    
                    bFig =0;
            % クラスター1
                [k1_g1_2 , k2_g1_2, X1_g1_2, fitParam_X1Y_g1_2, fitLineR_X1Y_g1_2] = Rhythm.PCA_regress_3dplot(dT_zc2(indexG1nwall2) , dA_zc2(indexG1nwall2) , Y_zc2(indexG1nwall2) , bFig) ;
            % クラスター2
                [k1_g2_2 , k2_g2_2, X1_g2_2, fitParam_X1Y_g2_2, fitLineR_X1Y_g2_2] = Rhythm.PCA_regress_3dplot(dT_zc2(indexG2nwall2) , dA_zc2(indexG2nwall2) , Y_zc2(indexG2nwall2) , bFig) ;
             % クラスターwall
                [k1_gwall2 , k2_gwall2, X1_gwall2, fitParam_X1Y_gwall2, fitLineR_X1Y_gwall2] = Rhythm.PCA_regress_3dplot(dT_zc2(indexGwall2) , dA_zc2(indexGwall2) , Y_zc2(indexGwall2) , bFig) ;                    
            % 回帰直線(クラスタ１)との距離(全データ)     
                [vector_HP_g1_2 , distError_g1_2 , distMean_g1_2] = Rhythm.PCA_regDist(dT_zc2 , dA_zc2 , Y_zc2 , k1_g1_2, k2_g1_2 , X1_g1_2, mean([dT_zc2, dA_zc2]) ,  fitParam_X1Y_g1_2, bFig );
            % 回帰直線(クラスタ2)との距離(全データ)    
                [vector_HP_g2_2 , distError_g2_2 , distMean_g2_2] = Rhythm.PCA_regDist(dT_zc2 , dA_zc2 , Y_zc2 , k1_g2_2, k2_g2_2 , X1_g2_2, mean([dT_zc2 , dA_zc2]) ,  fitParam_X1Y_g2_2, bFig );                
                
                d_threshold = 12;
                for i = 1:Nzc2
                    if i <= Nzc_wall2
                        group_d_2(i,1) = 3;
                    elseif distError_g1_2(i) - distError_g2_2(i) < 0
                        group_d_2(i,1) = 1;
                        if abs( distError_g1_2(i) - distError_g2_2(i) ) < d_threshold
                            group_d_2(i,1) = group_d_2(i-1,1);
                        end
                    elseif distError_g2_2(i) - distError_g1_2(i) < 0
                        group_d_2(i,1) = 2;
                        if abs( distError_g1_2(i) - distError_g2_2(i) ) < d_threshold
                            group_d_2(i,1) = group_d_2(i-1,1);
                        end
                    end
                end
                
                group_d_spot_2 = zeros(Nzc2,1);
                for i = startIndex2:endIndex2
                    if i <= Nzc_wall2
                        group_d_spot_2(i,1) = 3;
                    elseif distError_g1_2(i) - distError_g2_2(i) < 0
                        group_d_spot_2(i , 1) = 1;
                        if abs( distError_g1_2(i) - distError_g2_2(i) ) < d_threshold
                            group_d_spot_2(i , 1) = group_d_spot_2(i-1 , 1);
                        end
                    elseif distError_g2_2(i) - distError_g1_2(i) < 0
                        group_d_spot_2(i , 1) = 2;
                        if abs( distError_g1_2(i) - distError_g2_2(i) ) < d_threshold
                            group_d_spot_2(i , 1) = group_d_spot_2(i-1 , 1);
                        end
                    end
                end
                
                indexGd1_spot_2 = find( group_d_spot_2 == 1 );
                indexGd2_spot_2 = find( group_d_spot_2 == 2 );
                indexGdwall_spot_2 = find(group_d_spot_2 == 3);
                
%                 disp(indexGd1_2);
                
                lineEdgePoint_X1Y_g1_2 = [ min(X1_g1_2)*k1_g1_2 , min(X1_g1_2)*k2_g1_2 , polyval( fitParam_X1Y_g1_2, min(X1_g1_2) ) ;...
                                        max(X1_g1_2)*k1_g1_2 , max(X1_g1_2)*k2_g1_2 , polyval( fitParam_X1Y_g1_2, max(X1_g1_2) ) ];
                lineEdgePoint_X1Y_g2_2 = [ min(X1_g2_2)*k1_g2_2 , min(X1_g2_2)*k2_g2_2 , polyval( fitParam_X1Y_g2_2, min(X1_g2_2) ) ;...
                                        max(X1_g2_2)*k1_g2_2 , max(X1_g2_2)*k2_g2_2 , polyval( fitParam_X1Y_g2_2, max(X1_g2_2) ) ];
                lineEdgePoint_X1Y_gwall_2 = [ min(X1_gwall2)*k1_gwall2 , min(X1_gwall2)*k2_gwall2 , polyval( fitParam_X1Y_gwall2, min(X1_gwall2) ) ;...
                                        max(X1_gwall2)*k1_gwall2 , max(X1_gwall2)*k2_gwall2 , polyval( fitParam_X1Y_gwall2, max(X1_gwall2) ) ];
                plot3( [0 0],[0 0],[0 0],'k' );
                hold on
                                
                    plot3(dT_nzc2, dA_nzc2 , Y_nzc2 ,'Marker','.','MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none','MarkerSize',4 );
                    plot3(dT_zc2 , dA_zc2 , Y_zc2 ,'Marker','.','MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none','MarkerSize',4);

                    plot3(dT_zc(indexGdwall_spot_2) , dA_zc2(indexGdwall_spot_2) , Y_zc2(indexGdwall_spot_2) ,'MarkerEdgeColor' , 'y' ,'MarkerFaceColor','y', 'Marker','o', 'LineStyle','none','MarkerSize',5);
                    plot3(dT_zc2(indexGd1_spot_2) , dA_zc2(indexGd1_spot_2) , Y_zc2(indexGd1_spot_2) ,'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'Marker','o', 'LineStyle','none','MarkerSize',5);
                    plot3(dT_zc2(indexGd2_spot_2) , dA_zc2(indexGd2_spot_2) , Y_zc2(indexGd2_spot_2) ,'MarkerEdgeColor' , [0 .5 0] ,'MarkerFaceColor',[0 .5 0], 'Marker','o', 'LineStyle','none','MarkerSize',5);

                    plot3(  [ -100*k1_g1_2 ; 500*k1_g1_2 ] + mean(dT_zc2(indexG1nwall2)) , [ -100*k2_g1_2 ; 500*k2_g1_2 ] + mean(dA_zc2(indexG1nwall2)) , zeros(2,1) , 'r');
                    plot3( lineEdgePoint_X1Y_g1_2(:,1) + mean(dT_zc2(indexG1nwall2)) , lineEdgePoint_X1Y_g1_2(:,2) + mean(dA_zc2(indexG1nwall2)), lineEdgePoint_X1Y_g1_2(:,3) ,'r' ,'LineWidth',3 );
                    plot3( [ lineEdgePoint_X1Y_g1_2(2,1) + mean(dT_zc2(indexG1nwall2)) ,lineEdgePoint_X1Y_g1_2(2,1)+ mean(dT_zc2(indexG1nwall2)) ] ,...
                           [ lineEdgePoint_X1Y_g1_2(2,2)+ mean(dA_zc2(indexG1nwall2)) , lineEdgePoint_X1Y_g1_2(2,2)+ mean(dA_zc2(indexG1nwall2)) ] ,...
                           [0 lineEdgePoint_X1Y_g1_2(2,3)] ,'--r' );              % 垂線

                    plot3(  [ -100*k1_g2_2 ; 500*k1_g2_2 ] + mean(dT_zc2(indexG2nwall2)) , [ -100*k2_g2_2 ; 500*k2_g2_2 ] + mean(dA_zc2(indexG2nwall2)) , zeros(2,1) , 'r');
                    plot3( lineEdgePoint_X1Y_g2_2(:,1) + mean(dT_zc2(indexG2nwall2)) , lineEdgePoint_X1Y_g2_2(:,2) + mean(dA_zc2(indexG2nwall2)), lineEdgePoint_X1Y_g2_2(:,3) ,'r' ,'LineWidth',3 );
                    plot3( [ lineEdgePoint_X1Y_g2_2(2,1) + mean(dT_zc2(indexG2nwall2)) , lineEdgePoint_X1Y_g2_2(2,1) + mean(dT_zc2(indexG2nwall2)) ] ,...
                           [ lineEdgePoint_X1Y_g2_2(2,2) + mean(dA_zc2(indexG2nwall2))  lineEdgePoint_X1Y_g2_2(2,2) + mean(dA_zc2(indexG2nwall2))  ] ,...
                           [0 lineEdgePoint_X1Y_g2_2(2,3)] ,'--r' );              % 垂線

                    plot3(  [ -100*k1_gwall2 ; 500*k1_gwall2 ] + mean(dT_zc2(indexGwall2)) , [ -100*k2_gwall2 ; 500*k2_gwall2 ] + mean(dA_zc2(indexGwall2)) , zeros(2,1) , 'm');
                    plot3( lineEdgePoint_X1Y_gwall_2(:,1) + mean(dT_zc2(indexGwall2)) , lineEdgePoint_X1Y_gwall_2(:,2) + mean(dA_zc2(indexGwall2)), lineEdgePoint_X1Y_gwall_2(:,3) ,'m' ,'LineWidth',3 );
                    plot3( [ lineEdgePoint_X1Y_gwall_2(2,1) + mean(dT_zc2(indexGwall2)) , lineEdgePoint_X1Y_gwall_2(2,1) + mean(dT_zc2(indexGwall2)) ] ,...
                           [ lineEdgePoint_X1Y_gwall_2(2,2) + mean(dA_zc2(indexGwall2))  lineEdgePoint_X1Y_gwall_2(2,2) + mean(dA_zc2(indexGwall2))  ] ,...
                           [0 lineEdgePoint_X1Y_gwall_2(2,3)] ,'--m' );              % 垂線
                hold off
                grid on
                axis square
                view(2);
                xlabel('操作波形 周期の差dT');  ylabel('操作波形 振幅の差dA');  zlabel('対数演算前アバタ速さV');
                xlim([0 600]);            ylim([0 600]);          zlim([0 50000]);

                x_2 = [ -100*k1_g1_2 ; 500*k1_g1_2 ] + mean(dT_zc2(indexG1nwall2));
                y_2 = [ -100*k2_g1_2 ; 500*k2_g1_2 ] + mean(dA_zc2(indexG1nwall2));
                dx_2 = x_2(2,1)-x_2(1,1);
                dy_2 = y_2(2,1)-y_2(1,1);
                x2_2 = [ -100*k1_g2_2 ; 500*k1_g2_2 ] + mean(dT_zc2(indexG2nwall2));
                y2_2 = [ -100*k2_g2 ; 500*k2_g2 ] + mean(dA_zc2(indexG2nwall2));
                dx2_2 = x2_2(2,1)-x2_2(1,1);
                dy2_2 = y2_2(2,1)-y2_2(1,1);
                
                title( ['player2 θ1 = ' num2str(atan(dy_2/dx_2)*360/2/pi) ' , θ2 = ' num2str(atan(dy2_2/dx2_2)*360/2/pi) ] );

                axis square
                
             %%
                subplot(3,2,4);
                
                plot3( [0 0],[0 0],[0 0],'k' );
                hold on
                                
                    plot3(dT_nzc2, dA_nzc2 , Y_nzc2 ,'Marker','.','MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none','MarkerSize',4 );
                    plot3(dT_zc2 , dA_zc2 , Y_zc2 ,'Marker','.','MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none','MarkerSize',4);

                    plot3(dT_zc(indexGdwall_spot_2) , dA_zc2(indexGdwall_spot_2) , Y_zc2(indexGdwall_spot_2) ,'MarkerEdgeColor' , 'y' ,'MarkerFaceColor','y', 'Marker','o', 'LineStyle','none','MarkerSize',5);
                    plot3(dT_zc2(indexGd1_spot_2) , dA_zc2(indexGd1_spot_2) , Y_zc2(indexGd1_spot_2) ,'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'Marker','o', 'LineStyle','none','MarkerSize',5);
                    plot3(dT_zc2(indexGd2_spot_2) , dA_zc2(indexGd2_spot_2) , Y_zc2(indexGd2_spot_2) ,'MarkerEdgeColor' , [0 .5 0] ,'MarkerFaceColor',[0 .5 0], 'Marker','o', 'LineStyle','none','MarkerSize',5);

                    plot3(  [ -100*k1_g1_2 ; 500*k1_g1_2 ] + mean(dT_zc2(indexG1nwall2)) , [ -100*k2_g1_2 ; 500*k2_g1_2 ] + mean(dA_zc2(indexG1nwall2)) , zeros(2,1) , 'r');
                    plot3( lineEdgePoint_X1Y_g1_2(:,1) + mean(dT_zc2(indexG1nwall2)) , lineEdgePoint_X1Y_g1_2(:,2) + mean(dA_zc2(indexG1nwall2)), lineEdgePoint_X1Y_g1_2(:,3) ,'r' ,'LineWidth',3 );
                    plot3( [ lineEdgePoint_X1Y_g1_2(2,1) + mean(dT_zc2(indexG1nwall2)) ,lineEdgePoint_X1Y_g1_2(2,1)+ mean(dT_zc2(indexG1nwall2)) ] ,...
                           [ lineEdgePoint_X1Y_g1_2(2,2)+ mean(dA_zc2(indexG1nwall2)) , lineEdgePoint_X1Y_g1_2(2,2)+ mean(dA_zc2(indexG1nwall2)) ] ,...
                           [0 lineEdgePoint_X1Y_g1_2(2,3)] ,'--r' );              % 垂線

                    plot3(  [ -100*k1_g2_2 ; 500*k1_g2_2 ] + mean(dT_zc2(indexG2nwall2)) , [ -100*k2_g2_2 ; 500*k2_g2_2 ] + mean(dA_zc2(indexG2nwall2)) , zeros(2,1) , 'r');
                    plot3( lineEdgePoint_X1Y_g2_2(:,1) + mean(dT_zc2(indexG2nwall2)) , lineEdgePoint_X1Y_g2_2(:,2) + mean(dA_zc2(indexG2nwall2)), lineEdgePoint_X1Y_g2_2(:,3) ,'r' ,'LineWidth',3 );
                    plot3( [ lineEdgePoint_X1Y_g2_2(2,1) + mean(dT_zc2(indexG2nwall2)) , lineEdgePoint_X1Y_g2_2(2,1) + mean(dT_zc2(indexG2nwall2)) ] ,...
                           [ lineEdgePoint_X1Y_g2_2(2,2) + mean(dA_zc2(indexG2nwall2))  lineEdgePoint_X1Y_g2_2(2,2) + mean(dA_zc2(indexG2nwall2))  ] ,...
                           [0 lineEdgePoint_X1Y_g2_2(2,3)] ,'--r' );              % 垂線

                    plot3(  [ -100*k1_gwall2 ; 500*k1_gwall2 ] + mean(dT_zc2(indexGwall2)) , [ -100*k2_gwall2 ; 500*k2_gwall2 ] + mean(dA_zc2(indexGwall2)) , zeros(2,1) , 'm');
                    plot3( lineEdgePoint_X1Y_gwall_2(:,1) + mean(dT_zc2(indexGwall2)) , lineEdgePoint_X1Y_gwall_2(:,2) + mean(dA_zc2(indexGwall2)), lineEdgePoint_X1Y_gwall_2(:,3) ,'m' ,'LineWidth',3 );
                    plot3( [ lineEdgePoint_X1Y_gwall_2(2,1) + mean(dT_zc2(indexGwall2)) , lineEdgePoint_X1Y_gwall_2(2,1) + mean(dT_zc2(indexGwall2)) ] ,...
                           [ lineEdgePoint_X1Y_gwall_2(2,2) + mean(dA_zc2(indexGwall2))  lineEdgePoint_X1Y_gwall_2(2,2) + mean(dA_zc2(indexGwall2))  ] ,...
                           [0 lineEdgePoint_X1Y_gwall_2(2,3)] ,'--m' );              % 垂線
                hold off
                grid on
                axis square
                view(0,0);
                xlabel('操作波形 周期の差dT');  ylabel('操作波形 振幅の差dA');  zlabel('対数演算前アバタ速さV');
                xlim([0 600]);            ylim([0 600]);          zlim([0 50000]);
                
                axis square
                
                %%
                subplot(3,2,6);
                
                plot3( [0 0],[0 0],[0 0],'k' );
                hold on
                                
                    plot3(dT_nzc2, dA_nzc2 , Y_nzc2 ,'Marker','.','MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none','MarkerSize',4 );
                    plot3(dT_zc2 , dA_zc2 , Y_zc2 ,'Marker','.','MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none','MarkerSize',4);

                    plot3(dT_zc(indexGdwall_spot_2) , dA_zc2(indexGdwall_spot_2) , Y_zc2(indexGdwall_spot_2) ,'MarkerEdgeColor' , 'y' ,'MarkerFaceColor','y', 'Marker','o', 'LineStyle','none','MarkerSize',5);
                    plot3(dT_zc2(indexGd1_spot_2) , dA_zc2(indexGd1_spot_2) , Y_zc2(indexGd1_spot_2) ,'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'Marker','o', 'LineStyle','none','MarkerSize',5);
                    plot3(dT_zc2(indexGd2_spot_2) , dA_zc2(indexGd2_spot_2) , Y_zc2(indexGd2_spot_2) ,'MarkerEdgeColor' , [0 .5 0] ,'MarkerFaceColor',[0 .5 0], 'Marker','o', 'LineStyle','none','MarkerSize',5);

                    plot3(  [ -100*k1_g1_2 ; 500*k1_g1_2 ] + mean(dT_zc2(indexG1nwall2)) , [ -100*k2_g1_2 ; 500*k2_g1_2 ] + mean(dA_zc2(indexG1nwall2)) , zeros(2,1) , 'r');
                    plot3( lineEdgePoint_X1Y_g1_2(:,1) + mean(dT_zc2(indexG1nwall2)) , lineEdgePoint_X1Y_g1_2(:,2) + mean(dA_zc2(indexG1nwall2)), lineEdgePoint_X1Y_g1_2(:,3) ,'r' ,'LineWidth',3 );
                    plot3( [ lineEdgePoint_X1Y_g1_2(2,1) + mean(dT_zc2(indexG1nwall2)) ,lineEdgePoint_X1Y_g1_2(2,1)+ mean(dT_zc2(indexG1nwall2)) ] ,...
                           [ lineEdgePoint_X1Y_g1_2(2,2)+ mean(dA_zc2(indexG1nwall2)) , lineEdgePoint_X1Y_g1_2(2,2)+ mean(dA_zc2(indexG1nwall2)) ] ,...
                           [0 lineEdgePoint_X1Y_g1_2(2,3)] ,'--r' );              % 垂線

                    plot3(  [ -100*k1_g2_2 ; 500*k1_g2_2 ] + mean(dT_zc2(indexG2nwall2)) , [ -100*k2_g2_2 ; 500*k2_g2_2 ] + mean(dA_zc2(indexG2nwall2)) , zeros(2,1) , 'r');
                    plot3( lineEdgePoint_X1Y_g2_2(:,1) + mean(dT_zc2(indexG2nwall2)) , lineEdgePoint_X1Y_g2_2(:,2) + mean(dA_zc2(indexG2nwall2)), lineEdgePoint_X1Y_g2_2(:,3) ,'r' ,'LineWidth',3 );
                    plot3( [ lineEdgePoint_X1Y_g2_2(2,1) + mean(dT_zc2(indexG2nwall2)) , lineEdgePoint_X1Y_g2_2(2,1) + mean(dT_zc2(indexG2nwall2)) ] ,...
                           [ lineEdgePoint_X1Y_g2_2(2,2) + mean(dA_zc2(indexG2nwall2))  lineEdgePoint_X1Y_g2_2(2,2) + mean(dA_zc2(indexG2nwall2))  ] ,...
                           [0 lineEdgePoint_X1Y_g2_2(2,3)] ,'--r' );              % 垂線

                    plot3(  [ -100*k1_gwall2 ; 500*k1_gwall2 ] + mean(dT_zc2(indexGwall2)) , [ -100*k2_gwall2 ; 500*k2_gwall2 ] + mean(dA_zc2(indexGwall2)) , zeros(2,1) , 'm');
                    plot3( lineEdgePoint_X1Y_gwall_2(:,1) + mean(dT_zc2(indexGwall2)) , lineEdgePoint_X1Y_gwall_2(:,2) + mean(dA_zc2(indexGwall2)), lineEdgePoint_X1Y_gwall_2(:,3) ,'m' ,'LineWidth',3 );
                    plot3( [ lineEdgePoint_X1Y_gwall_2(2,1) + mean(dT_zc2(indexGwall2)) , lineEdgePoint_X1Y_gwall_2(2,1) + mean(dT_zc2(indexGwall2)) ] ,...
                           [ lineEdgePoint_X1Y_gwall_2(2,2) + mean(dA_zc2(indexGwall2))  lineEdgePoint_X1Y_gwall_2(2,2) + mean(dA_zc2(indexGwall2))  ] ,...
                           [0 lineEdgePoint_X1Y_gwall_2(2,3)] ,'--m' );              % 垂線
                hold off
                grid on
                axis square
                view(90,0);
                xlabel('操作波形 周期の差dT');  ylabel('操作波形 振幅の差dA');  zlabel('対数演算前アバタ速さV');
                xlim([0 600]);            ylim([0 600]);          zlim([0 50000]);
                
                axis square
                
                %% 保存

                    % 動画
                    drawnow             % drawnowを入れるとアニメーションになる
                    movmov(Num) = getframe(gcf,MonitorSize);           % アニメーションのフレームをゲットする

                    % 一枚ずつ保存
%                     if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
                        obj.saveGraphWithNameToFolder( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_'  num2str(Num)]);
%                     else
%                         obj.saveGraphWithNameToFolder( [  num2str(Num) ]);
%                     end

                    Num = Num +1;
                end
            end
            
            saveMovieName = obj.saveFilePath(['_' num2str( obj.data.splitTimeInfo.index ) '.avi']);
            movie2avi(movmov, saveMovieName,  'compression', 'None', 'fps', 2);

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
