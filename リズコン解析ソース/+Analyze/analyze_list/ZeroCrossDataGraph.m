classdef ZeroCrossDataGraph < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = ZeroCrossDataGraph(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
            [period_zx, peak_zx] = Rhythm.setZeroCrossPeriodData(user.zeroCrossData);
            r_fig = 6;      c_fig = 1;
            
            subplot(r_fig,c_fig,1);
            plot( user.zeroCrossData.zeroCrossTime, period_zx(:,1));
            xlabel('時間'); ylabel('操作周期（半周期）');
            xlim([0,60000]);         ylim([0 500]);

            subplot(r_fig,c_fig,2);
            plot(   user.zeroCrossData.zeroCrossTime, period_zx(:,2));
            xlabel('時間'); ylabel('操作周期（1周期）');
            xlim([0,60000]);          ylim([0 600]);

            subplot(r_fig,c_fig,3);
            plot(  user.zeroCrossData.zeroCrossTime,   period_zx(:,3));
            xlabel('時間'); ylabel('操作周期の差');
            xlim([0,60000]);          ylim([-300 300]);


            
            subplot(r_fig,c_fig,4);
            plot( user.zeroCrossData.zeroCrossTime, peak_zx(:,1));
            xlabel('時間'); ylabel('操作振幅（半周期のピーク値）');
            xlim([0,60000]);            ylim([-300 300]);
  
            subplot(r_fig,c_fig,5);
            plot( user.zeroCrossData.zeroCrossTime, peak_zx(:,2));
            xlabel('時間'); ylabel('操作振幅の和');
            xlim([0,60000]);             ylim([0 600]);
 
            subplot(r_fig,c_fig,6);
            plot( user.zeroCrossData.zeroCrossTime, peak_zx(:,3));
            xlabel('時間'); ylabel('操作振幅の差');
            xlim([0,60000]);            ylim([-300 300]);

            MonitorSize = [ 0, 0, 1280, 1000];
            set(gcf, 'Position', MonitorSize);
            obj.saveGraph();
        end

    end
end
