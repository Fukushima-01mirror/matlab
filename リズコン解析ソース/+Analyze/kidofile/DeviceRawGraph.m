classdef DeviceRawGraph < Analyze.Base
    %PRECURSOR このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = DeviceRawGraph(config,data)
            obj = obj@Analyze.Base(config,data);

        end


        function runForAlone(obj,user)
            
            subplot(4,1,1);
            plot(    user.device.raw.time, user.device.raw.rotate.x, 'o' );
            title('position x');


            subplot(4,1,2);
            plot(    user.device.raw.time,user.device.raw.rotate.z, 'o' );
            title('position z');
            
            subplot(4,1,3);
            plot(    user.device.raw.time,user.device.raw.force.x, 'o' );
            title('force x');
            
            subplot(4,1,4);
            plot(    user.device.raw.time,user.device.raw.force.z, 'o' );
            title('force z');

            obj.saveGraph();
            
            
            
        end

    end
end
