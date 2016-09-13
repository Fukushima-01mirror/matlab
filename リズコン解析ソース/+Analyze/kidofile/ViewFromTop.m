classdef ViewFromTop  < Analyze.Base
%STANDARDDEVIATION ���̃N���X�̊T�v�������ɋL�q
%   �ڍא����������ɋL�q

   properties
   end

   methods
       function obj = ViewFromTop(config,data)           
            obj = obj@Analyze.Base(config,data);
       end
       
       
       function runForAlone(obj,user)
            opti = user.opti;
            plot(opti.body.position.z * -1, opti.body.position.x * -1);
            xlabel('z'); 
            ylabel('x');
            obj.saveGraphWithName('body');
            clf;
            
            plot(opti.rightHand.position.z * -1, opti.rightHand.position.x * -1);
            xlabel('z'); 
            ylabel('x');
            obj.saveGraphWithName('rightHand');
            clf
       end
       
       
       
   end
end 
