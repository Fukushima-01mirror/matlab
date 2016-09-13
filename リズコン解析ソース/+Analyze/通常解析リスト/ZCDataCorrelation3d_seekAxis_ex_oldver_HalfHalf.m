classdef ZCDataCorrelation3d_seekAxis_ex_oldver_HalfHalf < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = ZCDataCorrelation3d_seekAxis_ex_oldver_HalfHalf(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
           [period_zx, peak_zx] = Rhythm.setZeroCrossPeriodData(user.zeroCrossData);
           %　ゼロクロス間でのピーク回数取得
           [zeroCrossTimes] = Rhythm.setZeroCrossCount(user.zeroCrossData);
            
            Y = abs( user.zeroCrossData.nonlogAvtVelocity );
            dT = abs( period_zx(:,3) );
            dA = abs( peak_zx(:,3) );
            
            
%%             前半データ
            if obj.currentRunType == obj.runTypePlayer1 ...
                    || ( obj.currentRunType == obj.runTypeArchive && obj.config.isExistPlayer1 )
                IndexZeroCross1 = find(zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2 ...
                    & obj.data.player1.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) + obj.data.player1.time.highSampled(1)...
                    & obj.data.player1.zeroCrossData.zeroCrossTime < 30000 );
                IndexNonZeroCross1 = find( zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1 ...
                    & obj.data.player1.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) + obj.data.player1.time.highSampled(1)...
                    & obj.data.player1.zeroCrossData.zeroCrossTime < 30000 );
            elseif obj.currentRunType == obj.runTypePlayer2 ...
                    || ( obj.currentRunType == obj.runTypeArchive && obj.config.isExistPlayer2 )
                IndexZeroCross1 = find(zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2 ...
                    & obj.data.player2.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) + obj.data.player2.time.highSampled(1)...
                    & obj.data.player2.zeroCrossData.zeroCrossTime < 30000 );
                IndexNonZeroCross1 = find( zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1 ...
                    & obj.data.player2.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) + obj.data.player2.time.highSampled(1)...
                    & obj.data.player2.zeroCrossData.zeroCrossTime < 30000 );
            end

            Y_zc  = Y(IndexZeroCross1);        Y_nzc  = Y(IndexNonZeroCross1);
            dT_zc = dT(IndexZeroCross1,:);     dT_nzc = dT(IndexNonZeroCross1,:);
            dA_zc = dA(IndexZeroCross1,:);     dA_nzc = dA(IndexNonZeroCross1,:);
            
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
%%        ΔAとΔTの回帰分析
            figure(1)
            [ fitParam_dTdA, fitLineR_dTdA, lineEdgePoint] = Rhythm.approxiLine2d(dT_zc  ,dA_zc );
            a = fitParam_dTdA(1);   b = fitParam_dTdA(2);
            plot( dT_zc   ,dA_zc  , 'Marker','*', 'LineStyle','none');
            hold on
                plot( dT_nzc   ,dA_nzc ,'Marker','o', 'LineStyle','none' );
                plot(lineEdgePoint(:,1), lineEdgePoint(:,2), 'r')
            hold off
            grid on
            xlabel('操作波形 周期の差　ΔT');    ylabel('操作波形　振幅の差　ΔA'); 
            xlim([0,600]);            ylim([0,600]);
            title({['ΔA =  (' num2str( a ) ') * ΔT  + (' num2str( b ) ')']; ...
                    ['相関係数R：' num2str( fitLineR_dTdA(1)) '　　決定係数R^2' num2str( fitLineR_dTdA(1)^2)]});
%%
            MonitorSize = [ 0, 0, 400, 400];
            set(gcf, 'Position', MonitorSize);
            if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_回帰分析(ΔA-ΔT)']);
            else
                obj.saveGraphWithName('_回帰分析(ΔA-ΔT)_1st-half');
            end
            
            
