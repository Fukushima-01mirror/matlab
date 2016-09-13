classdef DeviceOptiRawGraph < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = DeviceOptiRawGraph(config,data)
            obj = obj@Analyze.Base(config,data);
        end


        function runForAlone(obj,user)
            pos = user.device.getOptiPositionRaw();
            opti.x = user.opti.rightHand.raw.position.x;
            opti.z = user.opti.rightHand.raw.position.z;
            opti.x = opti.x - mean(opti.x);
            opti.z = opti.z - mean(opti.z);


            subplot(2,1,1);
            plot(   user.device.raw.time, pos.x , ...
                user.opti.rightHand.raw.time, opti.x );
            legend('device','opti')
            title('x');


            subplot(2,1,2);
            plot(   user.device.raw.time, pos.z , ...
                user.opti.rightHand.raw.time,  opti.z );
            legend('device','opti')
            title('z');
            obj.saveGraph();
        end



    end
end
