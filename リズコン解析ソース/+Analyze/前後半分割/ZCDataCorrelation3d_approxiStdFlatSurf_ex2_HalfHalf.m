classdef ZCDataCorrelation3d_approxiStdFlatSurf_ex2_HalfHalf < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = ZCDataCorrelation3d_approxiStdFlatSurf_ex2_HalfHalf(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
           [period_zx, peak_zx] = Rhythm.setZeroCrossPeriodData(user.zeroCrossData);
           %　ゼロクロス間でのピーク回数取得
           [zeroCrossTimes] = Rhythm.setZeroCrossCount(user.zeroCrossData);
            
            Y = abs( user.zeroCrossData.nonlogAvtVelocity );
            X1 = abs( period_zx(:,3)  );
            X2 = abs( peak_zx(:,3) );
            
%%             前半データ
            if obj.currentRunType == obj.runTypePlayer1
                IndexZeroCross1 = find(zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2 ...
                    & obj.data.player1.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) + obj.data.player1.time.highSampled(1)...
                    & obj.data.player1.zeroCrossData.zeroCrossTime < 30000 );
                IndexNonZeroCross1 = find( zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1 ...
                    & obj.data.player1.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) + obj.data.player1.time.highSampled(1)...
                    & obj.data.player1.zeroCrossData.zeroCrossTime < 30000 );
            elseif obj.currentRunType == obj.runTypePlayer2
                IndexZeroCross1 = find(zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2 ...
                    & obj.data.player1.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) + obj.data.player1.time.highSampled(1)...
                    & obj.data.player1.zeroCrossData.zeroCrossTime < 30000 );
                IndexNonZeroCross1 = find( zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1 ...
                    & obj.data.player1.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) + obj.data.player1.time.highSampled(1)...
                    & obj.data.player1.zeroCrossData.zeroCrossTime < 30000 );
            end

            
            Y_zc  = Y(IndexZeroCross1);        Y_nzc  = Y(IndexNonZeroCross1);
            X1_zc = X1(IndexZeroCross1,:);     X1_nzc = X1(IndexNonZeroCross1,:);
            X2_zc = X2(IndexZeroCross1,:);     X2_nzc = X2(IndexNonZeroCross1,:);

            %外れ値を除外するため，最大データ２つをカット
            [X1_max,X1_imax] = max(X1_zc);     X1_zc(X1_imax)= [];	 X2_zc(X1_imax)= [];     Y_zc(X1_imax)= [];
            [X1_max,X1_imax] = max(X1_zc);     X1_zc(X1_imax)= [];	 X2_zc(X1_imax)= [];     Y_zc(X1_imax)= [];
            [X2_max,X2_imax] = max(X2_zc);     X1_zc(X2_imax)= [];	 X2_zc(X2_imax)= [];     Y_zc(X2_imax)= [];
            [X2_max,X2_imax] = max(X2_zc);     X1_zc(X2_imax)= [];	 X2_zc(X2_imax)= [];     Y_zc(X2_imax)= [];
