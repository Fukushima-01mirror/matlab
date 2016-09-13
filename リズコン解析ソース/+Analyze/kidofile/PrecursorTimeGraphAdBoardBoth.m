classdef PrecursorTimeGraphAdBoardBoth < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = PrecursorTimeGraphAdBoardBoth(config,data)
            obj = obj@Analyze.Base(config,data);
        end


        function run(obj)
            result = zeros(1,2);

            obj.data.useLowpassFilter(0.01, 0.15);
            time = obj.data.master.adBoard.time;
            bodyPosM = obj.data.master.adBoard.bodyGravityCenter();
            devicePosM = obj.data.master.device.getOptiPosition();
            bodyPosS = obj.data.slave.adBoard.bodyGravityCenter();
            devicePosS = obj.data.slave.device.getOptiPosition();

            
            bodyPosM.x = (bodyPosM.x - mean(bodyPosM.x)) / 1000;
            bodyPosM.z = (bodyPosM.z - mean(bodyPosM.z)) / 1000;
            bodyPosS.x = (bodyPosS.x - mean(bodyPosS.x)) / 1000;
            bodyPosS.z = (bodyPosS.z - mean(bodyPosS.z)) / 1000;
            
            dt = 0.01;

            [TimeOutIM,PrecursorTimeIM,TimeOutM,PrecursorTimeM] = Tw.TW_PrecursorTime( ...
                devicePosM.x, ...
                bodyPosM.x, ...
                obj.data.master.adBoard.time, ...
                0);

            [TimeOutIS,PrecursorTimeIS,TimeOutS,PrecursorTimeS] = Tw.TW_PrecursorTime( ...
                devicePosS.x, ...
                bodyPosS.x, ...
                obj.data.slave.adBoard.time, ...
                0);

            timeMin = max([min(TimeOutIM) min(TimeOutIS)]);
            timeMax = min([max(TimeOutIM) max(TimeOutIS)]);
            newTime = timeMin:0.01:timeMax;

            PrecursorTimeIM = interp1(TimeOutM,PrecursorTimeM,newTime);
            PrecursorTimeIS = interp1(TimeOutS,PrecursorTimeS,newTime);
           result(1,1) = sum((PrecursorTimeIM>0) & (PrecursorTimeIS>0)) / length(PrecursorTimeIM);



PrecedenceGapFlagBoth_s = (PrecursorTimeIM>0) & (PrecursorTimeIS>0);

%両端に0を付ける 
PrecedenceGapFlagBoth_s = [0 PrecedenceGapFlagBoth_s 0];
diff_PrecedenceGapFlagBoth_s = diff(PrecedenceGapFlagBoth_s);

StartGapBothIndex_s = find(diff_PrecedenceGapFlagBoth_s>0);%両方先行する時の始まりのIndex．
EndGapBothIndex_s = find(diff_PrecedenceGapFlagBoth_s<0);


