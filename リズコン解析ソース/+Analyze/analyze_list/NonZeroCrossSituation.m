classdef NonZeroCrossSituation < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述
    %   ゼロクロスしない時の前後2.5秒をグラフ描画　
    %       アバタ位置，アバタ速度，コントローラ操作，振幅，周期，（相関の傾き）

    properties
    end

    methods
        function obj = NonZeroCrossSituation(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
           %　ゼロクロスしない時のデータを見る前後の時間 
           period_bf = 2500;
           %　ゼロクロス間でのピーク回数取得
           [zeroCrossTimes] = Rhythm.setZeroCrossCount(user.zeroCrossData);

           %　ゼロクロスしている時のインデックス
           IndexZeroCross = find(zeroCrossTimes(:,2)<2);
           %　ゼロクロスしない時のインデックス()
           IndexNonZeroCross = find( zeroCrossTimes(:,2)>1 );
           %　周期・振幅データ
           [period_zx, peak_zx] = Rhythm.setZeroCrossPeriodData(user.zeroCrossData);

           MonitorSize = [ 0, 0, 1200, 1000];
            set(gcf, 'Position', MonitorSize);
           r_fig =5;
           
           i_over = find(user.zeroCrossData.zeroCrossTime> period_bf  , 1, 'first');
           i_st = find(IndexNonZeroCross > i_over, 1,'first');
           
           for i = i_st: length(IndexNonZeroCross)
               t_zx = user.zeroCrossData.zeroCrossTime(IndexNonZeroCross(i));
               t_series = t_zx- period_bf : t_zx+ period_bf ;
               
%%           アバタ位置描画
               subplot(r_fig, 1, 1)     
               plot(   user.time.lowSampled,  user.avatarPosition.lowSampled);         
                % 自動アバタの位置描画
                if strcmp( obj.config.examType, '追い込まれ実験')...
                        || strcmp( obj.config.examType, '追い込む実験')
                    hold on
                        plot(   obj.data.com.time,  obj.data.com.avatarPosition , 'k:');               
                    hold off
                end
                hold on %　ゼロクロスしないタイミングを描画
                    for j= 1: length(IndexNonZeroCross)
                        zeroCrossTime = user.zeroCrossData.zeroCrossTime(IndexNonZeroCross(j) );
                        plot([zeroCrossTime zeroCrossTime],[0 1000],...
                            'Color' , [.7 .7 .7] , 'LineStyle', ':');
                    end
                    plot([t_zx t_zx],[0 1000],'Color' , 'm');
                hold off
                xlabel('時間t ms'); ylabel('アバタ位置');
                xlim([t_zx- period_bf  t_zx+ period_bf ]);    ylim([0 1000]);

%%            コントローラ操作描画    
                subplot(r_fig,1,2)
                plot(   user.time.highSampled,  user.operatePulse.highSampled );               
                hold on %　ゼロクロスしないタイミングを描画
                    for j= 1: length(IndexNonZeroCross)
                        zeroCrossTime = user.zeroCrossData.zeroCrossTime(IndexNonZeroCross(j) );
                        plot([zeroCrossTime zeroCrossTime],[-400 400],...
                            'Color' , [.7 .7 .7] , 'LineStyle', ':');
                    end
                    plot([t_zx t_zx],[-400 400],'Color' , 'm');
                    plot([0 60000], [0 0] ,'k')
                hold off
                xlabel('時間t ms'); ylabel('コントローラ操作');
                xlim([t_zx- period_bf  t_zx+ period_bf]);    ylim([-400 400]);
%                 grid on;
                set(gca,'YTick',[-400:100:400]);

%%            アバタ速度     
                subplot(r_fig,1,3)
                plot(   user.time.highSampled,  user.avatarVelocity.highSampled );               
                hold on %　ゼロクロスしないタイミングを描画
                    for j= 1: length(IndexNonZeroCross)
                        zeroCrossTime = user.zeroCrossData.zeroCrossTime(IndexNonZeroCross(j) );
                        plot([zeroCrossTime zeroCrossTime],[-0.5 0.5],...
                            'Color' , [.7 .7 .7] , 'LineStyle', ':');
                    end
                    plot([t_zx t_zx],[-0.5 0.5],'Color' , 'm');
                    plot([0 60000], [0 0] ,'k')
                hold off
                xlabel('時間t ms'); ylabel('アバタ速度');
                xlim([t_zx- period_bf  t_zx+ period_bf ]);    ylim([-0.5 0.5]);
%                 grid on;
                set(gca,'YTick',[-0.5:0.1:0.5]);

%%            ゼロクロス周期の差,ゼロクロス振幅の差
                subplot(r_fig,1,4)
                [AX,H1,H2] = plotyy(   user.zeroCrossData.zeroCrossTime, abs(period_zx(:,3)),...
                                        user.zeroCrossData.zeroCrossTime, abs(peak_zx(:,3)));
                set(AX(1), 'YColor', 'k',...
                    'XLim', [t_zx- period_bf  t_zx+ period_bf ], 'YLim', [0 600]);
                set(AX(2), 'YColor', 'k',...
                    'XLim', [t_zx- period_bf  t_zx+ period_bf ], 'YLim', [0 600]);

                set(H1, 'Color', 'b');  set(H2, 'Color', 'c');
                hold( AX(1) ,'on') %　ゼロクロスしないタイミングを描画
                    for j= 1: length(IndexNonZeroCross)
                        zeroCrossTime = user.zeroCrossData.zeroCrossTime(IndexNonZeroCross(j) );
                        plot([zeroCrossTime zeroCrossTime],[0 600], 'Color' , [.7 .7 .7] , 'LineStyle', ':');
                    end
                    plot([t_zx t_zx],[0 600],'Color' , 'm');
                hold off
                legend( [H1, H2], '周期の差', '振幅の差' );                
                xlabel('時間');
                ylabel(AX(1) , '操作周期の差');     ylabel(AX(2) , '操作振幅の差');

%%          　ゼロクロス周期・振幅
                subplot(r_fig,1,5)
                [AX,H1,H2] = plotyy(   user.zeroCrossData.zeroCrossTime, period_zx(:,2),...
                                        user.zeroCrossData.zeroCrossTime, peak_zx(:,2));
                set(AX(1), 'YColor', 'k',...
                    'XLim', [t_zx- period_bf  t_zx+ period_bf ], 'YLim', [0 600]);
                set(AX(2), 'YColor', 'k',...
                    'XLim', [t_zx- period_bf  t_zx+ period_bf ], 'YLim', [0 600]);

                set(H1, 'Color', 'b');  set(H2, 'Color', 'c');
                hold( AX(1) ,'on') %　ゼロクロスしないタイミングを描画
                    for j= 1: length(IndexNonZeroCross)
                        zeroCrossTime = user.zeroCrossData.zeroCrossTime(IndexNonZeroCross(j) );
                        plot([zeroCrossTime zeroCrossTime],[0 600], 'Color' , [.7 .7 .7] , 'LineStyle', ':');
                    end
                    plot([t_zx t_zx],[0 600],'Color' , 'm');
                hold off
                legend( [H1, H2], '周期', '振幅' );                
                xlabel('時間');
                ylabel(AX(1) , '操作周期');     ylabel(AX(2) , '操作振幅');
               
                obj.saveGraphWithName(num2str(i));
                
           end
            
           

        end
        
        function runForPair(obj,user1,user2)
           period_bf = 2500;

           %　ゼロクロス間でのピーク回数取得
           [zeroCrossTimes1] = Rhythm.setZeroCrossCount(user1.zeroCrossData);
           [zeroCrossTimes2] = Rhythm.setZeroCrossCount(user2.zeroCrossData);

           %　ゼロクロスしている時のインデックス
           IndexZeroCross1 = find(zeroCrossTimes1(:,2)<2);
           IndexZeroCross2 = find(zeroCrossTimes2(:,2)<2);
           %　ゼロクロスしない時のインデックス()
           IndexNonZeroCross1 = find( zeroCrossTimes1(:,2)>1 );
           IndexNonZeroCross2 = find( zeroCrossTimes2(:,2)>1 );

           [period_zx1, peak_zx1] = Rhythm.setZeroCrossPeriodData(user1.zeroCrossData);
            [period_zx2, peak_zx2] = Rhythm.setZeroCrossPeriodData(user2.zeroCrossData);
            filterdPul1 = Rhythm.BPfilter( user1.operatePulse.lowSampled);
            filterdPul2 = Rhythm.BPfilter( user2.operatePulse.lowSampled);
            [timeCorr, AB_Series0, AB_Series_Max] = Rhythm.AllCorr__func(filterdPul1, filterdPul2, user2.time.lowSampled, 100);

            MonitorSize = [ 0, 0, 1400, 1000];
            set(gcf, 'Position', MonitorSize);


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
            
            
            r_fig = 5;
            
%%          1Pゼロクロスしない時       
           i_over1 = find(user1.zeroCrossData.zeroCrossTime> period_bf  , 1, 'first');
           i_st = find(IndexNonZeroCross1 > i_over1, 1,'first');
           for i = i_st: length(IndexNonZeroCross1)
                t_zx1 = user1.zeroCrossData.zeroCrossTime(IndexNonZeroCross1(i) );

%%              アバタ位置                
                subplot(r_fig,1,1);
                plot(   user1.time.lowSampled,  user1.avatarPosition.lowSampled,'b');               
                hold on
                    plot(   user2.time.lowSampled,  user2.avatarPosition.lowSampled,...
                                    'Color', [0 .498 0] , 'LineStyle', ':');               
                %　1Pのゼロクロスしないタイミングを描画
                    for j= 1: length(IndexNonZeroCross1)
                        zeroCrossTime1 = user1.zeroCrossData.zeroCrossTime(IndexNonZeroCross1(j) );
                        plot([zeroCrossTime1 zeroCrossTime1],[0 1000],...
                            'Color' , [.7 .7 .7] , 'LineStyle', '-');
                    end
                    plot([t_zx1 t_zx1],[0 1000],'Color' , 'm');
                 %　2Pのゼロクロスしないタイミングを描画(点線)
                   for j= 1: length(IndexNonZeroCross2)
                        zeroCrossTime2 = user2.zeroCrossData.zeroCrossTime(IndexNonZeroCross2(j) );
                        plot([zeroCrossTime2 zeroCrossTime2],[0 1000],...
                            'Color' , [.7 .7 .7] , 'LineStyle', ':');
                    end
                hold off
                legend(legName1, legName2 ,'Location','NorthEastOutside');
                xlabel('時間t ms'); ylabel('アバタ位置');
                xlim([t_zx1- period_bf  t_zx1+ period_bf ]);    ylim([0 1000]);
                
%%              コントローラ操作
                subplot(r_fig,1,2)
                [haxes,hline1,hlineC] = plotyy( user1.time.highSampled , user1.operatePulse.highSampled ,  timeCorr, AB_Series_Max(:,2));
 
                set(haxes(1), 'YColor', 'k',...
                    'XLim', [t_zx1- period_bf  t_zx1+ period_bf ], 'YLim', [-400 400] , ...
                    'YTick',[-400:200:400]);
                set(haxes(2), 'YColor', 'r',...
                    'XLim', [t_zx1- period_bf  t_zx1+ period_bf ], 'YLim', [0 1] ,...
                    'YTick',[0:0.2:1] );

                set(hline1,'Color','b');            set(hlineC,'Color','r');
                
                hold( haxes(1),'on') % 重ね書きモードオン
                hline2 = plot(   haxes(1), user2.time.highSampled ,  user2.operatePulse.highSampled  ,...
                                'Color', [0 .498 0] ,'LineStyle' , ':' );   
                plot( haxes(1),[0 60000], [0 0],'k');

                hold( haxes(2),'on') % 重ね書きモードオン
                    plot( haxes(2),[0 60000], [0.8 0.8],'k:');
                %　1Pのゼロクロスしないタイミングを描画
                    for j= 1: length(IndexNonZeroCross1)
                        zeroCrossTime1 = user1.zeroCrossData.zeroCrossTime(IndexNonZeroCross1(j) );
                        plot([zeroCrossTime1 zeroCrossTime1],[-400 400],...
                            'Color' , [.7 .7 .7] , 'LineStyle', '-');
                    end
                    plot([t_zx1 t_zx1],[-400 400],'Color' , 'm');
                 %　2Pのゼロクロスしないタイミングを描画(点線)
                   for j= 1: length(IndexNonZeroCross2)
                        zeroCrossTime2 = user2.zeroCrossData.zeroCrossTime(IndexNonZeroCross2(j) );
                        plot([zeroCrossTime2 zeroCrossTime2],[-400 400],...
                            'Color' , [.7 .7 .7] , 'LineStyle', ':');
                    end
                 hold off

                legend( [hline1,hline2], legName1, legName2 ,'Location','NorthEastOutside');
                
                xlabel('時間t ms');
                ylabel(haxes(1) , 'コントローラ操作');     ylabel(haxes(2) , '最大相互相関');
                
                
%%              アバタ速度
                subplot(r_fig,1,3)
                plot(   user1.time.highSampled,  user1.avatarVelocity.highSampled ,'b' );               
                hold on
                    plot(   user2.time.highSampled,  user2.avatarVelocity.highSampled, ...
                    'Color', [0 .498 0] , 'LineStyle' , ':');               
                    for j= 1: length(IndexNonZeroCross1)
                        zeroCrossTime1 = user1.zeroCrossData.zeroCrossTime(IndexNonZeroCross1(j) );
                        plot([zeroCrossTime1 zeroCrossTime1],[-400 400],...
                            'Color' , [.7 .7 .7] , 'LineStyle', '-');
                    end
                    plot([t_zx1 t_zx1],[-400 400],'Color' , 'm');
                    for j= 1: length(IndexNonZeroCross2)
                        zeroCrossTime2 = user2.zeroCrossData.zeroCrossTime(IndexNonZeroCross2(j) );
                        plot([zeroCrossTime2 zeroCrossTime2],[-400 400],...
                            'Color' , [.7 .7 .7] , 'LineStyle', ':');
                    end
                     plot( [0 60000], [0 0],'k');
                hold off
                legend(legName1, legName2 ,'Location','NorthEastOutside');
                xlabel('時間t ms'); ylabel('アバタ速度');
                xlim([t_zx1- period_bf  t_zx1+ period_bf ]);    ylim([-0.5 0.5]);
%                 grid on;
                set(gca,'YTick',[-0.5:0.1:0.5]);

%%              ゼロクロス周期の差,ゼロクロス振幅の差
                subplot(r_fig,1,4)
                [AX, Hpd1, Hpk1] = plotyy( user1.zeroCrossData.zeroCrossTime, abs(period_zx1(:,3)), ...
                                user1.zeroCrossData.zeroCrossTime, abs(peak_zx1(:,3)));
                set(AX(1), 'YColor', 'k',...
                    'XLim', [t_zx1- period_bf  t_zx1+ period_bf ], 'YLim', [0 600]);
                set(AX(2), 'YColor', 'k',...
                    'XLim', [t_zx1- period_bf  t_zx1+ period_bf ], 'YLim', [0 600]);

                set(Hpd1,'Color','b');          set(Hpk1,'Color','c');
                hold( AX(1),'on')
                    Hpd2 = plot(   user2.zeroCrossData.zeroCrossTime, abs(period_zx2(:,3)), 'Color', [0 .5 0], 'LineStyle' , ':');          
                hold( AX(2),'on')
                    Hpk2 = plot(   user2.zeroCrossData.zeroCrossTime, abs(peak_zx2(:,3)), 'Color', 'g', 'LineStyle' , ':');          
                %　1Pのゼロクロスしないタイミングを描画
                    for j= 1: length(IndexNonZeroCross1)
                        zeroCrossTime1 = user1.zeroCrossData.zeroCrossTime(IndexNonZeroCross1(j) );
                        plot([zeroCrossTime1 zeroCrossTime1],[0 1000],...
                            'Color' , [.7 .7 .7] , 'LineStyle', '-');
                    end
                    plot([t_zx1 t_zx1],[0 1000],'Color' , 'm');
                 %　2Pのゼロクロスしないタイミングを描画(点線)
                   for j= 1: length(IndexNonZeroCross2)
                        zeroCrossTime2 = user2.zeroCrossData.zeroCrossTime(IndexNonZeroCross2(j) );
                        plot([zeroCrossTime2 zeroCrossTime2],[0 1000],...
                            'Color' , [.7 .7 .7] , 'LineStyle', ':');
                    end
                hold off
                
                legend([Hpd1,Hpk1,Hpd2,Hpk2], ...
                    '周期差','振幅差','周期差','振幅差','Location','NorthEastOutside');
%                     strcat(legName1,' 周期の差'), strcat(legName1,' 振幅の差'), ...
%                     strcat(legName2,' 周期の差'), strcat(legName2,' 振幅の差'),'Location','NorthEastOutside');
                xlabel('時間');
                ylabel(AX(1) , '操作周期の差');     ylabel(AX(2) , '操作振幅の差');
                