%             [Y_max,Y_imax] = max(Y_zc);     X1_zc(Y_imax)= [];	 X2_zc(Y_imax)= [];     Y_zc(Y_imax)= [];
%             [Y_max,Y_imax] = max(Y_zc);     X1_zc(Y_imax)= [];	 X2_zc(Y_imax)= [];     Y_zc(Y_imax)= [];
%             while max(Y_zc./X1_zc) > 1000
%                 [Y_X1_max,Y_X1_imax] = max(Y_zc./X1_zc);     X1_zc(Y_X1_imax)= [];	 X2_zc(Y_X1_imax)= [];     Y_zc(Y_X1_imax)= [];
%                 [Y_X1_max,Y_X1_imax] = max(Y_zc./X1_zc);     X1_zc(Y_X1_imax)= [];	 X2_zc(Y_X1_imax)= [];     Y_zc(Y_X1_imax)= [];
%             end
%             while max(Y_zc./X2_zc) > 1000
%                 [Y_X2_max,Y_X2_imax] = max(Y_zc./X2_zc);     X1_zc(Y_X2_imax)= [];	 X2_zc(Y_X2_imax)= [];     Y_zc(Y_X2_imax)= [];
%                 [Y_X2_max,Y_X2_imax] = max(Y_zc./X2_zc);     X1_zc(Y_X2_imax)= [];	 X2_zc(Y_X2_imax)= [];     Y_zc(Y_X2_imax)= [];
%             end

            [Y_zc , m_Y , s_Y]  = zscore( Y_zc);
            [X1_zc , m_X1 , s_X1] = zscore( X1_zc);
            [X2_zc , m_X2 , s_X2] = zscore( X2_zc);

            Y_nzc  =( Y(IndexNonZeroCross1) - repmat(m_Y ,length( Y(IndexNonZeroCross1)),1 ) )./ s_Y;
            X1_nzc =( X1(IndexNonZeroCross1,:) - repmat(m_X1 ,length( X1(IndexNonZeroCross1)),1 ) )./ s_X1;
            X2_nzc =( X2(IndexNonZeroCross1,:)- repmat(m_X2 ,length( X2(IndexNonZeroCross1)),1 ) )./ s_X2;
 

            figure(3);
            [fitParam3, X1FIT, X2FIT, YFIT , fitR, yhat, fitR2 ]  = Rhythm.approxiSurface_flat(X1_zc , X2_zc , Y_zc );
            plot3( X1_zc  , X2_zc , Y_zc,   'Marker','*', 'LineStyle','none');
            hold on
                plot3( X1_nzc  , X2_nzc , Y_nzc, 'Marker','o', 'LineStyle','none');
                mesh(X1FIT,X2FIT,YFIT, 'faceAlpha',0.5);
            hold off
            grid on
            xlabel('操作波形 周期の差');  ylabel('操作波形 振幅の差');  zlabel('対数演算前アバタ速さ');
            xlim([-5,5]);      ylim([-5,5]);         zlim([-5 5]);
            title({['V = (' num2str(fitParam3(1)) ') + (' num2str( fitParam3(2) ) ') * dPeriod + (' num2str( fitParam3(3)) ') * dPeak']; ...
                    ['データ数:' num2str( length(user.time.highSampled)  - obj.config.analyzeTime(1) ) '[ms],(' num2str( length(Y_zc) ) ')' ] });
            axis square
            MonitorSize = [ 0, 0, 800, 800];
            set(gcf, 'Position', MonitorSize);
            if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state ]);
            else
                obj.saveGraphWithName('_1st-half');
            end

%%             後半データ
            if obj.currentRunType == obj.runTypePlayer1
                IndexZeroCross2 = find(zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2 ...
                    & obj.data.player1.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) + 30000 );
                IndexNonZeroCross2 = find( zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1 ...
                    & obj.data.player1.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) + 30000 );
            elseif obj.currentRunType == obj.runTypePlayer2
                IndexZeroCross2 = find(zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2 ...
                    & obj.data.player1.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) + 30000 );
                IndexNonZeroCross2 = find( zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1 ...
                    & obj.data.player1.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) + 30000 );
            end

            
            Y_zc  = Y(IndexZeroCross2);        Y_nzc  = Y(IndexNonZeroCross2);
            X1_zc = X1(IndexZeroCross2,:);     X1_nzc = X1(IndexNonZeroCross2,:);
            X2_zc = X2(IndexZeroCross2,:);     X2_nzc = X2(IndexNonZeroCross2,:);

            %外れ値を除外するため，最大データ２つをカット
            [X1_max,X1_imax] = max(X1_zc);     X1_zc(X1_imax)= [];	 X2_zc(X1_imax)= [];     Y_zc(X1_imax)= [];
            [X1_max,X1_imax] = max(X1_zc);     X1_zc(X1_imax)= [];	 X2_zc(X1_imax)= [];     Y_zc(X1_imax)= [];
            [X2_max,X2_imax] = max(X2_zc);     X1_zc(X2_imax)= [];	 X2_zc(X2_imax)= [];     Y_zc(X2_imax)= [];
            [X2_max,X2_imax] = max(X2_zc);     X1_zc(X2_imax)= [];	 X2_zc(X2_imax)= [];     Y_zc(X2_imax)= [];
