classdef LeftHandWeightAndDeviceRightHand < Analyze.Base
    %PRECURSOR ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q

    properties
    end

    methods
        function obj = LeftHandWeightAndDeviceRightHand(config,data)
            obj = obj@Analyze.Base(config,data);

        end


       function runForAlone(obj,user)
            subplot(3,1,1);
            plot(    user.adBoard.leftHand.time, user.adBoard.leftHand.weight());
            title('left hand weight');
              
            subplot(3,1,2);
             plot(  user.device.time, user.device.position.i);
            title('right hand x');
              
            subplot(3,1,3);
             plot(  user.device.time, user.device.position.l);
            title('right hand z');
            
            
            obj.saveGraph();
        end

    end
end
