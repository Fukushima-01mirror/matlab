classdef StandardDeviationAdBoard < Analyze.Base
%STANDARDDEVIATION このクラスの概要をここに記述
%   詳細説明をここに記述

   properties
   end

   methods
       function obj = StandardDeviationAdBoard(config,data)           
            obj = obj@Analyze.Base(config,data);
       end
       
       
       function runForAlone(obj,user)
            pos = user.adBoard.bodyGravityCenter();
            stdValues = zeros(1,2);
            %右手　体　頭　xyz
            stdValues(1,1) = std( pos.x );
            stdValues(1,2) = std( pos.z );
            
            
            obj.outputAllToXls(stdValues,{'x','z'});
       end
       
       
       
   end
end 