%%        切片分プロットをずらす
            figure(2)
            dA_zc_shift = dA_zc  - b * ones(Nzc,1);
            plot( dT_zc   ,dA_zc_shift , 'Marker','*', 'LineStyle','none' );
            lineEdgePoint0(:,1) = lineEdgePoint(:,1);
            lineEdgePoint0(:,2) = lineEdgePoint(:,2) - b *ones(2,1);
            % 
            theta = atan( a );  % 回転角
            Rotate = [ cos(theta) sin(theta); -sin(theta) cos(theta)];      % 回転行列
            k1 =  Rotate(1,1);    k2 = Rotate(1,2);
            l1 =  Rotate(2,1);    l2 = Rotate(2,2);
            Rotate_inv = [ cos(-theta) sin(-theta); -sin(-theta) cos(-theta)];      % 逆回転行列
            m1 =Rotate_inv(1,1);    m2 = Rotate_inv(1,2);
            n1 =Rotate_inv(2,1);    n2 = Rotate_inv(2,2);
            hold on
                plot( dT_nzc   ,dA_nzc  - b *ones(Nnzc,1),'Marker','o', 'LineStyle','none' );
                plot(lineEdgePoint0(:,1), lineEdgePoint0(:,2), 'c')
            hold off
            grid on
            xlabel('操作波形 周期の差　ΔT');    ylabel('操作波形　振幅の差　ΔA’'); 
            xlim([0,600]);            ylim([0,600]);
            title({['ΔA’ =  (' num2str( a ) ') * ΔT' ]; ...
                    ['X = ' num2str( k1) ' * ΔT +' num2str( k2 ) ' * ΔA']});
%%
            MonitorSize = [ 0, 0, 400, 400];
            set(gcf, 'Position', MonitorSize);
            if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_回帰分析(ΔA’-ΔT)']);
            else
                obj.saveGraphWithName('_回帰分析(ΔA’-ΔT)_1st-half');
            end
            

%%        回転変換 X1 X2
            figure(3)
            X1 = k1 * dT_zc + k2 * dA_zc_shift;
            X2 = l1 * dT_zc + l2 * dA_zc_shift;
            plot( X1   ,X2 , 'Marker','*', 'LineStyle','none' );
            grid on
            xlabel('X1');    ylabel('X2'); 
            xlim([0,600]);            ylim([-300,300]);
%             title({['ΔA’ =  (' num2str( a ) ') * ΔT' ]; ...
%                     ['X = ' num2str( k1) ' * ΔT +' num2str( k2 ) ' * ΔA']});

%%
            MonitorSize = [ 0, 0, 400, 400];
            set(gcf, 'Position', MonitorSize);
            if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_座標変換X1X2']);
            else
                obj.saveGraphWithName('_座標変換X1X2_1st-half');
            end
                        
            
%%        X1とアバタ速さの回帰分析
            figure(4)
            %　ΔTとアバタ速さの相関
            subplot(3,1,1);
            [ fitParam1, fitLineR1, lineEdgePoint1] = Rhythm.approxiLine2d(dT_zc, Y_zc );
            plot( dT_zc  ,Y_zc,  'Marker','*', 'LineStyle','none' );
            hold on
                plot(lineEdgePoint1(:,1), lineEdgePoint1(:,2), 'r')
            hold off
            grid on
            xlabel('操作波形 周期の差　ΔT'); ylabel('対数演算前アバタ速さ');
            xlim([0,600]);         ylim([0 50000]);
            title({['V =  (' num2str( fitParam1(1) ) ') * ΔT  + (' num2str(fitParam1(2)) ')']; ...
                    ['相関係数：' num2str( fitLineR1(1))]} );

            %　ΔAとアバタ速さの相関
            subplot(3,1,2);
            [ fitParam2, fitLineR2, lineEdgePoint2] = Rhythm.approxiLine2d(dA_zc_shift, Y_zc );
            plot( dA_zc_shift  ,Y_zc ,  'Marker','*', 'LineStyle','none' );
            hold on
                plot(lineEdgePoint2(:,1), lineEdgePoint2(:,2), 'r')
            hold off
            grid on
            xlabel('操作波形　振幅の差　ΔA’'); ylabel('対数演算前アバタ速さ');
            xlim([0,600]);            ylim([0 50000]);
            title({['V =  (' num2str( fitParam2(1) ) ') * ΔA’  + (' num2str(fitParam2(2)) ')']; ...
                    ['相関係数：' num2str( fitLineR2(1))]});

            %　Xとアバタ速さの相関
            subplot(3,1,3);
            [ fitParam_X1Y, fitLineR_X1Y, lineEdgePoint_X1Y] = Rhythm.approxiLine2d(X1 ,Y_zc);
            alpha = fitParam_X1Y(1);   beta = fitParam_X1Y(2);
            plot( X1   ,Y_zc  , 'Marker','*', 'LineStyle','none');
            hold on
                plot(lineEdgePoint_X1Y(:,1), lineEdgePoint_X1Y(:,2), 'r')
            hold off
            grid on
            xlabel('X = k1*ΔT + k2*ΔA');    ylabel('対数変換前アバタ速度'); 
            xlim([0,600]);            ylim([0 50000]);
            title({['V =  (' num2str( alpha ) ') * X  + (' num2str( beta ) ')']; ...
                    ['相関係数R：' num2str( fitLineR_X1Y(1)) '　　決定係数R^2' num2str( fitLineR_X1Y(1)^2)]; ...
                    ['      →　V = (' num2str( alpha * k1 ) ') * ΔT + (' num2str( alpha * k2 ) ') * ΔA + (' num2str( beta ) ')'] });
            fitParam_recalc = [ beta, alpha*k1, alpha*k2];

