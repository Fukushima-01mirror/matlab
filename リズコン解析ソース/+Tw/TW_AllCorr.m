function [time_corr, AB_Series0, AB_Series_Max] = TW_AllCorr(A, B, Time, t_width)

SizeA = size(A);
SizeB = size(B);

if SizeA(1,1)<SizeA(1,2)
    A = A';
end

if SizeB(1,1)<SizeB(1,2)
    B = B';
end

lengthTime = length(Time);
SizeTime = size(Time);

if SizeTime(1,1)>SizeTime(1,2)
    EndTime = Time(end,1);
    StartTime = Time(1,1);
else    
    EndTime = Time(1,end);
    StartTime = Time(1,1);
end

dt = (EndTime-StartTime)/lengthTime;

%%
% 相互相関全体に対して
normalized_A = A-mean(A);
normalized_B = B-mean(B);

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
    AB = xcorr(normalized_B(tt:tt+width,1),normalized_A(tt:tt+width,1),'coeff');
    %AB_Series(tt,:) = AB;
 
    [AB_Max, MaxIndex] = max(AB);
     AB_Series_Max(tt,1) = dt * (MaxIndex-t0);
     AB_Series_Max(tt,2) = AB_Max;
     AB_Series0(tt,1) = AB(t0,1);
end
