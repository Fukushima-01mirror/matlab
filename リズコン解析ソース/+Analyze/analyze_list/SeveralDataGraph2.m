classdef SeveralDataGraph2 < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = SeveralDataGraph2(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
            
            %　ゼロクロス間でのピーク回数取得
            [zeroCrossTimes] = Rhythm.setZeroCrossCount(user.zeroCrossData);

            %　ゼロクロスしている時のインデックス
            IndexZeroCross = find(zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2);
            %　ゼロクロスしない時のインデックス
            IndexNonZeroCross = find( zeroCrossTimes(:,1)>1 | zeroCrossTimes(:,2)>1);
           
           
            if ~isempty(  findstr( char( obj.config.examType ) , '線追従'))
                bDirect = mean( obj.data.task.avatarPosition(1:10) ) - obj.data.task.avatarPosition(1) >0;
                swTiming(1,1) = 0;
                j=1; 
                for i = 1:length(obj.data.task.time)
                    if bDirect && obj.data.task.avatarPosition(i) >= obj.data.task.otherData(i,2)
                        swTiming(j,1) = obj.data.task.time(i);
                        bDirect = false;
                        j=j+1;
                    end
                    if ~bDirect && obj.data.task.avatarPosition(i) <= obj.data.task.otherData(i,1)
                        swTiming(j,1) = obj.data.task.time(i);
                        bDirect = true;
                        j=j+1;
                    end
                end
            end

            
            [period_zx, peak_zx] = Rhythm.setZeroCrossPeriodData(user.zeroCrossData);
            MonitorSize = [ 0, 0, 1200, 1000];
            set(gcf, 'Position', MonitorSize);
            for i = 1:3
                r_fig = 6;

%%           アバタ位置描画
               subplot(r_fig, 1, 1)     
               plot(   user.time.highSampled,  user.avatarPosition.highSampled);         
                % 自動アバタの位置描画
                hold on
                    % 実験条件の描画
                    if strcmp( obj.config.examType, '追い込まれ実験')...
                            || strcmp( obj.config.examType, '追い込む実験')
                        plot(   obj.data.com.time,  obj.data.com.avatarPosition , 'k:');               
                    elseif ~isempty(  findstr( char( obj.config.examType ) , '線追従'))
                            plot(   obj.data.task.time,  obj.data.task.avatarPosition , 'k:');               
                    end
                    %　ゼロクロスしないタイミングを描画
                    for j= 1: length(IndexNonZeroCross)
                        zeroCrossTime = user.zeroCrossData.zeroCrossTime(IndexNonZeroCross(j) );
                        plot([zeroCrossTime zeroCrossTime],[0 1000],...
                            'Color' , [.7 .7 .7] , 'LineStyle', ':');
                    end
                    if ~isempty(  findstr( char( obj.config.examType ) , '線追従'))
                        for j=1:length(swTiming)
                            plot( [swTiming(j) swTiming(j)],[0 1000], 'Color' , [.7 0 0] , 'LineStyle', ':');
                        end
                    end
                hold off
                xlabel('時間t ms'); ylabel('アバタ位置');
                xlim([20000*(i-1) 20000*i]);    ylim([0 1000]);

%%            コントローラ操作描画    
                subplot(r_fig,1,2)
                plot(   user.time.highSampled,  user.operatePulse.highSampled );               
                hold on %　ゼロクロスしないタイミングを描画
                    for j= 1: length(IndexNonZeroCross)
                        zeroCrossTime = user.zeroCrossData.zeroCrossTime(IndexNonZeroCross(j) );
                        plot([zeroCrossTime zeroCrossTime],[-400 400],...
                            'Color' , [.7 .7 .7] , 'LineStyle', ':');
                    end
                    plot([0 60000], [0 0] ,'k')
                    if ~isempty(  findstr( char( obj.config.examType ) , '線追従'))
                        for j=1:length(swTiming)
                            plot( [swTiming(j) swTiming(j)],[0 1000], 'Color' , [.7 0 0] , 'LineStyle', ':');
                        end
                    end
                hold off
                xlabel('時間t ms'); ylabel('コントローラ操作');
                xlim([20000*(i-1) 20000*i]);    ylim([-400 400]);
%                 grid on;
                set(gca,'YTick',[-400:100:400]);

%%            アバタ速度     
                subplot(r_fig,1,3)
                plot(   user.time.highSampled,  user.avatarVelocity.highSampled );               
                hold on %　ゼロクロスしないタイミングを描画
                    % 実験条件の描画
                    if ~isempty(  findstr( char( obj.config.examType ) , '線追従'))
                            plot(   obj.data.task.time,  obj.data.task.otherData(:,4) , 'k:');               
                    end
                   for j= 1: length(IndexNonZeroCross)
                        zeroCrossTime = user.zeroCrossData.zeroCrossTime(IndexNonZeroCross(j) );
                        plot([zeroCrossTime zeroCrossTime],[-0.5 0.5],...
                            'Color' , [.7 .7 .7] , 'LineStyle', ':');
                    end
                    plot([0 60000], [0 0] ,'k')
                    if ~isempty(  findstr( char( obj.config.examType ) , '線追従'))
                        for j=1:length(swTiming)
                            plot( [swTiming(j) swTiming(j)],[0 1000], 'Color' , [.7 0 0] , 'LineStyle', ':');
                        end
                    end
                hold off
                xlabel('時間t ms'); ylabel('アバタ速度');
                xlim([20000*(i-1) 20000*i]);    ylim([-0.5 0.5]);
%                 grid on;
                set(gca,'YTick',[-0.5:0.1:0.5]);
                 
%%            アバタ速さ     
               subplot(r_fig,1,4)
                plot(   user.time.highSampled, abs( user.avatarVelocity.highSampled ) );               
                hold on %　ゼロクロスしないタイミングを描画
                    for j= 1: length(IndexNonZeroCross)
                        zeroCrossTime = user.zeroCrossData.zeroCrossTime(IndexNonZeroCross(j) );
                        plot([zeroCrossTime zeroCrossTime],[-0.5 0.5],...
                            'Color' , [.7 .7 .7] , 'LineStyle', ':');
                    end
                    plot([0 60000], [0 0] ,'k')
                    if ~isempty(  findstr( char( obj.config.examType ) , '線追従'))
                        for j=1:length(swTiming)
                            plot( [swTiming(j) swTiming(j)],[0 1000], 'Color' , [.7 0 0] , 'LineStyle', ':');
                        end
                    end
                hold off
                xlabel('時間t ms'); ylabel('アバタ速度');
                xlim([20000*(i-1) 20000*i]);    ylim([ 0 0.5]);
%                 grid on;
                set(gca,'YTick',[0:0.1:0.5]);

%%            ゼロクロス周期の差,ゼロクロス振幅の差
                subplot(r_fig,1,5)
                [AX,H1,H2] = plotyy(   user.zeroCrossData.zeroCrossTime, abs(period_zx(:,3)),...
                                        user.zeroCrossData.zeroCrossTime, abs(peak_zx(:,3)));
                set(AX(1), 'YColor', 'k',...
                    'XLim', [20000*(i-1) 20000*i], 'YLim', [0 600], 'YTick' , [0:100:600]);
                set(AX(2), 'YColor', 'k',...
                    'XLim', [20000*(i-1) 20000*i], 'YLim', [0 600], 'YTick' , [0:100:600]);

                set(H1, 'Color', 'b');  set(H2, 'Color', 'c');
                hold( AX(1) ,'on') %　ゼロクロスしないタイミングを描画
                    for j= 1: length(IndexNonZeroCross)
                        zeroCrossTime = user.zeroCrossData.zeroCrossTime(IndexNonZeroCross(j) );
                        plot([zeroCrossTime zeroCrossTime],[0 600], 'Color' , [.7 .7 .7] , 'LineStyle', ':');
                    end
                    if ~isempty(  findstr( char( obj.config.examType ) , '線追従'))
                        for j=1:length(swTiming)
                            plot( [swTiming(j) swTiming(j)],[0 1000], 'Color' , [.7 0 0] , 'LineStyle', ':');
                        end
                    end
                hold off
                legend( [H1, H2], '周期の差', '振幅の差' );                
                xlabel('時間');
                ylabel(AX(1) , '操作周期の差');     ylabel(AX(2) , '操作振幅の差');

%%          　ゼロクロス周期・振幅
                subplot(r_fig,1,6)
                [AX,H1,H2] = plotyy(   user.zeroCrossData.zeroCrossTime, period_zx(:,2),...
                                        user.zeroCrossData.zeroCrossTime, peak_zx(:,2));
                set(AX(1), 'YColor', 'k',...
                    'XLim', [20000*(i-1) 20000*i], 'YLim', [0 600], 'YTick' , [0:100:600]);
                set(AX(2), 'YColor', 'k',...
                    'XLim', [20000*(i-1) 20000*i], 'YLim', [0 600], 'YTick' , [0:100:600]);

                set(H1, 'Color', 'b');  set(H2, 'Color', 'c');
                hold( AX(1) ,'on') %　ゼロクロスしないタイミングを描画
                    for j= 1: length(IndexNonZeroCross)
                        zeroCrossTime = user.zeroCrossData.zeroCrossTime(IndexNonZeroCross(j) );
                        plot([zeroCrossTime zeroCrossTime],[0 600], 'Color' , [.7 .7 .7] , 'LineStyle', ':');
                    end
                    if ~isempty(  findstr( char( obj.config.examType ) , '線追従'))
                        for j=1:length(swTiming)
                            plot( [swTiming(j) swTiming(j)],[0 1000], 'Color' , [.7 0 0] , 'LineStyle', ':');
                        end
                    end
                hold off
                legend( [H1, H2], '周期', '振幅' );                
                xlabel('時間');
                ylabel(AX(1) , '操作周期');     ylabel(AX(2) , '操作振幅');
               
                obj.saveGraphWithName(num2str(i));
                               
           end
        end

        function runForPair(obj,user1,user2)
%             [period_zx1, peak_zx1] = Rhythm.setZeroCrossPeriodData(user1.zeroCrossData);
%             [period_zx2, peak_zx2] = Rhythm.setZeroCrossPeriodData(user2.zeroCrossData);
%             filterdPul1 = Rhythm.BPfilter( user1.operatePulse.lowSampled);
%             filterdPul2 = Rhythm.BPfilter( user2.operatePulse.lowSampled);
%             [timeCorr, AB_Series0, AB_Series_Max] = Rhythm.AllCorr__func(filterdPul1, filterdPul2, user2.time.lowSampled, 100);
% 
%             MonitorSize = [ 0, 0, 1400, 1000];
%             set(gcf, 'Position', MonitorSize);
%            for i = 1:3
%                 if obj.config.isExistPlayer1
%                     legName1 = char(obj.config.player1UserName);
%                 elseif obj.config.filenameForArchive
%                     legName1 = 'アーカイブ';
%                 end
%                 if obj.config.isExistPlayer2
%                     legName2 = char(obj.config.player2UserName);
%                 elseif obj.config.filenameForArchive
%                     legName2 = 'アーカイブ';
%                 end               
%                 r_fig = 5;
%                 subplot(r_fig,1,1);
%                 plot(   user1.time.lowSampled,  user1.avatarPosition.lowSampled,'b');               
%                 hold on
%                 plot(   user2.time.lowSampled,  user2.avatarPosition.lowSampled,'Color', [0 .498 0] );               
%                 hold off
%                 legend(legName1, legName2 ,'Location','NorthEastOutside');
%                 xlabel('時間t ms'); ylabel('アバタ位置');
%                 xlim([20000*(i-1) 20000*i]);    ylim([0 1000]);
%                 
%                 subplot(r_fig,1,2)
%                 [haxes,hline1,hlineC] = plotyy( user1.time.lowSampled, filterdPul1,  timeCorr, AB_Series_Max(:,2));
%                 set(hline1,'Color','b');
%                 set(hlineC,'Color','r');
%                 set(haxes(1),'YColor','k');
%                 set(haxes(2),'YColor','r');
%                 
%                 hold( haxes(1),'on') % 重ね書きモードオン
%                 hline2 = plot(   haxes(1), user2.time.lowSampled,  filterdPul2 ,'Color', [0 .498 0] );   
% %                 plot(   haxes(1), user1.time.highSampled,  user1.operatePulse.highSampled ,'b:');
% %                 plot(   haxes(1), user2.time.highSampled,  user2.operatePulse.highSampled ,'LineStyle',':','Color', [0 .498 0]);
% 
%                 hold( haxes(2),'on') % 重ね書きモードオン
%                 plot( haxes(2),[0 60000], [0.8 0.8],'k:');
%                 hold off
% 
%                 legend( [hline1,hline2], legName1, legName2 ,'Location','NorthEastOutside');
%                 
%                 axes(haxes(1))
%                 xlabel('時間t ms'); ylabel('コントローラ操作');
%                 xlim([20000*(i-1) 20000*i]);    ylim([-400 400]);
%                 set(gca,'YTick',[-400:200:400]);
% 
%                 axes(haxes(2))
%                 xlabel('時間t ms'); ylabel('最大相互相関');
%                 xlim([20000*(i-1) 20000*i]);    ylim([0 1]);
%                 set(gca,'YTick',[0:0.2:1]);
%     
%                 subplot(r_fig,1,3)
%                 plot(   user1.time.highSampled,  user1.avatarVelocity.highSampled ,'b' );               
%                 hold on
%                 plot(   user2.time.highSampled,  user2.avatarVelocity.highSampled,'Color', [0 .498 0] );               
%                 hold off
%                 legend(legName1, legName2 ,'Location','NorthEastOutside');
%                 xlabel('時間t ms'); ylabel('アバタ速度');
%                 xlim([20000*(i-1) 20000*i]);    ylim([-0.5 0.5]);
%                 grid on;
%                 set(gca,'YTick',[-0.5:0.1:0.5]);
% 
%                 subplot(r_fig,1,4)
%                 plot(   user1.zeroCrossData.zeroCrossTime, period_zx1(:,2),'b');
%                 hold on
%                 plot(   user2.zeroCrossData.zeroCrossTime, period_zx2(:,2),'Color', [0 .498 0] );               
%                 hold off
%                 legend(legName1, legName2 ,'Location','NorthEastOutside');
%                 xlabel('時間'); ylabel('操作周期（1周期）');
%                 xlim([20000*(i-1) 20000*i]);          ylim([0 600]);
%                 
%                 subplot(r_fig,1,5)
%                 plot( user1.zeroCrossData.zeroCrossTime, peak_zx1(:,2),'b');
%                 hold on
%                 plot(   user2.zeroCrossData.zeroCrossTime, peak_zx2(:,2),'Color', [0 .498 0] );               
%                 hold off
%                 legend(legName1, legName2 ,'Location','NorthEastOutside');
%                 xlabel('時間'); ylabel('操作振幅の和');
%                 xlim([20000*(i-1) 20000*i]);             ylim([0 600]);
%                 
%                 obj.saveGraphWithName(num2str(i));
%                 
%             end
        end

    end
end