%%
            MonitorSize = [ 0, 0, 400, 1000];
            set(gcf, 'Position', MonitorSize);
            if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_単回帰分析(V-ΔT,V-ΔA,V-X1)']);
            else
                obj.saveGraphWithName('_単回帰分析(V-ΔT,V-ΔA,V-X1)_1st-half');
            end
            

%%        3次元分布　重回帰（交互作用なし）ΔAシフト
            figure(100);
            [fitParam3d, dTFIT, dAFIT, YFIT , fitR, yhat, fitR2 ]  = Rhythm.approxiSurface_flat(dT_zc , dA_zc_shift , Y_zc );
            plot3( dT_zc  , dA_zc_shift , Y_zc,   'Marker','*', 'LineStyle','none');
            lineEdgePoint_dTdAY(:,1) = m1 * lineEdgePoint_X1Y(:,1); %dT
            lineEdgePoint_dTdAY(:,2) = n1 * lineEdgePoint_X1Y(:,1); %dA
            lineEdgePoint_dTdAY(:,3) = lineEdgePoint_X1Y(:,2);      % Y

            hold on
                plot3( dT_nzc , dA_nzc  - b * ones(Nnzc,1), Y_nzc, 'Marker','o', 'LineStyle','none');
                plot3( [0,600*k1]  , [0,600*k2] , [0,0] ,'r' );
                plot3( [lineEdgePoint_dTdAY(2,1) lineEdgePoint_dTdAY(2,1)] , [lineEdgePoint_dTdAY(2,2) lineEdgePoint_dTdAY(2,2)] ...
                    , [0 lineEdgePoint_dTdAY(2,3)] ,'--r' );
                plot3( lineEdgePoint_dTdAY(:,1)  , lineEdgePoint_dTdAY(:,2) , lineEdgePoint_dTdAY(:,3) ,'r' ,'LineWidth',3 );
                C =colormap(jet);
                mesh(dTFIT,dAFIT,YFIT, 'faceAlpha',0.5);
                
%                 YFIT_recalc = fitParam_recalc(1) + fitParam_recalc(2)*dTFIT + fitParam_recalc(3)*dAFIT ;
% %                 C =colormap(Bone);
%                 mesh(dTFIT,dAFIT,YFIT_recalc, 'faceAlpha',0.5);     
                
%                 %　データグループ分割面
%                 dTgrid = 0:50:600;            dAgrid = 0:50:600;
%                 Zsep = 2* mean(Y_zc) * ones(length(dTgrid), length(dAgrid));
%                 mesh(dTgrid, dAgrid, Zsep, 'faceAlpha',0.8);
            hold off
            grid on
%             view(45,30);
            xlabel('操作波形 周期の差');  ylabel('操作波形 振幅の差');  zlabel('対数演算前アバタ速さ');
            xlim([0,600]);      ylim([0,600]);         zlim([0 50000]);
            title({ ['V = (' num2str(fitParam3d(1)) ') + (' num2str( fitParam3d(2) ) ') * ΔT + (' num2str( fitParam3d(3)) ') * ΔA’ '] ;...
                []});
            axis square
