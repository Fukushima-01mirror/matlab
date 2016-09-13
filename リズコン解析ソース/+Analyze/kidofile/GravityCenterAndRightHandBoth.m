classdef GravityCenterAndRightHandBoth < Analyze.Base
    %PRECURSOR このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = GravityCenterAndRightHandBoth(config,data)
            obj = obj@Analyze.Base(config,data);

        end


       function run(obj)
           
            mpos = obj.data.master.adBoard.bodyGravityCenter();
            mpos.x = mpos.x - mean(mpos.x);
            mpos.z = mpos.z - mean(mpos.z);

            spos = obj.data.slave.adBoard.bodyGravityCenter();
            spos.x = spos.x - mean(spos.x);
            spos.z = spos.z - mean(spos.z);

            mdpos = obj.data.master.device.getOptiPosition();
            sdpos = obj.data.slave.device.getOptiPosition();



            subplot(2,1,1);
            AX = plotyy( obj.data.master.device.time, mdpos.x,...
                obj.data.master.adBoard.time, mpos.x);
            axes(AX(1));hold on;
            axes(AX(2));hold on;
            plot(AX(1),  obj.data.slave.device.time, sdpos.x, ':', 'Color', 'b');
            plot(AX(2),  obj.data.slave.adBoard.time, spos.x, ':', 'Color', [0 0.5 0]);
            set(get(AX(1),'Ylabel'),'String','rightHand(device)');
            set(get(AX(2),'Ylabel'),'String','bodyGravityCenter');
            ylim(AX(1),[-0.2 0.2]);
            ylim(AX(2),[-100 100]);
            title('x');
            axes(AX(1));hold off;
            axes(AX(2));hold off;


            subplot(2,1,2);
            AX = plotyy( obj.data.master.device.time, mdpos.z,...
                obj.data.master.adBoard.time, mpos.z);

            axes(AX(1));hold on;
            axes(AX(2));hold on;
            plot(AX(1),  obj.data.slave.device.time, sdpos.z, ':', 'Color', 'b');
            plot(AX(2),  obj.data.slave.adBoard.time, spos.z, ':', 'Color', [0 0.5 0]);
            set(get(AX(1),'Ylabel'),'String','rightHand(device)');
            set(get(AX(2),'Ylabel'),'String','bodyGravityCenter');
            ylim(AX(1),[-0.2 0.2]);
            ylim(AX(2),[-100 100]);
            title('z');

            axes(AX(1));hold off;
            axes(AX(2));hold off;


            obj.saveGraph();
        end

    end
end
