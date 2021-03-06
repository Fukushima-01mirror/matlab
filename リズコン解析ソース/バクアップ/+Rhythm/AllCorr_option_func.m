function [time_corr, AB_Series0, AB_Series_Max] = AllCorr_func(A, B, Time, t_width, option)

SizeA = size(A);
SizeB = size(B);

if SizeA(1,1)<SizeA(1,2)
    A = A';
end

if SizeB(1,1)<SizeB(1,2)
    B = B';
end

lengthTime = length(Time);
EndTime = Time(end);
StartTime = 0;
dt = (EndTime-StartTime)/lengthTime;

%%
%時間データの作成
time_corr = StartTime+t_width/2:dt:EndTime-t_width/2;
%width_corr = -t_width:dt:t_width;
width = floor(t_width/dt);%:幅t=3s
t0 = width + 1;%時間ズレなしのときのインデックス


%%
%AB_Series = zeros(length(time_corr),2*width+1);
AB_Series_Max = zeros(length(time_corr),2);
AB_Series0 = zeros(length(time_corr),1);

for tt = 1:lengthTime-width
    AB = xcorr(B(tt:tt+width,1),A(tt:tt+width,1),option);
    %AB_Series(tt,:) = AB;
 
    [AB_Max, MaxIndex] = max(AB);
     AB_Series_Max(tt,1) = dt * (MaxIndex-t0);
     AB_Series_Max(tt,2) = AB_Max;
     AB_Series0(tt,1) = AB(t0,1);
end
