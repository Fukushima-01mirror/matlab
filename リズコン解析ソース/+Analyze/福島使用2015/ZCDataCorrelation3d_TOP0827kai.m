classdef ZCDataCorrelation3d_TOP0827kai < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = ZCDataCorrelation3d_TOP0827kai(config,data)
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
            
%             IndexTout = find(dT_zc>300);
%             IndexAout = find(dT_zc>300);
%                 
%              [dT_max,dT_imax] = max(dT_zc);     dT_zc( IndexTout)= [];	 dA_zc( IndexTout)= [];     Y_zc(IndexTout)= [];     Time_zc(IndexTout)= [];
%             [dT_max,dT_imax] = max(dT_zc);     dT_zc(IndexAout)= [];	 dA_zc(IndexAout)= [];     Y_zc(IndexAout)= [];     Time_zc(IndexAout)= [];
            
            
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
 
            IndexFormer = find(Time(:) > 0 & Time(:) < 35420);
            IndexLater = find(Time(:) > 30000 & Time(:) < 60000);
            
            Y_zcF  = Y(IndexFormer);        
            dT_zcF = dT(IndexFormer,:);     
            dA_zcF = dA(IndexFormer,:);     
            Time_zcF = Time(IndexFormer);   
            
%             Y_zcL  = Y(IndexLater);        
%             dT_zcL = dT(IndexLater,:);     
%             dA_zcL = dA(IndexLater,:);   
%             Time_zcL = Time(IndexLater);   

            Nzc = length(Y_zc) ;
            Nnzc = length(Y_nzc) ;
            
%%           主成分回帰分析
            set(gcf, 'Position', [ 0, 0, 500, 500]);    bFig = 1;
            [k1 , k2, X1, fitParam_X1Y, fitLineR_X1Y] = Rhythm.PCA_regress_3dplot2(dT_zcF , dA_zcF , Y_zcF , bFig) ;
            hold on
                %plot3(dT_nzcF, dA_nzcF , Y_nzcF ,'Color' , 'b' ,'Marker','o', 'LineStyle','none' );
            hold off
            view(0,90);
             xlim([0 1000]);            ylim([0 1000]);          zlim([0 100000]);
%             set(gcf, 'Position', [0 0 500 500]);
            
            %%
           if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_主成分回帰分析F']);
            else
                obj.saveGraphWithName('_主成分回帰分析F');
           end
%             %%           主成分回帰分析2
%             set(gcf, 'Position', [ 0, 0, 500, 500]);    bFig = 1;
%             [k1 , k2, X1, fitParam_X1Y, fitLineR_X1Y] = Rhythm.PCA_regress_3dplot2(dT_zcL , dA_zcL , Y_zcL , bFig) ;
%             hold on
%                 %plot3(dT_nzcL, dA_nzcL , Y_nzcL ,'Color' , 'b' ,'Marker','o', 'LineStyle','none' );
%             hold off
%             view(-30,25);
%              xlim([0 1000]);            ylim([0 1000]);          zlim([0 100000]);
% %             set(gcf, 'Position', [0 0 500 500]);
%             
%             %%
%            if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
%                 obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_主成分回帰分析L']);
%             else
%                 obj.saveGraphWithName('_主成分回帰分析L');
%             end
%             
          
        end

        function runForPair(obj,user1 ,user2)
%             obj.runForAlone(user1);
%             obj.runForAlone(user2);
%             
            
        end

        
    end
end
