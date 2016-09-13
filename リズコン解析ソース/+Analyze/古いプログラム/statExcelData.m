classdef statExcelData < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = statExcelData(config,data)
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
            
%%        各データ統計値
            outputTitle = {'dT平均','dT標準偏差','dA平均','dA標準偏差', ...
                                        'V平均','V標準偏差',' 複数ピークを持つサイクルの割合' };
            output = num2cell([mean(dT_zc) , std(dT_zc), mean(dA_zc) , std(dA_zc), ...
                                        mean(Y_zc) , std(Y_zc) , Nzc/(Nzc + Nnzc)]  );
            obj.outputAllToXlsWithName( 'statics' , output , outputTitle)
                
%%        各データ回帰分析
%             [ fitParam1, fitLineR1, lineEdgePoint] = Rhythm.approxiLine2d(dT_zc , Y_zc );
%             [ fitParam2, fitLineR2, lineEdgePoint] = Rhythm.approxiLine2d(dA_zc , Y_zc );
%             [ fitParam3, fitLineR3, lineEdgePoint] = Rhythm.approxiLine2d(dT_zc   ,dA_zc  );
%             outputTitle = {'ΔTとVの回帰係数','ΔTとVの相関係数','ΔAとVの回帰係数','ΔAとVの相関係数', ...
%                                         'ΔTとΔAの回帰係数','ΔTとΔAの相関係数'};
%             output = num2cell([fitParam1(1) , fitLineR1(1), fitParam2(1) , fitLineR2(1), ...
%                                         fitParam3(1), fitLineR3(1)] );
%             obj.outputAllToXlsWithName( 'each-regress' , output , outputTitle)
                
%%        3次元分布　重回帰分析
%             [fitParam, dTFIT, dAFIT, YFIT , fitR, yhat, fitR2 ,resError, SER]  = Rhythm.approxiSurface_flat(dT_zc , dA_zc , Y_zc );
%             [zY_zc , m_Y , s_Y]  = zscore( Y_zc);
%             [zdT_zc , m_dT , s_dT] = zscore( dT_zc);            [zdA_zc , m_dA , s_dA] = zscore( dA_zc);
%             [zfitParam, zdTFIT, zdAFIT, zYFIT , zfitR, zyhat, zfitR2 ]  = Rhythm.approxiSurface_flat(zdT_zc , zdA_zc , zY_zc );
%             outputTitle = { '定数項', '周期差', '(標準化)',...
%                                     '振幅差', '(標準化)', '重相関R', '重決定R2' ,'標準誤差(残差の標準偏差)' };
%             output = num2cell( [fitParam(1) fitParam(2) zfitParam(2) fitParam(3) zfitParam(3) fitR fitR2 SER ] );
%             obj.outputAllToXlsWithName( '3d-Regress' , output , outputTitle)
            
%%        ΔAとΔTの主成分分析 と 主成分回帰分析
%             figure(1)
%             [coeff,score,latent,tsquare] = princomp( [dT_zc dA_zc] );
%             k1 = abs(coeff(1,1));            k2 = abs(coeff(2,1));
%             dT0_zc = dT_zc - mean(dT_zc);
%             dA0_zc = dA_zc - mean(dA_zc);
%             X1 = k1 * dT0_zc + k2 * dA0_zc;
%             [ fitParam_X1Y, fitLineR_X1Y, lineEdgePoint_X1Y, yhat] = Rhythm.approxiLine2d(X1, Y_zc );
% 
%             alpha = fitParam_X1Y(1); 
%             direction = [k1, k2, alpha]; 
%             direct = direction / norm(direction);
%             Point = [dT0_zc dA0_zc Y_zc];
%             Point0 = [ lineEdgePoint_X1Y(1,1)*k1 , lineEdgePoint_X1Y(1,1)*k2 , lineEdgePoint_X1Y(1,2) ];
%             for i = 1 : Nzc
%                 vector_P0P = Point(i,:) - Point0;
%                 vector_P0H(i,:) = dot( vector_P0P , direct) * direct;
%                 H_Point(i,:) =  Point0 + vector_P0H(i,:);
%                 vector_HP(i,:) = Point(i,:) - H_Point(i,:);
%                 distError(i,:) = norm( vector_HP(i,:) );     %主成分回帰直線とデータの距離
%             end
%             distMean = sqrt( sum( distError.^2 ) / (Nzc-3) );
%             
%             %  　エクセルデータ出力  
%             outputTitle = { 'k1' , 'k2' , '角度','latent(X1)','latent(X2)',...
%                                     'X1の係数','重相関R','重決定R2' , '回帰直線とデータの距離の二乗平均平方根'};
%             output = num2cell( [k1 k2 (atan(k2/k1)*180/pi) latent' alpha fitLineR_X1Y(1) fitLineR_X1Y(1)^2 distMean] );
%             obj.outputAllToXlsWithName( 'PCA-Regress' ,output , outputTitle);

            
        end

        function runForPair(obj,user1 ,user2)
%             obj.runForAlone(user1);
%             obj.runForAlone(user2);
%             
            
        end

        
    end
end
