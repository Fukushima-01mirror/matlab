classdef LeftHandWeightAndDeviceRightHandGraph < Analyze.Base
    %PRECURSOR このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = LeftHandWeightAndDeviceRightHandGraph(config,data)
            obj = obj@Analyze.Base(config,data);

        end


       function run(obj)

            obj.data.useLowpassFilter(0.01, 0.15);
            time = obj.data.master.adBoard.time;
            leftHandPosM = obj.data.master.adBoard.leftHand.gravityCenter();
            devicePosM = obj.data.master.device.getOptiPosition();
            leftHandPosS = obj.data.slave.adBoard.leftHand.gravityCenter();
            devicePosS = obj.data.slave.device.getOptiPosition();
            weightM = obj.data.master.adBoard.leftHand.weight()/1000;
            weightS = obj.data.slave.adBoard.leftHand.weight()/1000;
           
            setup = 0:floor(length(leftHandPosM.x)/2);
            
            leftHandPosM.x = (leftHandPosM.x - mean(leftHandPosM.x(1:3000))) / 1000;
            leftHandPosM.z = (leftHandPosM.z - mean(leftHandPosM.z(1:3000))) / 1000;
            leftHandPosS.x = (leftHandPosS.x - mean(leftHandPosS.x(1:3000))) / 1000;
            leftHandPosS.z = (leftHandPosS.z - mean(leftHandPosS.z(1:3000))) / 1000;
            
            
           subplot(5,1,1);
            plot(time,devicePosM.z, 'red', time, devicePosS.z, 'blue');
            legend('西先生','柳沢さん',-1);
            title('右手の位置-前後方向');
            ylim([-0.2 0.2]);
            xlabel('時間[s]');
            ylabel('位置[m]');
            
            
            
           subplot(5,1,2);
            plot(time,leftHandPosM.z, 'red', time, leftHandPosS.z, 'blue');
            legend('西先生','柳沢さん',-1);
            title('左手COP-前後方向');
            ylim([-0.04 0.04]);
            xlabel('時間[s]');
            ylabel('位置[m]');
            
            
            
           subplot(5,1,3);
            plot(time,devicePosM.x, 'red', time, devicePosS.x, 'blue');
            legend('西先生','柳沢さん',-1);
            title('右手の位置-左右方向');
            ylim([-0.2 0.2]);
            xlabel('時間[s]');
            ylabel('位置[m]');
            
            
            
           subplot(5,1,4);
            plot(time,leftHandPosM.x, 'red', time, leftHandPosS.x, 'blue');
            legend('西先生','柳沢さん',-1);
            title('左手COP-左右方向');
            ylim([-0.04 0.04]);
            xlabel('時間[s]');
            ylabel('位置[m]');
            
            
           subplot(5,1,5);
            plot(time,weightM, 'red', time, weightS, 'blue');
            legend('西先生','柳沢さん',-1);
            title('左手荷重');
            xlabel('時間[s]');
            ylabel('荷重[kg]');
            ylim([0 4]);
            
            obj.saveGraph();
        end

    end
end
