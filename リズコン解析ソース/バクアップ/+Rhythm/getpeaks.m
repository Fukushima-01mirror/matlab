function[locs] = getpeaks(y)
%input  obj ←　user.zeroCrossData
% output    ゼロクロス間ピーク回数

dy = diff(y)

