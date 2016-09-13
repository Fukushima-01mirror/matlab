classdef GravityCenterAndRightHand < Analyze.Base
    %PRECURSOR このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = GravityCenterAndRightHand(config,data)
            obj = obj@Analyze.Base(config,data);

        end


       function runForAlone(obj,user)
           
            pos = user.adBoard.bodyGravityCenter();
            devicePos = user.device.getOptiPosition();
            
            pos.x = pos.x- mean(pos.x);
            pos.z = pos.z- mean(pos.z);
            devicePos.x = devicePos.x- mean(devicePos.x);
            devicePos.z = devicePos.z- mean(devicePos.z);
            
            subplot(2,1,1);
            AX =  plotyy(  user.device.time, devicePos.x,...
                 user.adBoard.time, pos.x);
           %  legend('rightHand(device)', 'bodyGravityCenter');
            set(get(AX(1),'Ylabel'),'String','rightHand(device)') ;
            set(get(AX(2),'Ylabel'),'String','bodyGravityCenter') ;
            ylim(AX(1),[-0.2 0.2]);
            ylim(AX(2),[-100 100]);
           
            title('x');
              
            subplot(2,1,2);
            AX =  plotyy(  user.device.time, devicePos.z,...
                 user.adBoard.time, pos.z);
            % legend('rightHand(device)', 'bodyGravityCenter');
            set(get(AX(1),'Ylabel'),'String','rightHand(device)') ;
            set(get(AX(2),'Ylabel'),'String','bodyGravityCenter') ;
            ylim(AX(1),[-0.2 0.2]);
            ylim(AX(2),[-100 100]);
            title('z');
            
            
            obj.saveGraph();
        end

    end
end
