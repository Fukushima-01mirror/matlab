

main_path = 'C:\Users\cell\Desktop\リズコン解析ソース\MotorControl\DATA';
player = 'kimura';                    %%
setPoint= 200;                         %%
% cond = '_Kp0.5_Kd0.5_Km-PID(0.2_0.05_0)';      %%
% cond = '_Kp0.5_Kd0.5_Km0';                       %%
cond = 'Follower_Kp0.5_Kd0.5_Km-PID(0.2_0.05_0)';      %%
% cond = '_Follower_Km-10';
Date = '0202_2215';
% Date = datestr( now, 'mmdd_HHMM');

%%

load( [main_path '\' player '\' Date ,cond '_sp' num2str(setPoint) ,'.mat'], ...
    'ZCycle_A_T_Fcontrol' , 'dataZcycle' , 'appData');

%% アバタ速度，周期，振幅，ゼロクロスミス分析
index_Pul =1;
% index_V =2;     index_dT =3;     index_dA=4;    index_T =5;     index_A =6;
data_zct = ts2zct_set( dataZcycle );
time = dataZcycle.time * 1000;  %ms
timeLength = time(end);
% t = [0: timeLength-1];

Pul_ts = dataZcycle.signals(index_Pul).values;
contParam = ZCycle_A_T_Fcontrol.signals(3).values;

% Pul_ts = dataZcycle.signals.values(:,index_Pul);
% Pul = interp1(time, Pul_ts , t');

%%
data = appData.mbed;
data0 = appData.data0;
if data0(1,1) ~= 20
    data0(1,:)=[];
end

avt0 = horzcat(data0(:,1),data0(:,2));

%コントローラ波形
tempPul = zeros(60000,1);
for i = 2:60000
    tempPul(i) = data(i,2)+tempPul(i-1);
end
% ゼロクロス変動
PulsesCP = 0;
zcPos = PulsesCP * ones( 60000,1 );

[Pul, avt_data, cycleData, avtCalcError] = rhythmAvt1_cpShift_cycle_data_func(tempPul, avt0, zcPos, -200, 7500);


%%
[ period_zc, peak_zc , zcTimes] = cycleDataFunc(Pul, cycleData );
    
t_st = 10000;
time_zc = cycleData(:,1);
Y = abs( cycleData(:,3) );    dT = abs( period_zc(:,3) );    dA = abs( peak_zc(:,3) );
IndexZeroCross = find(  zcTimes(:,1)<2 & zcTimes(:,2)<2  &  time_zc  > t_st  );
IndexNonZeroCross = find( zcTimes(:,1)>1 | zcTimes(:,2)>1 &  time_zc  >  t_st );
Y_zc  = Y(IndexZeroCross);        Y_nzc  = Y(IndexNonZeroCross);
dT_zc = dT(IndexZeroCross,:);     dT_nzc = dT(IndexNonZeroCross,:);
dA_zc = dA(IndexZeroCross,:);     dA_nzc = dA(IndexNonZeroCross,:);
t_zc =time_zc(IndexZeroCross);    t_nzc = time_zc(IndexNonZeroCross);

Nzc= length(IndexZeroCross);    Nnzc= length(IndexNonZeroCross);


t = 1:60000;
[ Peak ,loc ] = findpeaks(Pul);
[ Peak_rt ,loc_rt ] = findpeaks(Pul_ts);

plot( t, Pul , time , Pul_ts);



%%
%PWMデューティー比　計算
K = 0.5*ones(60000,1);
C = 0.5*ones(60000,1);
M = 
PwmDuty
PwmDuty_k
PwmDuty_c
PwmDuty_m











