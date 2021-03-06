classdef PeriodHist < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = PeriodHist(config,data)
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

            if obj.currentRunType == obj.runTypePlayer1 ...
                    || ( obj.currentRunType == obj.runTypeArchive && obj.config.isExistPlayer1 )
                IndexZeroCross = find(zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2 ...
                    & obj.data.player1.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) + obj.data.player1.time.highSampled(1) );
                IndexNonZeroCross = find( zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1 ...
                    & obj.data.player1.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) + obj.data.player1.time.highSampled(1) );
            elseif obj.currentRunType == obj.runTypePlayer2 ...
                    || ( obj.currentRunType == obj.runTypeArchive && obj.config.isExistPlayer2 )
                IndexZeroCross = find(zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2 ...
                    & obj.data.player2.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) + obj.data.player2.time.highSampled(1) );
                IndexNonZeroCross = find( zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1 ...
                    & obj.data.player2.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) + obj.data.player2.time.highSampled(1) );
            end

            Nzc = length(IndexZeroCross) ;
            Nnzc = length(IndexNonZeroCross) ;
            
            nbins = 50;

            MonitorSize = [ 0, 0, 600, 150];
            set(gcf, 'Position', MonitorSize);

            data = X1(:,2);
            data_zc = data( IndexZeroCross);
            data_nzc = data(IndexNonZeroCross );

            limMax = ceil(max(data_zc)/100)*100;
            x = 10:20:limMax-10;
            nData_zc = hist( data_zc , x);
            nData_nzc = hist( data_nzc , x);
            N = sum(nData_zc) + sum(nData_nzc);
            mdata = mean(data_zc);
            sdata = std(data_zc);
            hBar = bar( x, [nData_zc.'/N nData_nzc.'/N], 1,'Stack');
            hold on
                plot([mdata mdata] ,[0 1] , 'r');
                plot([mdata-sdata mdata-sdata] ,[0 1] , ':k');
                plot([mdata+sdata mdata+sdata] ,[0 1] , ':k');
            hold off
            set(hBar(2),'FaceColor', 'w' );
            xlim([0 600]);    set(gca, 'XTick', [0:100:600]);
            ylim([0 0.8]);
            title({ ['平均:' num2str(mdata) ', 標準偏差:' num2str(sdata) ]; ...
            ['データ数:' num2str(N) ', ゼロクロス間で複数ピークをもつ割合:' num2str( sum(nData_nzc)/N *100) '[%]' ] });
    
            if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state ]);
            else
                obj.saveGraph();
            end
            
%%        各データ統計値
%             outputTitle = {'dT平均','dT標準偏差','dA平均','dA標準偏差', ...
%                                         'V平均','V標準偏差',' 複数ピークを持つサイクルの割合' };
%             output = num2cell([mean(X1_zc(:,3)) , std(X1_zc(:,3)), mean(X2_zc(:,3)) , std(X2_zc(:,3)), ...
%                                         mean(Y_zc) , std(Y_zc) , Nnzc/(Nzc + Nnzc)]  );
% 
%             if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
%                 obj.outputAllToXlsWithName([ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state ] , output , outputTitle)
%             else
%                 obj.outputAllToXls(output , outputTitle);
%             end
%            
            
        end

    end
end
