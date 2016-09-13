classdef DivideDataAnalysis < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = DivideDataAnalysis(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
            
            % 自動アバタ　切り返しタイミング取得
           [period_zx, peak_zx] = Rhythm.setZeroCrossPeriodData(user.zeroCrossData);
           %　ゼロクロス間でのピーク回数取得
           [zeroCrossTimes] = Rhythm.setZeroCrossCount(user.zeroCrossData);
            
            
            for i= 2:length(obj.data.task.avtActUnit )-1
                zcIndexStart = find( user.zeroCrossData.zeroCrossTime >= obj.data.task.avtActUnit(i,1) ,1 ,'first');
                zcIndexEnd = find( user.zeroCrossData.zeroCrossTime < obj.data.task.avtActUnit(i,2) ,1 ,'last');   
                zcIndex = [zcIndexStart: zcIndexEnd]';
                
                zcTime = user.zeroCrossData.zeroCrossTime(zcIndex);
                zcPeakCount = zeroCrossTimes(zcIndex ,: );
                zcPeriod = abs( period_zx( zcIndex ,: ) );
                zcPeak = abs( peak_zx( zcIndex ,: ) );
                zcVel = abs( user.zeroCrossData.nonlogAvtVelocity(zcIndex) );
                
                tIndexStart = find( obj.data.task.time >= obj.data.task.avtActUnit(i,1) ,1 ,'first');
                tIndexEnd = find( obj.data.task.time < obj.data.task.avtActUnit(i,2) ,1 ,'last');   
                if  std( obj.data.task.otherData(tIndexStart:tIndexEnd ,4) )< 0.01
                    taskMoveMode = mean( obj.data.task.otherData( tIndexStart:tIndexEnd ,4) );
                else
                    taskMoveMode = 0;
                end
                taskMoveMode = round( taskMoveMode*1000 ) /1000;
                
                if ~exist([ cd() '\results\' obj.folderName()],'dir')
                    mkdir([ cd() '\results\' obj.folderName()]);
                end
                savePath = [cd(),'\results\',obj.folderName(),'\', datestr( now, 'yyyymmdd_HH')];
                if ~exist([cd(),'\results\',obj.folderName(),'\', datestr( now, 'yyyymmdd_HH')],'dir' )
                    mkdir( savePath );
                end
                if taskMoveMode == 0
                    if exist([ savePath '\VsinData.mat'] ,'file' )
                        storeData = load([ savePath '\VsinData.mat'] );
                        zcTime = vertcat( storeData.zcTime,  zcTime);
                        zcPeakCount = vertcat( storeData.zcPeakCount,  zcPeakCount);
                        zcPeak = vertcat( storeData.zcPeak,  zcPeak);
                        zcPeriod = vertcat( storeData.zcPeriod,  zcPeriod);
                        zcVel = vertcat( storeData.zcVel,  zcVel);
                    end
                    save([savePath '\VsinData.mat'], ...
                            'zcTime', 'zcPeakCount', 'zcPeak', 'zcPeriod', 'zcVel');
                elseif taskMoveMode ==  0.16
                    if exist([ savePath '\V016Data.mat'] ,'file' )
                        storeData = load([ savePath '\V016Data.mat'] );
                        zcTime = vertcat( storeData.zcTime,  zcTime);
                        zcPeakCount = vertcat( storeData.zcPeakCount,  zcPeakCount);
                        zcPeak = vertcat( storeData.zcPeak,  zcPeak);
                        zcPeriod = vertcat( storeData.zcPeriod,  zcPeriod);
                        zcVel = vertcat( storeData.zcVel,  zcVel);
                    end
                    save([ savePath '\V016Data.mat'], ...
                          'zcTime', 'zcPeakCount', 'zcPeak', 'zcPeriod', 'zcVel');
                elseif taskMoveMode ==  0.20
                    if exist([ savePath '\V020Data.mat'] ,'file' )
                        storeData = load([ savePath '\V020Data.mat'] );
                        zcTime = vertcat( storeData.zcTime,  zcTime);
                        zcPeakCount = vertcat( storeData.zcPeakCount,  zcPeakCount);
                        zcPeak = vertcat( storeData.zcPeak,  zcPeak);
                        zcPeriod = vertcat( storeData.zcPeriod,  zcPeriod);
                        zcVel = vertcat( storeData.zcVel,  zcVel);
                    end
                    save([ savePath '\V020Data.mat'], ...
                            'zcTime', 'zcPeakCount', 'zcPeak', 'zcPeriod', 'zcVel');
                end

            end
            VsinData = load([ savePath '\VsinData.mat'] );
            figure(3);
            zcIndex = find( VsinData.zcPeakCount(:,1)<2 & VsinData.zcPeakCount(:,2)<2);
            nzcIndex = find( VsinData.zcPeakCount(:,1)>1 | VsinData.zcPeakCount(:,2)>1); 
            [fitParam3, X1FIT, X2FIT, YFIT ]  = ...
                Rhythm.approxiSurface(VsinData.zcPeriod(zcIndex,3), VsinData.zcPeak(zcIndex,3), VsinData.zcVel(zcIndex) );
            plot3( VsinData.zcPeriod(zcIndex,3), VsinData.zcPeak(zcIndex,3), VsinData.zcVel(zcIndex), 'Marker','*', 'LineStyle','none');
            hold on
                plot3( VsinData.zcPeriod(nzcIndex,3), VsinData.zcPeak(nzcIndex,3), VsinData.zcVel(nzcIndex), 'Marker','o', 'LineStyle','none');
                mesh(X1FIT,X2FIT,YFIT);
            hold off
            grid on
            xlabel('操作波形 周期の差');  ylabel('操作波形 振幅の差');  zlabel('対数演算前アバタ速さ');
            xlim([0,600]);      ylim([0,600]);         zlim([0 50000]);
            title(['V = (' num2str(fitParam3(1)) ') + (' num2str( fitParam3(2) ) ') * dPeriod + (' num2str( fitParam3(3)) ') * dPeak + (' ...
                num2str(fitParam3(4)) ') * dPeriod*dPeak']);
            axis square
            MonitorSize = [ 0, 0, 800, 800];
            set(gcf, 'Position', MonitorSize);            obj.saveGraphWithName('_difParam');

            
        end

    end
end