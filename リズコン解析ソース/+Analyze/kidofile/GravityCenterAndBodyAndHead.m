classdef GravityCenterAndBodyAndHead < Analyze.Base
    %PRECURSOR このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = GravityCenterAndBodyAndHead(config,data)
            obj = obj@Analyze.Base(config,data);

        end


       function runForAlone(obj,user)
           
           pos = user.adBoard.bodyGravityCenter();
              
            subplot(2,1,1);
             plot(  user.opti.body.time,user.opti.body.position.x, ...
                 user.opti.head.time,user.opti.head.position.x, ...
                 user.adBoard.time, pos.x / 1000);
             legend('body','head', 'bodyGravityCenter');
            title('x');
              
            subplot(2,1,2);
             plot(  user.opti.body.time, user.opti.body.position.z,...
                  user.opti.head.time, user.opti.head.position.z,...
                 user.adBoard.time, pos.z / 1000);
             legend('body','head', 'bodyGravityCenter');
            title('z');
            
            
            obj.saveGraph();
        end

    end
end