%%
            MonitorSize = [ 0, 0, 800, 800];
            set(gcf, 'Position', MonitorSize);
            if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_重回帰分析（V-ΔT,ΔA）']);
            else
                obj.saveGraphWithName('_重回帰分析（V-ΔT,ΔA）_1st-half');
            end

%%        3次元分布　重回帰（交互作用なし）ΔAシフト→座標変換
            figure(110);
            [fitParam3d, X1FIT, X2FIT, YFIT , fitR, yhat, fitR2 ]  = Rhythm.approxiSurface_flat(X1 , X2 , Y_zc );
            plot3( X1  , X2 , Y_zc,   'Marker','*', 'LineStyle','none');

            hold on
                mesh(X1FIT,X2FIT,YFIT, 'faceAlpha',0.5);
                plot3(lineEdgePoint_X1Y(:,1), [0,0], lineEdgePoint_X1Y(:,2), 'r','LineWidth',3)
                plot3([lineEdgePoint_X1Y(2,1) lineEdgePoint_X1Y(2,1)], [0,0], [0 lineEdgePoint_X1Y(2,2)], '--r' );
                plot3([0 600], [0 0],[0 0],'r');
%                 %　データグループ分割面
%                 dTgrid = 0:50:600;            dAgrid = 0:50:600;
%                 Zsep = 2* mean(Y_zc) * ones(length(dTgrid), length(dAgrid));
%                 mesh(dTgrid, dAgrid, Zsep, 'faceAlpha',0.8);
            hold off
            grid on
            xlabel('X1 = k1*ΔT + k2*ΔA');  ylabel('X2 = l1*ΔT + l2*ΔA');  zlabel('対数演算前アバタ速さV');
            xlim([0,600]);      ylim([-300,300]);         zlim([0 50000]);
            title({ ['V = (' num2str(fitParam3d(1)) ') + (' num2str( fitParam3d(2) ) ') * X1 + (' num2str( fitParam3d(3)) ') * X2’ '] });
            axis square
%%
            MonitorSize = [ 0, 0, 800, 800];
            set(gcf, 'Position', MonitorSize);
            if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_重回帰分析(V-X1,X2)']);
            else
                obj.saveGraphWithName('_重回帰分析(V-X1,X2)_1st-half');
            end

%%             後半データ
            if obj.currentRunType == obj.runTypePlayer1 ...
                    || ( obj.currentRunType == obj.runTypeArchive && obj.config.isExistPlayer1 )
                IndexZeroCross2 = find(zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2 ...
                    & obj.data.player1.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) + 30000 );
                IndexNonZeroCross2 = find( zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1 ...
                    & obj.data.player1.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) + 30000 );
            elseif obj.currentRunType == obj.runTypePlayer2 ...
                    || ( obj.currentRunType == obj.runTypeArchive && obj.config.isExistPlayer2 )
                IndexZeroCross2 = find(zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2 ...
                    & obj.data.player2.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) + 30000 );
                IndexNonZeroCross2 = find( zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1 ...
                    & obj.data.player2.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) + 30000 );
            end

            Y_zc  = Y(IndexZeroCross2);        Y_nzc  = Y(IndexNonZeroCross2);
            dT_zc = dT(IndexZeroCross2,:);     dT_nzc = dT(IndexNonZeroCross2,:);
            dA_zc = dA(IndexZeroCross2,:);     dA_nzc = dA(IndexNonZeroCross2,:);
            
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
%%        ΔAとΔTの回帰分析
            figure(1)
            [ fitParam_dTdA, fitLineR_dTdA, lineEdgePoint] = Rhythm.approxiLine2d(dT_zc  ,dA_zc );
            a = fitParam_dTdA(1);   b = fitParam_dTdA(2);
            plot( dT_zc   ,dA_zc  , 'Marker','*', 'LineStyle','none');
            hold on
                plot( dT_nzc   ,dA_nzc ,'Marker','o', 'LineStyle','none' );
                plot(lineEdgePoint(:,1), lineEdgePoint(:,2), 'r')
            hold off
            grid on
            xlabel('操作波形 周期の差　ΔT');    ylabel('操作波形　振幅の差　ΔA'); 
            xlim([0,600]);            ylim([0,600]);
            title({['ΔA =  (' num2str( a ) ') * ΔT  + (' num2str( b ) ')']; ...
                    ['相関係数R：' num2str( fitLineR_dTdA(1)) '　　決定係数R^2' num2str( fitLineR_dTdA(1)^2)]});