StartGapBothTime_s = (StartGapBothIndex_s-1)*dt+newTime(1,1);
EndGapBothTime_s = (EndGapBothIndex_s-1)*dt+newTime(1,1);























            subplot(6,1,1);
            plot(time,devicePosM.z, 'red', time, devicePosS.z, 'blue');
            legend('西先生','柳沢さん',-1);
            title('右手の位置-前後方向');
            ylim([-0.2 0.2]);
            xlabel('時間[s]');
            ylabel('位置[m]');
            

            subplot(6,1,2);
            plot(time,bodyPosM.z, 'red', time, bodyPosS.z, 'blue');
            legend('西先生','柳沢さん',-1);
            title('COP-前後方向');
            ylim([-0.1 0.1]);
            xlabel('時間[s]');
            ylabel('位置[m]');

            
            subplot(6,1,3);
            hold on;
            for I=1:length(StartGapBothTime_s)
                x = [StartGapBothTime_s(1,I) EndGapBothTime_s(1,I) EndGapBothTime_s(1,I) StartGapBothTime_s(1,I)];
                y = [-10 -10 10 10];
                fill(x,y,[0.85 0.85 0.85],'LineStyle','none');
               end
         plot(newTime,PrecursorTimeIM, 'red', ...
                newTime, PrecursorTimeIS, 'blue' ,...
                [min(time) max(time)], [0 0] ,'black');
            legend('西先生','柳沢さん',-1);
            title('先行時間-前後方向');
            ylim([-4 4]);
            xlabel('時間[s]');
            ylabel('先行時間[s]');
            hold off;

            
            




            [TimeOutIM,PrecursorTimeIM,TimeOutM,PrecursorTimeM] = Tw.TW_PrecursorTime( ...
                devicePosM.z, ...
                bodyPosM.z, ...
                obj.data.master.adBoard.time, ...
                0);

            [TimeOutIS,PrecursorTimeIS,TimeOutS,PrecursorTimeS] = Tw.TW_PrecursorTime( ...
                devicePosS.z, ...
                bodyPosS.z, ...
                obj.data.slave.adBoard.time, ...
                0);

            timeMin = max([min(TimeOutM) min(TimeOutS)]);
            timeMax = min([max(TimeOutM) max(TimeOutS)]);
            newTime = timeMin:0.01:timeMax;

            PrecursorTimeIM = interp1(TimeOutM,PrecursorTimeM,newTime);
            PrecursorTimeIS = interp1(TimeOutS,PrecursorTimeS,newTime);
            result(1,2) = sum(PrecursorTimeIM>0 & PrecursorTimeIS>0) / length(PrecursorTimeIM);

            
PrecedenceGapFlagBoth_s = PrecursorTimeIM>0 & PrecursorTimeIS>0;

%両端に0を付ける 
PrecedenceGapFlagBoth_s = [0 PrecedenceGapFlagBoth_s 0];
diff_PrecedenceGapFlagBoth_s = diff(PrecedenceGapFlagBoth_s);

StartGapBothIndex_s = find(diff_PrecedenceGapFlagBoth_s>0);%両方先行する時の始まりのIndex．
EndGapBothIndex_s = find(diff_PrecedenceGapFlagBoth_s<0);


StartGapBothTime_s = (StartGapBothIndex_s-1)*dt+newTime(1,1);
EndGapBothTime_s = (EndGapBothIndex_s-1)*dt+newTime(1,1);

            
            subplot(6,1,4);
            plot(time,devicePosM.x, 'red', time, devicePosS.x, 'blue');
            legend('西先生','柳沢さん',-1);
            title('右手の位置-左右方向');
            ylim([-0.2 0.2]);
            xlabel('時間[s]');
            ylabel('位置[m]');

            subplot(6,1,5);
            plot(time,bodyPosM.x, 'red', time, bodyPosS.x, 'blue');
            legend('西先生','柳沢さん',-1);
            title('COP-左右方向');
            ylim([-0.1 0.1]);
            xlabel('時間[s]');
            ylabel('位置[m]');

            subplot(6,1,6); 
            hold on;
            for I=1:length(StartGapBothTime_s)
                x = [StartGapBothTime_s(1,I) EndGapBothTime_s(1,I) EndGapBothTime_s(1,I) StartGapBothTime_s(1,I)];
                y = [-10 -10 10 10];
                fill(x,y,[0.85 0.85 0.85],'LineStyle','none');
            end
            plot(newTime,PrecursorTimeIM, 'red', ...
                newTime, PrecursorTimeIS, 'blue' ,...
                [min(time) max(time)], [0 0] ,'black');
            legend('西先生','柳沢さん',-1);
            title('先行時間-前後方向');
            ylim([-4 4]);
            xlabel('時間[s]');
            ylabel('先行時間[s]');
            hold off;
            
            obj.saveGraph();


        end



    end
end
