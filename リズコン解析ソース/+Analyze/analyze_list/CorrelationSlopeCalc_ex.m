classdef CorrelationSlopeCalc_ex < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述
% アバタ速度との回帰分析

    properties
    end

    methods
        function obj = CorrelationSlopeCalc_ex(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
            
            titleName = [ char(obj.config.examType) ,'回帰係数 時系列変化'];
%%      時間スケールの設定            
            spotTime = 1000;
            startTime = 5000;
            spotTimeSeries = spotTime+startTime : user.time.highSampled(end);
            spotTimeSeries = spotTimeSeries.';

                
%%      データ読込
            if exist( obj.saveFilePath('.mat'), 'file' )
                load( obj.saveFilePath('.mat') );

            else
%%      傾き計算

                [period_zx1, peak_zx1] = Rhythm.setZeroCrossPeriodData(user.zeroCrossData);

                startIndex1 = find( user1.zeroCrossData.zeroCrossTime >= startTime ,1 ,'first');
                endIndex1 = find( user1.zeroCrossData.zeroCrossTime < spotTime+startTime ,1 ,'last');   
                fitLineFunc_peak1(1,:) = [0,0];            fitLineFunc_period1(1,:) = [0,0];
                fitLineR_peak1(1,:) = [0,0];            fitLineR_period1(1,:) = [0,0];
                i = 2;

                bNonPlot =1;
                r_fig = 3;  c_fig = 1;

                for spotTimeMax = spotTime+startTime+1 : user.time.highSampled(end)
                    %　1Pのゼロクロス時間のインデクスが進んだら，相関分析
                    if  startIndex1 ~= find( user.zeroCrossData.zeroCrossTime >= ( spotTimeMax - spotTime ) ,1 ,'first') ...
                              || endIndex1 ~= find( user.zeroCrossData.zeroCrossTime < spotTimeMax ,1 ,'last')

                       startIndex1 = find( user.zeroCrossData.zeroCrossTime >= ( spotTimeMax - spotTime ) ,1 ,'first');
                       endIndex1 = find( user.zeroCrossData.zeroCrossTime < spotTimeMax ,1 ,'last');  

                       k=2;
                       zeroCrossTimes1 = zeros(1,2);
                       % ゼロクロス間のピーク回数　C1:波形の前半部のピーク回数　C2:後半部のピーク回数
                       zeroCrossTimes1(1,1) = length( user.zeroCrossData.peak(startIndex1).time );
                       for IndexSeries = startIndex1+1 :endIndex1
                           zeroCrossTimes1(k,1) = length( user.zeroCrossData.peak(IndexSeries).time );
                           zeroCrossTimes1(k,2) = length( user.zeroCrossData.peak(IndexSeries-1).time );
                           k = k+1;
                       end

                       sizeZeroCross1 = find(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2);
                       %　ピークが2回未満のときのインデックス
                       if length( sizeZeroCross1 ) < 2  %　ピークが2回未満のデータ数が2個未満の時を除外
                            fitLineFunc_peak1(i,:) = [0,0];
                            fitLineFunc_period1(i,:) = [0,0];
                            fitLineR_peak1(i,:) = [0,0];
                            fitLineR_period1(i,:) = [0,0];
                       else

                            Y = abs( user.zeroCrossData.nonlogAvtVelocity( startIndex1:endIndex1 ) );
                            if bNonPlot == 0
                                subplot(r_fig,c_fig,1);
                                X = period_zx1( startIndex1:endIndex1 ,2 );
                                plot( X(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ,Y(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ,'ob');
                                hold on
                                    plot( X(zeroCrossTimes1(:,1)>1|zeroCrossTimes1(:,2)>1) ,Y(zeroCrossTimes1(:,1)>1|zeroCrossTimes1(:,2)>1) ,'sb');
                                hold off
                                xlabel('ゼロクロス点間隔(1周期)'); ylabel('対数演算前アバタ速さ');
                                xlim([0,800]);         ylim([0 50000]);
                                title( titleName1 );
                            end

                            X = abs( period_zx1( startIndex1:endIndex1 ,3 ) );
                            fitLineFunc_period1(i,:) = polyfit(X(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ...
                                                         ,Y(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ,1);
                            [R,P] = corrcoef(X(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2),Y(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2));
                            fitLineR_period1(i,:) = [R(1,2), P(1,2)]; 

                            if bNonPlot == 0
                                subplot(r_fig,c_fig,3);
                                fitDataY = polyval( fitLineFunc_period1(i,:) , X );
                                plot( X(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ,Y(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ,'ob');
                                hold on
                                    plot( X(zeroCrossTimes1(:,1)>1|zeroCrossTimes1(:,2)>1) ,Y(zeroCrossTimes1(:,1)>1|zeroCrossTimes1(:,2)>1) ,'sb');
                                    plot( X, fitDataY ,'k');
                                hold off
                                xlabel('ゼロクロス点間隔の差（半周期）'); ylabel('対数演算前アバタ速さ');
                                xlim([0,800]);         ylim([0 50000]);            
                            end

                            X = abs(peak_zx1( startIndex1:endIndex1 ,3) );
                            fitLineFunc_peak1(i,:) = polyfit(X(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ...
                                                         ,Y(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ,1);
                            [R,P] = corrcoef(X(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2),Y(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2));
                            fitLineR_peak1(i,:) = [R(1,2), P(1,2)]; 
                            if bNonPlot == 0
                                subplot(r_fig,c_fig,5);
                                fitDataY = polyval( fitLineFunc_peak1(i,:) , X );
                                plot( X(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ,Y(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ,'ob');
                                hold on
                                    plot( X(zeroCrossTimes1(:,1)>1|zeroCrossTimes1(:,2)>1) ,Y(zeroCrossTimes1(:,1)>1|zeroCrossTimes1(:,2)>1) ,'sb');
                                    plot( X, fitDataY ,'k');
                                hold off
                                xlabel('ピーク値の差'); ylabel('対数演算前アバタ速さ');
                                xlim([0,400]);            ylim([0 50000]);
                            end
                       end

                    else
                        fitLineFunc_peak1(i,:) = fitLineFunc_peak1(i-1,:);
                        fitLineFunc_period1(i,:) = fitLineFunc_period1(i-1,:);
                        fitLineR_peak1(i,:) = fitLineR_peak1(i-1,:);
                        fitLineR_period1(i,:) = fitLineR_period1(i-1,:);
                    end

                    i = i+1;

                    if mod(i, 1000) == 0
                    end
                    if i==50000

                    end

                end
            end

            
%%          グラフ描画
            MonitorSize = [ 0, 0, 1200, 1000];
            set(gcf, 'Position', MonitorSize);
            
            subplot(2,1,1,'align')
            [haxes,hline1,hlineR1] = ...
                plotyy(spotTimeSeries, fitLineFunc_peak1(:,1), spotTimeSeries, fitLineR_peak1(:,1));
            set(hline1,'Color','b');            set(hlineR1,'Color','c');
            set(haxes(1),'YColor','k');            set(haxes(2),'YColor','k');
            
            axes(haxes(1))
                 xlabel('時間'); ylabel('ピーク値の差とアバタ速度の回帰直線の傾き');
                 ylim([-100 300]);
                 set(haxes(1),'YTick',[-100:100:300]);
            axes(haxes(2))
                 ylabel('相関係数R');    ylim([-1 1]);
                 set(haxes(2),'YTick',[-1:0.5:1]);
            title(titleName,'Interpreter','none');
                
            subplot(2,1,2,'align')
            [haxes,hline1,hlineR1] = ...
                plotyy(spotTimeSeries, fitLineFunc_period1(:,1), spotTimeSeries, fitLineR_period1(:,1));
            set(hline1,'Color','b');            set(hlineR1,'Color','c');
            set(haxes(1),'YColor','k');            set(haxes(2),'YColor','k');
            
            axes(haxes(1))
                xlabel('時間'); ylabel('操作周期の差とアバタ速度の回帰直線の傾き');
                ylim([-100,300]);
                set(haxes(1),'YTick',[-100:100:300]);
            axes(haxes(2))
                 ylabel('相関係数R');    ylim([-1,1]);
                 set(haxes(2),'YTick',[-1:0.5:1]);
            title(titleName,'Interpreter','none');
                
            obj.saveGraph();
            
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
                       
                       k=2;
                       zeroCrossTimes1 = zeros(1,2);
                       % ゼロクロス間のピーク回数　C1:波形の前半部のピーク回数　C2:後半部のピーク回数
                       zeroCrossTimes1(1,1) = length( user1.zeroCrossData.peak(startIndex1).time );
                       for IndexSeries = startIndex1+1 :endIndex1
                           zeroCrossTimes1(k,1) = length( user1.zeroCrossData.peak(IndexSeries).time );
                           zeroCrossTimes1(k,2) = length( user1.zeroCrossData.peak(IndexSeries-1).time );
                           k = k+1;
                       end
                       
                       sizeZeroCross1 = find(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2);
                       %　ピークが2回未満のときのインデックス
                       if length( sizeZeroCross1 ) < 2  %　ピークが2回未満のデータ数が2個未満の時を除外
                            fitLineFunc_peak1(i,:) = [0,0];
                            fitLineFunc_period1(i,:) = [0,0];
                            fitLineR_peak1(i,:) = [0,0];
                            fitLineR_period1(i,:) = [0,0];
                       else

                            Y = abs( user1.zeroCrossData.nonlogAvtVelocity( startIndex1:endIndex1 ) );
                            if bNonPlot == 0
                                subplot(r_fig,c_fig,1);
                                X = period_zx1( startIndex1:endIndex1 ,2 );
                                plot( X(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ,Y(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ,'ob');
                                hold on
                                    plot( X(zeroCrossTimes1(:,1)>1|zeroCrossTimes1(:,2)>1) ,Y(zeroCrossTimes1(:,1)>1|zeroCrossTimes1(:,2)>1) ,'sb');
                                hold off
                                xlabel('ゼロクロス点間隔(1周期)'); ylabel('対数演算前アバタ速さ');
                                xlim([0,800]);         ylim([0 50000]);
                                title( titleName1 );
                            end

                            X = abs( period_zx1( startIndex1:endIndex1 ,3 ) );
                            fitLineFunc_period1(i,:) = polyfit(X(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ...
                                                         ,Y(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ,1);
                            [R,P] = corrcoef(X(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2),Y(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2));
                            fitLineR_period1(i,:) = [R(1,2), P(1,2)]; 

                            if bNonPlot == 0
                                subplot(r_fig,c_fig,3);
                                fitDataY = polyval( fitLineFunc_period1(i,:) , X );
                                plot( X(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ,Y(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ,'ob');
                                hold on
                                    plot( X(zeroCrossTimes1(:,1)>1|zeroCrossTimes1(:,2)>1) ,Y(zeroCrossTimes1(:,1)>1|zeroCrossTimes1(:,2)>1) ,'sb');
                                    plot( X, fitDataY ,'k');
                                hold off
                                xlabel('ゼロクロス点間隔の差（半周期）'); ylabel('対数演算前アバタ速さ');
                                xlim([0,800]);         ylim([0 50000]);            
                            end

                            X = abs(peak_zx1( startIndex1:endIndex1 ,3) );
                            fitLineFunc_peak1(i,:) = polyfit(X(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ...
                                                         ,Y(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ,1);
                            [R,P] = corrcoef(X(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2),Y(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2));
                            fitLineR_peak1(i,:) = [R(1,2), P(1,2)]; 
                            if bNonPlot == 0
                                subplot(r_fig,c_fig,5);
                                fitDataY = polyval( fitLineFunc_peak1(i,:) , X );
                                plot( X(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ,Y(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ,'ob');
                                hold on
                                    plot( X(zeroCrossTimes1(:,1)>1|zeroCrossTimes1(:,2)>1) ,Y(zeroCrossTimes1(:,1)>1|zeroCrossTimes1(:,2)>1) ,'sb');
                                    plot( X, fitDataY ,'k');
                                hold off
                                xlabel('ピーク値の差'); ylabel('対数演算前アバタ速さ');
                                xlim([0,400]);            ylim([0 50000]);
                            end
                       end

                    else
                        fitLineFunc_peak1(i,:) = fitLineFunc_peak1(i-1,:);
                        fitLineFunc_period1(i,:) = fitLineFunc_period1(i-1,:);
                        fitLineR_peak1(i,:) = fitLineR_peak1(i-1,:);
                        fitLineR_period1(i,:) = fitLineR_period1(i-1,:);
                    end

                    %　2Pのゼロクロス時間のインデクスが進んだら，相関分析
                    if startIndex2 ~= find( user2.zeroCrossData.zeroCrossTime > ( spotTimeMax - spotTime ) , 1, 'first') ...
                            || endIndex2 ~= find( user2.zeroCrossData.zeroCrossTime < spotTimeMax , 1, 'last')

                        startIndex2 = find( user2.zeroCrossData.zeroCrossTime > ( spotTimeMax - spotTime ) , 1, 'first');
                        endIndex2 = find( user2.zeroCrossData.zeroCrossTime < spotTimeMax , 1, 'last');

                       k=2;
                       zeroCrossTimes2 = zeros(1,2);
                       zeroCrossTimes2(1,1) = length( user2.zeroCrossData.peak(startIndex2).time );
                       for IndexSeries = startIndex2+1 :endIndex2
                           zeroCrossTimes2(k,1) = length( user2.zeroCrossData.peak(IndexSeries).time );
                           zeroCrossTimes2(k,2) = length( user2.zeroCrossData.peak(IndexSeries-1).time );
                           k = k+1;
                       end
                       
                       sizeZeroCross2 = find(zeroCrossTimes2(:,1)<2&zeroCrossTimes2(:,2)<2);
                       if length( sizeZeroCross2 ) < 2
                            fitLineFunc_peak2(i,:) = [0,0];
                            fitLineFunc_period2(i,:) = [0,0];
                            fitLineR_peak2(i,:) = [0,0];
                            fitLineR_period2(i,:) = [0,0];
                       else

                           Y = abs( user2.zeroCrossData.nonlogAvtVelocity( startIndex2:endIndex2 ) );
                            if bNonPlot == 0
                                subplot(r_fig,c_fig,2);
                                X = abs( period_zx2( startIndex2:endIndex2 ,2) );
                                plot( X(zeroCrossTimes2(:,1)<2&zeroCrossTimes2(:,2)<2) ,Y(zeroCrossTimes2(:,1)<2&zeroCrossTimes2(:,2)<2) ,'og');
                                hold on
                                    plot( X(zeroCrossTimes2(:,1)>1|zeroCrossTimes2(:,2)>1) ,Y(zeroCrossTimes2(:,1)>1|zeroCrossTimes2(:,2)>1) ,'sg');
                                hold off
                                xlabel('ゼロクロス点間隔(1周期)'); ylabel('対数演算前アバタ速さ');
                                xlim([0,600]);         ylim([0 50000]);
                                title( titleName2 );
                            end

                            X = abs( period_zx2( startIndex2:endIndex2 ,3) );
                            fitLineFunc_period2(i,:) = polyfit(X(zeroCrossTimes2(:,1)<2&zeroCrossTimes2(:,2)<2) ...
                                                            ,Y(zeroCrossTimes2(:,1)<2&zeroCrossTimes2(:,2)<2) ,1);
                            [R,P] = corrcoef(X(zeroCrossTimes2(:,1)<2&zeroCrossTimes2(:,2)<2),Y(zeroCrossTimes2(:,1)<2&zeroCrossTimes2(:,2)<2));
                            fitLineR_period2(i,:) = [R(1,2), P(1,2)]; 
                            if bNonPlot == 0
                                subplot(r_fig,c_fig,4);
                                fitDataY = polyval( fitLineFunc_period2(i,:) , X );
                                plot( X(zeroCrossTimes2(:,1)<2&zeroCrossTimes2(:,2)<2) ,Y(zeroCrossTimes2(:,1)<2&zeroCrossTimes2(:,2)<2) ,'og');
                                hold on
                                    plot( X(zeroCrossTimes2(:,1)>1|zeroCrossTimes2(:,2)>1) ,Y(zeroCrossTimes2(:,1)>1|zeroCrossTimes2(:,2)>1) ,'sg');
                                    plot( X, fitDataY ,'k');
                                hold off
                                xlabel('ゼロクロス点間隔の差（半周期）'); ylabel('対数演算前アバタ速さ');
                                xlim([0,600]);         ylim([0 50000]);            
                            end

                            X = abs( peak_zx2( startIndex2:endIndex2 ,3 ) );
                            fitLineFunc_peak2(i,:) = polyfit(X(zeroCrossTimes2(:,1)<2&zeroCrossTimes2(:,2)<2) ...
                                                            ,Y(zeroCrossTimes2(:,1)<2&zeroCrossTimes2(:,2)<2) ,1);
                            [R,P] = corrcoef(X(zeroCrossTimes2(:,1)<2&zeroCrossTimes2(:,2)<2),Y(zeroCrossTimes2(:,1)<2&zeroCrossTimes2(:,2)<2));
                            fitLineR_peak2(i,:) = [R(1,2), P(1,2)]; 
                            if bNonPlot == 0
                                subplot(r_fig,c_fig,6);
                                fitDataY = polyval( fitLineFunc_peak2(i,:) , X );
                                plot( X(zeroCrossTimes2(:,1)<2&zeroCrossTimes2(:,2)<2) ,Y(zeroCrossTimes2(:,1)<2&zeroCrossTimes2(:,2)<2) ,'og');
                                hold on
                                    plot( X(zeroCrossTimes2(:,1)>1|zeroCrossTimes2(:,2)>1) ,Y(zeroCrossTimes2(:,1)>1|zeroCrossTimes2(:,2)>1) ,'sg');
                                    plot( X, fitDataY ,'k');
                                hold off
                                xlabel('ピーク値の差'); ylabel('対数演算前アバタ速さ');
                                xlim([0,400]);            ylim([0 50000]);
                            end
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
                    if i==50000
                        
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


%%      エクセルデータ出力
            outputTitle = {'ピーク値の差との回帰係数平均値(1P)','標準偏差(1P)',...
                            'ピーク値の差との回帰係数平均値(2P)','標準偏差(2P)', ...
                            'ピーク値の差との回帰係数 類似割合',...
                            '操作周期の差との回帰係数平均値(1P)','標準偏差(1P)',...
                            '操作周期の差との回帰係数平均値(2P)','標準偏差(2P)', ...
                            '操作周期の差との回帰係数 類似割合'...
                            };
            slopePeakOutput = { mean( fitLineFunc_peak1(:,1) ), std( fitLineFunc_peak1(:,1) ) , ...
                                mean( fitLineFunc_peak2(:,1) ), std( fitLineFunc_peak2(:,1) ) };
            distSlopePeak = abs( fitLineFunc_peak1(:,1) - fitLineFunc_peak2(:,1));
            sameSlopePeakOutput = length( find( distSlopePeak < 10 ) )/60000;
            
            slopePeriodOutput = { mean( fitLineFunc_period1(:,1) ), std( fitLineFunc_period1(:,1) ) , ...
                                mean( fitLineFunc_period2(:,1) ), std( fitLineFunc_period2(:,1) ) };
            distSlopePeriod = abs( fitLineFunc_period1(:,1) - fitLineFunc_period2(:,1));
            sameSlopePeriodOutput = length( find( distSlopePeriod < 10 ) )/60000;
            
            output = horzcat( slopePeakOutput , sameSlopePeakOutput , slopePeriodOutput , sameSlopePeriodOutput );
            obj.outputAllToXls(output , outputTitle);

        end

    end
end
