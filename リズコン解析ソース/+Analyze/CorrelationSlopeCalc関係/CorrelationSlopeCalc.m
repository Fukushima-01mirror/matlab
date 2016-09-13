classdef CorrelationSlopeCalc < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述
% アバタ速度との回帰分析

    properties
    end

    methods
        function obj = CorrelationSlopeCalc(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        
        function runForPair(obj,user1,user2)

            if obj.config.isExistPlayer1
                titleName1 = [ char(obj.config.examType) ,'回帰係数 時系列変化'];
            elseif obj.config.filenameForArchive
                titleName1 = [ char(obj.config.examType) ,'(',char(obj.config.archiveDataFileName ),') 回帰係数 時系列変化'];
            end

            if obj.config.isExistPlayer2
                titleName2 = [ char(obj.config.examType) ,'回帰係数 時系列変化'];
            elseif obj.config.filenameForArchive
                titleName2 = [ char(obj.config.examType) ,'(',char(obj.config.archiveDataFileName ),') 回帰係数 時系列変化'];
            end

            if obj.config.isExistArchiveData
                titleName = [ char(obj.config.examType) ,'(',char(obj.config.archiveDataFileName ),') 回帰係数 時系列変化'];
            else
                titleName = [ char(obj.config.examType) ,'回帰係数 時系列変化'];
            end

%%      時間スケールの設定            
            spotTime = 1000;
            startTime = 5000;
            spotTimeSeries = spotTime+startTime : user1.time.highSampled(end);
            spotTimeSeries = spotTimeSeries.';

                
%%      データ読込
            if exist( obj.saveFilePath('.mat'), 'file' )
                load( obj.saveFilePath('.mat') );

            else
%%      傾き計算

                [period_zx1, peak_zx1] = Rhythm.setZeroCrossPeriodData(user1.zeroCrossData);
                [period_zx2, peak_zx2] = Rhythm.setZeroCrossPeriodData(user2.zeroCrossData);

                startIndex1 = find( user1.zeroCrossData.zeroCrossTime >= startTime ,1 ,'first');
                endIndex1 = find( user1.zeroCrossData.zeroCrossTime < spotTime+startTime ,1 ,'last');   
                startIndex2 = find( user2.zeroCrossData.zeroCrossTime > startTime , 1, 'first');
                endIndex2 = find( user2.zeroCrossData.zeroCrossTime < spotTime+startTime , 1, 'last');
                fitLineFunc_peak1(1,:) = [0,0];            fitLineFunc_period1(1,:) = [0,0];
                fitLineFunc_peak2(1,:) = [0,0];            fitLineFunc_period2(1,:) = [0,0];
                fitLineR_peak1(1,:) = [0,0];            fitLineR_period1(1,:) = [0,0];
                fitLineR_peak2(1,:) = [0,0];            fitLineR_period2(1,:) = [0,0];
                i = 2;
                
                bNonPlot =1;
                r_fig = 3;  c_fig = 2;
                
                for spotTimeMax = spotTime+startTime+1 : user1.time.highSampled(end)
                    %　1Pのゼロクロス時間のインデクスが進んだら，相関分析
                    if  startIndex1 ~= find( user1.zeroCrossData.zeroCrossTime >= ( spotTimeMax - spotTime ) ,1 ,'first') ...
                              || endIndex1 ~= find( user1.zeroCrossData.zeroCrossTime < spotTimeMax ,1 ,'last')

                       startIndex1 = find( user1.zeroCrossData.zeroCrossTime >= ( spotTimeMax - spotTime ) ,1 ,'first');
                       endIndex1 = find( user1.zeroCrossData.zeroCrossTime < spotTimeMax ,1 ,'last');   

                        Y = abs( user1.zeroCrossData.nonlogAvtVelocity( startIndex1:endIndex1 ) );
                        if bNonPlot == 0
                            subplot(r_fig,c_fig,1);
                            X = period_zx1( startIndex1:endIndex1 ,2 );
                            plot( X ,Y ,'*b');
                            xlabel('ゼロクロス点間隔(1周期)'); ylabel('対数演算前アバタ速さ');
                            xlim([0,800]);         ylim([0 50000]);
                            title( titleName1 );
                        end

                        X = abs( period_zx1( startIndex1:endIndex1 ,3 ) );
                        fitLineFunc_period1(i,:) = polyfit(X ,Y ,1);
                        [R,P] = corrcoef(X,Y);
                        fitLineR_period1(i,:) = [R(1,2), P(1,2)]; 

                        if bNonPlot == 0
                            subplot(r_fig,c_fig,3);
                            fitDataY = polyval( fitLineFunc_period1(i,:) , X );
                            plot( X ,Y ,'*b');
                            hold on
                                plot( X, fitDataY ,'k');
                            hold off
                            xlabel('ゼロクロス点間隔の差（半周期）'); ylabel('対数演算前アバタ速さ');
                            xlim([0,800]);         ylim([0 50000]);            
                        end

                        X = abs(peak_zx1( startIndex1:endIndex1 ,3) );
                        fitLineFunc_peak1(i,:) = polyfit(X ,Y ,1);
                        [R,P] = corrcoef(X,Y);
                        fitLineR_peak1(i,:) = [R(1,2), P(1,2)]; 
                        if bNonPlot == 0
                            subplot(r_fig,c_fig,5);
                            fitDataY = polyval( fitLineFunc_peak1(i,:) , X );
                            plot( X ,Y ,'*b');
                            hold on
                                plot( X, fitDataY ,'k');
                            hold off
                            xlabel('ピーク値の差'); ylabel('対数演算前アバタ速さ');
                            xlim([0,400]);            ylim([0 50000]);
                        end

                    else
                        fitLineFunc_peak1(i,:) = fitLineFunc_peak1(i-1,:);
                        fitLineFunc_period1(i,:) = fitLineFunc_period1(i-1,:);
                        fitLineR_peak1(i,:) = fitLineR_peak1(i-1,:);
                        fitLineR_period1(i,:) = fitLineR_period1(i-1,:);
                    end


                    %　2P
                    if startIndex2 ~= find( user2.zeroCrossData.zeroCrossTime > ( spotTimeMax - spotTime ) , 1, 'first') ...
                            || endIndex2 ~= find( user2.zeroCrossData.zeroCrossTime < spotTimeMax , 1, 'last')

                        startIndex2 = find( user2.zeroCrossData.zeroCrossTime > ( spotTimeMax - spotTime ) , 1, 'first');
                        endIndex2 = find( user2.zeroCrossData.zeroCrossTime < spotTimeMax , 1, 'last');

                        Y = abs( user2.zeroCrossData.nonlogAvtVelocity( startIndex2:endIndex2 ) );
                        if bNonPlot == 0
                            subplot(r_fig,c_fig,2);
                            X = abs( period_zx2( startIndex2:endIndex2 ,2) );
                            plot( X ,Y ,'*g');
                            xlabel('ゼロクロス点間隔(1周期)'); ylabel('対数演算前アバタ速さ');
                            xlim([0,600]);         ylim([0 50000]);
                            title( titleName2 );
                        end

                        X = abs( period_zx2( startIndex2:endIndex2 ,3) );
                        fitLineFunc_period2(i,:) = polyfit(X ,Y ,1);
                        [R,P] = corrcoef(X,Y);
                        fitLineR_period2(i,:) = [R(1,2), P(1,2)]; 
                        if bNonPlot == 0
                            subplot(r_fig,c_fig,4);
                            fitDataY = polyval( fitLineFunc_period2(i,:) , X );
                            plot( X ,Y ,'*g');
                            hold on
                                plot( X, fitDataY ,'k');
                            hold off
                            xlabel('ゼロクロス点間隔の差（半周期）'); ylabel('対数演算前アバタ速さ');
                            xlim([0,600]);         ylim([0 50000]);            
                        end

                        X = abs( peak_zx2( startIndex2:endIndex2 ,3 ) );
                        fitLineFunc_peak2(i,:) = polyfit(X ,Y ,1);
                        [R,P] = corrcoef(X,Y);
                        fitLineR_peak2(i,:) = [R(1,2), P(1,2)]; 
                        if bNonPlot == 0
                            subplot(r_fig,c_fig,6);
                            fitDataY = polyval( fitLineFunc_peak2(i,:) , X );
                            plot( X ,Y ,'*g');
                            hold on
                                plot( X, fitDataY ,'k');
                            hold off
                            xlabel('ピーク値の差'); ylabel('対数演算前アバタ速さ');
                            xlim([0,400]);            ylim([0 50000]);
                        end

                    else
                        fitLineFunc_peak2(i,:) = fitLineFunc_peak2(i-1,:);
                        fitLineFunc_period2(i,:) = fitLineFunc_period2(i-1,:);
                        fitLineR_peak2(i,:) = fitLineR_peak2(i-1,:);
                        fitLineR_period2(i,:) = fitLineR_period2(i-1,:);

                    end


                    i = i+1;
                    if mod(i, 1000) == 0
                    end

                end
    %%         データ保存
                name =  obj.saveFilePath('.mat');
                save( name, 'fitLineFunc_peak1' ,'fitLineR_peak1' ,'fitLineFunc_period1','fitLineR_period1', ...
                    'fitLineFunc_peak2', 'fitLineR_peak2', 'fitLineFunc_period2', 'fitLineR_period2');


            end
            
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
                 ylabel('相関係数R');    ylim([-1 1]);
                 set(haxes(2),'YTick',[-1:0.5:1]);
            
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
                 ylabel('相関係数R');    ylim([-1,1]);
                 set(haxes(2),'YTick',[-1:0.5:1]);
            legend( [hline1,hline2], legName1, legName2 ,'Location','NorthEastOutside');
            title(titleName,'Interpreter','none');
                
            obj.saveGraph();


% %%      エクセルデータ出力
%             outputTitle = {'ピーク値の差との相関の傾き最大値（1P）','最小値','平均値',...
%                             '操作周期の差との相関の傾きの最大値','最小値','平均値', ...
%                             '最大反応時間','平均反応時間','合計反応時間', ...
%                             '最大未反応時間','平均未反応時間','合計未反応時間'} ;
%             overIndex = find( reverseTimeGroup(:,1)>5000 );
%             reverseTimeOutput = { max( reverseTimeGroup(overIndex:end,3) ), mean( reverseTimeGroup(overIndex:end,3) ), sum( reverseTimeGroup(overIndex:end,3) ) };
%             rectingTimeOutput = { max( reactingTime(:,3) ), mean( reactingTime(:,3) ), sum( reactingTime(:,3) ) };
%             unrectingTimeOutput = { max( unreactingTime(:,3) ), mean( unreactingTime(:,3) ), sum( unreactingTime(:,3) ) };
%             output = horzcat( meanDist, stdDist, reverseTimeOutput , rectingTimeOutput , unrectingTimeOutput);
%             obj.outputAllToXls(output , outputTitle);

        end

    end
end
