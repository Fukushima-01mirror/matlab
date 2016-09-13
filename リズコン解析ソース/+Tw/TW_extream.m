function [AV,BV,A,B] = TW_extream(X,Y,TCX)

if length(X) ~= length(Y)
    error('Error!');
end

%列ベクトルに変換
if length(X(1,:)) < length(X(:,1))
    X = X';
end
if length(Y(1,:)) < length(Y(:,1))
    Y = Y';
end

dt =(X(1,end)-X(1,1))/length(X);

%%%%%%%%%%%%位置データにフィルタをかける
% N=1;%フィルタの次数
% Fs=1/dt; %サンプリング周波数
% t=TCX;
% Fc=1/(2*pi*t);
% Wn = Fc/(Fs/2); %カットオフ周波数
% [b,a]= butter(N, Wn);
% fY=filtfilt(b,a,Y);

vel = diff(Y)/dt;

% %%%%%%%%%%%%速度データにフィルタをかける
% N=1;%フィルタの次数
% Fs=1/dt; %サンプリング周波数
% t=TCV;
% Fc=1/(2*pi*t);
% Wn = Fc/(Fs/2); %カットオフ周波数
% [b,a]= butter(N, Wn);
% filtered_vel=filtfilt(b,a,vel);


mA=0;
mB=0;
for I=1:(length(vel)-1)
    if vel(1,I)*vel(1,I+1)<0
         if vel(1,I)>0;
             mA=mA+1;
             A(mA,1)=X(1,I);
             AV(mA,1)=Y(1,I);
         else
             mB=mB+1;
             B(mB,1)=X(1,I);
             BV(mB,1)=Y(1,I);
         end         
    end
end

return;