function [ dataGroup ] = storeDataGroup_time(dataGroup, obj, stTime, endTime , column)
%

    timeIndex_LSample = find( obj.time.lowSampled >= stTime...
                     & obj.time.lowSampled <= endTime ) ;
    timeIndex_HSample = find( obj.time.highSampled >= stTime...
                     & obj.time.highSampled <= endTime ) ;
                 
    dataGroup.time.highSampled(:,column) = [0:1:endTime-stTime]';
    dataGroup.avatarVelocity.highSampled(:,column) =  obj.avatarVelocity.highSampled( timeIndex_HSample );
    dataGroup.avatarPosition.highSampled(:,column) =  obj.avatarPosition.highSampled( timeIndex_HSample );
    dataGroup.operatePulse.highSampled(:,column) =  obj.operatePulse.highSampled( timeIndex_HSample );


end
