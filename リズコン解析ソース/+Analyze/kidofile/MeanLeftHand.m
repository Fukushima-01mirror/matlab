classdef MeanLeftHand < Analyze.Base
%STANDARDDEVIATION このクラスの概要をここに記述
%   詳細説明をここに記述

   properties
   end

   methods
       function obj = MeanLeftHand(config,data)           
            obj = obj@Analyze.Base(config,data);
       end
       
       
       function runForAlone(obj,user)
            weight = user.adBoard.leftHand.weight();
            meanValues = zeros(1);
            %右手　体　頭　xyz
            meanValues(1,1) = mean(weight );
            
            
            obj.outputAllToXls(meanValues,{'weight'});
       end
       
       
       
   end
end 
