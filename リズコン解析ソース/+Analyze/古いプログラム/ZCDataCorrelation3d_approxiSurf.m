classdef ZCDataCorrelation3d_approxiSurf < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = ZCDataCorrelation3d_approxiSurf(config,data)
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
            
            Y_zc  = abs( user.zeroCrossData.nonlogAvtVelocity(zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2) );
            Y  = abs( user.zeroCrossData.nonlogAvtVelocity );
            
            figure(1);
            X1_zc = period_zx( zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2,1);
            X2_zc = abs( peak_zx( zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2,1) );
            plot3( X1_zc , X2_zc, Y_zc,   'Marker','*', 'LineStyle','none');
            hold on
            plot3( period_zx(zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1,1)  , ...
                abs( peak_zx(zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1,1) ) ,...
                abs( user.zeroCrossData.nonlogAvtVelocity( zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1 ) ), ...
                'Marker','o', 'LineStyle','none');
            hold off
            grid on
            xlabel('操作波形 半周期'); ylabel('操作波形　ピーク値');  zlabel('対数演算前アバタ速さ');
            xlim([0,600]);      ylim([0,600]);         zlim([0 50000]);

            axis square
            MonitorSize = [ 0, 0, 800, 800];
            set(gcf, 'Position', MonitorSize);
            obj.saveGraphWithName('_halfParam');


            figure(2);
            X1_zc = period_zx( zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2,2);
            X2_zc = abs( peak_zx( zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2,2) );
            plot3( X1_zc , X2_zc, Y_zc,   'Marker','*', 'LineStyle','none');
            hold on
            plot3( period_zx(zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1,2)  , ...
                abs( peak_zx(zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1,2) ) ,...
                abs( user.zeroCrossData.nonlogAvtVelocity(zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1) ), ...
                'Marker','o', 'LineStyle','none');
            hold off
            grid on
            xlabel('操作波形 1周期'); ylabel('操作波形 振幅');  zlabel('対数演算前アバタ速さ');
            xlim([0,800]);     ylim([0,800]);   zlim([0 50000]);
            axis square
            MonitorSize = [ 0, 0, 800, 800];
            set(gcf, 'Position', MonitorSize);            obj.saveGraphWithName('_sumParam');


            figure(3);
            X1_zc = abs( period_zx( zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2,3) );
            X2_zc = abs( peak_zx( zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2,3) );
            X1 = abs( period_zx(:,3) );
            X2 = abs( peak_zx( :,3) );
%             input = [ones(size(X1)) X1 X2];
            input = [ones(size(X1)) X1 X2 X1.*X2];
            fitParam = regress(Y,input);
            x1fit = min(X1):10:max(X1);
            x2fit = min(X2):10:max(X2);
            [X1FIT,X2FIT] = meshgrid(x1fit,x2fit);
%             YFIT = fitParam(1) + fitParam(2)*X1FIT + fitParam(3)*X2FIT;
            YFIT = fitParam(1) + fitParam(2)*X1FIT + fitParam(3)*X2FIT + fitParam(4)*X1FIT.*X2FIT;
            
            plot3( X1_zc , X2_zc, Y_zc,   'Marker','*', 'LineStyle','none');
            hold on
            plot3( abs( period_zx(zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1,3) ) , ...
                abs( peak_zx(zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1,3) )  ,...
                abs( user.zeroCrossData.nonlogAvtVelocity(zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1) ), ...
                'Marker','o', 'LineStyle','none');
            mesh(X1FIT,X2FIT,YFIT);
            hold off
            grid on
            xlabel('操作波形 周期の差');  ylabel('操作波形 振幅の差');  zlabel('対数演算前アバタ速さ');
            xlim([0,600]);      ylim([0,600]);         zlim([0 50000]);
            axis square
            MonitorSize = [ 0, 0, 800, 800];
            set(gcf, 'Position', MonitorSize);            obj.saveGraphWithName('_difParam');

        end

    end
end
