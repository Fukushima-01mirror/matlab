classdef PrecursorTimeAdBoardBoth < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = PrecursorTimeAdBoardBoth(config,data)
            obj = obj@Analyze.Base(config,data);
        end


        function run(obj)
            result = zeros(1,2);

            obj.data.useLowpassFilter(0.01, 0.15);
            bodyPosM = obj.data.master.adBoard.bodyGravityCenter();
            devicePosM = obj.data.master.device.getOptiPosition();
            bodyPosS = obj.data.slave.adBoard.bodyGravityCenter();
            devicePosS = obj.data.slave.device.getOptiPosition();

            [TimeOutM,PrecursorTimeM,TimeOutM,PrecursorTimeM] = Tw.TW_PrecursorTime( ...
                devicePosM.x, ...
                bodyPosM.x, ...
                obj.data.master.adBoard.time, ...
                0);

            [TimeOutS,PrecursorTimeS,TimeOutS,PrecursorTimeS] = Tw.TW_PrecursorTime( ...
                devicePosS.x, ...
                bodyPosS.x, ...
                obj.data.slave.adBoard.time, ...
                0);

            timeMin = max([min(TimeOutM) min(TimeOutS)]);
            timeMax = min([max(TimeOutM) max(TimeOutS)]);
            newTime = timeMin:0.01:timeMax;

            newTimedPrecursorTimeIM = interp1(TimeOutM,PrecursorTimeM,newTime);
            newTimedPrecursorTimeIS = interp1(TimeOutS,PrecursorTimeS,newTime);
            result(1,1) = sum(newTimedPrecursorTimeIM>0 & newTimedPrecursorTimeIS>0) / length(newTimedPrecursorTimeIM);




            [TimeOutM,PrecursorTimeM,TimeOutM,PrecursorTimeM] = Tw.TW_PrecursorTime( ...
                devicePosM.z, ...
                bodyPosM.z, ...
                obj.data.master.adBoard.time, ...
                0);

            [TimeOutS,PrecursorTimeS,TimeOutS,PrecursorTimeS] = Tw.TW_PrecursorTime( ...
                devicePosS.z, ...
                bodyPosS.z, ...
                obj.data.slave.adBoard.time, ...
                0);

            timeMin = max([min(TimeOutM) min(TimeOutS)]);
            timeMax = min([max(TimeOutM) max(TimeOutS)]);
            newTime = timeMin:0.01:timeMax;

            newTimedPrecursorTimeIM = interp1(TimeOutM,PrecursorTimeM,newTime);
            newTimedPrecursorTimeIS = interp1(TimeOutS,PrecursorTimeS,newTime);
            result(1,2) = sum(newTimedPrecursorTimeIM>0 & newTimedPrecursorTimeIS>0) / length(newTimedPrecursorTimeIM);




            obj.outputAllToXls(result,{'x rate','z rate'});
        end



    end
end
