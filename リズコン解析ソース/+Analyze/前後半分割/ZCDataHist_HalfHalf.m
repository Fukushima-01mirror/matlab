classdef ZCDataHist_HalfHalf < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = ZCDataHist_HalfHalf(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
            [period_zx, peak_zx] = Rhythm.setZeroCrossPeriodData(user.zeroCrossData);
            
           %　ゼロクロス間でのピーク回数取得
           [zeroCrossTimes] = Rhythm.setZeroCrossCount(user.zeroCrossData);
            
            Y = abs( user.zeroCrossData.nonlogAvtVelocity );
            V = abs( user.zeroCrossData.avtVelocity );
            X1 = abs( period_zx );
            X2 = abs( peak_zx );

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
            V_zc  = V(IndexZeroCross1);        V_nzc  = V(IndexNonZeroCross1);
            X1_zc = X1(IndexZeroCross1,:);     X1_nzc = X1(IndexNonZeroCross1,:);
            X2_zc = X2(IndexZeroCross1,:);     X2_nzc = X2(IndexNonZeroCross1,:);
            
            r_fig = 3;      c_fig = 2;      
            nbins = 50;
            subplot(r_fig,c_fig,1);
            maxYaxis =50000;
            Ycenters = [maxYaxis/(2*nbins) : maxYaxis/nbins : maxYaxis-maxYaxis/(2*nbins)];
            nY_zc = hist( Y_zc ,Ycenters );
            nY_nzc = hist( Y_nzc ,Ycenters );
            N = sum(nY_zc) + sum(nY_nzc);
            hBarY = bar(Ycenters.' ,  [nY_zc.'/N nY_nzc.'/N], 'Stack');
            set(hBarY(2),'FaceColor', 'w' );
            ylabel('度数');   xlabel('対数演算前アバタ速さ');
            xlim([0,maxYaxis]);        ylim([0,0.75]);

            subplot(r_fig,c_fig,2);
            maxVaxis =0.5;
            Vcenters = [maxVaxis/(2*nbins) : maxVaxis/nbins : maxVaxis-maxVaxis/(2*nbins)];
            nV_zc = hist( V_zc ,Vcenters );
            nV_nzc = hist( V_nzc ,Vcenters );
            N = sum(nV_zc) + sum(nV_nzc);
            hBarV = bar(Vcenters.' ,  [nV_zc.'/N nV_nzc.'/N], 'Stack');
            set(hBarV(2),'FaceColor', 'w' );
            ylabel('度数');   xlabel('アバタ速さ');
            xlim([0,maxVaxis]);        ylim([0,0.75]);

            subplot(r_fig,c_fig,3);
            maxX1axis =600;
            X1centers = [maxX1axis/(2*nbins) : maxX1axis/nbins : maxX1axis-maxX1axis/(2*nbins)];
            nX1_zc = hist( X1_zc(:,3) ,X1centers );
            nX1_nzc = hist( X1_nzc(:,3) ,X1centers );
            N = sum(nX1_zc) + sum(nX1_nzc);
            hBarX1 = bar(X1centers.' ,  [nX1_zc.'/N nX1_nzc.'/N], 'Stack');
            set(hBarX1(2),'FaceColor', 'w' );
            ylabel('度数'); xlabel('周期差');
            xlim([0,maxX1axis]);        ylim([0,0.75]);
            
            subplot(r_fig,c_fig,4);
            maxX2axis =600;
            X2centers = [maxX2axis/(2*nbins) : maxX2axis/nbins : maxX2axis-maxX2axis/(2*nbins)];
            nX2_zc = hist( X2_zc(:,3) ,X2centers );
            nX2_nzc = hist( X2_nzc(:,3) ,X2centers );
            N = sum(nX2_zc) + sum(nX2_nzc);
            hBarX2 = bar(X2centers.' ,  [nX2_zc.'/N nX2_nzc.'/N], 'Stack');
            set(hBarX2(2),'FaceColor', 'w' );
            ylabel('度数'); xlabel('振幅差');
            xlim([0,maxX2axis]);        ylim([0,0.75]);

            subplot(r_fig,c_fig,5);
            maxX1axis =600;
            X1centers = [maxX1axis/(2*nbins) : maxX1axis/nbins : maxX1axis-maxX1axis/(2*nbins)];
            nX1_zc = hist( X1_zc(:,2) ,X1centers );
            nX1_nzc = hist( X1_nzc(:,2) ,X1centers );
            N = sum(nX1_zc) + sum(nX1_nzc);
            hBarX1 = bar(X1centers.' ,  [nX1_zc.'/N nX1_nzc.'/N], 'Stack');
            set(hBarX1(2),'FaceColor', 'w' );
            ylabel('度数'); xlabel('周期');
            xlim([0,maxX1axis]);        ylim([0,0.75]);
            
            subplot(r_fig,c_fig,6);
            maxX2axis =600;
            X2centers = [maxX2axis/(2*nbins) : maxX2axis/nbins : maxX2axis-maxX2axis/(2*nbins)];
            nX2_zc = hist( X2_zc(:,2) ,X2centers );
            nX2_nzc = hist( X2_nzc(:,2) ,X2centers );
            N = sum(nX2_zc) + sum(nX2_nzc);
            hBarX2 = bar(X2centers.' ,  [nX2_zc.'/N nX2_nzc.'/N], 'Stack');
            set(hBarX2(2),'FaceColor', 'w' );
            ylabel('度数'); xlabel('振幅');
            xlim([0,maxX2axis]);        ylim([0,0.75]);

            MonitorSize = [ 0, 0, 1000, 1000];
            set(gcf, 'Position', MonitorSize);
            if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state ]);
            else
                obj.saveGraphWithName('1st-half');
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
            V_zc  = V(IndexZeroCross2);        V_nzc  = V(IndexNonZeroCross2);
            X1_zc = X1(IndexZeroCross2,:);     X1_nzc = X1(IndexNonZeroCross2,:);
            X2_zc = X2(IndexZeroCross2,:);     X2_nzc = X2(IndexNonZeroCross2,:);
            
            r_fig = 3;      c_fig = 2;      
            nbins = 50;
            subplot(r_fig,c_fig,1);
            maxYaxis =50000;
            Ycenters = [maxYaxis/(2*nbins) : maxYaxis/nbins : maxYaxis-maxYaxis/(2*nbins)];
            nY_zc = hist( Y_zc ,Ycenters );
            nY_nzc = hist( Y_nzc ,Ycenters );
            N = sum(nY_zc) + sum(nY_nzc);
            hBarY = bar(Ycenters.' ,  [nY_zc.'/N nY_nzc.'/N], 'Stack');
            set(hBarY(2),'FaceColor', 'w' );
            ylabel('度数');   xlabel('対数演算前アバタ速さ');
            xlim([0,maxYaxis]);        ylim([0,0.75]);

            subplot(r_fig,c_fig,2);
            maxVaxis =0.5;
            Vcenters = [maxVaxis/(2*nbins) : maxVaxis/nbins : maxVaxis-maxVaxis/(2*nbins)];
            nV_zc = hist( V_zc ,Vcenters );
            nV_nzc = hist( V_nzc ,Vcenters );
            N = sum(nV_zc) + sum(nV_nzc);
            hBarV = bar(Vcenters.' ,  [nV_zc.'/N nV_nzc.'/N], 'Stack');
            set(hBarV(2),'FaceColor', 'w' );
            ylabel('度数');   xlabel('アバタ速さ');
            xlim([0,maxVaxis]);        ylim([0,0.75]);

            subplot(r_fig,c_fig,3);
            maxX1axis =600;
            X1centers = [maxX1axis/(2*nbins) : maxX1axis/nbins : maxX1axis-maxX1axis/(2*nbins)];
            nX1_zc = hist( X1_zc(:,3) ,X1centers );
            nX1_nzc = hist( X1_nzc(:,3) ,X1centers );
            N = sum(nX1_zc) + sum(nX1_nzc);
            hBarX1 = bar(X1centers.' ,  [nX1_zc.'/N nX1_nzc.'/N], 'Stack');
            set(hBarX1(2),'FaceColor', 'w' );
            ylabel('度数'); xlabel('周期差');
            xlim([0,maxX1axis]);        ylim([0,0.75]);
            
            subplot(r_fig,c_fig,4);
            maxX2axis =600;
            X2centers = [maxX2axis/(2*nbins) : maxX2axis/nbins : maxX2axis-maxX2axis/(2*nbins)];
            nX2_zc = hist( X2_zc(:,3) ,X2centers );
            nX2_nzc = hist( X2_nzc(:,3) ,X2centers );
            N = sum(nX2_zc) + sum(nX2_nzc);
            hBarX2 = bar(X2centers.' ,  [nX2_zc.'/N nX2_nzc.'/N], 'Stack');
            set(hBarX2(2),'FaceColor', 'w' );
            ylabel('度数'); xlabel('振幅差');
            xlim([0,maxX2axis]);        ylim([0,0.75]);

            subplot(r_fig,c_fig,5);
            maxX1axis =600;
            X1centers = [maxX1axis/(2*nbins) : maxX1axis/nbins : maxX1axis-maxX1axis/(2*nbins)];
            nX1_zc = hist( X1_zc(:,2) ,X1centers );
            nX1_nzc = hist( X1_nzc(:,2) ,X1centers );
            N = sum(nX1_zc) + sum(nX1_nzc);
            hBarX1 = bar(X1centers.' ,  [nX1_zc.'/N nX1_nzc.'/N], 'Stack');
            set(hBarX1(2),'FaceColor', 'w' );
            ylabel('度数'); xlabel('周期');
            xlim([0,maxX1axis]);        ylim([0,0.75]);
            
            subplot(r_fig,c_fig,6);
            maxX2axis =600;
            X2centers = [maxX2axis/(2*nbins) : maxX2axis/nbins : maxX2axis-maxX2axis/(2*nbins)];
            nX2_zc = hist( X2_zc(:,2) ,X2centers );
            nX2_nzc = hist( X2_nzc(:,2) ,X2centers );
            N = sum(nX2_zc) + sum(nX2_nzc);
            hBarX2 = bar(X2centers.' ,  [nX2_zc.'/N nX2_nzc.'/N], 'Stack');
            set(hBarX2(2),'FaceColor', 'w' );
            ylabel('度数'); xlabel('振幅');
            xlim([0,maxX2axis]);        ylim([0,0.75]);

            MonitorSize = [ 0, 0, 1000, 1000];
            set(gcf, 'Position', MonitorSize);
            if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state ]);
            else
                obj.saveGraphWithName('2nd-half');
            end
                        
            
        end

    end
end
