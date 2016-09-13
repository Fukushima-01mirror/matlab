classdef ZeroCrossDataCorrelationPairGraph < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = ZeroCrossDataCorrelationPairGraph(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        
        function runForPair(obj,user1,user2)
            [period_zx1, peak_zx1] = Rhythm.setZeroCrossPeriodData(user1.zeroCrossData);
            
            if obj.config.isExistPlayer1
                titleName1 = strcat(obj.config.player1UserName, ' アバタ速度‐操作　相関図');
            elseif obj.config.filenameForArchive
                titleName1 = [ 'アーカイブデータ　アバタ速度‐操作　相関図'];
            end
            
            if obj.config.isExistPlayer2
                titleName2 = strcat(obj.config.player2UserName, ' アバタ速度‐操作　相関図');
            elseif obj.config.filenameForArchive
                titleName2 = [ 'アーカイブデータ　アバタ速度‐操作　相関図'];
            end
            
            [period_zx2, peak_zx2] = Rhythm.setZeroCrossPeriodData(user2.zeroCrossData);
            r_fig = 3;  c_fig = 2;

            subplot(r_fig,c_fig,1);
            plot(  period_zx1(10:end,2)  ,abs( user1.zeroCrossData.nonlogAvtVelocity(10:end) ),'*');
            xlabel('ゼロクロス点間隔(1周期)'); ylabel('対数演算前アバタ速さ');
            xlim([0,800]);         ylim([0 50000]);
            title( titleName1 );

            subplot(r_fig,c_fig,3);
            plot(  abs( period_zx1(10:end,3) ) ,abs( user1.zeroCrossData.nonlogAvtVelocity(10:end) ),'*');
            xlabel('ゼロクロス点間隔の差（半周期）'); ylabel('対数演算前アバタ速さ');
            xlim([0,800]);         ylim([0 50000]);            
            
            subplot(r_fig,c_fig,5);
            plot(  abs(peak_zx1(10:end,3) )  ,abs( user1.zeroCrossData.nonlogAvtVelocity(10:end) ),'*');
            xlabel('ピーク値の差'); ylabel('対数演算前アバタ速さ');
            xlim([0,400]);            ylim([0 50000]);
 
            
            subplot(r_fig,c_fig,2);
            plot( abs( period_zx2(10:end,2) )  ,abs( user2.zeroCrossData.nonlogAvtVelocity(10:end) ),'*');
            xlabel('ゼロクロス点間隔(1周期)'); ylabel('対数演算前アバタ速さ');
            xlim([0,800]);         ylim([0 50000]);
            title( titleName2 );
 
            subplot(r_fig,c_fig,4);
            plot(  abs( period_zx2(10:end,3) )  ,abs( user2.zeroCrossData.nonlogAvtVelocity(10:end) ),'*');
            xlabel('ゼロクロス点間隔の差（半周期）'); ylabel('対数演算前アバタ速さ');
            xlim([0,800]);         ylim([0 50000]);            
            
            subplot(r_fig,c_fig,6);
            plot(  abs(peak_zx2(10:end,3))  ,abs( user2.zeroCrossData.nonlogAvtVelocity(10:end) ),'*');
            xlabel('ピーク値の差'); ylabel('対数演算前アバタ速さ');
            xlim([0,400]);            ylim([0 50000]);
            MonitorSize = [ 0, 0, 900, 1200];
            set(gcf, 'Position', MonitorSize);
            obj.saveGraph();
        end

    end
end
