classdef AvatarPositionGraph < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = AvatarPositionGraph(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
            fill( [5000 5000 30000 30000] , [0 1000 1000 0] , [0.9 0.9 0.9], 'FaceAlpha', 0.8 ,'LineStyle' , 'none');
            hold on
            fill( [35000 35000 60000 60000] , [ 0 1000 1000 0 ] , [0.9 0.9 0.9], 'FaceAlpha', 0.8 , 'LineStyle' , 'none');
                plot(   user.time.lowSampled,  user.avatarPosition.lowSampled ,'b');               
                plot(   obj.data.com.time ,  obj.data.com.avatarPosition , 'r' );               
                plot(   obj.data.com2.time ,  obj.data.com2.avatarPosition, 'r' );               
            hold off
            title('avatarPosition');
            xlabel('時間t ms'); ylabel('アバタ位置');
            xlim([0,60000]);    ylim([0 1000]);
            MonitorSize = [ 0, 0, 700, 250];
            set(gcf, 'Position', MonitorSize);
            obj.saveGraph();
        end

        function runForPair(obj,user1,user2)
%             plot(   user1.time.lowSampled,  user1.avatarPosition.lowSampled...
%                 ,user2.time.lowSampled,  user2.avatarPosition.lowSampled);               
%             title('avatarPosition');
%             legend('Player1', 'Player2');
%             xlabel('時間t ms'); ylabel('アバタ位置');
%             xlim([0,60000]);    ylim([0 1000]);
%             MonitorSize = [ 0, 0, 700, 250];
%             set(gcf, 'Position', MonitorSize);
%             obj.saveGraph();
        end

    end
end
