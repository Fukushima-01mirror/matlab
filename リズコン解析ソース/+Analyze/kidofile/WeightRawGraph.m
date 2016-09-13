classdef WeightRawGraph < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = WeightRawGraph(config,data)
            obj = obj@Analyze.Base(config,data);
        end


      function runForAlone(obj,user)
            
            for i= 1:3
                subplot(3,1,i);
                plot(   user.adBoard.getData(i).time,  user.adBoard.getData(i).rightTop, ...
                        user.adBoard.getData(i).time,  user.adBoard.getData(i).rightBottom, ...
                        user.adBoard.getData(i).time,  user.adBoard.getData(i).leftTop,...
                        user.adBoard.getData(i).time,  user.adBoard.getData(i).leftBottom);
                    legend('rightTop','rightBottom','leftTop','leftBottom')
                title(user.adBoard.propertyNames(i));
            end
            
            
            
            obj.saveGraph();
        end
       
       %{
        function run(obj)
            titles = {'master','master std','slave','slave std'};
            weight = obj.data.adBoard.weight();
             
            weightValue = zeros(1,4);
            weightTmp = weight.master.leftHand + weight.master.seat + weight.master.foot;
            weightValue(1,1) = mean(weightTmp);
            weightValue(1,2) = std(weightTmp);
            
            
            weightTmp = weight.slave.leftHand + weight.slave.seat + weight.slave.foot;
            weightValue(1,3) = mean(weightTmp);
            weightValue(1,4) = std(weightTmp);
            

            obj.outputAllToXls(weightValue,titles);
        end

%}
        

    end
end