%%              ゼロクロス振幅,周期　（1周期）
                subplot(r_fig,1,5)
                [AX, Hpd1, Hpk1] = plotyy( user1.zeroCrossData.zeroCrossTime, period_zx1(:,2), ...
                                user1.zeroCrossData.zeroCrossTime, peak_zx1(:,2));
                set(AX(1), 'YColor', 'k',...
                    'XLim', [t_zx1- period_bf  t_zx1+ period_bf ], 'YLim', [0 600]);
                set(AX(2), 'YColor', 'k',...
                    'XLim', [t_zx1- period_bf  t_zx1+ period_bf ], 'YLim', [0 600]);

                set(Hpd1,'Color','b');          set(Hpk1,'Color','c');
                hold( AX(1),'on')
                    Hpd2 = plot(   user2.zeroCrossData.zeroCrossTime, period_zx2(:,2),'Color', [0 .5 0], 'LineStyle' , ':');          
                hold( AX(2),'on')
                    Hpk2 = plot(   user2.zeroCrossData.zeroCrossTime, peak_zx2(:,2),'Color', 'g', 'LineStyle' , ':');          
                %　1Pのゼロクロスしないタイミングを描画
                    for j= 1: length(IndexNonZeroCross1)
                        zeroCrossTime1 = user1.zeroCrossData.zeroCrossTime(IndexNonZeroCross1(j) );
                        plot([zeroCrossTime1 zeroCrossTime1],[0 1000],...
                            'Color' , [.7 .7 .7] , 'LineStyle', '-');
                    end
                    plot([t_zx1 t_zx1],[0 1000],'Color' , 'm');
                 %　2Pのゼロクロスしないタイミングを描画(点線)
                   for j= 1: length(IndexNonZeroCross2)
                        zeroCrossTime2 = user2.zeroCrossData.zeroCrossTime(IndexNonZeroCross2(j) );
                        plot([zeroCrossTime2 zeroCrossTime2],[0 1000],...
                            'Color' , [.7 .7 .7] , 'LineStyle', ':');
                    end
                hold off
                legend([Hpd1,Hpk1,Hpd2,Hpk2], ...
                    '周期＿','振幅＿','周期＿','振幅＿','Location','NorthEastOutside');
