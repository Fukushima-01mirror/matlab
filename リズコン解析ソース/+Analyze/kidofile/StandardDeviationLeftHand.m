classdef StandardDeviationLeftHand < Analyze.Base
%STANDARDDEVIATION ���̃N���X�̊T�v�������ɋL�q
%   �ڍא����������ɋL�q

   properties
   end

   methods
       function obj = StandardDeviationLeftHand(config,data)           
            obj = obj@Analyze.Base(config,data);
       end
       
       
       function runForAlone(obj,user)
            weight = user.adBoard.leftHand.weight();
            stdValues = zeros(1);
            %�E��@�́@���@xyz
            stdValues(1,1) = std(weight );
            
            
            obj.outputAllToXls(stdValues,{'weight'});
       end
       
       
       
   end
end 
