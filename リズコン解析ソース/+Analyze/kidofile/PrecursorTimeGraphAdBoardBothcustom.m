classdef PrecursorTimeGraphAdBoardBothcustom < Analyze.Base
    %STANDARDDEVIATION ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q

    properties
    end

    methods
        function obj = PrecursorTimeGraphAdBoardBothcustom(config,data)
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

%���[��0��t���� 
PrecedenceGapFlagBoth_s = [0 PrecedenceGapFlagBoth_s 0];
diff_PrecedenceGapFlagBoth_s = diff(PrecedenceGapFlagBoth_s);

StartGapBothIndex_s = find(diff_PrecedenceGapFlagBoth_s>0);%������s���鎞�̎n�܂��Index�D
EndGapBothIndex_s = find(diff_PrecedenceGapFlagBoth_s<0);


StartGapBothTime_s = (StartGapBothIndex_s-1)*dt+newTime(1,1);
EndGapBothTime_s = (EndGapBothIndex_s-1)*dt+newTime(1,1);






















%{
            subplot(2,2,1);
            plot(time,devicePosM.z, 'red', time, devicePosS.z, 'blue');
            ylim([-0.2 0.2]);
            xlim([0 40]);
            xlabel('����[s]');
            ylabel('�ʒu[m]');
            

            subplot(2,2,3);
            plot(time,bodyPosM.z, 'red', time, bodyPosS.z, 'blue');
            ylim([-0.1 0.1]);
            xlim([0 40]);
            xlabel('����[s]');
            ylabel('�ʒu[m]');
%}  
            subplot(1,2,1);
            hold on;
            for I=1:length(StartGapBothTime_s)
                x = [StartGapBothTime_s(1,I) EndGapBothTime_s(1,I) EndGapBothTime_s(1,I) StartGapBothTime_s(1,I)];
                y = [-10 -10 10 10];
                fill(x,y,[0.85 0.85 0.85],'LineStyle','none');
               end
         plot(newTime,PrecursorTimeIM, 'red', ...
                newTime, PrecursorTimeIS, 'blue' ,...
                [min(time) max(time)], [0 0] ,'black');
            ylim([-4 4]);
            xlim([0 40]);
            xlabel('����[s]');
            ylabel('��s����[s]');
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

%���[��0��t���� 
PrecedenceGapFlagBoth_s = [0 PrecedenceGapFlagBoth_s 0];
diff_PrecedenceGapFlagBoth_s = diff(PrecedenceGapFlagBoth_s);

StartGapBothIndex_s = find(diff_PrecedenceGapFlagBoth_s>0);%������s���鎞�̎n�܂��Index�D
EndGapBothIndex_s = find(diff_PrecedenceGapFlagBoth_s<0);


StartGapBothTime_s = (StartGapBothIndex_s-1)*dt+newTime(1,1);
EndGapBothTime_s = (EndGapBothIndex_s-1)*dt+newTime(1,1);

         %{   
            subplot(2,2,2);
            plot(time,devicePosM.x, 'red', time, devicePosS.x, 'blue');
           ylim([-0.2 0.2]);
            xlim([0 40]);
            xlabel('����[s]');
            ylabel('�ʒu[m]');

            subplot(2,2,4);
            plot(time,bodyPosM.x, 'red', time, bodyPosS.x, 'blue');
            ylim([-0.1 0.1]);
            xlim([0 40]);
            xlabel('����[s]');
            ylabel('�ʒu[m]');
%}
            subplot(1,2,2); 
            hold on;
            for I=1:length(StartGapBothTime_s)
                x = [StartGapBothTime_s(1,I) EndGapBothTime_s(1,I) EndGapBothTime_s(1,I) StartGapBothTime_s(1,I)];
                y = [-10 -10 10 10];
                fill(x,y,[0.85 0.85 0.85],'LineStyle','none');
            end
            plot(newTime,PrecursorTimeIM, 'red', ...
                newTime, PrecursorTimeIS, 'blue' ,...
                [min(time) max(time)], [0 0] ,'black');
            ylim([-4 4]);
            xlim([0 40]);
            xlabel('����[s]');
            ylabel('��s����[s]');
            hold off;
            %}
            obj.saveGraph();


        end



    end
end