%                     strcat(legName1,' 周期の差'), strcat(legName1,' 振幅の差'), ...
%                     strcat(legName2,' 周期の差'), strcat(legName2,' 振幅の差'),'Location','NorthEastOutside');
                xlabel('時間');
                ylabel(AX(1) , '操作周期');     ylabel(AX(2) , '操作振幅');
                
                obj.saveGraphWithName(num2str(i));
           end
           
%%          2Pゼロクロスしない時       
           i_over2 = find(user2.zeroCrossData.zeroCrossTime> period_bf  , 1, 'first');
           i_st = find(IndexNonZeroCross2 > i_over2, 1,'first');
           for i = i_st: length(IndexNonZeroCross2)
                t_zx2 = user2.zeroCrossData.zeroCrossTime(IndexNonZeroCross2(i) );

%%              アバタ位置                
                subplot(r_fig,1,1);
                plot(   user1.time.lowSampled,  user1.avatarPosition.lowSampled,'b:');
                hold on
                    plot(   user2.time.lowSampled,  user2.avatarPosition.lowSampled, 'Color', [0 .498 0] );               
                %　1Pのゼロクロスしないタイミングを描画（点線）
                    for j= 1: length(IndexNonZeroCross1)
                        zeroCrossTime1 = user1.zeroCrossData.zeroCrossTime(IndexNonZeroCross1(j) );
                        plot([zeroCrossTime1 zeroCrossTime1],[0 1000],...
                            'Color' , [.7 .7 .7]  , 'LineStyle', ':');
                    end
                 %　2Pのゼロクロスしないタイミングを描画
                   for j= 1: length(IndexNonZeroCross2)
                        zeroCrossTime2 = user2.zeroCrossData.zeroCrossTime(IndexNonZeroCross2(j) );
                        plot([zeroCrossTime2 zeroCrossTime2],[0 1000],...
                            'Color' , [.7 .7 .7]  , 'LineStyle', '-');
                    end
                    plot([t_zx2 t_zx2],[0 1000],'Color' , 'm');
                hold off
                legend(legName1, legName2 ,'Location','NorthEastOutside');
                xlabel('時間t ms'); ylabel('アバタ位置');
                xlim([t_zx2- period_bf  t_zx2+ period_bf ]);    ylim([0 1000]);
                
