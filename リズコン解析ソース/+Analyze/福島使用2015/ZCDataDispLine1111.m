classdef ZCDataDispLine < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = ZCDataDispLine(config,data)
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
%             disp('dT');
%             disp(dT);
%             disp('Time');
%             disp(Time);
 filename = '0919ΔT.xlsx';
           %Take 2014-11-20 11.13.37 PM.csv
           %dataname = 'DATA1_04.csv';
%%          Optiでのマーカーの変位
%     x=xlsread(filename,1,'A3:A624');disp('X_Done');
%     y=xlsread(filename,1,'B3:B624');disp('Y_Done');
%     x=xlsread(filename,1,'D3:D583');disp('X_Done');
%     y=xlsread(filename,1,'E3:E583');disp('Y_Done');
%     x=xlsread(filename,1,'G3:G565');disp('X_Done');
%     y=xlsread(filename,1,'H3:H565');disp('Y_Done');
%     x=xlsread(filename,1,'K3:K558');disp('X_Done');
%     y=xlsread(filename,1,'L3:L558');disp('Y_Done');
    x=xlsread(filename,1,'N3:N628');disp('X_Done');
    y=xlsread(filename,1,'O3:O628');disp('Y_Done');

%     x=xlsread(filename,1,'Q3:Q671');disp('X_Done');
%     y=xlsread(filename,1,'R3:R671');disp('Y_Done');
%     x=xlsread(filename,1,'U3:U619');disp('X_Done');
%     y=xlsread(filename,1,'V3:V619');disp('Y_Done');
%     x=xlsread(filename,1,'X3:X681');disp('X_Done');
%     y=xlsread(filename,1,'Y3:Y681');disp('Y_Done');
%     x=xlsread(filename,1,'AA3:AA602');disp('X_Done');
%     y=xlsread(filename,1,'AB3:AB602');disp('Y_Done');

    disp(x);
    disp(y);
    xx = 0:20:60000;
    yy = spline(x,y,xx);
    yy2=rot90(yy);
    yy3=rot90(yy2);
    yy4=rot90(yy3);

    %%      使えんのかコレ
    
    outputname = strcat('レバー波形6000',filename);
            sheet = 1;
            xlRange = 'A1';
            xlswrite(outputname,yy4,sheet,xlRange)
            
            fluct = gallery('',size(xx),2);
            sdata = cumsum(fluct) + 20 + t/100;
            
            mean(sdata);
            
    figure
    plot(xx,sdata);
    legend('original data','Location','northwest');
    xlabel('Time');
    ylabel('Amp');
    
            detrend_sdata = detrend(sdata);
            trend = sdata - detrend_sdata;
            
            mean(detrend_sdata);
    hold on
    plot(xx,trend,':r')
    plot(xx,detrend_sdata,'m')
    plot(xx,zeros(size(xx)),':k')
    legend('Original Data','Trend','Detrended Data',...
       'Mean of Detrended Data','Location','northwest')
    xlabel('Time');
    ylabel('Amp');
    
    
    
    
    %%
    
    
    
            
%%           主成分回帰分析
%             set(gcf, 'Position', [ 0, 0, 500, 500]);    bFig = 1;
% %             [k1 , k2, X1, fitParam_X1Y, fitLineR_X1Y] = Rhythm.PCA_regress_3dplot(dT_zc , dA_zc , Y_zc , bFig) ;
%             plot3( dT_zc  , dA_zc , Y_zc,   'Marker','*', 'LineStyle','none','MarkerSize',2);
%             hold on
%                 plot3(dT_nzc, dA_nzc , Y_nzc ,'Color' , 'b' ,'Marker','o', 'LineStyle','none' );
%             hold off
%             grid on
%             view(-30,30);
%             xlabel('操作波形 周期の差');  ylabel('操作波形 振幅の差');  zlabel('対数演算前アバタ速さ');
%             xlim([0 400]);            ylim([0 400]);          zlim([0 40000]);
%             title({ [] ;...
%                 [];...
%                 [ ]});
            
            %%
%            if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
%                 obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_主成分回帰分析']);
%             else
                %obj.saveGraphWithName('_主成分回帰分析');
%             end
            
        end

        function runForPair(obj,user1 ,user2)
%             obj.runForAlone(user1);
%             obj.runForAlone(user2);
%             
            
        end

        
    end
end
