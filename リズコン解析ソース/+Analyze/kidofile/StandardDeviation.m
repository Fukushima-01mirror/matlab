classdef StandardDeviation < Analyze.Base
%STANDARDDEVIATION このクラスの概要をここに記述
%   詳細説明をここに記述

   properties
   end

   methods
       function obj = StandardDeviation(config,data)           
            obj = obj@Analyze.Base(config,data);
       end
       
       
       function runForAlone(obj,user)
            opti = user.opti;
            stdValues = zeros(1,3);
            %右手　体　頭　xyz
            stdValues(1,1) = std( opti.body.position.x );
            stdValues(1,2) = std( opti.body.position.y );
            stdValues(1,3) = std( opti.body.position.z );
            
            stdValues(1,4) = std( opti.head.position.x );
            stdValues(1,5) = std( opti.head.position.y );
            stdValues(1,6) = std( opti.head.position.z );
            
            
            stdValues(1,7) = std( opti.rightHand.position.x );
            stdValues(1,8) = std( opti.rightHand.position.y );
            stdValues(1,9) = std( opti.rightHand.position.z );
            
            
            obj.outputAllToXls(stdValues,{'bodyX','bodyY','bodyZ','headX','headY','headZ','rightHandX','rightHandY','rightHandZ'});
       end
       
       
       
   end
end 
