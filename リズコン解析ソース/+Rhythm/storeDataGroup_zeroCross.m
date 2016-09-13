function [ dataGroup ] = storeDataGroup_zeroCross(dataGroup, obj, stTime, endTime , column)
%

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
