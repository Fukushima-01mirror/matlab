classdef ZCDataCorrelation3d_0827kai_TimeDivide < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = ZCDataCorrelation3d_0827kai_TimeDivide(config,data)
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
 
            IndexFormer = find(Time_zc(:) > 0 & Time_zc(:) < 35420);
            IndexLater = find(Time_zc(:) > 30000 & Time_zc(:) < 60000);
            Index_A = find(Time_zc(:) > 0 & Time_zc(:) < 5000);
            Index_B = find(Time_zc(:) > 5000 & Time_zc(:) < 10000);
            Index_C = find(Time_zc(:) > 10000 & Time_zc(:) < 15000);
            Index_D = find(Time_zc(:) > 15000 & Time_zc(:) < 20000);
            Index_E = find(Time_zc(:) > 20000 & Time_zc(:) < 25000);
            Index_F = find(Time_zc(:) > 25000 & Time_zc(:) < 30000);
            Index_G = find(Time_zc(:) > 30000 & Time_zc(:) < 35000);
            Index_H = find(Time_zc(:) > 3000 & Time_zc(:) < 5500);
            Index_I = find(Time_zc(:) > 11000 & Time_zc(:) < 22000);
            Index_J = find(Time_zc(:) > 22000 & Time_zc(:) < 33000);
            Index_K = find(Time_zc(:) > 33000 & Time_zc(:) < 44000);
            
            Index_Detect =  find(dT_zc > 200 );
            Y_zcDT  = Y(Index_Detect);        
            dT_zcDT = dT(Index_Detect,:);     
            dA_zcDT = dA(Index_Detect,:); 
            Time_zcDT = Time(Index_Detect);
      
%             Y_zcF  = Y(IndexFormer);        
%             dT_zcF = dT(IndexFormer,:);     
%             dA_zcF = dA(IndexFormer,:);     
%             Time_zcF = Time(IndexFormer);   
%             
%             Y_zcL  = Y(IndexLater);        
%             dT_zcL = dT(IndexLater,:);     
%             dA_zcL = dA(IndexLater,:);   
%             Time_zcL = Time(IndexLater);   

            Y_zcA  = Y_zc(Index_A);        
            dT_zcA = dT_zc(Index_A,:);     
            dA_zcA = dA_zc(Index_A,:);     
            Time_zcA = Time_zc(Index_A);
            
            Y_zcB = Y_zc(Index_B);        
            dT_zcB = dT_zc(Index_B,:);     
            dA_zcB = dA_zc(Index_B,:);     
            Time_zcB = Time_zc(Index_B);
            
            Y_zcC  = Y_zc(Index_C);        
            dT_zcC = dT_zc(Index_C,:);     
            dA_zcC = dA_zc(Index_C,:);     
            Time_zcC = Time_zc(Index_C);
            
            Y_zcD  = Y_zc(Index_D);        
            dT_zcD = dT_zc(Index_D,:);     
            dA_zcD = dA_zc(Index_D,:);     
            Time_zcD = Time_zc(Index_D);
            
            Y_zcE  = Y_zc(Index_E);        
            dT_zcE = dT_zc(Index_E,:);     
            dA_zcE = dA_zc(Index_E,:);     
            Time_zcE = Time_zc(Index_E);
            
            Y_zcF  = Y_zc(Index_F);        
            dT_zcF = dT_zc(Index_F,:);     
            dA_zcF = dA_zc(Index_F,:);     
            Time_zcF = Time_zc(Index_F);
            
            Y_zcG = Y_zc(Index_G);        
            dT_zcG = dT_zc(Index_G,:);     
            dA_zcG = dA_zc(Index_G,:);     
            Time_zcG = Time_zc(Index_G);
            
            Y_zcH  = Y_zc(Index_H);        
            dT_zcH = dT_zc(Index_H,:);     
            dA_zcH = dA_zc(Index_H,:);     
            Time_zcH = Time_zc(Index_H);
            
            Y_zcI  = Y_zc(Index_I);        
            dT_zcI = dT_zc(Index_I,:);     
            dA_zcI = dA_zc(Index_I,:);     
            Time_zcI = Time_zc(Index_I);
            
            Y_zcJ  = Y_zc(Index_J);        
            dT_zcJ = dT_zc(Index_J,:);     
            dA_zcJ = dA_zc(Index_J,:);     
            Time_zcJ = Time_zc(Index_J);
            
            Y_zcK = Y_zc(Index_K);        
            dT_zcK = dT_zc(Index_K,:);     
            dA_zcK = dA_zc(Index_K,:);     
            Time_zcK = Time_zc(Index_K);

            Nzc = length(Y_zc) ;
            Nnzc = length(Y_nzc) ;
            
%%           主成分回帰分析
            set(gcf, 'Position', [ 0, 0, 500, 500]);    bFig = 1;
%             [k1 , k2, X1, fitParam_X1Y, fitLineR_X1Y] = Rhythm.PCA_regress_3dplot2(dT_zcF , dA_zcF , Y_zcF , bFig) ;
            hold on
                plot3(dT_zcDT, dA_zcDT , Y_zcDT ,'Color' , 'r' ,'Marker','.', 'LineStyle','none' );
%                 plot3(dT_zcI, dA_zcI , Y_zcI ,'Color' , 'g' ,'Marker','.', 'LineStyle','none' );
%                 plot3(dT_zcJ, dA_zcJ , Y_zcJ ,'Color' , 'b' ,'Marker','.', 'LineStyle','none' );
%                 plot3(dT_zcK, dA_zcK , Y_zcK ,'Color' , 'k' ,'Marker','.', 'LineStyle','none' );
                
            hold off
            grid on
            view(-30,25);
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
