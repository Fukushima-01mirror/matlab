classdef DeviceToOptiCheck < Analyze.Base
    %STANDARDDEVIATION ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q

    properties
    end

    methods
        function obj = DeviceToOptiCheck(config,data)
            obj = obj@Analyze.Base(config,data);
        end


      function runForAlone(obj,user)
          
          
          pos = user.device.getOptiPosition();
            
            subplot(2,1,1);
            plotyy(   user.device.time, pos.x , ...
                user.device.time, user.device.rotate.x );          
            legend('opti','device')
            title('x');
            
            
            subplot(2,1,2);
            plotyy(   user.device.time, pos.z , ...
                user.device.time, user.device.rotate.z );       
            legend('opti','device')
            title('z');
            obj.saveGraph();
        end
       
        

    end
end
