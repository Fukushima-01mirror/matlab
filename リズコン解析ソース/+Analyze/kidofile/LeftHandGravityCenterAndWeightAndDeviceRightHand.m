classdef LeftHandGravityCenterAndWeightAndDeviceRightHand < Analyze.Base
    %PRECURSOR このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = LeftHandGravityCenterAndWeightAndDeviceRightHand(config,data)
            obj = obj@Analyze.Base(config,data);

        end


       function runForAlone(obj,user)
           
           pos = user.adBoard.leftHand.gravityCenter();
           pos.x = pos.x - mean(pos.x);
           pos.z = pos.z - mean(pos.z);
           deviceRightHand = user.device.getOptiPosition();
            subplot(3,1,1);
            [AX,H1,H2] =  plotyy(  user.device.time, deviceRightHand.x,...
                 user.adBoard.time, pos.x);
            %legend('rightHand(device)', 'leftHandGravityCenter');
            set(get(AX(1),'Ylabel'),'String','rightHand(device)') 
            set(get(AX(2),'Ylabel'),'String','leftHandGravityCenter') 
            ylim(AX(1),[-0.2 0.2]);
            ylim(AX(2),[-40 40]);
            title('x');
              
            subplot(3,1,2);
            [AX,H1,H2] = plotyy(  user.device.time, deviceRightHand.z,...
                 user.adBoard.time, pos.z);
             %legend('rightHand(device)', 'leftHandGravityCenter');
             set(get(AX(1),'Ylabel'),'String','rightHand(device)') 
             set(get(AX(2),'Ylabel'),'String','leftHandGravityCenter') 
            ylim(AX(1),[-0.2 0.2]);
            ylim(AX(2),[-40 40]);
            title('z');
            
            subplot(3,1,3);
            plot(user.adBoard.leftHand.time,user.adBoard.leftHand.weight());
            ylim([0 5000]);
            title('weight');
            
            obj.saveGraph();
        end

    end
end
