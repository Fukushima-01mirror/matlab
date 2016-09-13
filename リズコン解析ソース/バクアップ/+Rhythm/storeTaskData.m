function [ dataGroup ] = storeTaskData(dataGroup, obj, stTime, endTime )
%
    timeIndex = find( obj.time >= stTime & obj.time <= endTime ) ;
                 
    dataGroup.taskTime =  [0:20:endTime-stTime]';
    dataGroup.taskVelocity =  obj.avatarVelocity( timeIndex );
    dataGroup.taskPosition =  obj.avatarPosition( timeIndex );

end
