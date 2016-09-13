classdef GravityCenterGraph < Analyze.Base
    %PRECURSOR ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q

    properties
    end

    methods
        function obj = GravityCenterGraph(config,data)
            obj = obj@Analyze.Base(config,data);

        end


       function runForAlone(obj,user)
            center = user.adBoard.bodyGravityCenter();
            subplot(2,1,1);
            plot(user.adBoard.time, center.x)
            title('x');
            
            subplot(2,1,2);
            plot(user.adBoard.time, center.z)
            title('z');

            obj.saveGraph();
        end

    end
end