%%              コントローラ操作
                subplot(r_fig,1,2)
                [haxes,hline1,hlineC] = plotyy( user1.time.highSampled, user1.operatePulse.highSampled , ...
                                                    timeCorr, AB_Series_Max(:,2));
                set(haxes(1), 'YColor', 'k',...
                    'XLim', [t_zx2- period_bf  t_zx2+ period_bf ], 'YLim', [-400 400] , ...
                    'YTick',[-400:200:400]);
                set(haxes(2), 'YColor', 'r',...
                    'XLim', [t_zx2- period_bf  t_zx2+ period_bf ], 'YLim', [0 1] ,...
                    'YTick',[0:0.2:1] );

                set(hline1,'Color','b');            set(hlineC,'Color','r');
                
                hold( haxes(1),'on') % 重ね書きモードオン
                hline2 = plot(   haxes(1), user2.time.highSampled, user2.operatePulse.highSampled ,'Color', [0 .498 0] );   

                hold( haxes(2),'on') % 重ね書きモードオン
                    plot( haxes(2),[0 60000], [0.8 0.8],'k:');
                %　1Pのゼロクロスしないタイミングを描画（点線）
                    for j= 1: length(IndexNonZeroCross1)
                        zeroCrossTime1 = user1.zeroCrossData.zeroCrossTime(IndexNonZeroCross1(j) );
                        plot([zeroCrossTime1 zeroCrossTime1],[-400 400],...
                            'Color' , [.7 .7 .7]  , 'LineStyle', ':');
                    end
                 %　2Pのゼロクロスしないタイミングを描画
                   for j= 1: length(IndexNonZeroCross2)
                        zeroCrossTime2 = user2.zeroCrossData.zeroCrossTime(IndexNonZeroCross2(j) );
                        plot([zeroCrossTime2 zeroCrossTime2],[-400 400],...
                            'Color' , [.7 .7 .7]  , 'LineStyle', '-');
                    end
                    plot([t_zx2 t_zx2],[-400 400],'Color' , 'm');
                  hold off

                legend( [hline1,hline2], legName1, legName2 ,'Location','NorthEastOutside');
                
                xlabel('時間t ms');
                ylabel(haxes(1) , 'コントローラ操作');     ylabel(haxes(2) , '最大相互相関');
                
