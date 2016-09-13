classdef LeftHandGravityCenter < Analyze.Base
    %PRECURSOR ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q

    properties
    end

    methods
        function obj = LeftHandGravityCenter(config,data)
            obj = obj@Analyze.Base(config,data);

        end


       function runForAlone(obj,user)
           
           pos = user.adBoard.leftHand.gravityCenter();
            subplot(2,1,1);
             plot(user.adBoard.time, pos.x);
            title('x');
              
            subplot(2,1,2);
             plot( user.adBoard.time, pos.z);
            title('z');
            
            
            obj.saveGraph();
        end

    end
end
