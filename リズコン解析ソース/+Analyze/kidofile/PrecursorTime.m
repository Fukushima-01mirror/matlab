classdef PrecursorTime < Analyze.Base
    %STANDARDDEVIATION ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q

    properties
    end

    methods
        function obj = PrecursorTime(config,data)
            obj = obj@Analyze.Base(config,data);
        end


        function runForAlone(obj,user)
             opti = user.opti;
            opti.useLowpassFilter(0.01, 0.15);
            
            [TimeOutI,PrecursorTimeI,TimeOut,PrecursorTime] = Tw.TW_PrecursorTime( ...
                opti.rightHand.position.x, ...
                opti.body.position.x, ...
                opti.body.time, ...
                1);

            obj.saveGraphWithName('x');
            clf;
            result = zeros(1,3);
            result(1,1) = mean(PrecursorTime);
            result(1,2) = std(PrecursorTime);
            result(1,3) = sum(PrecursorTimeI>0) / length(PrecursorTimeI);
            
            
            [TimeOutI,PrecursorTimeI,TimeOut,PrecursorTime] = Tw.TW_PrecursorTime( ...
                opti.rightHand.position.z, ...
                opti.body.position.z, ...
                opti.body.time, ...
                1);
            obj.saveGraphWithName('z');
            clf;
            result(1,5) = mean(PrecursorTime);
            result(1,6) = std(PrecursorTime);
            result(1,7) = sum(PrecursorTimeI>0) / length(PrecursorTimeI);


            obj.outputAllToXls(result,{'�O�㕽��','�O��W���΍�','�O�㎞�ԗ�','','���E����','���E�W���΍�','���E���ԗ�'});
        end



    end
end