%%              アバタ速度
                subplot(r_fig,1,3)
                plot(   user1.time.highSampled,  user1.avatarVelocity.highSampled ,'b' );               
                hold on
                    plot(   user2.time.highSampled,  user2.avatarVelocity.highSampled,'Color', [0 .498 0] );               
                %　1Pのゼロクロスしないタイミングを描画（点線）
                    for j= 1: length(IndexNonZeroCross1)
                        zeroCrossTime1 = user1.zeroCrossData.zeroCrossTime(IndexNonZeroCross1(j) );
                        plot([zeroCrossTime1 zeroCrossTime1],[-400 400],...
                            'Color' , [.7 .7 .7]  , 'LineStyle', ':');
                    end
                 %　2Pのゼロクロスしないタイミングを描画
                   for j= 1: length(IndexNonZeroCross2)
                        zeroCrossTime2 = user2.zeroCrossData.zeroCrossTime(IndexNonZeroCross2(j) );
                        plot([zeroCrossTime2 zeroCrossTime2],[-400 400],...
                            'Color' , [.7 .7 .7]  , 'LineStyle', '-');
                    end
                    plot([t_zx2 t_zx2],[-400 400],'Color' , 'm');
                hold off
                legend(legName1, legName2 ,'Location','NorthEastOutside');
                xlabel('時間t ms'); ylabel('アバタ速度');
                xlim([t_zx2- period_bf  t_zx2+ period_bf ]);    ylim([-0.5 0.5]);
