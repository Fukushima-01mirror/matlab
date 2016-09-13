classdef DeviceGraph < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = DeviceGraph(config,data)
            obj = obj@Analyze.Base(config,data);
        end


      function runForAlone(obj,user)
            
            for i= 2:5
                subplot(4,1,i-1);
                plot(   user.device.time,  user.device.getData(i));               
                title(user.device.propertyNames(i));
            end
            obj.saveGraph();
        end
       
        

    end
end
