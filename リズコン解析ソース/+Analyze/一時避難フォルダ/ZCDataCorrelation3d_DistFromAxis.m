classdef ZCDataCorrelation3d_DistFromAxis < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = ZCDataCorrelation3d_DistFromAxis(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
           [period_zx, peak_zx] = Rhythm.setZeroCrossPeriodData(user.zeroCrossData);
           %　ゼロクロス間でのピーク回数取得
           [zeroCrossTimes] = Rhythm.setZeroCrossCount(user.zeroCrossData);
            
            Y = abs( user.zeroCrossData.nonlogAvtVelocity );
            dT = abs( period_zx(:,3) );
            dA = abs( peak_zx(:,3) );
            Time = user.zeroCrossData.zeroCrossTime;
            
            
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
            Time_zc = Time(IndexZeroCross);
            
            %外れ値を除外するため，最大データ２つをカット
            [dT_max,dT_imax] = max(dT_zc);     dT_zc(dT_imax)= [];	 dA_zc(dT_imax)= [];     Y_zc(dT_imax)= [];     Time_zc(dT_imax)= [];
            [dT_max,dT_imax] = max(dT_zc);     dT_zc(dT_imax)= [];	 dA_zc(dT_imax)= [];     Y_zc(dT_imax)= [];     Time_zc(dT_imax)= [];
            [dA_max,dA_imax] = max(dA_zc);     dT_zc(dA_imax)= [];	 dA_zc(dA_imax)= [];     Y_zc(dA_imax)= [];     Time_zc(dA_imax)= [];
            [dA_max,dA_imax] = max(dA_zc);     dT_zc(dA_imax)= [];	 dA_zc(dA_imax)= [];     Y_zc(dA_imax)= [];     Time_zc(dA_imax)= [];
%             [Y_max,Y_imax] = max(Y_zc);     dT_zc(Y_imax)= [];	 dA_zc(Y_imax)= [];     Y_zc(Y_imax)= [];
%             [Y_max,Y_imax] = max(Y_zc);     dT_zc(Y_imax)= [];	 dA_zc(Y_imax)= [];     Y_zc(Y_imax)= [];
            while max(Y_zc./dT_zc) > 500
                [Y_dT_max,Y_dT_imax] = max(Y_zc./dT_zc);     dT_zc(Y_dT_imax)= [];	 dA_zc(Y_dT_imax)= [];     Y_zc(Y_dT_imax)= [];     Time_zc(Y_dT_imax)= [];
                [Y_dT_max,Y_dT_imax] = max(Y_zc./dT_zc);     dT_zc(Y_dT_imax)= [];	 dA_zc(Y_dT_imax)= [];     Y_zc(Y_dT_imax)= [];     Time_zc(Y_dT_imax)= [];
            end
            while max(Y_zc./dA_zc) > 500
                [Y_dA_max,Y_dA_imax] = max(Y_zc./dA_zc);     dT_zc(Y_dA_imax)= [];	 dA_zc(Y_dA_imax)= [];     Y_zc(Y_dA_imax)= [];     Time_zc(Y_dA_imax)= [];
                [Y_dA_max,Y_dA_imax] = max(Y_zc./dA_zc);     dT_zc(Y_dA_imax)= [];	 dA_zc(Y_dA_imax)= [];     Y_zc(Y_dA_imax)= [];     Time_zc(Y_dA_imax)= [];
            end
 
            Nzc = length(Y_zc) ;
            Nnzc = length(Y_nzc) ;
            
%%        ΔAとΔTの主成分分析 と 主成分回帰分析
            [coeff,score,latent,tsquare] = princomp( [dT_zc dA_zc] );
%             [coeff,score,latent,tsquare] = pca( [dT_zc dA_zc] );
            k1 = abs(coeff(1,1));            k2 = abs(coeff(2,1));
            dT0_zc = dT_zc - mean(dT_zc);
            dA0_zc = dA_zc - mean(dA_zc);
            X1 = k1 * dT0_zc + k2 * dA0_zc;
            [ fitParam_X1Y, fitLineR_X1Y, lineEdgePoint_X1Y, yhat] = Rhythm.approxiLine2d(X1, Y_zc );

            alpha = fitParam_X1Y(1); 
            direction = [k1, k2, alpha]; 
            direct = direction / norm(direction);
            Point = [dT0_zc dA0_zc Y_zc];
            Point0 = [ lineEdgePoint_X1Y(1,1)*k1 , lineEdgePoint_X1Y(1,1)*k2 , lineEdgePoint_X1Y(1,2) ];
            for i = 1 : Nzc
                vector_P0P = Point(i,:) - Point0;
                vector_P0H(i,:) = dot( vector_P0P , direct) * direct;
                H_Point(i,:) =  Point0 + vector_P0H(i,:);
                vector_HP(i,:) = Point(i,:) - H_Point(i,:);
                distError(i,:) = norm( vector_HP(i,:) );     %主成分回帰直線とデータの距離
            end
            distMean = sqrt( sum( distError.^2 ) / (Nzc-3) );
            
%%          回帰直線とデータの距離の時系列変化
            figure(1)
            MonitorSize = [ 0, 0, 1000, 800];
            set(gcf, 'Position', MonitorSize);
            
            subplot(3,1,1);
            Leng = norm( [lineEdgePoint_X1Y(:,1) , lineEdgePoint_X1Y(:,2)] );
            leng = norm( 400 * direction );
            plot3([0 Leng],[0 0],[0 0],'r' ,'LineWidth',3 );
            XYmax = ceil(distMean/50)*50;
            hold on
                plot3([0 leng],[0 0],[0 0],'r');
                plot3([0 0],[0 0],[-XYmax XYmax] ,'k');
                plot3([0 0],[-XYmax XYmax],[0 0] ,'k');
                for i = 1 : Nzc
                    plot3( [0 vector_HP(i,3)]+ norm( vector_P0H(i,:) )   ,[0 vector_HP(i,1)] ,[0 vector_HP(i,2)]  ,'k' );
                    plot3( vector_HP(i,3) + norm( vector_P0H(i,:) ) , vector_HP(i,1) , vector_HP(i,2)  , '*' );
                end
            hold off
            view(5,30);            grid on
            xlabel('');  ylabel('');  zlabel('回帰直線');
            title({ ['各データの回帰直線との距離'] });
            ylim([-XYmax XYmax]);            zlim([-XYmax XYmax]);
           
            
            subplot(3,1,2);
            plot(  Time_zc , distError );
            xlabel('ゼロクロス時間');  ylabel('回帰直線とデータの距離');
            xlim([0 60000]);            ylim([0 400]);

            subplot(3,1,3);
            plot3(  Time_zc , vector_HP(:,1) , vector_HP(:,2) );
            xlabel('ゼロクロス時間');  zlabel('回帰直線からのデータベクトル');
            view(5,30);            grid on
%             xlim([0 60000]);            ylim([0 400]);
            
%             title({ ['X：(' num2str(coeff(1,1)) ', '  num2str(coeff(2,1)) ')　\theta =(' num2str( atan(k2/k1) *180 / pi ) ')[deg]'] ;...
%                 ['X-Vの傾き：' num2str( alpha ) '，相関係数R：' num2str( fitLineR_X1Y(1)) '，決定係数R^2：' num2str( fitLineR_X1Y(1)^2)];...
%                 [ '回帰直線からの距離の二乗平均平方根：' num2str( distMean ) ]});

%%
            if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_重回帰分析（V-X1）']);
            else
                obj.saveGraphWithName('_重回帰分析（V-X1）');
            end


            %%   　エクセルデータ出力  
%             outputTitle = { 'k1' , 'k2' , '角度','latent(X1)','latent(X2)',...
%                                     'X1の係数','重相関R','重決定R2' };
%             output = num2cell( [k1 k2 (atan(k2/k1)*180/pi) latent' alpha  fitLineR_X1Y(1) fitLineR_X1Y(1)^2] );
%             if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
%                 obj.outputAllToXlsWithName([ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state ] , output , outputTitle)
%             else
%                 obj.outputAllToXls(output , outputTitle);
%             end
           
            
        end

        function runForPair(obj,user1 ,user2)
%             obj.runForAlone(user1);
%             obj.runForAlone(user2);
%             
            
        end

        
    end
end
