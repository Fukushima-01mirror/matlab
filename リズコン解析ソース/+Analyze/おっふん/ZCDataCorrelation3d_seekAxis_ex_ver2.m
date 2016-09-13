classdef ZCDataCorrelation3d_seekAxis_ex_ver2 < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = ZCDataCorrelation3d_seekAxis_ex_ver2(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
           [period_zx, peak_zx] = Rhythm.setZeroCrossPeriodData(user.zeroCrossData);
           %　ゼロクロス間でのピーク回数取得
           [zeroCrossTimes] = Rhythm.setZeroCrossCount(user.zeroCrossData);
            
            Y = abs( user.zeroCrossData.nonlogAvtVelocity );
            dT = abs( period_zx(:,3) );
            dA = abs( peak_zx(:,3) );
            
            
            if obj.currentRunType == obj.runTypePlayer1
                IndexZeroCross = find(zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2 ...
                    & obj.data.player1.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) );
                IndexNonZeroCross = find( zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1 ...
                    & obj.data.player1.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) );
            elseif obj.currentRunType == obj.runTypePlayer2
                IndexZeroCross = find(zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2 ...
                    & obj.data.player2.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) );
                IndexNonZeroCross = find( zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1 ...
                    & obj.data.player2.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) );
            end

            Y_zc  = Y(IndexZeroCross);        Y_nzc  = Y(IndexNonZeroCross);
            dT_zc = dT(IndexZeroCross,:);     dT_nzc = dT(IndexNonZeroCross,:);
            dA_zc = dA(IndexZeroCross,:);     dA_nzc = dA(IndexNonZeroCross,:);
            
            %外れ値を除外するため，最大データ２つをカット
            [dT_max,dT_imax] = max(dT_zc);     dT_zc(dT_imax)= [];	 dA_zc(dT_imax)= [];     Y_zc(dT_imax)= [];
            [dT_max,dT_imax] = max(dT_zc);     dT_zc(dT_imax)= [];	 dA_zc(dT_imax)= [];     Y_zc(dT_imax)= [];
            [dA_max,dA_imax] = max(dA_zc);     dT_zc(dA_imax)= [];	 dA_zc(dA_imax)= [];     Y_zc(dA_imax)= [];
            [dA_max,dA_imax] = max(dA_zc);     dT_zc(dA_imax)= [];	 dA_zc(dA_imax)= [];     Y_zc(dA_imax)= [];
%             [Y_max,Y_imax] = max(Y_zc);     dT_zc(Y_imax)= [];	 dA_zc(Y_imax)= [];     Y_zc(Y_imax)= [];
%             [Y_max,Y_imax] = max(Y_zc);     dT_zc(Y_imax)= [];	 dA_zc(Y_imax)= [];     Y_zc(Y_imax)= [];
            while max(Y_zc./dT_zc) > 500
                [Y_dT_max,Y_dT_imax] = max(Y_zc./dT_zc);     dT_zc(Y_dT_imax)= [];	 dA_zc(Y_dT_imax)= [];     Y_zc(Y_dT_imax)= [];
                [Y_dT_max,Y_dT_imax] = max(Y_zc./dT_zc);     dT_zc(Y_dT_imax)= [];	 dA_zc(Y_dT_imax)= [];     Y_zc(Y_dT_imax)= [];
            end
            while max(Y_zc./dA_zc) > 500
                [Y_dA_max,Y_dA_imax] = max(Y_zc./dA_zc);     dT_zc(Y_dA_imax)= [];	 dA_zc(Y_dA_imax)= [];     Y_zc(Y_dA_imax)= [];
                [Y_dA_max,Y_dA_imax] = max(Y_zc./dA_zc);     dT_zc(Y_dA_imax)= [];	 dA_zc(Y_dA_imax)= [];     Y_zc(Y_dA_imax)= [];
            end
 
            Nzc = length(Y_zc) ;
            Nnzc = length(Y_nzc) ;
            
%%        ΔAとΔTの主成分分析 と 主成分回帰分析
            figure(1)
            dT0_zc = dT_zc - mean(dT_zc);
            dA0_zc = dA_zc - mean(dA_zc);
            [coeff,score,latent,tsquare] = princomp( [dT_zc dA_zc] );
            k1 = abs(coeff(1,1));            k2 = abs(coeff(2,1));
            
            X1 = k1 * dT0_zc + k2 * dA0_zc;
            [ fitParam_X1Y, fitLineR_X1Y, lineEdgePoint_X1Y] = Rhythm.approxiLine2d(X1, Y_zc );
            
            subplot(2,1,1);
            plot( dT0_zc , dA0_zc , 'Marker','*', 'LineStyle','none');
            hold on
                plot( dT_nzc - mean(dT_zc) , dA_nzc - mean(dT_zc) ,'Marker','o', 'LineStyle','none' );
                plot(  [ -300*coeff(1,:) ; 300*coeff(1,:) ] , [ -300*coeff(2,:) ; 300*coeff(2,:) ] , 'r')
            hold off
            text(200*coeff(1,1), 200*coeff(2,1), ['X1:(' num2str(coeff(1,1)) ','  num2str(coeff(2,1)) ')'] )
            text(200*coeff(1,2), 200*coeff(2,2), ['X2:(' num2str(coeff(1,2)) ','  num2str(coeff(2,2)) ')'] )
            grid on
            axis square
            xlabel('操作波形 周期の差　ΔT');    ylabel('操作波形　振幅の差　ΔA'); 
            xlim([-300 300]);            ylim([-300 300]);
            title({['　\theta =  (' num2str( atan(k2/k1) *180 / pi ) ')[degree]']});

            subplot(2,1,2);
            %　Xとアバタ速さの相関
            alpha = fitParam_X1Y(1);   beta = fitParam_X1Y(2);
            plot( X1   ,Y_zc  , 'Marker','*', 'LineStyle','none');
            hold on
                plot(lineEdgePoint_X1Y(:,1), lineEdgePoint_X1Y(:,2), 'r')
            hold off
            grid on 
            axis square
            xlabel('X = k1*ΔT + k2*ΔA');    ylabel('対数変換前アバタ速度'); 
            xlim([-300,300]);            ylim([0 50000]);
            title({['V =  (' num2str( alpha ) ') * X  + (' num2str( beta ) ')']; ...
                    ['相関係数R：' num2str( fitLineR_X1Y(1)) '　　決定係数R^2' num2str( fitLineR_X1Y(1)^2)] });
