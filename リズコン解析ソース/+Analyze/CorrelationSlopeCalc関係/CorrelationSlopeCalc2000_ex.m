classdef CorrelationSlopeCalc2000_ex < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述
% アバタ速度との回帰分析

    properties
    end

    methods
        function obj = CorrelationSlopeCalc2000_ex(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
            bDispR =0;
            titleName = [ char(obj.config.examType) ,'回帰係数 時系列変化'];
                
            %　時間スケールの設定            
            spotTime = 2000;    %  時間スケールの設定    
            startTime = 5000;
            spotTimeSeries = spotTime+startTime : user.time.highSampled(end);
            spotTimeSeries = spotTimeSeries.';

            % 読込ファイル名
            if obj.currentRunType == obj.runTypePlayer1
                loadFileName = ...
                    char( strcat( cd(),'\results\',obj.folderName(),'\',obj.config.filenameForPlayer1(),'.mat' ) );
            elseif obj.currentRunType == obj.runTypePlayer2
                loadFileName = ...
                    char( strcat( cd(),'\results\',obj.folderName(),'\',obj.config.filenameForPlayer2(),'.mat' ) );
            end

            % データ読込
            if exist( loadFileName, 'file' )
                load( loadFileName );

            else
                % 傾き計算
                [fitLineFunc_peak, fitLineR_peak, fitLineFunc_period, fitLineR_period]...
                                                                = CorrelationSlope_ex(user, spotTime);
                % データ保存
                name =  obj.saveFilePath('.mat');
                save( name, 'fitLineFunc_peak' ,'fitLineR_peak' ,'fitLineFunc_period','fitLineR_period');

            end

%            %　ゼロクロス間でのピーク回数取得
%            k=2;
%            zeroCrossTimes = zeros(1,2);   %　C1:波形の前半部のピーク回数　C2:後半部のピーク回数
%            zeroCrossTimes(1,1) = length( obj.zeroCrossData.peak( spotTime + startTime ).time );
%            for IndexSeries = spotTime + startTime +1 : length( obj.zeroCrossData.peak )
%                zeroCrossTimes(k,1) = length( obj.zeroCrossData.peak(IndexSeries).time );
%                zeroCrossTimes(k,2) = length( obj.zeroCrossData.peak(IndexSeries-1).time );
%                k = k+1;
%            end
% 
%            %　ゼロクロスしている時のインデックス
%            IndexZeroCross = find(zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2);
%            %　ゼロクロスしない時のインデックス
%            IndexNonZeroCross = find( zeroCrossTimes(:,1)>1 | zeroCrossTimes(:,2)>1);
%             
           
%%          グラフ描画
            MonitorSize = [ 0, 0, 1200, 1000];
            set(gcf, 'Position', MonitorSize);
            
            subplot(2,1,1,'align')
            [haxes,hline1,hlineR1] = ...
                plotyy(spotTimeSeries, fitLineFunc_peak(:,1), spotTimeSeries, fitLineR_peak(:,1));
            set(hline1,'Color','b');            set(hlineR1,'Color','c');
            set(haxes(1),'YColor','k');            set(haxes(2),'YColor','k');
            
            axes(haxes(1))
                 xlabel('時間'); ylabel('ピーク値の差とアバタ速度の回帰直線の傾き');
                 ylim([-100 300]);
                 set(haxes(1),'YTick',[-100:100:300]);
            axes(haxes(2))
            if bDispR == 0
                axis off;
                axes(haxes(1))
            else
                 ylabel('相関係数R');    ylim([-1,1]);
                 set(haxes(2),'YTick',[-1:0.5:1]);
            end
            title(titleName,'Interpreter','none');
                
            subplot(2,1,2,'align')
            [haxes,hline1,hlineR1] = ...
                plotyy(spotTimeSeries, fitLineFunc_period(:,1), spotTimeSeries, fitLineR_period(:,1));
            set(hline1,'Color','b');            set(hlineR1,'Color','c');
            set(haxes(1),'YColor','k');            set(haxes(2),'YColor','k');
            
            axes(haxes(1))
                xlabel('時間'); ylabel('操作周期の差とアバタ速度の回帰直線の傾き');
                ylim([-100,300]);
                set(haxes(1),'YTick',[-100:100:300]);
            axes(haxes(2))
            if bDispR == 0
                axis off;
                axes(haxes(1))
            else
                 ylabel('相関係数R');    ylim([-1,1]);
                 set(haxes(2),'YTick',[-1:0.5:1]);
            end
            title(titleName,'Interpreter','none');

            
            obj.saveGraph();
            
        end
        
        
        
        function runForPair(obj,user1,user2)
            bDispR =0;
            
            if obj.config.isExistPlayer1
                titleName1 = [ char(obj.config.examType) ,'回帰係数 時系列変化'];
                loadFileName1 = ...
                    char( strcat( cd(),'\results\',obj.folderName(),'\',obj.config.filenameForPlayer1(),'.mat' ) );
            elseif obj.config.filenameForArchive
                titleName1 = [ char(obj.config.examType) ,'(',char(obj.config.archiveDataFileName ),') 回帰係数 時系列変化'];
                loatFileData = dir( strcat( cd(),'\results\',obj.folderName(),'\', char(obj.config.archiveDataFileName) , '*(L)*.mat') );
                loadFileName1 = char( strcat( cd(),'\results\',obj.folderName(),'\', loatFileData.name) );
            end

            if obj.config.isExistPlayer2
                titleName2 = [ char(obj.config.examType) ,'回帰係数 時系列変化'];
                loadFileName2 = ...
                    char( strcat( cd(),'\results\',obj.folderName(),'\',obj.config.filenameForPlayer2(),'.mat' ) );
            elseif obj.config.filenameForArchive
                titleName2 = [ char(obj.config.examType) ,'(',char(obj.config.archiveDataFileName ),') 回帰係数 時系列変化'];
                loatFileData = dir( strcat( cd(),'\results\',obj.folderName(),'\', char(obj.config.archiveDataFileName) , '*(L)*.mat') );
                loadFileName2 = char( strcat( cd(),'\results\',obj.folderName(),'\',loatFileData.name) );
            end

            if obj.config.isExistArchiveData
                titleName = [ char(obj.config.examType) ,'(',char(obj.config.archiveDataFileName ),') 回帰係数 時系列変化'];
            else
                titleName = [ char(obj.config.examType) ,'回帰係数 時系列変化'];
            end
            
%%      時間スケールの設定            
            spotTime = 2000;
            startTime = 5000;
            spotTimeSeries = spotTime+startTime : user1.time.highSampled(end);
            spotTimeSeries = spotTimeSeries.';

                
%%      データ読込
%             if exist(loadFileName1, 'file' ) && exist(loadFileName2 'file' )

            data1 = load( loadFileName1 );
            data2 = load( loadFileName2 );

            fitLineFunc_peak1 = data1.fitLineFunc_peak;
            fitLineFunc_period1 = data1.fitLineFunc_period;
            fitLineR_peak1 = data1.fitLineR_peak;
            fitLineR_period1 = data1.fitLineR_period;

            fitLineFunc_peak2 = data2.fitLineFunc_peak;
            fitLineFunc_period2 = data2.fitLineFunc_period;
            fitLineR_peak2 = data2.fitLineR_peak;
            fitLineR_period2 = data2.fitLineR_period;


%%          グラフ描画
            MonitorSize = [ 0, 0, 1200, 1000];
            set(gcf, 'Position', MonitorSize);
            
            
            subplot(2,1,1,'align')
            [haxes,hline1,hlineR1] = ...
                plotyy(spotTimeSeries, fitLineFunc_peak1(:,1), spotTimeSeries, fitLineR_peak1(:,1));
            set(hline1,'Color','b');            set(hlineR1,'Color','c');
            set(haxes(1),'YColor','k');            set(haxes(2),'YColor','k');
            
            hold( haxes(1),'on') % 傾き　重ね書きモードオン
                hline2 = plot(  haxes(1), spotTimeSeries, fitLineFunc_peak2(:,1),'Color', [0 0.5 0] );
            hold( haxes(2),'on') % 相関係数　重ね書きモードオン
                hlineR2 = plot(  haxes(2), spotTimeSeries, fitLineR_peak2(:,1),'g' );
            hold off
            
            axes(haxes(1))
                 xlabel('時間'); ylabel('ピーク値の差とアバタ速度の回帰直線の傾き');
                 ylim([-100 300]);
                 set(haxes(1),'YTick',[-100:100:300]);
            axes(haxes(2))
            if bDispR == 0
                axis off;
                axes(haxes(1))
            else
                 ylabel('相関係数R');    ylim([-1,1]);
                 set(haxes(2),'YTick',[-1:0.5:1]);
            end
            
            if obj.config.isExistPlayer1
                legName1 = char(obj.config.player1UserName);
            elseif obj.config.filenameForArchive
                legName1 = 'アーカイブ';
            end
            if obj.config.isExistPlayer2
                legName2 = char(obj.config.player2UserName);
            elseif obj.config.filenameForArchive
                legName2 = 'アーカイブ';
            end
            legend( [hline1,hline2], legName1, legName2 ,'Location','NorthEastOutside');
            title(titleName,'Interpreter','none');
                
            subplot(2,1,2,'align')
            [haxes,hline1,hlineR1] = ...
                plotyy(spotTimeSeries, fitLineFunc_period1(:,1), spotTimeSeries, fitLineR_period1(:,1));
            set(hline1,'Color','b');            set(hlineR1,'Color','c');
            set(haxes(1),'YColor','k');            set(haxes(2),'YColor','k');
            
            hold( haxes(1),'on') % 傾き　重ね書きモードオン
                hline2 = plot(  haxes(1), spotTimeSeries, fitLineFunc_period2(:,1),'Color',[0 0.5 0] );
            hold( haxes(2),'on') % 相関係数　重ね書きモードオン
                hlineR2 = plot(  haxes(2), spotTimeSeries, fitLineR_period2(:,1),'g' );
            hold off
                
            axes(haxes(1))
                xlabel('時間'); ylabel('操作周期の差とアバタ速度の回帰直線の傾き');
                ylim([-100,300]);
                set(haxes(1),'YTick',[-100:100:300]);
            axes(haxes(2))
            if bDispR == 0
                axis off;
                axes(haxes(1))
            else
                 ylabel('相関係数R');    ylim([-1,1]);
                 set(haxes(2),'YTick',[-1:0.5:1]);
            end
            legend( [hline1,hline2], legName1, legName2 ,'Location','NorthEastOutside');
            title(titleName,'Interpreter','none');
                
            obj.saveGraph();


%%      エクセルデータ出力
            outputTitle = {'ピーク値の差との回帰係数平均値(1P)','標準偏差(1P)',...
                            'ピーク値の差との回帰係数平均値(2P)','標準偏差(2P)', ...
                            'ピーク値の差との回帰係数 類似割合(誤差10%)','類似割合(誤差20%)','類似割合(誤差30%)',...
                            '操作周期の差との回帰係数平均値(1P)','標準偏差(1P)',...
                            '操作周期の差との回帰係数平均値(2P)','標準偏差(2P)', ...
                            '操作周期の差との回帰係数 類似割合(誤差10%)','類似割合(誤差20%)','類似割合(誤差30%)'...
                            };
            slopePeakOutput = { mean( fitLineFunc_peak1(:,1) ), std( fitLineFunc_peak1(:,1) ) , ...
                                mean( fitLineFunc_peak2(:,1) ), std( fitLineFunc_peak2(:,1) ) };
            peakSlopeMean = ( mean( fitLineFunc_peak1(:,1) ) + mean( fitLineFunc_peak2(:,1) ))/2;
            distSlopePeak = abs( fitLineFunc_peak1(:,1) - fitLineFunc_peak2(:,1));
            sameSlopePeakOutput = { length( find( distSlopePeak < peakSlopeMean*0.1 ) )/60000 , ...
                                    length( find( distSlopePeak < peakSlopeMean*0.2 ) )/60000 , ...
                                    length( find( distSlopePeak < peakSlopeMean*0.3 ) )/60000 , ...
                                    };
            
            slopePeriodOutput = { mean( fitLineFunc_period1(:,1) ), std( fitLineFunc_period1(:,1) ) , ...
                                mean( fitLineFunc_period2(:,1) ), std( fitLineFunc_period2(:,1) ) };
            periodSlopeMean = ( mean( fitLineFunc_period1(:,1) ) + mean( fitLineFunc_period2(:,1) ))/2;
            distSlopePeriod = abs( fitLineFunc_period1(:,1) - fitLineFunc_period2(:,1));
            sameSlopePeriodOutput = { length( find( distSlopePeriod < periodSlopeMean*0.1 ) )/60000 ...
                                      length( find( distSlopePeriod < periodSlopeMean*0.2 ) )/60000 ...          
                                      length( find( distSlopePeriod < periodSlopeMean*0.3 ) )/60000 ...          
                                      };
            
            output = horzcat( slopePeakOutput , sameSlopePeakOutput , slopePeriodOutput , sameSlopePeriodOutput );
            obj.outputAllToXls(output , outputTitle);

        end

    end
end
