classdef MeanLeftHand < Analyze.Base
%STANDARDDEVIATION ���̃N���X�̊T�v�������ɋL�q
%   �ڍא����������ɋL�q

   properties
   end

   methods
       function obj = MeanLeftHand(config,data)           
            obj = obj@Analyze.Base(config,data);
       end
       
       
       function runForAlone(obj,user)
            weight = user.adBoard.leftHand.weight();
            meanValues = zeros(1);
            %�E��@�́@���@xyz
            meanValues(1,1) = mean(weight );
            
            
            obj.outputAllToXls(meanValues,{'weight'});
       end
       
       
       
   end
end 
