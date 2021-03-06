function[y_trend, t_series] = getTrend(y, t , t_width)
%input  obj ←　user.zeroCrossData
% output    ゼロクロス間ピーク回数

t_sampling = round( ( t(end)-t(1) ) / length(t) ) ;
t_series = [t(1)+t_width/2 : t_sampling : t(end)-t_width];
y = zeros(length(t_series));
i =1;
for t_M = t_width: t_sampling : t(end)
    t_m = t_M - t_width +1 ;
    y_trend(i) = mean(y(t_m: t_M));
    i = i+1;
end