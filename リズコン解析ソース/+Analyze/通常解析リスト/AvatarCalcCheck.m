classdef AvatarCalcCheck < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = AvatarCalcCheck(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
            

%%           アバタ位置描画
                plot(   user.time.highSampled,  user.avatarPosition.highSampled ,  'b' );         
                hold on 
                  plot(   user.time.lowSampled,  user.avatarPosition.lowSampled ,':r');         
                hold off
                xlabel('時間t ms'); ylabel('アバタ位置');
                xlim([0 60000]);    ylim([0 1000]);

                MonitorSize = [ 0, 0, 1000, 600];
                set(gcf, 'Position', MonitorSize);
                
                if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
                    obj.saveGraphWithName(num2str( obj.data.splitTimeInfo.index ));
                else
                    obj.saveGraph();
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
