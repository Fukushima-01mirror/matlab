classdef PeakPeriodCorrelationGraph < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = PeakPeriodCorrelationGraph(config,data)
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

            r_fig = 3;      c_fig = 3;      
            period_zx_n0 = period_zx(3:end-1,:);
            period_zx_n1 = period_zx(4:end,:);
            peak_zx_n0 = peak_zx(3:end-1,:);
            peak_zx_n1 = peak_zx(4:end,:);

            subplot(r_fig,c_fig,1);
            plot( abs( peak_zx_n0(:,1) )  , abs( period_zx_n1(:,1) ) ,'*');
            xlabel('ピーク値（半周期）n-1'); ylabel('操作波形 半周期 n');
            xlim([0,600]);            ylim([0,600]); 
  
            subplot(r_fig,c_fig,2);
            plot( abs( period_zx_n0(:,1) )  , abs( peak_zx_n1(:,1) ) ,'*');
            xlabel('操作波形 半周期 n-1'); ylabel('ピーク値（半周期）n');
            xlim([0,600]);            ylim([0,600]); 
 
            subplot(r_fig,c_fig,3);
            plot(  abs( peak_zx( zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2,1) )  ,abs( period_zx( zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2,1) ),'*');
            hold on
                plot( abs( peak_zx(zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1,1) )  ,abs( period_zx(zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1,1) ),'o');
            hold off
            xlabel('ピーク値（半周期）n'); ylabel('操作波形 半周期 n');
            xlim([0,600]);            ylim([0,600]);

            
            subplot(r_fig,c_fig,4);
            plot( peak_zx_n0(:,2)  , period_zx_n1(:,2) ,'*');
            xlabel('振幅(1周期) n-1'); ylabel('操作波形 1周期 n');
            xlim([0,800]);             ylim([0,800]);
  
            subplot(r_fig,c_fig,5);
            plot( period_zx_n0(:,2)  , peak_zx_n1(:,2) ,'*');
            xlabel('操作波形 1周期 n-1'); ylabel('振幅(1周期) n');
            xlim([0,800]);             ylim([0,800]);
 
            subplot(r_fig,c_fig,6);
            plot(  abs( peak_zx( zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2,2) )  ,abs( period_zx( zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2,2) ),'*');
            hold on
                plot( abs( peak_zx(zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1,2) )  ,abs( period_zx(zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1,2) ),'o');
            hold off
            xlabel('振幅(1周期) n'); ylabel('操作波形 1周期 n');
            xlim([0,800]);            ylim([0,800]);
            
            
            subplot(r_fig,c_fig,7);
            plot( peak_zx_n0(:,3)  , period_zx_n1(:,3) ,'*');
            xlabel('振幅の差 n-1'); ylabel('周期の差 n');
            xlim([0,600]);             ylim([0,600]);
  
            subplot(r_fig,c_fig,8);
            plot( period_zx_n0(:,3)  , peak_zx_n1(:,3) ,'*');
            xlabel('周期の差 n-1'); ylabel('振幅の差 n');
            xlim([0,800]);             ylim([0,600]);
 
            subplot(r_fig,c_fig,9);
            plot(  abs( peak_zx( zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2,3) )  ,abs( period_zx( zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2,3) ),'*');
            hold on
                plot( abs( peak_zx(zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1,3) )  ,abs( period_zx(zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1,3) ),'o');
            hold off
            xlabel('振幅の差 n'); ylabel('周期の差 n');
            xlim([0,600]);            ylim([0,600]);

            
            MonitorSize = [ 0, 0, 1000, 1000];
            set(gcf, 'Position', MonitorSize);
            
            obj.saveGraph();
        end
        
%         function runForPair(obj.user1, obj.user2)
%             
%         end

        
    end
end