%%
            MonitorSize = [ 0, 0, 400, 400];
            set(gcf, 'Position', MonitorSize);
            if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_回帰分析(ΔA-ΔT)']);
            else
                obj.saveGraphWithName('_回帰分析(ΔA-ΔT)_2nd-half');
            end
            
            
%%        切片分プロットをずらす
            figure(2)
            dA_zc_shift = dA_zc  - b * ones(Nzc,1);
            plot( dT_zc   ,dA_zc_shift , 'Marker','*', 'LineStyle','none' );
            lineEdgePoint0(:,1) = lineEdgePoint(:,1);
            lineEdgePoint0(:,2) = lineEdgePoint(:,2) - b *ones(2,1);
            % 
            theta = atan( a );  % 回転角
            Rotate = [ cos(theta) sin(theta); -sin(theta) cos(theta)];      % 回転行列
            k1 =  Rotate(1,1);    k2 = Rotate(1,2);
            l1 =  Rotate(2,1);    l2 = Rotate(2,2);
            Rotate_inv = [ cos(-theta) sin(-theta); -sin(-theta) cos(-theta)];      % 逆回転行列
            m1 =Rotate_inv(1,1);    m2 = Rotate_inv(1,2);
            n1 =Rotate_inv(2,1);    n2 = Rotate_inv(2,2);
            hold on
                plot( dT_nzc   ,dA_nzc  - b *ones(Nnzc,1),'Marker','o', 'LineStyle','none' );
                plot(lineEdgePoint0(:,1), lineEdgePoint0(:,2), 'c')
            hold off
            grid on
            xlabel('操作波形 周期の差　ΔT');    ylabel('操作波形　振幅の差　ΔA’'); 
            xlim([0,600]);            ylim([0,600]);
            title({['ΔA’ =  (' num2str( a ) ') * ΔT' ]; ...
                    ['X = ' num2str( k1) ' * ΔT +' num2str( k2 ) ' * ΔA']});
%%
            MonitorSize = [ 0, 0, 400, 400];
            set(gcf, 'Position', MonitorSize);
            if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_回帰分析(ΔA’-ΔT)']);
            else
                obj.saveGraphWithName('_回帰分析(ΔA’-ΔT)_2nd-half');
            end
            

%%        回転変換 X1 X2
            figure(3)
            X1 = k1 * dT_zc + k2 * dA_zc_shift;
            X2 = l1 * dT_zc + l2 * dA_zc_shift;
            plot( X1   ,X2 , 'Marker','*', 'LineStyle','none' );
            grid on
            xlabel('X1');    ylabel('X2'); 
            xlim([0,600]);            ylim([-300,300]);
%             title({['ΔA’ =  (' num2str( a ) ') * ΔT' ]; ...
%                     ['X = ' num2str( k1) ' * ΔT +' num2str( k2 ) ' * ΔA']});

%%
            MonitorSize = [ 0, 0, 400, 400];
            set(gcf, 'Position', MonitorSize);
            if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_座標変換X1X2']);
            else
                obj.saveGraphWithName('_座標変換X1X2_2nd-half');
            end
                        
            
