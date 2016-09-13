classdef xcorrCalib < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = xcorrCalib(config,data)
            obj = obj@Analyze.Base(config,data);
        end


        function runForAlone(obj,user)
            results = zeros(1,4);
            deltaTime = (min(user.device.time) - max(user.device.time))/(length(user.device.time)-1);
            
            device = user.device.getOptiPosition();
            
            xcorrX = xcorr(-device.x , user.opti.rightHand.position.x ,'coeff');
            [C,I]  = max(xcorrX);
            preTimeCount = I - (length(xcorrX)-1)/2 + 1;
            preTime = preTimeCount * deltaTime;
            results(1) = preTime;
            results(2) = C;
            
            subplot(2,1,1);
            plot(user.device.time,-device.x, ...
                user.opti.rightHand.time, user.opti.rightHand.position.x);
            legend('device','opti');
            title('x');
            
            
            
            
            xcorrZ = xcorr(-device.z, user.opti.rightHand.position.z ,'coeff');
            [C,I]  = max(xcorrZ);
            preTimeCount = I - (length(xcorrZ)-1)/2 + 1;
            preTime = preTimeCount * deltaTime;
            results(3) = preTime;
            results(4) = C;
            
            subplot(2,1,2);
            plot(user.device.time,-device.z, ...
                user.opti.rightHand.time, user.opti.rightHand.position.z);
            legend('device','opti');
            title('z');
            
            obj.saveGraph();
            
            obj.outputAllToXls(results,{'x-時間','x-値','z-時間','z-値'});
        end



    end
end
