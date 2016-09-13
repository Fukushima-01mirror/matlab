classdef Weight < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = Weight(config,data)
            obj = obj@Analyze.Base(config,data);
        end


       function runForAlone(obj,user)
            titles = {'weight','weight std'};
             
            weightValue = zeros(1,2);
            weight = user.adBoard.leftHand.weight() + user.adBoard.seat.weight() + user.adBoard.foot.weight();
            weightValue(1,1) = mean(weight);
            weightValue(1,2) = std(weight);
            obj.outputAllToXls(weightValue,titles);
           
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