%%        X1とアバタ速さの回帰分析
            figure(4)
            %　ΔTとアバタ速さの相関
            subplot(3,1,1);
            [ fitParam1, fitLineR1, lineEdgePoint1] = Rhythm.approxiLine2d(dT_zc, Y_zc );
            plot( dT_zc  ,Y_zc,  'Marker','*', 'LineStyle','none' );
            hold on
                plot(lineEdgePoint1(:,1), lineEdgePoint1(:,2), 'r')
            hold off
            grid on
            xlabel('操作波形 周期の差　ΔT'); ylabel('対数演算前アバタ速さ');
            xlim([0,600]);         ylim([0 50000]);
            title({['V =  (' num2str( fitParam1(1) ) ') * ΔT  + (' num2str(fitParam1(2)) ')']; ...
                    ['相関係数：' num2str( fitLineR1(1))]} );

            %　ΔAとアバタ速さの相関
            subplot(3,1,2);
            [ fitParam2, fitLineR2, lineEdgePoint2] = Rhythm.approxiLine2d(dA_zc_shift, Y_zc );
            plot( dA_zc_shift  ,Y_zc ,  'Marker','*', 'LineStyle','none' );
            hold on
                plot(lineEdgePoint2(:,1), lineEdgePoint2(:,2), 'r')
            hold off
            grid on
            xlabel('操作波形　振幅の差　ΔA’'); ylabel('対数演算前アバタ速さ');
            xlim([0,600]);            ylim([0 50000]);
            title({['V =  (' num2str( fitParam2(1) ) ') * ΔA’  + (' num2str(fitParam2(2)) ')']; ...
                    ['相関係数：' num2str( fitLineR2(1))]});

            %　Xとアバタ速さの相関
            subplot(3,1,3);
            [ fitParam_X1Y, fitLineR_X1Y, lineEdgePoint_X1Y] = Rhythm.approxiLine2d(X1 ,Y_zc);
            alpha = fitParam_X1Y(1);   beta = fitParam_X1Y(2);
            plot( X1   ,Y_zc  , 'Marker','*', 'LineStyle','none');
            hold on
                plot(lineEdgePoint_X1Y(:,1), lineEdgePoint_X1Y(:,2), 'r')
            hold off
            grid on
            xlabel('X = k1*ΔT + k2*ΔA');    ylabel('対数変換前アバタ速度'); 
            xlim([0,600]);            ylim([0 50000]);
            title({['V =  (' num2str( alpha ) ') * X  + (' num2str( beta ) ')']; ...
                    ['相関係数R：' num2str( fitLineR_X1Y(1)) '　　決定係数R^2' num2str( fitLineR_X1Y(1)^2)]; ...
                    ['      →　V = (' num2str( alpha * k1 ) ') * ΔT + (' num2str( alpha * k2 ) ') * ΔA + (' num2str( beta ) ')'] });
            fitParam_recalc = [ beta, alpha*k1, alpha*k2];

%%
            MonitorSize = [ 0, 0, 400, 1000];
            set(gcf, 'Position', MonitorSize);
            if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_単回帰分析(V-ΔT,V-ΔA,V-X1)']);
            else
                obj.saveGraphWithName('_単回帰分析(V-ΔT,V-ΔA,V-X1)_2nd-half');
            end
            

%%        3次元分布　重回帰（交互作用なし）ΔAシフト
            figure(100);
            [fitParam3d, dTFIT, dAFIT, YFIT , fitR, yhat, fitR2 ]  = Rhythm.approxiSurface_flat(dT_zc , dA_zc_shift , Y_zc );
            plot3( dT_zc  , dA_zc_shift , Y_zc,   'Marker','*', 'LineStyle','none');
            lineEdgePoint_dTdAY(:,1) = m1 * lineEdgePoint_X1Y(:,1); %dT
            lineEdgePoint_dTdAY(:,2) = n1 * lineEdgePoint_X1Y(:,1); %dA
            lineEdgePoint_dTdAY(:,3) = lineEdgePoint_X1Y(:,2);      % Y

            hold on
                plot3( dT_nzc , dA_nzc  - b * ones(Nnzc,1), Y_nzc, 'Marker','o', 'LineStyle','none');
                plot3( [0,600*k1]  , [0,600*k2] , [0,0] ,'r' );
                plot3( [lineEdgePoint_dTdAY(2,1) lineEdgePoint_dTdAY(2,1)] , [lineEdgePoint_dTdAY(2,2) lineEdgePoint_dTdAY(2,2)] ...
                    , [0 lineEdgePoint_dTdAY(2,3)] ,'--r' );
                plot3( lineEdgePoint_dTdAY(:,1)  , lineEdgePoint_dTdAY(:,2) , lineEdgePoint_dTdAY(:,3) ,'r' ,'LineWidth',3 );
                C =colormap(jet);
                mesh(dTFIT,dAFIT,YFIT, 'faceAlpha',0.5);
                
