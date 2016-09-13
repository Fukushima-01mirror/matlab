classdef ZeroCrossDataCorrelationGraph_ex < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = ZeroCrossDataCorrelationGraph_ex(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
            [period_zx, peak_zx] = Rhythm.setZeroCrossPeriodData(user.zeroCrossData);
            
            k=2;
            zeroCrossTimes = zeros(1,2);
            % ゼロクロス間のピーク回数　C1:波形の前半部のピーク回数　C2:後半部のピーク回数
            zeroCrossTimes(1,1) = length( user.zeroCrossData.peak(1).time );
            for i = 2 : length(user.zeroCrossData.peak)
                zeroCrossTimes(k,1) = length( user.zeroCrossData.peak(i).time );
                zeroCrossTimes(k,2) = length( user.zeroCrossData.peak(i-1).time );
                k = k+1;
            end

            r_fig = 3;      c_fig = 2;      
            subplot(r_fig,c_fig,1);
            plot( period_zx( zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2,1)  ,abs( user.zeroCrossData.nonlogAvtVelocity(zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2) ),'*');
            hold on
                plot( period_zx(zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1,1)  ,abs( user.zeroCrossData.nonlogAvtVelocity(zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1) ),'o');
            hold off
            xlabel('ゼロクロス点間隔（半周期）'); ylabel('対数演算前アバタ速さ');
            xlim([0,600]);         ylim([0 50000]);

            subplot(r_fig,c_fig,3);
            plot(  period_zx( zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2,2)  ,abs( user.zeroCrossData.nonlogAvtVelocity( zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2) ),'*');
            hold on
                plot( period_zx(zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1,2)  ,abs( user.zeroCrossData.nonlogAvtVelocity(zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1) ),'o');
            hold off
            xlabel('ゼロクロス点間隔(1周期)'); ylabel('対数演算前アバタ速さ');
            xlim([0,800]);         ylim([0 50000]);

            subplot(r_fig,c_fig,5);
            plot(  abs( period_zx( zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2,3) )  ,abs( user.zeroCrossData.nonlogAvtVelocity( zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2) ),'*');
            hold on
                plot( period_zx(zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1,3)  ,abs( user.zeroCrossData.nonlogAvtVelocity(zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1) ),'o');
            hold off
            xlabel('ゼロクロス点間隔の差（半周期）'); ylabel('対数演算前アバタ速さ');
            xlim([0,800]);         ylim([0 50000]);


            
            subplot(r_fig,c_fig,2);
            plot(  peak_zx( zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2,1)  ,abs( user.zeroCrossData.nonlogAvtVelocity( zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2) ),'*');
            hold on
                plot( peak_zx(zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1,1)  ,abs( user.zeroCrossData.nonlogAvtVelocity(zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1) ),'o');
            hold off
            xlabel('ピーク値（半周期）'); ylabel('対数演算前アバタ速さ');
            xlim([0,500]);            ylim([0 50000]);
  
            subplot(r_fig,c_fig,4);
            plot(  peak_zx( zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2,2)  ,abs( user.zeroCrossData.nonlogAvtVelocity( zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2) ),'*');
            hold on
                plot( peak_zx(zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1,2)  ,abs( user.zeroCrossData.nonlogAvtVelocity(zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1) ),'o');
            hold off
            xlabel('振幅(1周期)'); ylabel('対数演算前アバタ速さ');
            xlim([0,800]);             ylim([0 50000]);
 
            subplot(r_fig,c_fig,6);
            plot(  abs( peak_zx( zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2,3) )  ,abs( user.zeroCrossData.nonlogAvtVelocity( zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2) ),'*');
            hold on
                plot( peak_zx(zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1,3)  ,abs( user.zeroCrossData.nonlogAvtVelocity(zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1) ),'o');
            hold off
            xlabel('ピーク値の差'); ylabel('対数演算前アバタ速さ');
            xlim([0,400]);            ylim([0 50000]);

            MonitorSize = [ 0, 0, 800, 1000];
            set(gcf, 'Position', MonitorSize);
            obj.saveGraph();
        end

    end
end