%                 grid on;
                set(gca,'YTick',[-0.5:0.1:0.5]);

%%              ゼロクロス周期の差,ゼロクロス振幅の差
                subplot(r_fig,1,4)
                [AX, Hpd1, Hpk1] = plotyy( user1.zeroCrossData.zeroCrossTime, period_zx1(:,3), ...
                                user1.zeroCrossData.zeroCrossTime, peak_zx1(:,3));
                set(AX(1), 'YColor', 'k',...
                    'XLim', [t_zx2- period_bf  t_zx2+ period_bf ], 'YLim', [0 600]);
                set(AX(2), 'YColor', 'k',...
                    'XLim', [t_zx2- period_bf  t_zx2+ period_bf ], 'YLim', [0 600]);

                set(Hpd1,'Color','g', 'LineStyle' , ':');          
                set(Hpk1,'Color',[0 .5 0], 'LineStyle' , ':');
                hold( AX(1),'on')
                    Hpd2 = plot(   user2.zeroCrossData.zeroCrossTime, period_zx2(:,3),'Color', 'c');          
                hold( AX(2),'on')
                    Hpk2 = plot(   user2.zeroCrossData.zeroCrossTime, peak_zx2(:,3),'Color', 'b');          
                %　1Pのゼロクロスしないタイミングを描画（点線）
                    for j= 1: length(IndexNonZeroCross1)
                        zeroCrossTime1 = user1.zeroCrossData.zeroCrossTime(IndexNonZeroCross1(j) );
                        plot([zeroCrossTime1 zeroCrossTime1],[0 1000],...
                            'Color' , [.7 .7 .7]  , 'LineStyle', ':');
                    end
                 %　2Pのゼロクロスしないタイミングを描画
                   for j= 1: length(IndexNonZeroCross2)
                        zeroCrossTime2 = user2.zeroCrossData.zeroCrossTime(IndexNonZeroCross2(j) );
                        plot([zeroCrossTime2 zeroCrossTime2],[0 1000],...
                            'Color' , [.7 .7 .7]  , 'LineStyle', '-');
                    end
                    plot([t_zx2 t_zx2],[0 1000],'Color' , 'm');
                hold off
                legend([Hpd1,Hpk1,Hpd2,Hpk2], ...
                    '周期差','振幅差','周期差','振幅差','Location','NorthEastOutside');
                xlabel('時間');
                ylabel(AX(1) , '操作周期の差');     ylabel(AX(2) , '操作振幅の差');
                
