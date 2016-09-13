classdef GravityCenterAndBody < Analyze.Base
    %PRECURSOR このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = GravityCenterAndBody(config,data)
            obj = obj@Analyze.Base(config,data);

        end


       function runForAlone(obj,user)
           
           pos = user.adBoard.bodyGravityCenter();
              
            subplot(2,1,1);
            AX =  plotyy(  user.opti.body.time,user.opti.body.position.x, ...
                 user.adBoard.time, pos.x);
            set(get(AX(1),'Ylabel'),'String','body');
            set(get(AX(2),'Ylabel'),'String','bodyGravityCenter');
            title('x');
              
            subplot(2,1,2);
            AX =  plotyy(  user.opti.body.time, user.opti.body.position.z,...
                 user.adBoard.time, pos.z);
            set(get(AX(1),'Ylabel'),'String','body');
            set(get(AX(2),'Ylabel'),'String','bodyGravityCenter');
            title('z');
            
            
            obj.saveGraph();
        end

    end
end
