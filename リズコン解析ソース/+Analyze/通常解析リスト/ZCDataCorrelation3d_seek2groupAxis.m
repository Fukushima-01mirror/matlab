classdef ZCDataCorrelation3d_seek2groupAxis < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = ZCDataCorrelation3d_seek2groupAxis(config,data)
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
            while max(Y_zc./dT_zc) > 1000
                [Y_dT_max,Y_dT_imax] = max(Y_zc./dT_zc);     dT_zc(Y_dT_imax)= [];	 dA_zc(Y_dT_imax)= [];     Y_zc(Y_dT_imax)= [];
                [Y_dT_max,Y_dT_imax] = max(Y_zc./dT_zc);     dT_zc(Y_dT_imax)= [];	 dA_zc(Y_dT_imax)= [];     Y_zc(Y_dT_imax)= [];
            end
            while max(Y_zc./dA_zc) > 1000
                [Y_dA_max,Y_dA_imax] = max(Y_zc./dA_zc);     dT_zc(Y_dA_imax)= [];	 dA_zc(Y_dA_imax)= [];     Y_zc(Y_dA_imax)= [];
                [Y_dA_max,Y_dA_imax] = max(Y_zc./dA_zc);     dT_zc(Y_dA_imax)= [];	 dA_zc(Y_dA_imax)= [];     Y_zc(Y_dA_imax)= [];
            end
 
            Nzc = length(Y_zc) ;
            Nnzc = length(Y_nzc) ;
%%
            dT_border = 50; dA_border = 50; k_border = 1;
            
%%        ΔAとΔTの散布図
            figure(200)
            [ fitParam_dTdA, fitLineR_dTdA, lineEdgePoint] = Rhythm.approxiLine2d(dT_zc  ,dA_zc );
            a = fitParam_dTdA(1);   b = fitParam_dTdA(2);
            plot( dT_zc   ,dA_zc  , 'Marker','*', 'LineStyle','none');
            hold on
                plot( dT_nzc   ,dA_nzc ,'Marker','o', 'LineStyle','none' );
                plot(lineEdgePoint(:,1), lineEdgePoint(:,2), '--r');
%                 plot([ 0:50:300 ], [100 100 200 300 400 500 600],'--m');
%                 plot([ 50 50 100:50:300 ], [0:100:600],'--c');
            hold off
            grid on
            xlabel('操作波形 周期の差　ΔT');    ylabel('操作波形　振幅の差　ΔA'); 
            xlim([0,600]);            ylim([0,600]);
            title({['ΔA =  (' num2str( a ) ') * ΔT  + (' num2str( b ) ')']; ...
                    ['相関係数R：' num2str( fitLineR_dTdA(1)) '　　決定係数R^2' num2str( fitLineR_dTdA(1)^2)]});
%%
            MonitorSize = [ 0, 0, 800, 800];
            set(gcf, 'Position', MonitorSize);
            
            if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_散布図(ΔA-ΔT)領域分け']);
            else
                obj.saveGraphWithName('_散布図(ΔA-ΔT)領域分け');
            end
            
%%          グループ分け
            figure(210)
            IndexGroup1 = find( dA_zc <= dA_border | dA_zc./dT_zc <= k_border );
            IndexGroup2 = find( dT_zc <= dT_border | dA_zc./dT_zc >= k_border );
            dA_g1 = dA_zc(IndexGroup1);     dT_g1 = dT_zc(IndexGroup1);     Y_g1 = Y_zc(IndexGroup1);
            dA_g2 = dA_zc(IndexGroup2);     dT_g2 = dT_zc(IndexGroup2);     Y_g2 = Y_zc(IndexGroup2);
                subplot(1,2,1);
            plot(dT_g1 , dA_g1  , 'Marker','*', 'LineStyle','none');
            hold on
%                 plot([ 0:50:300 ], [100 100 200 300 400 500 600],'m');
            hold off
            grid on
            xlabel('操作波形 周期の差　ΔT group1');    ylabel('操作波形　振幅の差　ΔA group1'); 
            xlim([0,600]);            ylim([0,600]);
            title({['データ数' num2str(length(Y_g1))]});
                subplot(1,2,2);
            plot(dT_g2 , dA_g2  , 'Marker','*', 'LineStyle','none');
            hold on