%             [Y_max,Y_imax] = max(Y_zc);     X1_zc(Y_imax)= [];	 X2_zc(Y_imax)= [];     Y_zc(Y_imax)= [];
%             [Y_max,Y_imax] = max(Y_zc);     X1_zc(Y_imax)= [];	 X2_zc(Y_imax)= [];     Y_zc(Y_imax)= [];
%             while max(Y_zc./X1_zc) > 1000
%                 [Y_X1_max,Y_X1_imax] = max(Y_zc./X1_zc);     X1_zc(Y_X1_imax)= [];	 X2_zc(Y_X1_imax)= [];     Y_zc(Y_X1_imax)= [];
%                 [Y_X1_max,Y_X1_imax] = max(Y_zc./X1_zc);     X1_zc(Y_X1_imax)= [];	 X2_zc(Y_X1_imax)= [];     Y_zc(Y_X1_imax)= [];
%             end
%             while max(Y_zc./X2_zc) > 1000
%                 [Y_X2_max,Y_X2_imax] = max(Y_zc./X2_zc);     X1_zc(Y_X2_imax)= [];	 X2_zc(Y_X2_imax)= [];     Y_zc(Y_X2_imax)= [];
%                 [Y_X2_max,Y_X2_imax] = max(Y_zc./X2_zc);     X1_zc(Y_X2_imax)= [];	 X2_zc(Y_X2_imax)= [];     Y_zc(Y_X2_imax)= [];
%             end

            [Y_zc , m_Y , s_Y]  = zscore( Y_zc);
            [X1_zc , m_X1 , s_X1] = zscore( X1_zc);
            [X2_zc , m_X2 , s_X2] = zscore( X2_zc);

            Y_nzc  =( Y(IndexNonZeroCross2) - repmat(m_Y ,length( Y(IndexNonZeroCross2)),1 ) )./ s_Y;
            X1_nzc =( X1(IndexNonZeroCross2,:) - repmat(m_X1 ,length( X1(IndexNonZeroCross2)),1 ) )./ s_X1;
            X2_nzc =( X2(IndexNonZeroCross2,:)- repmat(m_X2 ,length( X2(IndexNonZeroCross2)),1 ) )./ s_X2;
 

            figure(3);
            [fitParam3, X1FIT, X2FIT, YFIT , fitR, yhat, fitR2 ]  = Rhythm.approxiSurface_flat(X1_zc , X2_zc , Y_zc );
            plot3( X1_zc  , X2_zc , Y_zc,   'Marker','*', 'LineStyle','none');
            hold on
                plot3( X1_nzc  , X2_nzc , Y_nzc, 'Marker','o', 'LineStyle','none');
                mesh(X1FIT,X2FIT,YFIT, 'faceAlpha',0.5);
            hold off
            grid on
            xlabel('操作波形 周期の差');  ylabel('操作波形 振幅の差');  zlabel('対数演算前アバタ速さ');
            xlim([-5,5]);      ylim([-5,5]);         zlim([-5 5]);
            title({['V = (' num2str(fitParam3(1)) ') + (' num2str( fitParam3(2) ) ') * dPeriod + (' num2str( fitParam3(3)) ') * dPeak']; ...
                    ['データ数:' num2str( length(user.time.highSampled)  - obj.config.analyzeTime(1) ) '[ms],(' num2str( length(Y_zc) ) ')' ] });
            axis square
            MonitorSize = [ 0, 0, 800, 800];
            set(gcf, 'Position', MonitorSize);
            if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state ]);
            else
                obj.saveGraphWithName('_2nd-half');
            end

            %%      近似面　係数　エクセルデータ出力  
% %             VIF = Rhythm.getVIF([X1_zc , X2_zc ]);
%             VIF = [ NaN ,NaN ];
%             outputTitle = { '定数項' , '周期差' , '振幅差',...
%                                     'VIF(周期差)', 'VIF（振幅差）','重相関R','重決定R2' };
%             output = num2cell( [fitParam3' VIF fitR fitR2] );
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
