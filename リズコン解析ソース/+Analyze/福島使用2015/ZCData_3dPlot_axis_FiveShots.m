classdef ZCData_3dPlot_axis_FiveShots < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = ZCData_3dPlot_axis_FiveShots(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
           [period_zx, peak_zx] = Rhythm.setZeroCrossPeriodData(user.zeroCrossData);
           %　ゼロクロス間でのピーク回数取得
           [zeroCrossTimes] = Rhythm.setZeroCrossCount(user.zeroCrossData);
            
            Y = abs( user.zeroCrossData.nonlogAvtVelocity );
            dT = abs( period_zx(:,3) );
            dA = abs( peak_zx(:,3) );
            
            V_max = 50000;
            dT_max = 500;
            dA_max = 500;
            
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

                    dTg_zc = mean(dT_zc);
                    dAg_zc = mean(dA_zc);
                    dT0_zc = dT_zc - dTg_zc;
                    dA0_zc = dA_zc - dAg_zc;
                    [coeff,score,latent,tsquare] = princomp( [dT_zc dA_zc] );
                    k1 = abs(coeff(1,1));            k2 = abs(coeff(2,1));
                    theta = atan(k2/k1) *180 / pi ;

                    X1 = k1 * dT0_zc + k2 * dA0_zc;
                    [ fitParam_X1Y, fitLineR_X1Y, lineEdgePoint_X1Y] = Rhythm.approxiLine2d(X1, Y_zc);
                    plot3( dT_zc , dA_zc, Y_zc,   'Marker','o', 'MarkerEdgeColor' , [.7 .7 .7] ,'LineStyle','none');
                    axis square
                    grid on
                    hold on
                        plot3( dT_nzc , dA_nzc, Y_nzc, 'Marker','.', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none');
                        plot3( dT_zc, dA_zc, Y_zc,'Marker','o', 'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'LineStyle','none');
                        plot(  [ -150*coeff(1,1)+dTg_zc ; 150*coeff(1,1)+dTg_zc ] , [ -150*coeff(2,1)+dAg_zc ; 150*coeff(2,1)+dAg_zc ] , 'r')
                        plot(  [ -50*coeff(1,2)+dTg_zc ; 50*coeff(1,2)+dTg_zc ] , [ -50*coeff(2,2)+dAg_zc ; 50*coeff(2,2)+dAg_zc ] , 'r')
                        plot3( lineEdgePoint_X1Y(:,1)*k1 +dTg_zc , lineEdgePoint_X1Y(:,1)*k2 +dAg_zc, lineEdgePoint_X1Y(:,2) ,'r' ,'LineWidth',3 );

                        plot3( [ lineEdgePoint_X1Y(2,1)*k1+dTg_zc lineEdgePoint_X1Y(2,1)*k1+dTg_zc ] ,...
                               [ lineEdgePoint_X1Y(2,1)*k2+dAg_zc lineEdgePoint_X1Y(2,1)*k2+dAg_zc ] ,...
                               [0 lineEdgePoint_X1Y(2,2)] ,'--r' );              % 垂線
                    hold off
                    xlabel('操作波形 周期の差');  ylabel('操作波形 振幅の差');  zlabel('対数演算前アバタ速さ');
                    xlim([0,dT_max]);      ylim([0,dA_max]);         zlim([0 V_max]);

                    if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
                         title({['GameTime: ' num2str(obj.data.player1.time.highSampled(1)) '～' num2str( obj.data.player1.time.highSampled(end))];...
                             ['time:' num2str(spotTimeMax-spotTime ) '～'  num2str(spotTimeMax)  ]});
                    else
                        title({['time:' num2str(spotTimeMax-spotTime ) '～'  num2str(spotTimeMax)  ]});
                    end
                       %%  合成変数X1
                    subplot(3,4,1);
                    startIndexA = find( user.zeroCrossData.zeroCrossTime(IndexZeroCross) >= 0 ,1 ,'first');
                    endIndexA = find( user.zeroCrossData.zeroCrossTime(IndexZeroCross) < 4500 ,1 ,'last');
                    [coeff,score,latent,tsquare] = princomp( [dT_zc(startIndexA:endIndexA) dA_zc(startIndexA:endIndexA)] );
                    k1 = abs(coeff(1,1));            k2 = abs(coeff(2,1));
                    plot( dT0_zc , dA0_zc , 'Marker','o', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none');
                    hold on
                        plot( dT_nzc - mean(dT_zc(startIndexA:endIndexA)) , dA_nzc - mean(dT_zc(startIndexA:endIndexA)) ,'Marker','.', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none');
                        plot( dT0_zc(startIndexA:endIndexA) , dA0_zc(startIndexA:endIndexA) ,...
                            'Marker','o', 'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'LineStyle','none');
                        plot(  [ -150*coeff(1,1) ; 150*coeff(1,1) ] , [ -150*coeff(2,1) ; 150*coeff(2,1) ] , 'r')
                        plot(  [ -50*coeff(1,2) ; 50*coeff(1,2) ] , [ -50*coeff(2,2) ; 50*coeff(2,2) ] , 'r')
                    hold off
                    grid on
                    axis square
                    xlabel('操作波形 周期の差　ΔT');    ylabel('操作波形　振幅の差　ΔA'); 
                    xlim([-dT_max/2,dT_max/2]);             xlim([-dA_max/2,dA_max/2]); 
                    title({['k1 : ' num2str( decround(k1,3) ) ' , k2 : ' num2str( decround(k2,3) )]; ...
                        ['　\theta =  (' num2str( decround(theta,3) ) ')[degree]']});
                    axis square    
                    %%  合成変数X1
                    subplot(3,4,5);
                    startIndexB = find( user.zeroCrossData.zeroCrossTime(IndexZeroCross) >= 4500 ,1 ,'first');
                    endIndexB = find( user.zeroCrossData.zeroCrossTime(IndexZeroCross) < 17000 ,1 ,'last');
                    [coeff,score,latent,tsquare] = princomp( [dT_zc(startIndexB:endIndexB) dA_zc(startIndexB:endIndexB)] );
                    k1 = abs(coeff(1,1));            k2 = abs(coeff(2,1));
                    plot( dT0_zc , dA0_zc , 'Marker','o', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none');
                    hold on
                        plot( dT_nzc - mean(dT_zc(startIndexB:endIndexB)) , dA_nzc - mean(dT_zc(startIndexB:endIndexB)) ,'Marker','.', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none');
                        plot( dT0_zc(startIndexB:endIndexB) , dA0_zc(startIndexB:endIndexB) ,...
                            'Marker','o', 'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'LineStyle','none');
                        plot(  [ -150*coeff(1,1) ; 150*coeff(1,1) ] , [ -150*coeff(2,1) ; 150*coeff(2,1) ] , 'r')
                        plot(  [ -50*coeff(1,2) ; 50*coeff(1,2) ] , [ -50*coeff(2,2) ; 50*coeff(2,2) ] , 'r')
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
                    startIndexC = find( user.zeroCrossData.zeroCrossTime(IndexZeroCross) >= 17000 ,1 ,'first');
                    endIndexC = find( user.zeroCrossData.zeroCrossTime(IndexZeroCross) < 30000 ,1 ,'last');
                    [coeff,score,latent,tsquare] = princomp( [dT_zc(startIndexC:endIndexC) dA_zc(startIndexC:endIndexC)] );
                    k1 = abs(coeff(1,1));            k2 = abs(coeff(2,1));
                    plot( dT0_zc , dA0_zc , 'Marker','o', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none');
                    hold on
                        plot( dT_nzc - mean(dT_zc(startIndexC:endIndexC)) , dA_nzc - mean(dT_zc(startIndexC:endIndexC)) ,'Marker','.', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none');
                        plot( dT0_zc(startIndexC:endIndexC) , dA0_zc(startIndexC:endIndexC) ,...
                            'Marker','o', 'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'LineStyle','none');
                        plot(  [ -150*coeff(1,1) ; 150*coeff(1,1) ] , [ -150*coeff(2,1) ; 150*coeff(2,1) ] , 'r')
                        plot(  [ -50*coeff(1,2) ; 50*coeff(1,2) ] , [ -50*coeff(2,2) ; 50*coeff(2,2) ] , 'r')
                    hold off
                    grid on
                    axis square
                    xlabel('操作波形 周期の差　ΔT');    ylabel('操作波形　振幅の差　ΔA'); 
                    xlim([-dT_max/2,dT_max/2]);             xlim([-dA_max/2,dA_max/2]); 
                    title({['k1 : ' num2str( decround(k1,3) ) ' , k2 : ' num2str( decround(k2,3) )]; ...
                        ['　\theta =  (' num2str( decround(theta,3) ) ')[degree]']});
                    axis square  
                    %%  合成変数X1
                    subplot(3,4,9);
                    startIndexD = find( user.zeroCrossData.zeroCrossTime(IndexZeroCross) >= 32500 ,1 ,'first');
                    endIndexD = find( user.zeroCrossData.zeroCrossTime(IndexZeroCross) < 43500 ,1 ,'last');
                    [coeff,score,latent,tsquare] = princomp( [dT_zc(startIndexD:endIndexD) dA_zc(startIndexD:endIndexD)] );
                    plot( dT0_zc , dA0_zc , 'Marker','o', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none');
                    hold on
                        plot( dT_nzc - mean(dT_zc(startIndexD:endIndexD)) , dA_nzc - mean(dT_zc(startIndexD:endIndexD)) ,'Marker','.', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none');
                        plot( dT0_zc(startIndexD:endIndexD) , dA0_zc(startIndexD:endIndexD) ,...
                            'Marker','o', 'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'LineStyle','none');
                        plot(  [ -150*coeff(1,1) ; 150*coeff(1,1) ] , [ -150*coeff(2,1) ; 150*coeff(2,1) ] , 'r')
                        plot(  [ -50*coeff(1,2) ; 50*coeff(1,2) ] , [ -50*coeff(2,2) ; 50*coeff(2,2) ] , 'r')
                    hold off
                    grid on
                    axis square
                    xlabel('操作波形 周期の差　ΔT');    ylabel('操作波形　振幅の差　ΔA'); 
                    xlim([-dT_max/2,dT_max/2]);             xlim([-dA_max/2,dA_max/2]); 
                    title({['k1 : ' num2str( decround(k1,3) ) ' , k2 : ' num2str( decround(k2,3) )]; ...
                        ['　\theta =  (' num2str( decround(theta,3) ) ')[degree]']});
                    axis square    
                    %%  合成変数X1
                    subplot(3,4,10);
                    startIndexE = find( user.zeroCrossData.zeroCrossTime(IndexZeroCross) >= 43500 ,1 ,'first');
                    endIndexE = find( user.zeroCrossData.zeroCrossTime(IndexZeroCross) < 56000 ,1 ,'last');
                    plot( dT0_zc , dA0_zc , 'Marker','o', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none');
                    hold on
                        plot( dT_nzc - mean(dT_zc(startIndexE:endIndexE)) , dA_nzc - mean(dT_zc(startIndexE:endIndexE)) ,'Marker','.', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none');
                        plot( dT0_zc(startIndexE:endIndexE) , dA0_zc(startIndexE:endIndexE) ,...
                            'Marker','o', 'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'LineStyle','none');
                        plot(  [ -150*coeff(1,1) ; 150*coeff(1,1) ] , [ -150*coeff(2,1) ; 150*coeff(2,1) ] , 'r')
                        plot(  [ -50*coeff(1,2) ; 50*coeff(1,2) ] , [ -50*coeff(2,2) ; 50*coeff(2,2) ] , 'r')
                    hold off
                    grid on
                    axis square
                    xlabel('操作波形 周期の差　ΔT');    ylabel('操作波形　振幅の差　ΔA'); 
                    xlim([-dT_max/2,dT_max/2]);             xlim([-dA_max/2,dA_max/2]); 
                    title({['k1 : ' num2str( decround(k1,3) ) ' , k2 : ' num2str( decround(k2,3) )]; ...
                        ['　\theta =  (' num2str( decround(theta,3) ) ')[degree]']});
                    axis square               
                    %%

                    % 動画
                    drawnow             % drawnowを入れるとアニメーションになる
        
        end

        function runForPair(obj,user1 ,user2)
%             obj.runForAlone(user1);
%             obj.runForAlone(user2);
%             
            
        end   
    end
end
