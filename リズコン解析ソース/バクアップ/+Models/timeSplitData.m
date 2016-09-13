function [obj_ts] = timeSplitData(obj)

[n_match, m ] = size( obj.player1.splitTime);
for k =  1: n_match  
    t_st = obj.player1.splitTime(k,1);
    t_end = obj.player1.splitTime(k,2);
    
    %%
    obj_ts(k,1).splitTimeInfo.index = k;
    obj_ts(k,1).splitTimeInfo.examTime = t_end - t_st + 1;
    if obj.player1.splitTime(k,3) == 1
        obj_ts(k,1).splitTimeInfo.state = '1PWIN';
    elseif obj.player1.splitTime(k,3) == 2
        obj_ts(k,1).splitTimeInfo.state = '2PWIN';
    elseif obj.player1.splitTime(k,3) == 0
        obj_ts(k,1).splitTimeInfo.state = 'DRAW';
    end
        
    
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

    obj_ts(k,1).player1.avatarSword ...
    = obj.player1.avatarSword ;

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
    obj_ts(k,1).player2.time.highSampled = [t_st:t_end]';
    obj_ts(k,1).player2.time.lowSampled = [t_st:20:t_end]';
    
    obj_ts(k,1).player2.operatePulse.highSampled ...
        = obj.player2.operatePulse.highSampled( obj_ts(k,1).player2.time.highSampled );
    obj_ts(k,1).player2.operatePulse.lowSampled ...
        = obj.player2.operatePulse.lowSampled( obj_ts(k,1).player2.time.lowSampled./20 );
    
    obj_ts(k,1).player2.avatarPosition.highSampled ...
        = obj.player2.avatarPosition.highSampled(obj_ts(k,1).player2.time.highSampled);
    obj_ts(k,1).player2.avatarPosition.lowSampled ...
        = obj.player2.avatarPosition.lowSampled(obj_ts(k,1).player2.time.lowSampled./20);
    obj_ts(k,1).player2.avatarPosition.error ...
        = obj.player2.avatarPosition.error(k,1) ;
    
    obj_ts(k,1).player2.avatarSword ...
    = obj.player2.avatarSword ;

    obj_ts(k,1).player2.avatarVelocity.highSampled ...
        = obj.player2.avatarVelocity.highSampled(obj_ts(k,1).player2.time.highSampled);

    zcIndex = find( obj.player2.zeroCrossData.zeroCrossTime > t_st ...
        & obj.player2.zeroCrossData.zeroCrossTime < t_end);
    
    obj_ts(k,1).player2.zeroCrossData.zeroCrossTime ...
        = obj.player2.zeroCrossData.zeroCrossTime( zcIndex );
    obj_ts(k,1).player2.zeroCrossData.area ...
        = obj.player2.zeroCrossData.area ( zcIndex );
    obj_ts(k,1).player2.zeroCrossData.avtVelocity ...
        = obj.player2.zeroCrossData.avtVelocity ( zcIndex );
    obj_ts(k,1).player2.zeroCrossData.nonlogAvtVelocity ...
        = obj.player2.zeroCrossData.nonlogAvtVelocity ( zcIndex );
    obj_ts(k,1).player2.zeroCrossData.peak ...
        = obj.player2.zeroCrossData.peak ( zcIndex );
    

    
end
