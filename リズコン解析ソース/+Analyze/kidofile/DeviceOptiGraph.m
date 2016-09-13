classdef DeviceOptiGraph < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = DeviceOptiGraph(config,data)
            obj = obj@Analyze.Base(config,data);
        end


      function runForAlone(obj,user)
          %{
          sizeX = max(abs(user.device.position.i) / 0.036) + 3000;
          sizeZ = max(abs(user.device.position.l) / 0.036) + 3000;
          for i = 1:length(user.device.time)
              x = floor((user.device.position.i(i)/0.036 + 3000)/10);
              z = floor((user.device.position.l(i)/0.036 + 3000)/10);
              data(x,z) = user.opti.rightHand.position.x(i);
              %data(x,z).z = user.opti.rightHand.position.z(i);
              
          end
          %}
          
          
          pos = user.device.getOptiPosition();
            
            subplot(2,1,1);
            plot(   user.device.time, pos.x , ...
                user.opti.rightHand.time, user.opti.rightHand.position.x );          
            legend('device','opti')
            title('x');
            
            
            subplot(2,1,2);
            plot(   user.device.time, pos.z , ...
                user.opti.rightHand.time, user.opti.rightHand.position.z );          
            legend('device','opti')
            title('z');
            obj.saveGraph();
        end
       
        

    end
end