%                 plot([ 50 50 100:50:300 ], [0:100:600],'c');
            hold off
            grid on
            xlabel('操作波形 周期の差　ΔT group2');    ylabel('操作波形　振幅の差　ΔA group2'); 
            xlim([0,600]);            ylim([0,600]);
            title({['データ数' num2str(length(Y_g2))]});

            %%
            MonitorSize = [ 0, 0, 1000, 400];
            set(gcf, 'Position', MonitorSize);
            
            if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_散布図(ΔA-ΔT)グループ分け']);
            else
                obj.saveGraphWithName('_散布図(ΔA-ΔT)グループ分け');
            end
            

%%        グループ１　軸解析
             [ a1 ,b1 , alpha1, beta1 ] = Rhythm.findContAxis(obj, dT_g1, dA_g1 , Y_g1 ,'group1');
            
%%        グループ2　軸解析
             [ a2 ,b2 , alpha2, beta2 ]  = Rhythm.findContAxis(obj, dT_g2, dA_g2 , Y_g2 ,'group2');
            
%%        全体データ散布図
             figure(220);
            [fitParam3d, dTFIT, dAFIT, YFIT , fitR, yhat, fitR2 ]  = Rhythm.approxiSurface_flat(dT_zc , dA_zc , Y_zc );
            plot3( dT_g1  , dA_g1 , Y_g1,  'm',  'Marker','*', 'LineStyle','none');
            [k11, k12, lineEdgePoint_g1] = Rhythm.calcContAxis( a1 ,b1 , alpha1, beta1 ,dT_g1  , dA_g1);
            [k21, k22, lineEdgePoint_g2] = Rhythm.calcContAxis( a2 ,b2 , alpha2, beta2 ,dT_g2  , dA_g2);
            hold on
                plot3( dT_g2  , dA_g2 , Y_g2,  'c',  'Marker','*', 'LineStyle','none');
                mesh(dTFIT,dAFIT,YFIT, 'faceAlpha',0.5);
                
                plot3( [0,600*k11]  , [b1,b1+600*k12] , [0,0] ,'r' );
                plot3( lineEdgePoint_g1(:,1)  , lineEdgePoint_g1(:,2) , lineEdgePoint_g1(:,3) ,'r' ,'LineWidth',3 );
                plot3( [lineEdgePoint_g1(2,1) lineEdgePoint_g1(2,1)] , [lineEdgePoint_g1(2,2) lineEdgePoint_g1(2,2)] ...
                    , [0 lineEdgePoint_g1(2,3)] ,'--r' );

                plot3( [0,600*k21]  , [b2,b2+600*k22] , [0,0] ,'b' );
                plot3( lineEdgePoint_g2(:,1)  , lineEdgePoint_g2(:,2) , lineEdgePoint_g2(:,3) ,'b' ,'LineWidth',3 );
                plot3( [lineEdgePoint_g2(2,1) lineEdgePoint_g2(2,1)] , [lineEdgePoint_g2(2,2) lineEdgePoint_g2(2,2)] ...
                    , [0 lineEdgePoint_g2(2,3)] ,'--b' );
                
            hold off
            grid on
%             view(45,30);
            xlabel('操作波形 周期の差');  ylabel('操作波形 振幅の差');  zlabel('対数演算前アバタ速さ');
            xlim([0,600]);      ylim([0,600]);         zlim([0 50000]);
            title({ ['V = (' num2str(fitParam3d(1)) ') + (' num2str( fitParam3d(2) ) ') * ΔT + (' num2str( fitParam3d(3)) ') * ΔA'] ;...
                []});
            axis square
%%
            MonitorSize = [ 0, 0, 500, 500];
            set(gcf, 'Position', MonitorSize);
            
            if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_重回帰分析（group1,2重ね合わせ）']);
            else
                obj.saveGraphWithName('_重回帰分析（group1,2重ね合わせ）');
            end

%%        全体データ散布図
             figure(250);
            plot( dT_g1  , dA_g1 ,  'm',  'Marker','*', 'LineStyle','none');
            hold on
                plot( dT_g2  , dA_g2 , 'c',  'Marker','*', 'LineStyle','none');
                plot( [0,600*k11]  , [b1,b1+600*k12] ,'r' );
                plot( [0,600*k21]  , [b2,b2+600*k22] ,'b' );
            hold off
            grid on
%             view(45,30);
            xlabel('操作波形 周期の差');  ylabel('操作波形 振幅の差'); 
            xlim([0,600]);      ylim([0,600]);
%%
            MonitorSize = [ 0, 0, 500, 500];
            set(gcf, 'Position', MonitorSize);
            
            if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_2次元相関（group1,2重ね合わせ）']);
            else
                obj.saveGraphWithName('_2次元相関（group1,2重ね合わせ）');
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
