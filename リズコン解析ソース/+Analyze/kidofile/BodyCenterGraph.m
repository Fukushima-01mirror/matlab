classdef BodyCenterGraph < Analyze.Base
    %PRECURSOR このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = BodyCenterGraph(config,data)
            obj = obj@Analyze.Base(config,data);

        end


     
       function runForAlone(obj,user)
           for i = 1:3
            center = user.adBoard.getData(i).gravityCenter();
            subplot(3,2,i*2 - 1);
            plot(user.adBoard.time, center.x);
            title(char(strcat(user.adBoard.propertyNames(i),' x')));
            
            subplot(3,2,i*2);
            plot(user.adBoard.time, center.z);
            title(char(strcat(user.adBoard.propertyNames(i),' z')));
            
           end
           
            obj.saveGraph();
        end

    end
end
