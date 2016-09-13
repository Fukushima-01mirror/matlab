classdef AvatarCaluError < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = AvatarCaluError(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
        end

        function runForPair(obj,user1,user2)
            plot(   user1.time.lowSampled,  user1.avatarPosition.lowSampled...
                ,user2.time.lowSampled,  user2.avatarPosition.lowSampled);               
            if mean( abs( user1.avatarPosition.error ) ) >5 || mean( abs( user2.avatarPosition.error ) ) >5
                hold on
                plot(   user1.time.lowSampled,  user1.avatarPosition.lowSampled , 'b',...
                    user1.time.highSampled,  user1.avatarPosition.highSampled , 'b:');
                plot(   user2.time.lowSampled,  user2.avatarPosition.lowSampled ,'Color', [0 .498 0] );
                plot(   user2.time.highSampled,  user2.avatarPosition.highSampled ,'LineStyle',':','Color', [0 .498 0]);
                hold off
                title(['AvatarCaluError 1P:',num2str( mean( abs( user1.avatarPosition.error ) ) ), ...
                    ' 2P:',num2str( mean( abs( user2.avatarPosition.error ) ) )]);
                xlabel('時間t ms'); ylabel('アバタ位置');
                xlim([0,60000]);    ylim([0 1000]);
                MonitorSize = [ 0, 0, 700, 500];
                set(gcf, 'Position', MonitorSize);
                obj.saveGraph();
            end
        end

    end
end
