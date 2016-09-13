classdef WeightGraph < Analyze.Base
    %PRECURSOR ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q

    properties
    end

    methods
        function obj = WeightGraph(config,data)
            obj = obj@Analyze.Base(config,data);

        end


       function runForAlone(obj,user)
            weight = user.adBoard.weight();
            subplot(3,1,1);
            plot(    user.adBoard.time, weight.leftHand);
            title('leftHand');
              
            subplot(3,1,2);
             plot(  user.adBoard.time, weight.seat);
            title('seat');
              
            subplot(3,1,3);
            plot(   user.adBoard.time, weight.foot);
            title('foot');
            
            
            obj.saveGraph();
        end

    end
end
