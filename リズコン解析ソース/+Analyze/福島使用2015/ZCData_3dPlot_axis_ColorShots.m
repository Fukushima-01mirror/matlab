classdef ZCData_3dPlot_axis_ColorShots < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = ZCData_3dPlot_axis_ColorShots(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
           [period_zx, peak_zx] = Rhythm.setZeroCrossPeriodData(user.zeroCrossData);
           %　ゼロクロス間でのピーク回数取得
           [zeroCrossTimes] = Rhythm.setZeroCrossCount(user.zeroCrossData);
            
            Y = abs( user.zeroCrossData.nonlogAvtVelocity );
            dT = abs( period_zx(:,3) );
            dA = abs( peak_zx(:,3) );
            
            V_max = 30000;
            dT_max = 300;
            dA_max = 300;
            %元の数値は5/3
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

            %　時間スケールの設定            
%             spotTimeSeries = spotTime+startTime : user.time.highSampled(end);
%             spotTimeSeries = spotTimeSeries.';


                    MonitorSize = [ 0, 0, 1200, 800];
                    set(gcf, 'Position', MonitorSize);
                         figure(1);

                         %% アバタ位置
                    subplot(3,4,[3 4])
                    plot(   user.time.lowSampled,  user.avatarPosition.lowSampled , 'Color', 'c'); 
                    hold on 
                   
                        % 実験条件の描画
                        if strcmp( obj.config.examType, '追い込まれ実験')...
                                || strcmp( obj.config.examType, '追い込む実験')
                            plot(   obj.data.com.time,  obj.data.com.avatarPosition , 'Color' , [.6 .6 .6]);               
                        elseif ~isempty(  findstr( char( obj.config.examType ) , '追従'))
                            plot(   obj.data.task.time,  obj.data.task.avatarPosition , 'Color' , [.6 .6 .6]);
                            if ~isempty(  findstr( char( obj.config.examType ) , '目標追従'))
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
                    if ~isempty(  findstr( char( obj.config.examType ) , '剣道'))
                        title( [ 'アバタ位置  ( ' char( obj.data.splitTimeInfo.state ) ' ）']);
                    end
                    xlabel('時間t ms'); ylabel('アバタ位置');
                    xlim([0,60000]);    ylim([0 1000]);

                    %%  3D散布図
                    subplot(3,4,[7 8 11 12])
                    %startIndexA = find( user.zeroCrossData.zeroCrossTime(IndexZeroCross) >= 0 ,1 ,'first');
                    %endIndexA = find( user.zeroCrossData.zeroCrossTime(IndexZeroCross) < 4500 ,1 ,'last');
                    startIndexB = find( user.zeroCrossData.zeroCrossTime(IndexZeroCross) >= 5000 ,1 ,'first');
                    endIndexB = find( user.zeroCrossData.zeroCrossTime(IndexZeroCross) < 23000 ,1 ,'last');
                    startIndexC = find( user.zeroCrossData.zeroCrossTime(IndexZeroCross) >= 42000 ,1 ,'first');
                    endIndexC = find( user.zeroCrossData.zeroCrossTime(IndexZeroCross) < 60000 ,1 ,'last');
%                      startIndexD = find( user.zeroCrossData.zeroCrossTime(IndexZeroCross) >= 43500 ,1 ,'first');
%                      endIndexD = find( user.zeroCrossData.zeroCrossTime(IndexZeroCross) < 56000 ,1 ,'last');
%                     startIndexE = find( user.zeroCrossData.zeroCrossTime(IndexZeroCross) >= 43500 ,1 ,'first');
%                     endIndexE = find( user.zeroCrossData.zeroCrossTime(IndexZeroCross) < 56000 ,1 ,'last');
                    
                    %dTgA_zc = mean(dT_zc(startIndexA:endIndexA));
                   % dAgA_zc = mean(dA_zc(startIndexA:endIndexA));
                   % dT0A_zc = dT_zc - dTgA_zc;
                   % dA0A_zc = dA_zc - dAgA_zc;
                    
                    dTgB_zc = mean(dT_zc(startIndexB:endIndexB));
                    dAgB_zc = mean(dA_zc(startIndexB:endIndexB));
                    dT0B_zc = dT_zc - dTgB_zc;
                    dA0B_zc = dA_zc - dAgB_zc;
                    
                    dTgC_zc = mean(dT_zc(startIndexC:endIndexC));
                    dAgC_zc = mean(dA_zc(startIndexC:endIndexC));
                    dT0C_zc = dT_zc - dTgC_zc;
                    dA0C_zc = dA_zc - dAgC_zc;
                    
%                      dTgD_zc = mean(dT_zc(startIndexD:endIndexD));
%                      dAgD_zc = mean(dA_zc(startIndexD:endIndexD));
%                      dT0D_zc = dT_zc - dTgD_zc;
%                      dA0D_zc = dA_zc - dAgD_zc;
%                     
%                     dTgE_zc = mean(dT_zc(startIndexE:endIndexE));
%                     dAgE_zc = mean(dA_zc(startIndexE:endIndexE));
%                     dT0E_zc = dT_zc - dTgE_zc;
%                     dA0E_zc = dA_zc - dAgE_zc;
                   % [coeff,score,latent,tsquare] = princomp( [dT_zc dA_zc] );
                    %k1 = abs(coeff(1,1));            k2 = abs(coeff(2,1));
                    %theta = atan(k2/k1) *180 / pi ;

                    %X1 = k1 * dT0_zc + k2 * dA0_zc;
                    %[ fitParam_X1Y, fitLineR_X1Y, lineEdgePoint_X1Y] = Rhythm.approxiLine2d(X1, Y_zc);
%                     plot3( dT_zc , dA_zc, Y_zc,    'Marker','*', 'LineStyle','none','MarkerSize',2);
                    axis square
                    grid on
                    view(-30,30);
                    hold on
                        plot3( dT_nzc , dA_nzc, Y_nzc, 'Color' , 'b' ,'Marker','o', 'LineStyle','none');
                        
                       %plot3( dT_zc(startIndexA:endIndexA), dA_zc(startIndexA:endIndexA), Y_zc(startIndexA:endIndexA),'Marker','*', 'MarkerEdgeColor' , 'r' ,'MarkerFaceColor','r', 'LineStyle','none');
                        plot3( dT_zc(startIndexB:endIndexB), dA_zc(startIndexB:endIndexB), Y_zc(startIndexB:endIndexB),'Color' , 'b' ,'Marker','*', 'LineStyle','none');
                        plot3( dT_zc(startIndexC:endIndexC), dA_zc(startIndexC:endIndexC), Y_zc(startIndexC:endIndexC),'Color' , 'b' ,'Marker','*', 'LineStyle','none');
%                          plot3( dT_zc(startIndexD:endIndexD), dA_zc(startIndexD:endIndexD), Y_zc(startIndexD:endIndexD),'Color' , 'b' ,'Marker','*', 'LineStyle','none');
%                         plot3( dT_zc(startIndexE:endIndexE), dA_zc(startIndexE:endIndexE), Y_zc(startIndexE:endIndexE),'Marker','*', 'MarkerEdgeColor' , 'k' ,'MarkerFaceColor','k', 'LineStyle','none');
%                         plot(  [ -150*coeff(1,1)+dTg_zc ; 150*coeff(1,1)+dTg_zc ] , [ -150*coeff(2,1)+dAg_zc ; 150*coeff(2,1)+dAg_zc ] , 'r')
%                         plot(  [ -50*coeff(1,2)+dTg_zc ; 50*coeff(1,2)+dTg_zc ] , [ -50*coeff(2,2)+dAg_zc ; 50*coeff(2,2)+dAg_zc ] , 'r')
%                         plot3( lineEdgePoint_X1Y(:,1)*k1 +dTg_zc , lineEdgePoint_X1Y(:,1)*k2 +dAg_zc, lineEdgePoint_X1Y(:,2) ,'r' ,'LineWidth',3 );
% 
%                         plot3( [ lineEdgePoint_X1Y(2,1)*k1+dTg_zc lineEdgePoint_X1Y(2,1)*k1+dTg_zc ] ,...
%                                [ lineEdgePoint_X1Y(2,1)*k2+dAg_zc lineEdgePoint_X1Y(2,1)*k2+dAg_zc ] ,...
%                                [0 lineEdgePoint_X1Y(2,2)] ,'--r' );              % 垂線
                        %plot(  [ -150*coeff(1,1)+dTg_zc ; 150*coeff(1,1)+dTg_zc ] , [ -150*coeff(2,1)+dAg_zc ; 150*coeff(2,1)+dAg_zc ] , 'r')
                        %plot(  [ -50*coeff(1,2)+dTg_zc ; 50*coeff(1,2)+dTg_zc ] , [ -50*coeff(2,2)+dAg_zc ; 50*coeff(2,2)+dAg_zc ] , 'r')
                        %plot3( lineEdgePoint_X1Y(:,1)*k1 +dTg_zc , lineEdgePoint_X1Y(:,1)*k2 +dAg_zc, lineEdgePoint_X1Y(:,2) ,'r' ,'LineWidth',3 );
                        %hold on
                        % 回帰直線
                %    [coeffA,scoreA,latentA,tsquareA] = princomp( [dT_zc(startIndexA:endIndexA) dA_zc(startIndexA:endIndexA)] );
                %    k1 = abs(coeffA(1,1));            k2 = abs(coeffA(2,1));
               %     X1 = k1 * dT0A_zc + k2 * dA0A_zc;
              %      [ fitParam_X1Y, fitLineR_X1Y, lineEdgePoint_X1Y] =Rhythm.approxiLine2d(X1(startIndexA:endIndexA), Y_zc(startIndexA:endIndexA));
          %  plot3(  [ -100*k1 ; 500*k1 ] + mean(dT_zc(startIndexA:endIndexA)) , [ -100*k2 ; 500*k2 ] + mean(dA_zc(startIndexA:endIndexA)) , zeros(2,1) , 'r' );
           %   plot3( lineEdgePoint_X1Y(:,1)*k1 +dTgA_zc , lineEdgePoint_X1Y(:,1)*k2 +dAgA_zc, lineEdgePoint_X1Y(:,2) ,'r' ,'LineWidth',3 );
         %      plot3( [ lineEdgePoint_X1Y(2,1)*k1+dTgA_zc lineEdgePoint_X1Y(2,1)*k1+dTgA_zc ] ,...
           %                    [ lineEdgePoint_X1Y(2,1)*k2+dAgA_zc lineEdgePoint_X1Y(2,1)*k2+dAgA_zc ] ,...
           %                    [0 lineEdgePoint_X1Y(2,2)] ,'--r' );              % 垂線
           % plot3( [ lineEdgePoint_X1Y(2,1) + mean(dT_zc(startIndexA:endIndexA)) ,lineEdgePoint_X1Y(2,1)+ mean(dT_zc(startIndexA:endIndexA)) ] ,...
               % [ lineEdgePoint_X1Y(2,2)+ mean(dA_zc(startIndexA:endIndexA)) , lineEdgePoint_X1Y(2,2)+ mean(dA_zc(startIndexA:endIndexA)) ] ,...
                %[0 lineEdgePoint_X1Y(2,3)] ,'--r' );              % 垂線
                      [coeffB,scoreB,latentB,tsquareB] = princomp( [dT_zc(startIndexB:endIndexB) dA_zc(startIndexB:endIndexB)] );
                    k1 = abs(coeffB(1,1));            k2 = abs(coeffB(2,1));
                    X1 = k1 * dT0B_zc + k2 * dA0B_zc;
                    [ fitParam_X1Y, fitLineR_X1Y, lineEdgePoint_X1Y] =Rhythm.approxiLine2d(X1(startIndexB:endIndexB), Y_zc(startIndexB:endIndexB));
            plot3(  [ -100*k1 ; 500*k1 ] + mean(dT_zc(startIndexB:endIndexB)) , [ -100*k2 ; 500*k2 ] + mean(dA_zc(startIndexB:endIndexB)) , zeros(2,1) , 'r' );
              plot3( lineEdgePoint_X1Y(:,1)*k1 +dTgB_zc , lineEdgePoint_X1Y(:,1)*k2 +dAgB_zc, lineEdgePoint_X1Y(:,2) ,'r' ,'LineWidth',3 );
               plot3( [ lineEdgePoint_X1Y(2,1)*k1+dTgB_zc lineEdgePoint_X1Y(2,1)*k1+dTgB_zc ] ,...
                               [ lineEdgePoint_X1Y(2,1)*k2+dAgB_zc lineEdgePoint_X1Y(2,1)*k2+dAgB_zc ] ,...
                               [0 lineEdgePoint_X1Y(2,2)] ,'--r' );              % 垂線
           [coeffC,scoreC,latentC,tsquareC] = princomp( [dT_zc(startIndexC:endIndexC) dA_zc(startIndexC:endIndexC)] );
                    k1 = abs(coeffC(1,1));            k2 = abs(coeffC(2,1));
                    X1 = k1 * dT0C_zc + k2 * dA0C_zc;
                    [ fitParam_X1Y, fitLineR_X1Y, lineEdgePoint_X1Y] =Rhythm.approxiLine2d(X1(startIndexC:endIndexC), Y_zc(startIndexC:endIndexC));
            plot3(  [ -100*k1 ; 500*k1 ] + mean(dT_zc(startIndexC:endIndexC)) , [ -100*k2 ; 500*k2 ] + mean(dA_zc(startIndexC:endIndexC)) , zeros(2,1) , 'r' );
              plot3( lineEdgePoint_X1Y(:,1)*k1 +dTgC_zc , lineEdgePoint_X1Y(:,1)*k2 +dAgC_zc, lineEdgePoint_X1Y(:,2) ,'r' ,'LineWidth',3 );
               plot3( [ lineEdgePoint_X1Y(2,1)*k1+dTgC_zc lineEdgePoint_X1Y(2,1)*k1+dTgC_zc ] ,...
                               [ lineEdgePoint_X1Y(2,1)*k2+dAgC_zc lineEdgePoint_X1Y(2,1)*k2+dAgC_zc ] ,...
                               [0 lineEdgePoint_X1Y(2,2)] ,'--r' );   
%                             [coeffD,scoreD,latentD,tsquareD] = princomp( [dT_zc(startIndexD:endIndexD) dA_zc(startIndexD:endIndexD)] );
%                     k1 = abs(coeffD(1,1));            k2 = abs(coeffD(2,1));
%                     X1 = k1 * dT0D_zc + k2 * dA0D_zc;
%                     [ fitParam_X1Y, fitLineR_X1Y, lineEdgePoint_X1Y] =Rhythm.approxiLine2d(X1(startIndexD:endIndexD), Y_zc(startIndexD:endIndexD));
%             plot3(  [ -100*k1 ; 500*k1 ] + mean(dT_zc(startIndexD:endIndexD)) , [ -100*k2 ; 500*k2 ] + mean(dA_zc(startIndexD:endIndexD)) , zeros(2,1) , 'r' );
%               plot3( lineEdgePoint_X1Y(:,1)*k1 +dTgD_zc , lineEdgePoint_X1Y(:,1)*k2 +dAgD_zc, lineEdgePoint_X1Y(:,2) ,'r' ,'LineWidth',3 );
%                plot3( [ lineEdgePoint_X1Y(2,1)*k1+dTgD_zc lineEdgePoint_X1Y(2,1)*k1+dTgD_zc ] ,...
%                                [ lineEdgePoint_X1Y(2,1)*k2+dAgD_zc lineEdgePoint_X1Y(2,1)*k2+dAgD_zc ] ,...
%                                [0 lineEdgePoint_X1Y(2,2)] ,'--r' );  
%                             [coeffE,scoreE,latentE,tsquareE] = princomp( [dT_zc(startIndexE:endIndexE) dA_zc(startIndexE:endIndexE)] );
%                     k1 = abs(coeffE(1,1));            k2 = abs(coeffE(2,1));
%                     X1 = k1 * dT0E_zc + k2 * dA0E_zc;
%                     [ fitParam_X1Y, fitLineR_X1Y, lineEdgePoint_X1Y] =Rhythm.approxiLine2d(X1(startIndexE:endIndexE), Y_zc(startIndexE:endIndexE));
%             plot3(  [ -100*k1 ; 500*k1 ] + mean(dT_zc(startIndexE:endIndexE)) , [ -100*k2 ; 500*k2 ] + mean(dA_zc(startIndexE:endIndexE)) , zeros(2,1) , 'k' );
%               plot3( lineEdgePoint_X1Y(:,1)*k1 +dTgE_zc , lineEdgePoint_X1Y(:,1)*k2 +dAgE_zc, lineEdgePoint_X1Y(:,2) ,'k' ,'LineWidth',3 );
%                plot3( [ lineEdgePoint_X1Y(2,1)*k1+dTgE_zc lineEdgePoint_X1Y(2,1)*k1+dTgE_zc ] ,...
%                                [ lineEdgePoint_X1Y(2,1)*k2+dAgE_zc lineEdgePoint_X1Y(2,1)*k2+dAgE_zc ] ,...
%                                [0 lineEdgePoint_X1Y(2,2)] ,'--k' );  
           
            hold off
                    hold off
                    xlabel('操作波形 周期の差');  ylabel('操作波形 振幅の差');  zlabel('対数演算前アバタ速さ');
                    xlim([0,dT_max]);      ylim([0,dA_max]);         zlim([0 V_max]);

                    %if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
                    %     title({['GameTime: ' num2str(obj.data.player1.time.highSampled(1)) '〜' num2str( obj.data.player1.time.highSampled(end))];...
                    %         ['time:' num2str(spotTimeMax-spotTime ) '〜'  num2str(spotTimeMax)  ]});
                    %else
                    %    title({['time:' num2str(spotTimeMax-spotTime ) '〜'  num2str(spotTimeMax)  ]});
                    %end
                       %%  合成変数X1
                  %  subplot(3,4,1);
                %    [coeffA,scoreA,latentA,tsquareA] = princomp( [dT_zc(startIndexA:endIndexA) dA_zc(startIndexA:endIndexA)] );
                 %   k1 = abs(coeffA(1,1));            k2 = abs(coeffA(2,1));
                 %    theta = atan(k2/k1) *180 / pi ;
                 %   plot( dT0A_zc , dA0A_zc , 'Marker','o', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none');
                 %   hold on
                 %       plot( dT_nzc - mean(dT_zc(startIndexA:endIndexA)) , dA_nzc - mean(dT_zc(startIndexA:endIndexA)) ,'Marker','.', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none');
                 %       plot( dT0A_zc(startIndexA:endIndexA) , dA0A_zc(startIndexA:endIndexA) ,...
                 %           'Marker','o', 'MarkerEdgeColor' , 'r' ,'MarkerFaceColor','r', 'LineStyle','none');
                 %       plot(  [ -150*coeffA(1,1) ; 150*coeffA(1,1) ] , [ -150*coeffA(2,1) ; 150*coeffA(2,1) ] , 'r')
                 %       plot(  [ -50*coeffA(1,2) ; 50*coeffA(1,2) ] , [ -50*coeffA(2,2) ; 50*coeffA(2,2) ] , 'r')
                 %   hold off
                 %   grid on
                 %   axis square
                  %  xlabel('操作波形 周期の差　ΔT');    ylabel('操作波形　振幅の差　ΔA'); 
                 %   xlim([-dT_max/2,dT_max/2]);             xlim([-dA_max/2,dA_max/2]); 
                 %   title({['k1 : ' num2str( decround(k1,3) ) ' , k2 : ' num2str( decround(k2,3) )]; ...
                 %       ['　\theta =  (' num2str( decround(theta,3) ) ')[degree]']});
                 %   axis square    
                    %%  合成変数X1
                    subplot(3,4,5);
                    [coeffB,scoreB,latentB,tsquareB] = princomp( [dT_zc(startIndexB:endIndexB) dA_zc(startIndexB:endIndexB)] );
                    k1 = abs(coeffB(1,1));            k2 = abs(coeffB(2,1));
                     theta = atan(k2/k1) *180 / pi ;
                    plot( dT0B_zc , dA0B_zc , 'Marker','o', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none');
                    hold on
                        plot( dT_nzc - mean(dT_zc(startIndexB:endIndexB)) , dA_nzc - mean(dT_zc(startIndexB:endIndexB)) ,'Marker','.', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none');
                        plot( dT0B_zc(startIndexB:endIndexB) , dA0B_zc(startIndexB:endIndexB) ,...
                            'Marker','o', 'MarkerEdgeColor' , 'r' ,'MarkerFaceColor','r', 'LineStyle','none');
                        plot(  [ -150*coeffB(1,1) ; 150*coeffB(1,1) ] , [ -150*coeffB(2,1) ; 150*coeffB(2,1) ] , 'r')
                        plot(  [ -50*coeffB(1,2) ; 50*coeffB(1,2) ] , [ -50*coeffB(2,2) ; 50*coeffB(2,2) ] , 'r')
                    hold off
                    grid on
                    axis square
                    xlabel('操作波形 周期の差　ΔT');    ylabel('操作波形　振幅の差　ΔA'); 
                    xlim([-dT_max/2,dT_max/2]);             xlim([-dA_max/2,dA_max/2]); 
                    title({['k1 : ' num2str( decround(k1,3) ) ' , k2 : ' num2str( decround(k2,3) )]; ...
                        ['　\theta =  (' num2str( decround(theta,3) ) ')[degree]']});
                    axis square       
                    %%  合成変数X1
                    subplot(3,4,6);
                    [coeffC,scoreC,latentC,tsquareC] = princomp( [dT_zc(startIndexC:endIndexC) dA_zc(startIndexC:endIndexC)] );
                    k1 = abs(coeffC(1,1));            k2 = abs(coeffC(2,1));
                     theta = atan(k2/k1) *180 / pi ;
                    plot( dT0C_zc , dA0C_zc , 'Marker','o', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none');
                    hold on
                        plot( dT_nzc - mean(dT_zc(startIndexC:endIndexC)) , dA_nzc - mean(dT_zc(startIndexC:endIndexC)) ,'Marker','.', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none');
                        plot( dT0C_zc(startIndexC:endIndexC) , dA0C_zc(startIndexC:endIndexC) ,...
                            'Marker','o', 'MarkerEdgeColor' , 'k' ,'MarkerFaceColor','k', 'LineStyle','none');
                        plot(  [ -150*coeffC(1,1) ; 150*coeffC(1,1) ] , [ -150*coeffC(2,1) ; 150*coeffC(2,1) ] , 'k')
                        plot(  [ -50*coeffC(1,2) ; 50*coeffC(1,2) ] , [ -50*coeffC(2,2) ; 50*coeffC(2,2) ] , 'k')
                    hold off
                    grid on
                    axis square
                    xlabel('操作波形 周期の差　ΔT');    ylabel('操作波形　振幅の差　ΔA'); 
                    xlim([-dT_max/2,dT_max/2]);             xlim([-dA_max/2,dA_max/2]); 
                    title({['k1 : ' num2str( decround(k1,3) ) ' , k2 : ' num2str( decround(k2,3) )]; ...
                        ['　\theta =  (' num2str( decround(theta,3) ) ')[degree]']});
                    axis square  
%                     %%  合成変数X1
%                     subplot(3,4,9);
%                     [coeffD,scoreD,latentD,tsquareD] = princomp( [dT_zc(startIndexD:endIndexD) dA_zc(startIndexD:endIndexD)] );
%                     k1 = abs(coeffD(1,1));            k2 = abs(coeffD(2,1));
%                      theta = atan(k2/k1) *180 / pi ;
%                     plot( dT0D_zc , dA0D_zc , 'Marker','o', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none');
%                     hold on
%                         plot( dT_nzc - mean(dT_zc(startIndexD:endIndexD)) , dA_nzc - mean(dT_zc(startIndexD:endIndexD)) ,'Marker','.', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none');
%                         plot( dT0D_zc(startIndexD:endIndexD) , dA0D_zc(startIndexD:endIndexD) ,...
%                             'Marker','o', 'MarkerEdgeColor' , 'g' ,'MarkerFaceColor','g', 'LineStyle','none');
%                         plot(  [ -150*coeffD(1,1) ; 150*coeffD(1,1) ] , [ -150*coeffD(2,1) ; 150*coeffD(2,1) ] , 'g')
%                         plot(  [ -50*coeffD(1,2) ; 50*coeffD(1,2) ] , [ -50*coeffD(2,2) ; 50*coeffD(2,2) ] , 'g')
%                     hold off
%                     grid on
%                     axis square
%                     xlabel('操作波形 周期の差　ΔT');    ylabel('操作波形　振幅の差　ΔA'); 
%                     xlim([-dT_max/2,dT_max/2]);             xlim([-dA_max/2,dA_max/2]); 
%                     title({['k1 : ' num2str( decround(k1,3) ) ' , k2 : ' num2str( decround(k2,3) )]; ...
%                         ['　\theta =  (' num2str( decround(theta,3) ) ')[degree]']});
%                     axis square    
%                     %%  合成変数X1
%                     subplot(3,4,10);
%                     [coeffE,scoreE,latentE,tsquareE] = princomp( [dT_zc(startIndexE:endIndexE) dA_zc(startIndexE:endIndexE)] );
%                     k1 = abs(coeffE(1,1));            k2 = abs(coeffE(2,1));
%                      theta = atan(k2/k1) *180 / pi ;
%                     plot( dT0E_zc , dA0E_zc , 'Marker','o', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none');
%                     hold on
%                         plot( dT_nzc - mean(dT_zc(startIndexE:endIndexE)) , dA_nzc - mean(dT_zc(startIndexE:endIndexE)) ,'Marker','.', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none');
%                         plot( dT0E_zc(startIndexE:endIndexE) , dA0E_zc(startIndexE:endIndexE) ,...
%                             'Marker','o', 'MarkerEdgeColor' , 'k' ,'MarkerFaceColor','k', 'LineStyle','none');
%                         plot(  [ -150*coeffE(1,1) ; 150*coeffE(1,1) ] , [ -150*coeffE(2,1) ; 150*coeffE(2,1) ] , 'k')
%                         plot(  [ -50*coeffE(1,2) ; 50*coeffE(1,2) ] , [ -50*coeffE(2,2) ; 50*coeffE(2,2) ] , 'k')
%                     hold off
%                     grid on
%                     axis square
%                     xlabel('操作波形 周期の差　ΔT');    ylabel('操作波形　振幅の差　ΔA'); 
%                     xlim([-dT_max/2,dT_max/2]);             xlim([-dA_max/2,dA_max/2]); 
%                     title({['k1 : ' num2str( decround(k1,3) ) ' , k2 : ' num2str( decround(k2,3) )]; ...
%                         ['　\theta =  (' num2str( decround(theta,3) ) ')[degree]']});
%                     axis square               
                    %%

                    % 動画
                    %drawnow             % drawnowを入れるとアニメーションになる
        obj.saveGraphWithName('時間で分けて直線');
        end

        function runForPair(obj,user1 ,user2)
%             obj.runForAlone(user1);
%             obj.runForAlone(user2);
%             
            
        end   
    end
end
