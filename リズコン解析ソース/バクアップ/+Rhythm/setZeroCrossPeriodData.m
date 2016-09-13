function[period_zx, peak_zx] = setZeroCrossPeriodData(obj)
%input  obj ←　user.zeroCrossData

% output    period_zx   ゼロクロス時間間隔   周期　周期の差
%           peak_zx     ピーク値   振幅　ピーク値の差


% ゼロクロス点間隔
period_zx(1,1) = 0;     %半周期 
for i= 2 : length(obj.zeroCrossTime)
    period_zx(i,1) =  obj.zeroCrossTime(i) - obj.zeroCrossTime(i-1);
end

period_zx(1:2,2) = 0;       %1周期(ゼロクロス時間間隔の和)
period_zx(1:2,3) = 0;       %周期(ゼロクロス時間間隔の差) 
for i= 3 : length(obj.zeroCrossTime)
    period_zx(i,2) =  period_zx(i,1) + period_zx(i-1,1);
    period_zx(i,3) =  period_zx(i,1) - period_zx(i-1,1);
end


% ピーク値
peak_zx(1,1) = 0;
for i=2:length(obj.peak)
    if mean( obj.peak(i).value ) > 0
        peak_zx(i,1) = max( obj.peak(i).value );
    else
        peak_zx(i,1) = min( obj.peak(i).value );
    end
end

peak_zx(1:2,2) = 0;        % 振幅（正のみ）
peak_zx(1:2,3) = 0;        % ピーク値の差
for i= 3 : length(obj.peak)
    peak_zx(i,2) =  abs( peak_zx(i-1,1) ) + abs( peak_zx(i,1) ) ;
    peak_zx(i,3) =  abs( peak_zx(i-1,1) ) - abs( peak_zx(i,1) ) ;
end

