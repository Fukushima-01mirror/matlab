classdef PrecursorTimeAdBoard < Analyze.Base
    %STANDARDDEVIATION ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q

    properties
    end

    methods
        function obj = PrecursorTimeAdBoard(config,data)
            obj = obj@Analyze.Base(config,data);
        end


        function runForAlone(obj,user)
            user.useLowpassFilter(0.01, 0.15);
            bodyPos = user.adBoard.bodyGravityCenter();
            devicePos = user.device.getOptiPosition();
            
            [TimeOutI,PrecursorTimeI,TimeOut,PrecursorTime] = Tw.TW_PrecursorTime( ...
                devicePos.x, ...
                bodyPos.x, ...
                user.adBoard.time, ...
                1);

            obj.saveGraphWithName('x');
            clf;
            result = zeros(1,3);
            result(1,1) = mean(PrecursorTime);
            result(1,2) = std(PrecursorTime);
            result(1,3) = sum(PrecursorTimeI>0) / length(PrecursorTimeI);
            
            
            [TimeOutI,PrecursorTimeI,TimeOut,PrecursorTime] = Tw.TW_PrecursorTime( ...
                devicePos.z, ...
                bodyPos.z, ...
                user.adBoard.time, ...
                1);
            obj.saveGraphWithName('z');
            clf;
            result(1,5) = mean(PrecursorTime);
            result(1,6) = std(PrecursorTime);
            result(1,7) = sum(PrecursorTimeI>0) / length(PrecursorTimeI);


            obj.outputAllToXls(result,{'x����','x�W���΍�','x���ԗ�','','z����','z�W���΍�','z���ԗ�'});
        end



    end
end
