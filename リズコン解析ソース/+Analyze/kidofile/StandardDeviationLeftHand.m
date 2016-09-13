classdef StandardDeviationLeftHand < Analyze.Base
%STANDARDDEVIATION このクラスの概要をここに記述
%   詳細説明をここに記述

   properties
   end

   methods
       function obj = StandardDeviationLeftHand(config,data)           
            obj = obj@Analyze.Base(config,data);
       end
       
       
       function runForAlone(obj,user)
            weight = user.adBoard.leftHand.weight();
            stdValues = zeros(1);
            %右手　体　頭　xyz
            stdValues(1,1) = std(weight );
            
            
            obj.outputAllToXls(stdValues,{'weight'});
       end
       
       
       
   end
end 
