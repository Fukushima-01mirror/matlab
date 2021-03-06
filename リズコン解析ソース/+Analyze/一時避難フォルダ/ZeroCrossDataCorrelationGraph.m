classdef ZeroCrossDataCorrelationGraph < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = ZeroCrossDataCorrelationGraph(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
            [period_zx, peak_zx] = Rhythm.setZeroCrossPeriodData(user.zeroCrossData);
            
            r_fig = 3;      c_fig = 2;      
            subplot(r_fig,c_fig,1);
            plot(  period_zx(10:end,1)  ,abs( user.zeroCrossData.nonlogAvtVelocity(10:end) ),'*');
            xlabel('ゼロクロス点間隔（半周期）'); ylabel('対数演算前アバタ速さ');
            xlim([0,600]);         ylim([0 50000]);

            subplot(r_fig,c_fig,3);
            plot(  period_zx(10:end,2)  ,abs( user.zeroCrossData.nonlogAvtVelocity(10:end) ),'*');
            xlabel('ゼロクロス点間隔(1周期)'); ylabel('対数演算前アバタ速さ');
            xlim([0,800]);         ylim([0 50000]);

            subplot(r_fig,c_fig,5);
            plot(  abs( period_zx(10:end,3) )  ,abs( user.zeroCrossData.nonlogAvtVelocity(10:end) ),'*');
            xlabel('ゼロクロス点間隔の差（半周期）'); ylabel('対数演算前アバタ速さ');
            xlim([0,800]);         ylim([0 50000]);

            

            subplot(r_fig,c_fig,2);
            plot(  peak_zx(10:end,1)  ,abs( user.zeroCrossData.nonlogAvtVelocity(10:end) ),'*');
            xlabel('ピーク値（半周期）'); ylabel('対数演算前アバタ速さ');
            xlim([0,500]);            ylim([0 50000]);
  
            subplot(r_fig,c_fig,4);
            plot(  peak_zx(10:end,2)  ,abs( user.zeroCrossData.nonlogAvtVelocity(10:end) ),'*');
            xlabel('振幅(1周期)'); ylabel('対数演算前アバタ速さ');
            xlim([0,800]);             ylim([0 50000]);
 
            subplot(r_fig,c_fig,6);
            plot(  abs( peak_zx(10:end,3) )  ,abs( user.zeroCrossData.nonlogAvtVelocity(10:end) ),'*');
            xlabel('ピーク値の差'); ylabel('対数演算前アバタ速さ');
            xlim([0,400]);            ylim([0 50000]);

            MonitorSize = [ 0, 0, 800, 1000];
            set(gcf, 'Position', MonitorSize);
            obj.saveGraph();
        end

    end
end
