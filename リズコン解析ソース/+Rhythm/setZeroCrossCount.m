function[zeroCrossTimes] = setZeroCrossCount(obj)
%input  obj ←　user.zeroCrossData
% output    ゼロクロス間ピーク回数


%　ゼロクロス間でのピーク回数取得
zeroCrossTimes = zeros(1,2);   %　C1:波形の前半部のピーク回数　C2:後半部のピーク回数
zeroCrossTimes(1,1) = length( obj.peak(1).time );
for i = 2:length( obj.peak )
   zeroCrossTimes(i,1) = length( obj.peak(i).time );
   zeroCrossTimes(i,2) = length( obj.peak(i-1).time );
end

