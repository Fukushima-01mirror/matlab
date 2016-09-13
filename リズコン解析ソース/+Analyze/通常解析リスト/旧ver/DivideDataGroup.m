%  線追従　線動作パターンによりデータを分割
%  Excel出力  '開始時間','終了時間','線速度モード','進行方向','操作速度誤差' 

classdef DivideDataGroup < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = DivideDataGroup(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
            
           [period_zx, peak_zx] = Rhythm.setZeroCrossPeriodData(user.zeroCrossData);
           %　ゼロクロス間でのピーク回数取得
           [zeroCrossTimes] = Rhythm.setZeroCrossCount(user.zeroCrossData);
            
            
            for i= 3:length(obj.data.task.avtActUnit )-1
                startTime  = obj.data.task.avtActUnit(i,1);
                endTime = obj.data.task.avtActUnit(i,2);
                zcIndexStart = find( user.zeroCrossData.zeroCrossTime >= startTime ,1 ,'first');
                zcIndexEnd = find( user.zeroCrossData.zeroCrossTime < endTime ,1 ,'last');   
                zcIndex = [zcIndexStart: zcIndexEnd]';
                
                zcTime = user.zeroCrossData.zeroCrossTime(zcIndex);
                zcPeakCount = zeroCrossTimes(zcIndex ,: );
                zcPeriod = abs( period_zx( zcIndex ,: ) );
                zcPeak = abs( peak_zx( zcIndex ,: ) );
                zcVel = abs( user.zeroCrossData.nonlogAvtVelocity(zcIndex) );
                
                tIndexStart = find( obj.data.task.time >= startTime ,1 ,'first');
                tIndexEnd = find( obj.data.task.time < endTime ,1 ,'last');   
                if  std( obj.data.task.otherData(tIndexStart:tIndexEnd ,4) )< 0.01
                    taskMoveMode = mean( obj.data.task.otherData( tIndexStart:tIndexEnd ,4) );
                else
                    taskMoveMode = 0;
                end
                taskMoveMode = round( taskMoveMode*1000 ) /1000;
                
                avtVel_lowSample = downsample( user.avatarVelocity.highSampled , 20 );
                avtVelErrors = avtVel_lowSample - obj.data.task.avatarVelocity ;
                avtVelError =  sqrt( mean(avtVelErrors(tIndexStart:tIndexEnd).^2) ) ;
%                 plot( user.time.lowSampled , avtVel_lowSample  , obj.data.task.time , obj.data.task.avatarVelocity , user.time.lowSampled, avtVelErrors );
%                 hold on
%                 plot([0 60000], [obj.data.task.avtActUnit(i,3)*avtVelError obj.data.task.avtActUnit(i,3)*avtVelError] ,'m');
%                 plot([0 60000],[0 0],'k');
%                 hold off
                xlim([startTime endTime]);  ylim([-0.5 0.5]);

                %%      　エクセルデータ出力  
                outputTitle = {  '開始時間' , '終了時間','線速度モード' , '進行方向','操作速度誤差' };

                output = num2cell( [ startTime endTime taskMoveMode obj.data.task.avtActUnit(i,3) avtVelError]);
                obj.outputAllToXlsWithName('', output , outputTitle);
            end
            
            

            
        end

    end
end