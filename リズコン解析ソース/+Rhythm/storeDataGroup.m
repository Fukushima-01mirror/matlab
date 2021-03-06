function [ dataGroup ] = storeDataGroup(dataGroup, obj, stTime, endTime , column)
%

    timeIndex_LSample = find( obj.time.lowSampled >= stTime...
                     & obj.time.lowSampled <= endTime ) ;
    timeIndex_HSample = find( obj.time.highSampled >= stTime...
                     & obj.time.highSampled <= endTime ) ;
                 
    dataGroup.time.highSampled(:,column) = [0:1:endTime-stTime]';
    dataGroup.avatarVelocity.highSampled(:,column) =  obj.avatarVelocity.highSampled( timeIndex_HSample );
    dataGroup.avatarPosition.highSampled(:,column) =  obj.avatarPosition.highSampled( timeIndex_HSample );
    dataGroup.operatePulse.highSampled(:,column) =  obj.operatePulse.highSampled( timeIndex_HSample );

    [period_zx, peak_zx] = Rhythm.setZeroCrossPeriodData(obj.zeroCrossData);
    [zcPeakCount] = Rhythm.setZeroCrossCount(obj.zeroCrossData);
    zcIndex = find( obj.zeroCrossData.zeroCrossTime >= stTime...
                     & obj.zeroCrossData.zeroCrossTime <= endTime ) ;
    dataGroup.zeroCrossData(column,1).time = obj.zeroCrossData.zeroCrossTime(zcIndex);
    dataGroup.zeroCrossData(column,1).period = period_zx(zcIndex,:);
    dataGroup.zeroCrossData(column,1).peak = peak_zx(zcIndex,:);
    dataGroup.zeroCrossData(column,1).avtVelocity = obj.zeroCrossData.avtVelocity(zcIndex);
    dataGroup.zeroCrossData(column,1).nonlogAvtVelocity ...
                        = obj.zeroCrossData.nonlogAvtVelocity(zcIndex);
    dataGroup.zeroCrossData(column,1).zcPeakCount = zcPeakCount(zcIndex,:);
           

end