%                 YFIT_recalc = fitParam_recalc(1) + fitParam_recalc(2)*dTFIT + fitParam_recalc(3)*dAFIT ;
% %                 C =colormap(Bone);
%                 mesh(dTFIT,dAFIT,YFIT_recalc, 'faceAlpha',0.5);     
                
%                 %　データグループ分割面
%                 dTgrid = 0:50:600;            dAgrid = 0:50:600;
%                 Zsep = 2* mean(Y_zc) * ones(length(dTgrid), length(dAgrid));
%                 mesh(dTgrid, dAgrid, Zsep, 'faceAlpha',0.8);
            hold off
            grid on
%             view(45,30);
            xlabel('操作波形 周期の差');  ylabel('操作波形 振幅の差');  zlabel('対数演算前アバタ速さ');
            xlim([0,600]);      ylim([0,600]);         zlim([0 50000]);
            title({ ['V = (' num2str(fitParam3d(1)) ') + (' num2str( fitParam3d(2) ) ') * ΔT + (' num2str( fitParam3d(3)) ') * ΔA’ '] ;...
                []});
            axis square
%%
            MonitorSize = [ 0, 0, 800, 800];
            set(gcf, 'Position', MonitorSize);
            if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_重回帰分析（V-ΔT,ΔA）']);
            else
                obj.saveGraphWithName('_重回帰分析（V-ΔT,ΔA）_2nd-half');
            end

%%        3次元分布　重回帰（交互作用なし）ΔAシフト→座標変換
            figure(110);
            [fitParam3d, X1FIT, X2FIT, YFIT , fitR, yhat, fitR2 ]  = Rhythm.approxiSurface_flat(X1 , X2 , Y_zc );
            plot3( X1  , X2 , Y_zc,   'Marker','*', 'LineStyle','none');

            hold on
                mesh(X1FIT,X2FIT,YFIT, 'faceAlpha',0.5);
                plot3(lineEdgePoint_X1Y(:,1), [0,0], lineEdgePoint_X1Y(:,2), 'r','LineWidth',3)
                plot3([lineEdgePoint_X1Y(2,1) lineEdgePoint_X1Y(2,1)], [0,0], [0 lineEdgePoint_X1Y(2,2)], '--r' );
                plot3([0 600], [0 0],[0 0],'r');
%                 %　データグループ分割面
%                 dTgrid = 0:50:600;            dAgrid = 0:50:600;
%                 Zsep = 2* mean(Y_zc) * ones(length(dTgrid), length(dAgrid));
%                 mesh(dTgrid, dAgrid, Zsep, 'faceAlpha',0.8);
            hold off
            grid on
            xlabel('X1 = k1*ΔT + k2*ΔA');  ylabel('X2 = l1*ΔT + l2*ΔA');  zlabel('対数演算前アバタ速さV');
            xlim([0,600]);      ylim([-300,300]);         zlim([0 50000]);
            title({ ['V = (' num2str(fitParam3d(1)) ') + (' num2str( fitParam3d(2) ) ') * X1 + (' num2str( fitParam3d(3)) ') * X2’ '] });
            axis square
%%
            MonitorSize = [ 0, 0, 800, 800];
            set(gcf, 'Position', MonitorSize);
            if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_重回帰分析(V-X1,X2)']);
            else
                obj.saveGraphWithName('_重回帰分析(V-X1,X2)_2nd-half');
            end

            %%      近似面　係数　エクセルデータ出力  
%             VIF = Rhythm.getVIF([dT_zc , dA_zc , dT_zc .*dA_zc ]);
%             outputTitle = { '定数項' , '周期差' , '振幅差','振幅差＊周期差',...
%                                     'VIF(周期差)', 'VIF（振幅差）', 'VIF（交互作用）','重相関R','重決定R2' };
%             output = num2cell( [fitParam3' VIF fitR fitR2] );
%             obj.outputAllToXls(output , outputTitle);
            
        end

        function runForPair(obj,user1 ,user2)
%             obj.runForAlone(user1);
%             obj.runForAlone(user2);
%             
            
        end

        
    end
end