%             fitParam_recalc = [ beta, alpha*k1, alpha*k2];
            
            %%
            MonitorSize = [ 0, 0, 400, 800];
            set(gcf, 'Position', MonitorSize);
            if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_主成分分析']);
            else
                obj.saveGraphWithName('_主成分分析');
            end
            
%%        3次元分布　重回帰
            figure(100);
%             [fitParam3d, dTFIT, dAFIT, YFIT , fitR, yhat, fitR2 ]  = Rhythm.approxiSurface_flat(dT_zc , dA_zc_shift , Y_zc );
            plot3( dT_zc  , dA_zc , Y_zc,   'Marker','*', 'LineStyle','none');
            % 
            hold on
                plot3( dT_nzc  , dA_nzc, Y_nzc, 'Marker','o', 'LineStyle','none');
                plot3(  [ -100*k1 ; 500*k1 ] + mean(dT_zc) , [ -100*k2 ; 500*k2 ] + mean(dA_zc) , zeros(2,1) , 'r')
%                 plot3( [0 0] , [-300 300] , [0 0] ,'k');
%                 plot3( [-300 300] ,[0 0] , [0 0],'k');
%                 plot3( [0 0] , [0 0],[0 50000] ,'k');

%                 plot3( [0,600*k1]  , [0,600*k2] , [0,0] ,'r' );
                plot3( lineEdgePoint_X1Y(:,1)*k1 + mean(dT_zc) , lineEdgePoint_X1Y(:,1)*k2 + mean(dA_zc), lineEdgePoint_X1Y(:,2) ,'r' ,'LineWidth',3 );

                plot3( [ lineEdgePoint_X1Y(2,1)*k1 lineEdgePoint_X1Y(2,1)*k1 ] + mean(dT_zc),...
                       [ lineEdgePoint_X1Y(2,1)*k2 lineEdgePoint_X1Y(2,1)*k2 ] + mean(dA_zc),...
                       [0 lineEdgePoint_X1Y(2,2)] ,'--r' );              % 垂線
%                 C =colormap(jet);
%                 mesh(dTFIT,dAFIT,YFIT, 'faceAlpha',0.5);
                
%                 YFIT_recalc = fitParam_recalc(1) + fitParam_recalc(2)*dTFIT + fitParam_recalc(3)*dAFIT ;
% %                 C =colormap(Bone);
%                 mesh(dTFIT,dAFIT,YFIT_recalc, 'faceAlpha',0.5);     
                
%                 %　データグループ分割面
%                 dTgrid = 0:50:600;            dAgrid = 0:50:600;
%                 Zsep = 2* mean(Y_zc) * ones(length(dTgrid), length(dAgrid));
%                 mesh(dTgrid, dAgrid, Zsep, 'faceAlpha',0.8);
            hold off
            grid on
            view(-30,30);
            xlabel('操作波形 周期の差');  ylabel('操作波形 振幅の差');  zlabel('対数演算前アバタ速さ');
            xlim([0 600]);            ylim([0 600]);          zlim([0 50000]);
            title({ ['X：(' num2str(coeff(1,1)) ', '  num2str(coeff(2,1)) ')　\theta =(' num2str( atan(k2/k1) *180 / pi ) ')[deg]'] ;...
                ['X-Vの傾き：' num2str( alpha ) '，相関係数R：' num2str( fitLineR_X1Y(1)) '，決定係数R^2：' num2str( fitLineR_X1Y(1)^2)];...
                []});
            axis square

%%
            MonitorSize = [ 0, 0, 800, 800];
            set(gcf, 'Position', MonitorSize);
            if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_重回帰分析（V-X1）']);
            else
                obj.saveGraphWithName('_重回帰分析（V-X1）');
            end


            %%   　エクセルデータ出力  
            outputTitle = { 'k1' , 'k2' , '角度','latent(X1)','latent(X2)',...
                                    'X1の係数','重相関R','重決定R2' };
            output = num2cell( [k1 k2 (atan(k2/k1)*180/pi) latent' alpha  fitLineR_X1Y(1) fitLineR_X1Y(1)^2] );
            obj.outputAllToXls(output , outputTitle);
            
        end

        function runForPair(obj,user1 ,user2)
%             obj.runForAlone(user1);
%             obj.runForAlone(user2);
%             
            
        end

        
    end
end
