classdef AvatarDistanceGraph < Analyze.Base
    %STANDARDDEVIATION ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q

    properties
    end

    methods
        function obj = AvatarDistanceGraph(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForPair(obj,user1,user2)
            plot(   user1.time.lowSampled,  user1.avatarPosition.lowSampled,'b:',...
                user2.time.lowSampled,  user2.avatarPosition.lowSampled,'g:',...
                user2.time.lowSampled,  user2.avatarPosition.lowSampled - user1.avatarPosition.lowSampled ,'r');               
            title('avatarDistance');
            xlabel('����t ms'); ylabel('�A�o�^�ԋ���');
            xlim([0,60000]);    ylim([0 1000]);
            MonitorSize = [ 0, 0, 700, 250];
            set(gcf, 'Position', MonitorSize);
            obj.saveGraph();
        end

    end
end
