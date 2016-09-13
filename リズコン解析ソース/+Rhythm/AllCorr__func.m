function [time_corr, AB_Series0, AB_Series_Max] = AllCorr__func(A, B, Time, t_width)
% 相互相関の絶対値の最大値　　→　　同相，逆相のどちらも

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
StartTime = Time(1);
dt = (EndTime-StartTime)/lengthTime;    % dt=20

%%
%時間データの作成
time_corr = StartTime+t_width/2:dt:EndTime-t_width/2;
time_corr = time_corr';
%width_corr = -t_width:dt:t_width;
width = floor(t_width/dt);%:幅t=3s       % width=5
% width=30;
% disp(lengthTime);
t0 = width + 1;%時間ズレなしのときのインデックス

%%
%AB_Series = zeros(length(time_corr),2*width+1);
AB_Series_Max = zeros(length(time_corr),2);
AB_Series0 = zeros(length(time_corr),1);

for tt = 1:lengthTime-width    
    AB = xcorr(B(tt:tt+width,1), A(tt:tt+width,1),'coeff');
    %AB_Series(tt,:) = AB;
%     disp(AB);
    [AB_Max, MaxIndex] = max(abs(AB));          %相関の絶対値の最大値　　逆位相の同期も含む
     AB_Series_Max(tt,1) = dt * (MaxIndex-t0);  %ズレ時間
     AB_Series_Max(tt,2) = AB_Max;              %相互相関最大値
     AB_Series0(tt,1) = AB(t0,1);              %時間ズレなしの時の相互相関
end
