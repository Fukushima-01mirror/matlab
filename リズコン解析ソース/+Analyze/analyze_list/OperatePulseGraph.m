classdef OperatePulseGraph < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = OperatePulseGraph(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
            for i = 1:6
                subplot(6,1,i)
                plot(   user.time.highSampled,  user.operatePulse.highSampled );               
                xlabel('時間t ms'); ylabel('コントローラ操作');
                xlim([10000*(i-1) 10000*i]);    ylim([-400 400]);
                grid on;
                set(gca,'YTick',[-400:100:400]);
           end
            MonitorSize = [ 0, 0, 1200, 1000];
            set(gcf, 'Position', MonitorSize);
            obj.saveGraph();
        end

        function runForPair(obj,user1,user2)
            for i = 1:6
                subplot(6,1,i)
                hold on
                plot(   user1.time.highSampled,  user1.operatePulse.highSampled ,'b');
                plot(   user2.time.highSampled,  user2.operatePulse.highSampled,'Color', [0 .498 0] );               
                hold off
                legend('Player1', 'Player2','Location','EastOutside');
                xlabel('時間t ms'); ylabel('コントローラ操作');
                xlim([10000*(i-1) 10000*i]);    ylim([-400 400]);
                grid on;
                set(gca,'YTick',[-400:100:400]);
            end
            MonitorSize = [ 0, 0, 1400, 1000];
            set(gcf, 'Position', MonitorSize);
            obj.saveGraph();
        end

    end
end
