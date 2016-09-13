classdef ZCDataAvtPosVar2 < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = ZCDataAvtPosVar2(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
           [period_zx, peak_zx] = Rhythm.setZeroCrossPeriodData(user.zeroCrossData);
           %　ゼロクロス間でのピーク回数取得
           [zeroCrossTimes] = Rhythm.setZeroCrossCount(user.zeroCrossData);
            
            Y = abs( user.zeroCrossData.nonlogAvtVelocity );
            dT = abs( period_zx(:,2) );
            dA = abs( peak_zx(:,2) );
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
            Time_zc = Time(IndexZeroCross,:);        Time_nzc  = Time(IndexNonZeroCross,:);
            
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
            
 
            
%%        主成分回帰分析
%             bFig =1 ;
%             [k1 , k2, X1, fitParam_X1Y, fitLineR_X1Y] = Rhythm.PCA_regress(dT_zc , dA_zc , Y_zc , bFig) ;
           % hold on
            %    plot3(dT_nzc, dA_nzc , Y_nzc ,'Color' , 'b' ,'Marker','o', 'LineStyle','none' );
            %hold off
%             view(-30,25);
%             set(gcf, 'Position', [0 0 500 500]);
            

%%           各データの回帰直線との距離
%             dTdAmean = mean( [dT_zc , dA_zc] );
%              [vector_HP , distError , distMean] = Rhythm.PCA_regDist(dT_zc , dA_zc , Y_zc , k1, k2 , X1, dTdAmean, fitParam_X1Y , bFig );
%         function [vector_HP , distError , distMean] = PCA_regDist(dT_zc , dA_zc , Y_zc , k1, k2 , X1, dTdAmean, fitParam_X1Y, bFig )


%%        回帰直線からの距離の時間変化
            
            MonitorSize = [ 0, 0, 800, 400];
            set(gcf, 'Position', MonitorSize);
           %%剣角度検出
            D=dir(char(strcat(cd(),'\data\',obj.config.fileName,'\avt*.csv')));
            SA = csvread(char(strcat(cd(),'\data\',obj.config.fileName,'\',D(1).name)),1,2,[1,2,3000,2]);
%             plot(  user.time.lowSampled , SA ,'-k');
%             
%             hold on
            
%             for j= 2:length(SA)
%                 SupTime = user.time.lowSampled(j);
%                 if SA(j-1) == 0 && SA(j) ~= SA(j-1)
% %                      plot([SupTime SupTime],[-1 2],...
% %                          'Color' , 'b' , 'LineStyle', '-');
% %                 else if SA(j) == 0 && SA(j-1) ~= SA(j)
% %                          plot([SupTime SupTime],[-1 2],...
% %                          'Color' , [0 0 1] , 'LineStyle', ':');
% %                     end
%                 end
%             end
%              xlabel('時間t ms'); ylabel('剣角度');
%               xlim([0 60000]);  ylim([-1 2]);
%             hold on

                x = Time_zc;
                y1 = dA_zc;
                y2 = dT_zc;
                a1 = subplot( 2,1,1);
                hold on
                %set(get(gcf,'Title'),'Color','k')
%                 set(get(gcf,'XLabel'),'Color','k')
%                 set(get(gcf,'YLabel'),'Color','k')
                [a1,hLine1,hLine2] = plotyy(x,y1,x,y2);
                
                 set(hLine1,'Color','b');
                 set(hLine2,'Color','g');
                 set(a1,'YColor','k');
                 set(a1,'YColor','k');
                 set(a1(1),'XLim',[5000 30000]);
                 set(a1(2),'XLim',[5000 30000]);
%            plot( user.zeroCrossData.zeroCrossTime,dT,'-k');
%             disp(length(dA));
            xlabel('時間t ms'); 
            hold on
              a2 = subplot( 2,1,2);
              plot( user.time.lowSampled,user.avatarPosition.lowSampled,'-r');
            xlabel('時間t ms'); ylabel('アバタ位置');
            xlim([5000 30000]);  
            
              linkaxes([a1 a2],'x');
%%
            if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_回帰直線からの距離とアバタ位置']);
            else
                obj.saveGraphWithName('_回帰直線からの距離とアバタ分散');
            end

            %%   　エクセルデータ出力
            %  　エクセルデータ出力  
%             outputTitle = { 'k1' , 'k2' , '角度',...
%                                     'X1の係数','重相関R','重決定R2' , '回帰直線とデータの距離の二乗平均平方根'};
%             output = num2cell( [k1 k2 (atan(k2/k1)*180/pi) fitParam_X1Y(1) fitLineR_X1Y(1) fitLineR_X1Y(1)^2 distMean] );
%             
%             if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
%                 obj.outputAllToXlsWithName([ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state ] , output , outputTitle)
%             else
%                 obj.outputAllToXls(output , outputTitle);
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
