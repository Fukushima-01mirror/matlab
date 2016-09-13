function [obj_ts] = timeSplit_inHalf(obj)

 k =  1;
    t_st = 0;
    t_end =30000;
    
    %%
    
    obj_ts(k,1).player1.time.highSampled = [t_st:t_end]';
    obj_ts(k,1).player1.time.lowSampled = [t_st:20:t_end]';
    
    obj_ts(k,1).player1.operatePulse.highSampled ...
        = obj.player1.operatePulse.highSampled( obj_ts(k,1).player1.time.highSampled );
    obj_ts(k,1).player1.operatePulse.lowSampled ...
        = obj.player1.operatePulse.lowSampled( obj_ts(k,1).player1.time.lowSampled./20 );
    
    obj_ts(k,1).player1.avatarPosition.highSampled ...
        = obj.player1.avatarPosition.highSampled(obj_ts(k,1).player1.time.highSampled);
    obj_ts(k,1).player1.avatarPosition.lowSampled ...
        = obj.player1.avatarPosition.lowSampled(obj_ts(k,1).player1.time.lowSampled./20);
    obj_ts(k,1).player1.avatarPosition.error ...
        = obj.player1.avatarPosition.error(k,1) ;
    
    obj_ts(k,1).player1.avatarVelocity.highSampled ...
        = obj.player1.avatarVelocity.highSampled(obj_ts(k,1).player1.time.highSampled);

    zcIndex = find( obj.player1.zeroCrossData.zeroCrossTime > t_st ...
        & obj.player1.zeroCrossData.zeroCrossTime < t_end);
    
    obj_ts(k,1).player1.zeroCrossData.zeroCrossTime ...
        = obj.player1.zeroCrossData.zeroCrossTime( zcIndex );
    obj_ts(k,1).player1.zeroCrossData.area ...
        = obj.player1.zeroCrossData.area ( zcIndex );
    obj_ts(k,1).player1.zeroCrossData.avtVelocity ...
        = obj.player1.zeroCrossData.avtVelocity ( zcIndex );
    obj_ts(k,1).player1.zeroCrossData.nonlogAvtVelocity ...
        = obj.player1.zeroCrossData.nonlogAvtVelocity ( zcIndex );
    obj_ts(k,1).player1.zeroCrossData.peak ...
        = obj.player1.zeroCrossData.peak ( zcIndex );
    
%%
 k =  2;
    t_st = 30000;
    t_end = 60000;
    
    %%
    
    obj_ts(k,1).player1.time.highSampled = [t_st:t_end]';
    obj_ts(k,1).player1.time.lowSampled = [t_st:20:t_end]';
    
    obj_ts(k,1).player1.operatePulse.highSampled ...
        = obj.player1.operatePulse.highSampled( obj_ts(k,1).player1.time.highSampled );
    obj_ts(k,1).player1.operatePulse.lowSampled ...
        = obj.player1.operatePulse.lowSampled( obj_ts(k,1).player1.time.lowSampled./20 );
    
    obj_ts(k,1).player1.avatarPosition.highSampled ...
        = obj.player1.avatarPosition.highSampled(obj_ts(k,1).player1.time.highSampled);
    obj_ts(k,1).player1.avatarPosition.lowSampled ...
        = obj.player1.avatarPosition.lowSampled(obj_ts(k,1).player1.time.lowSampled./20);
    obj_ts(k,1).player1.avatarPosition.error ...
        = obj.player1.avatarPosition.error(k,1) ;
    
    obj_ts(k,1).player1.avatarVelocity.highSampled ...
        = obj.player1.avatarVelocity.highSampled(obj_ts(k,1).player1.time.highSampled);

    zcIndex = find( obj.player1.zeroCrossData.zeroCrossTime > t_st ...
        & obj.player1.zeroCrossData.zeroCrossTime < t_end);
    
    obj_ts(k,1).player1.zeroCrossData.zeroCrossTime ...
        = obj.player1.zeroCrossData.zeroCrossTime( zcIndex );
    obj_ts(k,1).player1.zeroCrossData.area ...
        = obj.player1.zeroCrossData.area ( zcIndex );
    obj_ts(k,1).player1.zeroCrossData.avtVelocity ...
        = obj.player1.zeroCrossData.avtVelocity ( zcIndex );
    obj_ts(k,1).player1.zeroCrossData.nonlogAvtVelocity ...
        = obj.player1.zeroCrossData.nonlogAvtVelocity ( zcIndex );
    obj_ts(k,1).player1.zeroCrossData.peak ...
        = obj.player1.zeroCrossData.peak ( zcIndex );
    

    
    
end
