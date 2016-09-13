classdef LeftHandGravityWeightAndDeviceRightHand < Analyze.Base
    %PRECURSOR ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q

    properties
    end

    methods
        function obj = LeftHandGravityWeightAndDeviceRightHand(config,data)
            obj = obj@Analyze.Base(config,data);

        end


       function runForAlone(obj,user)
           
           pos = user.adBoard.leftHand.gravityCenter();
           pos.x = pos.x - mean(pos.x);
           pos.z = pos.z - mean(pos.z);
           deviceRightHand = user.device.getOptiPosition();
            subplot(3,1,1);
             plot(  user.device.time, deviceRightHand.x);
            %legend('rightHand(device)', 'leftHandGravityCenter');
            ylim([-0.2 0.2]);
            xlabel('����[s]');
            ylabel('�ʒu[m]');
            
            title('x');
              
            subplot(3,1,2);
            plot(  user.device.time, deviceRightHand.z); 
            ylim([-0.2 0.2]);
            xlabel('����[s]');
            ylabel('�ʒu[m]');
            
            title('z');
            
            subplot(3,1,3);
            plot(user.adBoard.leftHand.time,user.adBoard.leftHand.weight() / 1000);
            ylim([0 5]);
            xlabel('����[s]');
            ylabel('�׏d[kg]');
            title('weight');
            
            obj.saveGraph();
        end

    end
end
