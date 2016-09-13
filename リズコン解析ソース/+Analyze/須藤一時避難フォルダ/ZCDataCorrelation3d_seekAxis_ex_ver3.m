classdef ZCDataCorrelation3d_seekAxis_ex_ver3 < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = ZCDataCorrelation3d_seekAxis_ex_ver3(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
           [period_zx, peak_zx] = Rhythm.setZeroCrossPeriodData(user.zeroCrossData);
           %　ゼロクロス間でのピーク回数取得
           [zeroCrossTimes] = Rhythm.setZeroCrossCount(user.zeroCrossData);
            
            Y = abs( user.zeroCrossData.nonlogAvtVelocity );
            dT = abs( period_zx(:,3) );
            dA = abs( peak_zx(:,3) );
            Time = abs( user.zeroCrossData.zeroCrossTime );
            
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
            Time_zc = Time(IndexZeroCross);        Time_nzc  = Time(IndexNonZeroCross);
            
            %外れ値を除外するため，最大データ２つをカット
            [dT_max,dT_imax] = max(dT_zc);     dT_zc(dT_imax)= [];	 dA_zc(dT_imax)= [];     Y_zc(dT_imax)= [];     Time_zc(dT_imax)= [];
            [dT_max,dT_imax] = max(dT_zc);     dT_zc(dT_imax)= [];	 dA_zc(dT_imax)= [];     Y_zc(dT_imax)= [];     Time_zc(dT_imax)= [];
            [dA_max,dA_imax] = max(dA_zc);     dT_zc(dA_imax)= [];	 dA_zc(dA_imax)= [];     Y_zc(dA_imax)= [];     Time_zc(dA_imax)= [];
            [dA_max,dA_imax] = max(dA_zc);     dT_zc(dA_imax)= [];	 dA_zc(dA_imax)= [];     Y_zc(dA_imax)= [];     Time_zc(dA_imax)= [];
%             [Y_max,Y_imax] = max(Y_zc);     dT_zc(Y_imax)= [];	 dA_zc(Y_imax)= [];     Y_zc(Y_imax)= [];
%             [Y_max,Y_imax] = max(Y_zc);     dT_zc(Y_imax)= [];	 dA_zc(Y_imax)= [];     Y_zc(Y_imax)= [];
%             while max(Y_zc./dT_zc) > 500
%                 [Y_dT_max,Y_dT_imax] = max(Y_zc./dT_zc);     dT_zc(Y_dT_imax)= [];	 dA_zc(Y_dT_imax)= [];     Y_zc(Y_dT_imax)= [];
%                 [Y_dT_max,Y_dT_imax] = max(Y_zc./dT_zc);     dT_zc(Y_dT_imax)= [];	 dA_zc(Y_dT_imax)= [];     Y_zc(Y_dT_imax)= [];
%             end
%             while max(Y_zc./dA_zc) > 500
%                 [Y_dA_max,Y_dA_imax] = max(Y_zc./dA_zc);     dT_zc(Y_dA_imax)= [];	 dA_zc(Y_dA_imax)= [];     Y_zc(Y_dA_imax)= [];
%                 [Y_dA_max,Y_dA_imax] = max(Y_zc./dA_zc);     dT_zc(Y_dA_imax)= [];	 dA_zc(Y_dA_imax)= [];     Y_zc(Y_dA_imax)= [];
%             end
 
            Nzc = length(Y_zc) ;
            Nnzc = length(Y_nzc) ;
            
%%           主成分回帰分析
            bFig =1 ;
            [k1 , k2, X1, fitParam_X1Y, fitLineR_X1Y] = Rhythm.PCA_regress(dT_zc , dA_zc , Y_zc , bFig) ;
            hold on
                plot3(dT_nzc, dA_nzc , Y_nzc ,'Color' , 'b' ,'Marker','o', 'LineStyle','none' );
            hold off
%             view(-30,25);
%             set(gcf, 'Position', [0 0 500 500]);
            
            %%
           if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_主成分回帰分析']);
            else
                obj.saveGraphWithName('_主成分回帰分析');
            end
            
%%           各データの回帰直線との距離
            dTdAmean = mean( [dT_zc , dA_zc] );
             [vector_HP , distError , distMean] = Rhythm.PCA_regDist(dT_zc , dA_zc , Y_zc , k1, k2 , X1, dTdAmean, fitParam_X1Y , bFig );
%         function [vector_HP , distError , distMean] = PCA_regDist(dT_zc , dA_zc , Y_zc , k1, k2 , X1, dTdAmean, fitParam_X1Y, bFig )

%%
            if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_回帰直線からの距離']);
            else
                obj.saveGraphWithName('_回帰直線からの距離');
            end

%%        回帰直線からの距離の時間変化

            MonitorSize = [ 0, 0, 1200, 800];
            set(gcf, 'Position', MonitorSize);
            a1 = subplot( 2,1,1 );
            
            plot(   user.time.highSampled,  user.avatarPosition.highSampled);      
            hold on
                if ~isempty( strfind( char(obj.config.examType), '追い込まれ') ) ...
                        || ~isempty( strfind( char(obj.config.examType), '追い込む実験') )
                    plot(   obj.data.com.time, abs( obj.data.com.avatarPosition ) , 'k:');               
                    if ~isempty(strfind( char(obj.config.examType), '両側') )  
                        plot(   obj.data.com2.time,  obj.data.com2.avatarPosition , 'k:');     
                    end
                elseif ~isempty(  findstr( char( obj.config.examType ) , '追従'))
                    if ~isempty(  findstr( char( obj.config.examType ) , '目標追従'))
                        plot(   obj.data.task.time,  obj.data.task.avatarPosition , 'color' ,[.8 .8 .8]);   
                        plot(   obj.data.task.time,  obj.data.task.avatarPosition-75 , 'color' ,[.8 .8 .8]);   
                    else
                        plot(   obj.data.task.time,  obj.data.task.avatarPosition , 'k:');   
                    end
                elseif obj.config.isExistPlayer1 && obj.config.isExistPlayer2
                    if obj.currentRunType == obj.runTypePlayer1
                        plot( obj.data.player2.time.highSampled , obj.data.player2.avatarPosition.highSampled , 'k:');
                    elseif obj.currentRunType == obj.runTypePlayer2
                        plot( obj.data.player1.time.highSampled , obj.data.player1.avatarPosition.highSampled , 'k:');
                    end
                end
                %　ゼロクロスしないタイミングを描画
                for j= 1: length(IndexNonZeroCross)
                    zeroCrossTime = user.zeroCrossData.zeroCrossTime(IndexNonZeroCross(j) );
                    plot([zeroCrossTime zeroCrossTime],[0 1000],...
                        'Color' , [1 0 0] , 'LineStyle', ':');
                end
                if ~isempty(  findstr( char( obj.config.examType ) , '線追従'))
                    for j=1:length(swTiming)
                        plot( [swTiming(j) swTiming(j)],[-1000 1000], 'Color' , 'k' , 'LineStyle', ':');
                    end
                end
            hold off
            xlabel('時間t ms'); ylabel('アバタ位置');
            xlim([0 60000]);    ylim([0 1000]);
            
            a2 = subplot( 2,1,2 );
            plot(Time_zc , distError);
            xlabel('時間t ms'); ylabel('回帰直線からの距離');
            xlim([0 60000]);    ylim([0 300]);
            
            linkaxes([a1 a2],'x');

%%
            if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_回帰直線からの距離とアバタ位置']);
            else
                obj.saveGraphWithName('_回帰直線からの距離とアバタ位置');
            end

            %%   　エクセルデータ出力  
            %  　エクセルデータ出力  
            outputTitle = { 'k1' , 'k2' , '角度',...
                                    'X1の係数','重相関R','重決定R2' , '回帰直線とデータの距離の二乗平均平方根'};
            output = num2cell( [k1 k2 (atan(k2/k1)*180/pi) fitParam_X1Y(1) fitLineR_X1Y(1) fitLineR_X1Y(1)^2 distMean] );
            
            if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
                obj.outputAllToXlsWithName([ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state ] , output , outputTitle)
            else
                obj.outputAllToXls(output , outputTitle);
            end
           
            
        end

        function runForPair(obj,user1 ,user2)
%             obj.runForAlone(user1);
%             obj.runForAlone(user2);
%             
            
        end

        
    end
end