%%              ゼロクロス周期・振幅（1周期）
                subplot(r_fig,1,5)
                [AX, Hpd1, Hpk1] = plotyy( user1.zeroCrossData.zeroCrossTime, period_zx1(:,2), ...
                                user1.zeroCrossData.zeroCrossTime, peak_zx1(:,2));
                set(AX(1), 'YColor', 'k',...
                    'XLim', [t_zx2- period_bf  t_zx2+ period_bf ], 'YLim', [0 600]);
                set(AX(2), 'YColor', 'k',...
                    'XLim', [t_zx2- period_bf  t_zx2+ period_bf ], 'YLim', [0 600]);

                set(Hpd1,'Color','g', 'LineStyle' , ':');          
                set(Hpk1,'Color',[0 .5 0], 'LineStyle' , ':');
                hold( AX(1),'on')
                    Hpd2  = plot(   user2.zeroCrossData.zeroCrossTime, period_zx2(:,2),'Color', 'c');          
                hold( AX(2),'on')
                    Hpk2 = plot(   user2.zeroCrossData.zeroCrossTime, peak_zx2(:,2),'Color', 'b');          
                %　1Pのゼロクロスしないタイミングを描画（点線）
                    for j= 1: length(IndexNonZeroCross1)
                        zeroCrossTime1 = user1.zeroCrossData.zeroCrossTime(IndexNonZeroCross1(j) );
                        plot([zeroCrossTime1 zeroCrossTime1],[0 1000],...
                            'Color' , [.7 .7 .7]  , 'LineStyle', ':');
                    end
                 %　2Pのゼロクロスしないタイミングを描画
                   for j= 1: length(IndexNonZeroCross2)
                        zeroCrossTime2 = user2.zeroCrossData.zeroCrossTime(IndexNonZeroCross2(j) );
                        plot([zeroCrossTime2 zeroCrossTime2],[0 1000],...
                            'Color' , [.7 .7 .7]  , 'LineStyle', '-');
                    end
                    plot([t_zx2 t_zx2],[0 1000],'Color' , 'm');
                hold off
                legend([Hpd1,Hpk1,Hpd2,Hpk2], ...
                    '周期＿','振幅＿','周期＿','振幅＿','Location','NorthEastOutside');
                xlabel('時間');
                ylabel(AX(1) , '操作周期');     ylabel(AX(2) , '操作振幅');
                
                obj.saveGraphWithName(num2str(i));
           end
           
            end

    end
end
