classdef DeviceGraph < Analyze.Base
    %STANDARDDEVIATION ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q

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
