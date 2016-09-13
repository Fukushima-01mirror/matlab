%%%二人の全身の重心位置（新ADボードにしてから）

%%座面のデータのがおかしいので，周囲のデータから補正(2010.2.19の実験に関して)

time_data = data(:,1);%データの時間抽出

EXAM_PERIOD = 191;

%データ間時間を等間隔に
dt = (time_data(end,1)-time_data(1,1))/length(time_data);
%dt = 0.005;

%%%%%%%%%%%%エンコーダデータの処理
%エンコーダの時間の冒頭の0をカット
m=0;
for I=1:length(time_data)
   if time_data(I,1) == 0;
       m = m + 1;
   else
       break;
   end
end

mtime_data = time_data(m:length(time_data),1);

hoge=0;
hoge2=0;
K=1;
%同じ時間が続いている奴があるかどうかチェック
for I=1:(length(mtime_data)-1)
   if mtime_data(I,1) == mtime_data(I+1,1)
%        hoge=hoge+1;
       while mtime_data(I,1) == mtime_data(I+K,1)
           K = K + 1;
       end
       d_hoge = (mtime_data(I+K,1) - mtime_data(I,1))/K;
       for J = 1:K-1
           mtime_data(I+J,1) = J*d_hoge + mtime_data(I,1);
       end       
   end
end


% %mtime_dataに３つ同じ時間が続いている奴があるとき
% for I=1:(length(mtime_data)-1)
%    if mtime_data(I,1) == mtime_data(I+1,1);
%        hoge = hoge + 1;
%        mtime_data(I+1,1) = 0.5*(mtime_data(I,1)+mtime_data(I+2,1));
%        if mtime_data(I,1) == mtime_data(I+1,1);
%            hoge2=hoge2+1;
%            mtime_data(I+1,1) = (mtime_data(I,1)+mtime_data(I+3,1))/3;
%            mtime_data(I+2,1) = (mtime_data(I,1)+mtime_data(I+3,1))*2/3;    
%        end
%    end
% end

time_s = time_data(1,1):dt:EXAM_PERIOD;

Encoder = data(:,2);
Position = Encoder * (-0.00025);%パルスを位置mに変換
mPosition = Position(m:length(time_data),1);
position_s=spline(mtime_data,mPosition,time_s);%スプライン補完

%フィルタその１（エンコーダおよび力）の作成
N=1;%フィルタの次数
Fs=200; %サンプリング周波数
t=0.015;
Fc=1/(2*pi*t);
Wn = Fc/(Fs/2); %カットオフ周波数
[b,a]= butter(N, Wn);

%速度の算出
dposition = diff(position_s);
vel = dposition/dt;
timeV=time_s(1,1:length(time_s)-1);
filtered_vel=filtfilt(b,a,vel);%速度データにフィルタをかける

%位置が極値をとる際の各値の算出
nMax=0;%極大値カウント
nMin=0;%極小値カウント

for I=1:(length(timeV)-1)
    if filtered_vel(1,I)*filtered_vel(1,I+1)<0
         if filtered_vel(1,I)>0;
             nMax=nMax+1;
             Kyoku_timeMax(nMax,1)=timeV(1,I);
             KyokuMax(nMax,1) = position_s(1,I);
         else
             nMin=nMin+1;
             Kyoku_timeMin(nMin,1)=timeV(1,I);
             KyokuMin(nMin,1) = position_s(1,I);
         end         
    end
end


%
%周期の算出その１（半周期重複型）
%

%手の動きのピーク間時間を算出しこれを周期とした。
diff_Kyoku_timeMax = diff(Kyoku_timeMax);
diff_Kyoku_timeMin = diff(Kyoku_timeMin);

for I = 1:length(diff_Kyoku_timeMax)
    time_diff_Kyoku_timeMax(I,1) = Kyoku_timeMax(I,1)+0.5*diff_Kyoku_timeMax(I,1);%極大値間の真ん中の時間
end
for I = 1:length(diff_Kyoku_timeMin)
    time_diff_Kyoku_timeMin(I,1) = Kyoku_timeMin(I,1)+0.5*diff_Kyoku_timeMin(I,1);%極小値間の真ん中の時間
end

pre_diff_Kyoku_time = [diff_Kyoku_timeMax;diff_Kyoku_timeMin];
pre_time_diff_Kyoku_time = [time_diff_Kyoku_timeMax; time_diff_Kyoku_timeMin];
[time_diff_Kyoku_time, IndexTDK] = sort(pre_time_diff_Kyoku_time);
diff_Kyoku_time = zeros(length(IndexTDK),1);

for I=1:length(IndexTDK)
	diff_Kyoku_time(I,1) =  pre_diff_Kyoku_time(IndexTDK(I,1),1);
end




time_data_wii = data_wii(:,1);%wiiの時間取得
time_data_wii = time_data_wii + 0.0025176; 

%%%%%%%%%%%%各センサ生データ
for i = 1:24;
    sensor_data_now(:,i)  = data_wii(:,i+1);
end

%%%offset生データ
for i = 1:24;
    sensor_data_off(:,i)  = data_off(:,i+1);
end

%%%生データの平均
for i = 1:24;
    sensor_data_off_ave(:,i) = sum(sensor_data_off(:,i))/length(sensor_data_off(:,i));
end

%%%%センサデータ
for i = 1:24;
    sensor_data(:,i) = sensor_data_now(:,i) - sensor_data_off_ave(:,i);
end

%%%%%%%%%%%生データ荷重グラム変換
%%%%%%%%%%Aの荷重変換
%%%%左手2
    sensor_g(:,1) = 704.6969234   * sensor_data(:,1) ;%rf
    sensor_g(:,2) = 680.8358363   * sensor_data(:,2) ;%rb
    sensor_g(:,3) = 705.5169798   * sensor_data(:,3) ;%lf
    sensor_g(:,4) = 777.5147644   * sensor_data(:,4) ;%lb   
%%%%ボード3
    sensor_g(:,5) =  18908.59431 * sensor_data(:,5) ;%rf
    sensor_g(:,6) =  39860.36531 * sensor_data(:,6) ;%rb
    sensor_g(:,7) =  51835.79850 * sensor_data(:,7) ;%lf
    sensor_g(:,8) =  16838.46654 * sensor_data(:,8) ;%lb  
%%%%ボード4
    sensor_g(:,9) =  12985.88554 * sensor_data(:,9) ;%rf
    sensor_g(:,10) =  12891.85296 * sensor_data(:,10) ;%rb
    sensor_g(:,11) =  21198.05169 * sensor_data(:,11) ;%lf
    sensor_g(:,12) =  24627.38253 * sensor_data(:,12) ;%lb  
%%%%%%%%%%Bの荷重変換
%%%%左手1
    sensor_g(:,13) =  696.9379141 * sensor_data(:,13) ;%rf
    sensor_g(:,14) =  706.7056351 * sensor_data(:,14) ;%rb
    sensor_g(:,15) =  748.3413948 * sensor_data(:,15) ;%lf
    sensor_g(:,16) =  696.1289266 * sensor_data(:,16) ;%lb  
%%%%ボード1
    sensor_g(:,17) = 9827.121   * sensor_data(:,17) ;%rf
    sensor_g(:,18) = 19815.3984   * sensor_data(:,18) ;%rb
    sensor_g(:,19) = 17121.6358   * sensor_data(:,19) ;%lf
    sensor_g(:,20) = 14596.1732   * sensor_data(:,20) ;%lb   
%%%%ボード2
    sensor_g(:,21) = 21356.59377  * sensor_data(:,21)  ;%rf
    sensor_g(:,22) = 15224.09441  * sensor_data(:,22) ;%rb
    sensor_g(:,23) = 15133.59702  * sensor_data(:,23) ;%lf
    sensor_g(:,24) = 21704.29744  * sensor_data(:,24) ;%lb 



%%%%%%%%%%%スプライン補間
%%time_data_wiiに同じ時間が続いている奴があるかどうかチェック
hoge=0;
hoge2=0;
L=1;
%同じ時間が続いている奴があるかどうかチェック
for I=1:(length(time_data_wii)-1)
   if time_data_wii(I,1) == time_data_wii(I+1,1)
%        hoge=hoge+1;
       while time_data_wii(I,1) == time_data_wii(I+L,1)
           L = L + 1;
       end
       d_hoge = (time_data_wii(I+L,1) - time_data_wii(I,1))/L;
       for J = 1:L-1
           time_data_wii(I+J,1) = J*d_hoge + time_data_wii(I,1);
       end       
   end
end

for i = 1:24;
    sensor_g_s(:,i) = spline(time_data_wii,sensor_g(:,i),time_s);
end

%sensor_g_s(:,1) = spline(time_data_wii,sensor_g(:,1),time_s);


%%%%%%%%%%%%荷重データにフィルタをかける
%%%フィルターをかけたセンサの値
N=1;%フィルタの次数
Fs=1/dt; %サンプリング周波数
t=0.05;
Fc=1/(2*pi*t);
Wn = Fc/(Fs/2); %カットオフ周波数
[b,a]= butter(N, Wn);

for i = 1:24;
    filtered_sensor_g(:,i) = filtfilt(b,a,sensor_g_s(:,i));
end



%%
for i = 0:5
    filtered_weight_data(:,i+1) = filtered_sensor_g(:,1+i*4) + filtered_sensor_g(:,2+i*4) + filtered_sensor_g(:,3+i*4) + filtered_sensor_g(:,4+i*4);
    weight_data(:,i+1) = sensor_g(:,1+i*4) + sensor_g(:,2+i*4) + sensor_g(:,3+i*4) + sensor_g(:,4+i*4);
end

M_A = filtered_weight_data(:,1) + filtered_weight_data(:,2) + filtered_weight_data(:,3);
M_A_ave = sum(M_A) / length(filtered_weight_data(:,1));
M_B = filtered_weight_data(:,4) + filtered_weight_data(:,5) + filtered_weight_data(:,6);
M_B_ave = sum(M_B) / length(filtered_weight_data(:,1));



%% 
for j=0:5;
    figure(j+1)
    for i=0:3;
        subplot(4,1,i+1);
        hold on
        plot(time_data_wii,sensor_g(:,j*4+1+i),'Color',[0 0 0],'LineWidth',1);
        plot(time_s,sensor_g_s(:,j*4+1+i),'Color',[0 0 0.5],'LineWidth',1);
        plot(time_s, filtered_sensor_g(:,j*4+1+i),'Color',[1 0 0],'LineWidth',1);
        hold off
        if j==0
            ylim([-1000,2000]);
        else
            ylim([-1000,30000]);
        end
         xlim([0,EXAM_PERIOD]);
    end
end

%%
figure(7)%被験者AとBの各ボードに掛かる荷重をグラフ化
subplot(4,1,1);
hold on
plot(time_s, filtered_weight_data(:,1),'Color',[0.5 0 0],'LineWidth',1);
plot(time_s, filtered_weight_data(:,2),'Color',[0 0.5 0],'LineWidth',1);
plot(time_s, filtered_weight_data(:,3),'Color',[0 0 0.5],'LineWidth',1);
hold off
ylim([-1000,5000]);
ylim([-1000,80000]);
xlim([0,EXAM_PERIOD]);

subplot(4,1,2);
hold on
plot(time_s, M_A(:,1),'Color',[0 0 0],'LineWidth',1);
hold off
ylim([-1000,100000]);
xlim([0,EXAM_PERIOD]);

subplot(4,1,3);
hold on
plot(time_s, filtered_weight_data(:,4),'Color',[0.5 0 0],'LineWidth',1);
plot(time_s, filtered_weight_data(:,5),'Color',[0 0.5 0],'LineWidth',1);
plot(time_s, filtered_weight_data(:,6),'Color',[0 0 0.5],'LineWidth',1);
hold off
ylim([-1000,5000]);
ylim([-1000,60000]);
xlim([0,EXAM_PERIOD]);

subplot(4,1,4);
hold on
plot(time_s, M_B(:,1),'Color',[0 0 0],'LineWidth',1);
hold off
ylim([-1000,80000]);
xlim([0,EXAM_PERIOD]);


%%


%%%%%%%%%%%%重心位置計算(左手用)
hidarite_w = 139;
hidarite_h = 228;

jyusin_x(:,1) = ((filtered_sensor_g(:,1) + filtered_sensor_g(:,2)) - (filtered_sensor_g(:,3) + filtered_sensor_g(:,4))) ./ filtered_weight_data(:,1) * (hidarite_w/2);
jyusin_y(:,1) = ((filtered_sensor_g(:,1) + filtered_sensor_g(:,3)) - (filtered_sensor_g(:,2) + filtered_sensor_g(:,4))) ./ filtered_weight_data(:,1) * (hidarite_h/2);
jyusin_x(:,4) = ((filtered_sensor_g(:,13) + filtered_sensor_g(:,14)) - (filtered_sensor_g(:,15) + filtered_sensor_g(:,16))) ./ filtered_weight_data(:,4) * (hidarite_w/2);
jyusin_y(:,4) = ((filtered_sensor_g(:,13) + filtered_sensor_g(:,15)) - (filtered_sensor_g(:,14) + filtered_sensor_g(:,16))) ./ filtered_weight_data(:,4) * (hidarite_h/2);
%%%%%%%%%%%%重心位置計算（ボード用）
boad_w = 430;
boad_h = 240;

jyusin_x(:,2) = ((filtered_sensor_g(:,5) + filtered_sensor_g(:,6)) - (filtered_sensor_g(:,7) + filtered_sensor_g(:,8))) ./ filtered_weight_data(:,2) * (boad_w/2);
jyusin_y(:,2) = ((filtered_sensor_g(:,5) + filtered_sensor_g(:,7)) - (filtered_sensor_g(:,6) + filtered_sensor_g(:,8))) ./ filtered_weight_data(:,2) * (boad_h/2);
jyusin_x(:,3) = ((filtered_sensor_g(:,9) + filtered_sensor_g(:,10)) - (filtered_sensor_g(:,11) + filtered_sensor_g(:,12))) ./ filtered_weight_data(:,3) * (boad_w/2);
jyusin_y(:,3) = ((filtered_sensor_g(:,9) + filtered_sensor_g(:,11)) - (filtered_sensor_g(:,10) + filtered_sensor_g(:,12))) ./ filtered_weight_data(:,3) * (boad_h/2);
jyusin_x(:,5) = ((filtered_sensor_g(:,17) + filtered_sensor_g(:,18)) - (filtered_sensor_g(:,19) + filtered_sensor_g(:,20))) ./ filtered_weight_data(:,5) * (boad_w/2);
jyusin_y(:,5) = ((filtered_sensor_g(:,17) + filtered_sensor_g(:,19)) - (filtered_sensor_g(:,18) + filtered_sensor_g(:,20))) ./ filtered_weight_data(:,5) * (boad_h/2);
jyusin_x(:,6) = ((filtered_sensor_g(:,21) + filtered_sensor_g(:,22)) - (filtered_sensor_g(:,23) + filtered_sensor_g(:,24))) ./ filtered_weight_data(:,6) * (boad_w/2);
jyusin_y(:,6) = ((filtered_sensor_g(:,21) + filtered_sensor_g(:,23)) - (filtered_sensor_g(:,22) + filtered_sensor_g(:,24))) ./ filtered_weight_data(:,6) * (boad_h/2);

%%%Aの重心位置（おく）
jyusin_A_x = (filtered_weight_data(:,2).*jyusin_x(:,2) + filtered_weight_data(:,3).*jyusin_x(:,3) + filtered_weight_data(:,1).*(jyusin_x(:,1)+80)) ./ M_A;
jyusin_A_y = (filtered_weight_data(:,2).*jyusin_y(:,2) + filtered_weight_data(:,3).*(jyusin_y(:,3)+350) + filtered_weight_data(:,1).*(jyusin_y(:,1)+440)) ./ M_A;
jyusin_B_x = (filtered_weight_data(:,5).*jyusin_x(:,5) + filtered_weight_data(:,6).*jyusin_x(:,6) + filtered_weight_data(:,4).*(jyusin_x(:,4)+80)) ./ M_B;
jyusin_B_y = (filtered_weight_data(:,5).*jyusin_y(:,5) + filtered_weight_data(:,6).*(jyusin_y(:,6)+350) + filtered_weight_data(:,4).*(jyusin_y(:,4)+440)) ./ M_B;

%%%絶対座標系への変換
jyusin_A_y_w = jyusin_A_y-580;
jyusin_B_y_w = 580-jyusin_B_y;

jyusin_B_yDash = -jyusin_B_y;

%%
% %センサの飛びの値を修正(2010.02.02のデータに関して)

% Kari_M_A = zeros(length(time_s),1);
% for i = 1:12
%     Kari_M_A = Kari_M_A + filtered_sensor_g(:,i);
% end
% filtered_sensor_g(:,7) = M_A_HOSEI - (Kari_M_A -
% filtered_sensor_g(:,7));%ノイズが載る7番目のセンサの値を取り除く




%重心の極値の算出（手の動きの極値の間にある極値を探す）
for I=1: length(Kyoku_timeMax)+1
    if 1<I && I<length(Kyoku_timeMax)+1
        StartIndex = find(Kyoku_timeMax(I-1,1)==time_s);
        EndIndex = find(Kyoku_timeMax(I,1)==time_s);
        [GKyoku_MinA(I,1), GKyoku_timeMinA(I,1),GKyoku_MinAFlag(I,1)] = TW_MinPeakMin(time_s(1,StartIndex:EndIndex)',jyusin_A_y(StartIndex:EndIndex,1));
        [GKyoku_MinB(I,1), GKyoku_timeMinB(I,1),GKyoku_MinBFlag(I,1)] = TW_MinPeakMin(time_s(1,StartIndex:EndIndex)',jyusin_B_yDash(StartIndex:EndIndex,1));
    elseif I == 1
        StartIndex = 10;%最初スプライン等でデータが吹っ飛ぶので調整
        EndIndex = find(Kyoku_timeMax(1,1)==time_s);
        [GKyoku_MinA(I,1), GKyoku_timeMinA(I,1),GKyoku_MinAFlag(I,1)] = TW_MinPeakMin(time_s(1,StartIndex:EndIndex)',jyusin_A_y(StartIndex:EndIndex,1));
        [GKyoku_MinB(I,1), GKyoku_timeMinB(I,1),GKyoku_MinBFlag(I,1)] = TW_MinPeakMin(time_s(1,StartIndex:EndIndex)',jyusin_B_yDash(StartIndex:EndIndex,1));
    else
        StartIndex = find(Kyoku_timeMax(I-1,1)==time_s);
        EndIndex = length(time_s);
        [GKyoku_MinA(I,1), GKyoku_timeMinA(I,1),GKyoku_MinAFlag(I,1)] = TW_MinPeakMin(time_s(1,StartIndex:EndIndex)',jyusin_A_y(StartIndex:EndIndex,1));
        [GKyoku_MinB(I,1), GKyoku_timeMinB(I,1),GKyoku_MinBFlag(I,1)] = TW_MinPeakMin(time_s(1,StartIndex:EndIndex)',jyusin_B_yDash(StartIndex:EndIndex,1));
    end
end

for I=1: length(Kyoku_timeMin)+1
    if 1<I && I<length(Kyoku_timeMin)+1
        StartIndex = find(Kyoku_timeMin(I-1,1)==time_s);
        EndIndex = find(Kyoku_timeMin(I,1)==time_s);
        [GKyoku_MaxA(I,1), GKyoku_timeMaxA(I,1),GKyoku_MaxAFlag(I,1)] = TW_MaxPeakMax(time_s(1,StartIndex:EndIndex)',jyusin_A_y(StartIndex:EndIndex,1));
        [GKyoku_MaxB(I,1), GKyoku_timeMaxB(I,1),GKyoku_MaxBFlag(I,1)] = TW_MaxPeakMax(time_s(1,StartIndex:EndIndex)',jyusin_B_yDash(StartIndex:EndIndex,1));
    elseif I == 1
        StartIndex = 10;%最初スプライン等でデータが吹っ飛ぶので調整
        EndIndex = find(Kyoku_timeMin(1,1)==time_s);
        [GKyoku_MaxA(I,1), GKyoku_timeMaxA(I,1),GKyoku_MaxAFlag(I,1)] = TW_MaxPeakMax(time_s(1,StartIndex:EndIndex)',jyusin_A_y(StartIndex:EndIndex,1));
        [GKyoku_MaxB(I,1), GKyoku_timeMaxB(I,1),GKyoku_MaxBFlag(I,1)] = TW_MaxPeakMax(time_s(1,StartIndex:EndIndex)',jyusin_B_yDash(StartIndex:EndIndex,1));
    else
        StartIndex = find(Kyoku_timeMin(I-1,1)==time_s);
        EndIndex = length(time_s);
        [GKyoku_MaxA(I,1), GKyoku_timeMaxA(I,1),GKyoku_MaxAFlag(I,1)] = TW_MaxPeakMax(time_s(1,StartIndex:EndIndex)',jyusin_A_y(StartIndex:EndIndex,1));
        [GKyoku_MaxB(I,1), GKyoku_timeMaxB(I,1),GKyoku_MaxBFlag(I,1)] = TW_MaxPeakMax(time_s(1,StartIndex:EndIndex)',jyusin_B_yDash(StartIndex:EndIndex,1));
    end
end


%%
figure(8)

Xstart = 5;
subplot(3,1,1);
hold on
for I=1:length(Kyoku_timeMax)
    plot([Kyoku_timeMax(I,1),Kyoku_timeMax(I,1)],[-10000,10000],'-','Color',[0.7 0.7 0.7]);
end
for I=1:length(Kyoku_timeMin)
    plot([Kyoku_timeMin(I,1),Kyoku_timeMin(I,1)],[-10000,10000],':','Color',[0.5 0.5 0.5]);
end
% plot([0 60], [0 0],'Color',[0 0 0],'LineWidth',0.5);
plot(time_s,position_s,'Color',[0 0 0],'LineWidth',0.5);
hold off
ylim([-0.5,0.5]);
xlim([Xstart,EXAM_PERIOD]);

subplot(3,1,2);
hold on
for I=1:length(Kyoku_timeMax)
    plot([Kyoku_timeMax(I,1),Kyoku_timeMax(I,1)],[-10000,10000],'-','Color',[0.7 0.7 0.7]);
end
for I=1:length(Kyoku_timeMin)
    plot([Kyoku_timeMin(I,1),Kyoku_timeMin(I,1)],[-10000,10000],':','Color',[0.5 0.5 0.5]);
end
plot(time_s, 0.001*jyusin_A_y,'Color',[1 0 0],'LineWidth',0.5);
% plot(time_s, 0.001*Origin_jyusin_A_y,'Color',[1 0 0],'LineWidth',0.5);
% plot(time_s, 0.001*Hosei_Hosei_jyusin_A_y,'Color',[0.5 0 0],'LineWidth',0.5);

plot(time_s, 0.001*jyusin_B_y,'Color',[0 0 1],'LineWidth',0.5);
% plot(GKyoku_timeMaxA, 0.001*GKyoku_MaxA,'o','Color',[1 0 0],'LineWidth',0.5);
% plot(GKyoku_timeMinA, 0.001*GKyoku_MinA,'*','Color',[1 0 0],'LineWidth',0.5);
% plot(GKyoku_timeMaxB, -0.001*GKyoku_MaxB,'o','Color',[0 0 1],'LineWidth',0.5);
% plot(GKyoku_timeMinB, -0.001*GKyoku_MinB,'*','Color',[0 0 1],'LineWidth',0.5);
hold off
ylim([-0.1,0.3]);
xlim([Xstart,EXAM_PERIOD]);


%%
figure(10)
subplot(2,1,1);
hold on
for I=1:length(Kyoku_timeMax)
    plot([Kyoku_timeMax(I,1),Kyoku_timeMax(I,1)],[-10000,10000],'-','Color',[0.7 0.7 0.7]);
end
for I=1:length(Kyoku_timeMin)
    plot([Kyoku_timeMin(I,1),Kyoku_timeMin(I,1)],[-10000,10000],':','Color',[0.5 0.5 0.5]);
end
plot(time_s, 0.001*jyusin_A_y,'Color',[0 0 0],'LineWidth',1.5);


plot(GKyoku_timeMaxA, 0.001*GKyoku_MaxA,'o','Color',[1 0 0],'LineWidth',0.5);
% plot(GKyoku_timeMaxMaxA, 0.001*GKyoku_MaxMaxA,'o','Color',[1 0 1],'LineWidth',0.5);
plot(GKyoku_timeMinA, 0.001*GKyoku_MinA,'*','Color',[1 0 0],'LineWidth',0.5);

hold off
ylim([-0.1,0.3]);
xlim([0,EXAM_PERIOD]);

subplot(2,1,2);
hold on
for I=1:length(Kyoku_timeMax)
    plot([Kyoku_timeMax(I,1),Kyoku_timeMax(I,1)],[-10000,10000],'-','Color',[0.7 0.7 0.7]);
end
for I=1:length(Kyoku_timeMin)
    plot([Kyoku_timeMin(I,1),Kyoku_timeMin(I,1)],[-10000,10000],':','Color',[0.5 0.5 0.5]);
end

plot(time_s, 0.001*jyusin_B_y,'Color',[0.5 0.5 0.5],'LineWidth',1.5);
plot(GKyoku_timeMaxB, -0.001*GKyoku_MaxB,'o','Color',[0 0 1],'LineWidth',0.5);
plot(GKyoku_timeMinB, -0.001*GKyoku_MinB,'*','Color',[0 0 1],'LineWidth',0.5);
hold off
ylim([-0.1,0.3]);
xlim([0,EXAM_PERIOD]);


%% 重心と手の動きの差を調べるセル

%最初と最後を調整
if Kyoku_timeMin(1,1)<Kyoku_timeMax(1,1)
    GKyoku_timeMaxA = GKyoku_timeMaxA(2:end,1);
    GKyoku_MaxA = GKyoku_MaxA(2:end,1);
    GKyoku_MaxAFlag = GKyoku_MaxAFlag(2:end,1);
else
    GKyoku_timeMinA = GKyoku_timeMinA(2:end,1);
    GKyoku_MinA = GKyoku_MinA(2:end,1);
    GKyoku_MinAFlag = GKyoku_MinAFlag(2:end,1);
end

if Kyoku_timeMax(end,1)<Kyoku_timeMin(end,1)
    GKyoku_timeMaxA = GKyoku_timeMaxA(1:(end-1),1);
    GKyoku_MaxA = GKyoku_MaxA(1:(end-1),1);
    GKyoku_MaxAFlag = GKyoku_MaxAFlag(1:(end-1),1);
else
    GKyoku_timeMinA = GKyoku_timeMinA(1:(end-1),1);
    GKyoku_MinA = GKyoku_MinA(1:(end-1),1);
    GKyoku_MinAFlag = GKyoku_MinAFlag(1:(end-1),1);
end


%最初と最後を調整
if Kyoku_timeMin(1,1)<Kyoku_timeMax(1,1)
    GKyoku_timeMaxB = GKyoku_timeMaxB(2:end,1);
    GKyoku_MaxB = GKyoku_MaxB(2:end,1);
    GKyoku_MaxBFlag = GKyoku_MaxBFlag(2:end,1);
else
    GKyoku_timeMinB = GKyoku_timeMinB(2:end,1);
    GKyoku_MinB = GKyoku_MinB(2:end,1);
    GKyoku_MinBFlag = GKyoku_MinBFlag(2:end,1);
end

if Kyoku_timeMax(end,1)<Kyoku_timeMin(end,1)
    GKyoku_timeMaxB = GKyoku_timeMaxB(1:(end-1),1);
    GKyoku_MaxB = GKyoku_MaxB(1:(end-1),1);
    GKyoku_MaxBFlag = GKyoku_MaxBFlag(1:(end-1),1);
else
    GKyoku_timeMinB = GKyoku_timeMinB(1:(end-1),1);
    GKyoku_MinB = GKyoku_MinB(1:(end-1),1);
    GKyoku_MinBFlag = GKyoku_MinBFlag(1:(end-1),1);
end



%%

GapMaxA = Kyoku_timeMax - GKyoku_timeMaxA;
GapMinA = Kyoku_timeMin - GKyoku_timeMinA;
GapMaxB = Kyoku_timeMax - GKyoku_timeMaxB;
GapMinB = Kyoku_timeMin - GKyoku_timeMinB;

precedenceGapNumMax = sum((GapMaxA>0) & (GapMaxB>0));%先に調べておかないとめちゃくちゃになっちゃう．
precedenceGapNumMin = sum((GapMinA>0) & (GapMinB>0));%先に調べておかないとめちゃくちゃになっちゃう．

precedenceGapNumBoth = precedenceGapNumMax + precedenceGapNumMin;

%重心ピークが定義できない箇所をカット
GapMaxA = GapMaxA(GKyoku_MaxAFlag == 0);
GKyoku_timeMaxA = GKyoku_timeMaxA(GKyoku_MaxAFlag == 0); 
GaptimeMaxA = Kyoku_timeMax(GKyoku_MaxAFlag == 0);

GapMinA = GapMinA(GKyoku_MinAFlag == 0);
GKyoku_timeMinA = GKyoku_timeMinA(GKyoku_MinAFlag == 0); 
GaptimeMinA = Kyoku_timeMin(GKyoku_MinAFlag == 0);

GapMaxB = GapMaxB(GKyoku_MaxBFlag == 0);
GKyoku_timeMaxB = GKyoku_timeMaxB(GKyoku_MaxBFlag == 0); 
GaptimeMaxB = Kyoku_timeMax(GKyoku_MaxBFlag == 0);

GapMinB = GapMinB(GKyoku_MinBFlag == 0);
GKyoku_timeMinB = GKyoku_timeMinB(GKyoku_MinBFlag == 0); 
GaptimeMinB = Kyoku_timeMin(GKyoku_MinBFlag == 0);

%ズレ時間の定義
pre_GaptimeA = [GaptimeMaxA;GaptimeMinA];
[GaptimeA, IndexGAT] = sort(pre_GaptimeA);
pre_GaptimeB = [GaptimeMaxB;GaptimeMinB];
[GaptimeB, IndexGBT] = sort(pre_GaptimeB);

preGapA = [GapMaxA;GapMinA];
preGapB = [GapMaxB;GapMinB];

for I=1:length(IndexGAT)
	GapA(I,1) =  preGapA(IndexGAT(I,1),1);
end

for I=1:length(IndexGBT)
	GapB(I,1) =  preGapB(IndexGBT(I,1),1);
end

%以下統計量の算出
mean_GapMaxA = mean(GapMaxA);
std_GapMaxA = std(GapMaxA);
mean_GapMinA = mean(GapMinA);
std_GapMinA = std(GapMinA);
mean_GapMaxB = mean(GapMaxB);
std_GapMaxB = std(GapMaxB);
mean_GapMinB = mean(GapMinB);
std_GapMinB = std(GapMinB);

mean_GapA = mean(GapA);
std_GapA = std(GapA);
mean_GapB = mean(GapB);
std_GapB = std(GapB);

precedenceGapMaxRateA =  sum(GapMaxA>0)/length(GapMaxA);
precedenceGapMinRateA =  sum(GapMinA>0)/length(GapMinA);
precedenceGapMaxRateB =  sum(GapMaxB>0)/length(GapMaxB);
precedenceGapMinRateB =  sum(GapMinB>0)/length(GapMinB);
precedenceGapRateA =  sum(GapA>0)/length(GapA);
precedenceGapRateB =  sum(GapB>0)/length(GapB);

precedenceGapRateBoth = precedenceGapNumBoth/length(GapA);


%%
%以下
pre_Kyoku_time = [Kyoku_timeMax;Kyoku_timeMin];
[Kyoku_time, IndexKT] = sort(pre_Kyoku_time);
time_Gap_s = Kyoku_time(1,1):dt:Kyoku_time(end,1);

%線形補間
GapA_s=interp1(GaptimeA(:,1),GapA(:,1),time_Gap_s);
GapB_s=interp1(GaptimeB(:,1),GapB(:,1),time_Gap_s);

%ギャップ時間の平均と標準偏差を算出
mean_GapA_s = mean(GapA_s(~isnan(GapA_s)));
std_GapA_s = std(GapA_s(~isnan(GapA_s)));
mean_GapB_s = mean(GapB_s(~isnan(GapB_s)));
std_GapB_s = std(GapB_s(~isnan(GapB_s)));

%先行時間割合
precedenceGapRateA_s = sum(GapA_s>0)/length(GapA_s);
precedenceGapRateB_s = sum(GapB_s>0)/length(GapB_s);

%双方時間先行割合
precedenceGapRateBoth_s = sum((GapA_s>0) & (GapB_s>0))/length(GapA_s);

%%%%%%%%%%%%重心が両方の先行する時間帯の算出
PrecedenceGapFlagBoth_s = (GapA_s>0) & (GapB_s>0);

%両端に0を付ける 
PrecedenceGapFlagBoth_s = [0 PrecedenceGapFlagBoth_s 0];
diff_PrecedenceGapFlagBoth_s = diff(PrecedenceGapFlagBoth_s);

StartGapBothIndex_s = find(diff_PrecedenceGapFlagBoth_s>0);%両方先行する時の始まりのIndex．
EndGapBothIndex_s = find(diff_PrecedenceGapFlagBoth_s<0);


StartGapBothTime_s = (StartGapBothIndex_s-1)*dt+time_Gap_s(1,1);
EndGapBothTime_s = (EndGapBothIndex_s-1)*dt+time_Gap_s(1,1);


%%

% %位相の定義(ボードの動き)
% PhaseMax = zeros(length(Kyoku_timeMax),1);%上に凸の場所
% PhaseMax = PhaseMax+2*pi;
% PhaseMin = zeros(length(Kyoku_timeMin),1);%下に凸の場所
% PhaseMin = PhaseMin + pi;
% PhaseZero = zeros(length(Kyoku_timeMax),1);%上に凸の場所のすぐ次
% PhaseZeroTime = Kyoku_timeMax+dt;
% 
% pre_Phase_time = [Kyoku_timeMax;Kyoku_timeMin;PhaseZeroTime];
% [Phase_time, IndexPT] = sort(pre_Phase_time);
% prePhase = [PhaseMax;PhaseMin;PhaseZero];
% 
% for I=1:length(IndexPT)
% 	Phase(I,1) =  prePhase(IndexPT(I,1),1);
% end
% 
% 
% %位相の定義(重心被験者A)
% GPhaseMaxA = zeros(length(GKyoku_timeMaxA),1);%上に凸の場所
% GPhaseMaxA = GPhaseMaxA+2*pi;
% GPhaseMinA = zeros(length(GKyoku_timeMinA),1);%下に凸の場所
% GPhaseMinA = GPhaseMinA + pi;
% GPhaseZeroA = zeros(length(GKyoku_timeMaxA),1);%上に凸の場所のすぐ次
% GPhaseZeroTimeA = GKyoku_timeMaxA+dt;
% 
% Gpre_Phase_timeA = [GKyoku_timeMaxA;GKyoku_timeMinA;GPhaseZeroTimeA];
% [GPhase_timeA, GIndexPTA] = sort(Gpre_Phase_timeA);
% GprePhaseA = [GPhaseMaxA;GPhaseMinA;GPhaseZeroA];
% 
% for I=1:length(GIndexPTA)
% 	GPhaseA(I,1) =  GprePhaseA(GIndexPTA(I,1),1);
% end
% 
% %位相の定義(重心被験者B)
% GPhaseMaxB = zeros(length(GKyoku_timeMaxB),1);%上に凸の場所
% GPhaseMaxB = GPhaseMaxB+2*pi;
% GPhaseMinB = zeros(length(GKyoku_timeMinB),1);%下に凸の場所
% GPhaseMinB = GPhaseMinB + pi;
% GPhaseZeroB = zeros(length(GKyoku_timeMaxB),1);%上に凸の場所のすぐ次
% GPhaseZeroTimeB = GKyoku_timeMaxB+dt;
% 
% Gpre_Phase_timeB = [GKyoku_timeMaxB;GKyoku_timeMinB;GPhaseZeroTimeB];
% [GPhase_timeB, GIndexPTB] = sort(Gpre_Phase_timeB);
% GprePhaseB = [GPhaseMaxB;GPhaseMinB;GPhaseZeroB];
% 
% for I=1:length(GIndexPTB)
% 	GPhaseB(I,1) =  GprePhaseB(GIndexPTB(I,1),1);
% end
% 
% Phase_s=interp1(Phase_time(:,1),Phase(:,1),time_Gap_s);
% GPhaseA_s=interp1(GPhase_timeA(:,1),GPhaseA(:,1),time_Gap_s);
% GPhaseB_s=interp1(GPhase_timeB(:,1),GPhaseB(:,1),time_Gap_s);
% 
% GapPhaseA = GPhaseA_s - Phase_s;
% GapPhaseB = GPhaseB_s - Phase_s;
% 
% for I=1:length(GapPhaseA)
%     if GapPhaseA(1,I)>pi
%         HoseiGapPhaseA(1,I)=GapPhaseA(1,I)-2*pi;
%     elseif GapPhaseA(1,I)<-pi
%         HoseiGapPhaseA(1,I)=GapPhaseA(1,I)+2*pi;
%     else
%         HoseiGapPhaseA(1,I)=GapPhaseA(1,I);
%     end   
% end
% for I=1:length(GapPhaseB)
%     if GapPhaseB(1,I)>pi
%         HoseiGapPhaseB(1,I)=GapPhaseB(1,I)-2*pi;
%     elseif GapPhaseB(1,I)<-pi
%         HoseiGapPhaseB(1,I)=GapPhaseB(1,I)+2*pi;
%     else
%         HoseiGapPhaseB(1,I)=GapPhaseB(1,I);
%     end   
% end
% 
% %ギャップ時間の平均と標準偏差を算出
% mean_GapPhaseA_s = mean(HoseiGapPhaseA(~isnan(HoseiGapPhaseA)));
% std_GapPhaseA_s = std(HoseiGapPhaseA(~isnan(HoseiGapPhaseA)));
% mean_GapPhaseB_s = mean(HoseiGapPhaseB(~isnan(HoseiGapPhaseB)));
% std_GapPhaseB_s = std(HoseiGapPhaseB(~isnan(HoseiGapPhaseB)));
% 
% %先行位相割合
% precedencePhaseRateA_s = sum(HoseiGapPhaseA>0)/length(HoseiGapPhaseA);
% precedencePhaseRateB_s = sum(HoseiGapPhaseB>0)/length(HoseiGapPhaseB);
% 
% %双方時間割合
% precedencePhaseRateBoth_s = sum((HoseiGapPhaseA>0) & (HoseiGapPhaseB>0))/length(HoseiGapPhaseA);
% 
% %%%%%%%%%%%%両方の重心の位相が先行する時間帯の算出
% 
% PrecedencePhaseFlagBoth_s = (HoseiGapPhaseA>0) & (HoseiGapPhaseB>0);
% 
% 
% PrecedencePhaseFlagBoth_s = [0 PrecedencePhaseFlagBoth_s 0];
% diff_PrecedencePhaseFlagBoth_s = diff(PrecedencePhaseFlagBoth_s);
% StartPhaseBothIndex_s = find(diff_PrecedencePhaseFlagBoth_s>0);%両方先行する時の始まりのIndex．
% EndPhaseBothIndex_s = find(diff_PrecedencePhaseFlagBoth_s<0);
% StartPhaseBothTime_s = (StartPhaseBothIndex_s-1)*dt+time_Gap_s(1,1);
% EndPhaseBothTime_s = (EndPhaseBothIndex_s-1)*dt+time_Gap_s(1,1);


%%
figure(8)
subplot(3,1,3);
hold on

for I=1:length(StartGapBothTime_s)
    x = [StartGapBothTime_s(1,I) EndGapBothTime_s(1,I) EndGapBothTime_s(1,I) StartGapBothTime_s(1,I)];hold on
    y = [-10 -10 10 10];
    fill(x,y,[0.85 0.85 0.85],'LineStyle','none');
end

for I=1:length(Kyoku_timeMax)
    plot([Kyoku_timeMax(I,1),Kyoku_timeMax(I,1)],[-10,10],'-','Color',[0.7 0.7 0.7]);
end
for I=1:length(Kyoku_timeMin)
    plot([Kyoku_timeMin(I,1),Kyoku_timeMin(I,1)],[-10,10],':','Color',[0.5 0.5 0.5]);
end

% StartGapBothTime_s = (StartGapBothIndex_s-1)*dt+time_Gap_s(1,1);
% EndGapBothTime_s = (EndGapBothIndex_s-1)*dt+time_Gap_s(1,1);


plot([0 EXAM_PERIOD], [0 0],'Color',[0 0 0],'LineWidth',0.5);
plot(GaptimeA, GapA,'Color',[1 0 0],'LineWidth',0.5);
plot(GaptimeB, GapB,'Color',[0 0 1],'LineWidth',0.5);
hold off
ylim([-1,1.5]);
xlim([Xstart,EXAM_PERIOD]);


%%
%%%%%位相の差を見るためのグラフ
% figure(9)
% subplot(4,1,1);
% hold on
% for I=1:length(Kyoku_timeMax)
%     plot([Kyoku_timeMax(I,1),Kyoku_timeMax(I,1)],[-10000,10000],'-','Color',[0.7 0.7 0.7]);
% end
% for I=1:length(Kyoku_timeMin)
%     plot([Kyoku_timeMin(I,1),Kyoku_timeMin(I,1)],[-10000,10000],':','Color',[0.5 0.5 0.5]);
% end
% plot([0 EXAM_PERIOD], [0 0],'Color',[0 0 0],'LineWidth',0.5);
% plot(Phase_time, Phase,'Color',[0 0 0],'LineWidth',1.5);
% hold off
% ylim([-1,7]);
% xlim([0,EXAM_PERIOD]);
% 
% 
% subplot(4,1,2);
% hold on
% for I=1:length(Kyoku_timeMax)
%     plot([Kyoku_timeMax(I,1),Kyoku_timeMax(I,1)],[-10000,10000],'-','Color',[0.7 0.7 0.7]);
% end
% for I=1:length(Kyoku_timeMin)
%     plot([Kyoku_timeMin(I,1),Kyoku_timeMin(I,1)],[-10000,10000],':','Color',[0.5 0.5 0.5]);
% end
% plot([0 EXAM_PERIOD], [0 0],'Color',[0 0 0],'LineWidth',0.5);
% plot(GPhase_timeA, GPhaseA,'Color',[0 0 0],'LineWidth',1.5);
% hold off
% ylim([-1,7]);
% xlim([0,EXAM_PERIOD]);
% 
% subplot(4,1,3);
% hold on
% for I=1:length(Kyoku_timeMax)
%     plot([Kyoku_timeMax(I,1),Kyoku_timeMax(I,1)],[-10000,10000],'-','Color',[0.7 0.7 0.7]);
% end
% for I=1:length(Kyoku_timeMin)
%     plot([Kyoku_timeMin(I,1),Kyoku_timeMin(I,1)],[-10000,10000],':','Color',[0.5 0.5 0.5]);
% end
% plot([0 EXAM_PERIOD], [0 0],'Color',[0 0 0],'LineWidth',0.5);
% plot(GPhase_timeB, GPhaseB,'Color',[0.5 0.5 0.5],'LineWidth',1.5);
% hold off
% ylim([-1,7]);
% xlim([0,EXAM_PERIOD]);

%%

% N=1;%フィルタの次数
% Fs=200; %サンプリング周波数
% t=0.015;
% Fc=1/(2*pi*t);
% Wn = Fc/(Fs/2); %カットオフ周波数
% [b,a]= butter(N, Wn);
% 
% HoseiGapPhaseAisnan = HoseiGapPhaseA(find(~isnan(HoseiGapPhaseA)));
% HoseiGapPhaseBisnan = HoseiGapPhaseB(find(~isnan(HoseiGapPhaseB)));
% 
% filtered_HoseiGapPhaseA=filtfilt(b,a,HoseiGapPhaseAisnan);%
% filtered_HoseiGapPhaseB=filtfilt(b,a,HoseiGapPhaseBisnan);%
% 
% subplot(4,1,4);
% hold on
% 
% for I=1:length(StartPhaseBothTime_s)
%     x = [StartPhaseBothTime_s(1,I) EndPhaseBothTime_s(1,I) EndPhaseBothTime_s(1,I) StartPhaseBothTime_s(1,I)];hold on
%     y = [-10 -10 10 10];
%     fill(x,y,[0.85 0.85 0.85],'LineStyle','none');
% end
% 
% for I=1:length(Kyoku_timeMax)
%     plot([Kyoku_timeMax(I,1),Kyoku_timeMax(I,1)],[-10000,10000],'-','Color',[0.7 0.7 0.7]);
% end
% for I=1:length(Kyoku_timeMin)
%     plot([Kyoku_timeMin(I,1),Kyoku_timeMin(I,1)],[-10000,10000],':','Color',[0.5 0.5 0.5]);
% end
% plot([0 EXAM_PERIOD], [0 0],'Color',[0 0 0],'LineWidth',0.5);
% plot(time_Gap_s(1,1:length(filtered_HoseiGapPhaseA)), filtered_HoseiGapPhaseA,'Color',[0 0 0],'LineWidth',1.5);
% plot(time_Gap_s(1,1:length(filtered_HoseiGapPhaseB)), filtered_HoseiGapPhaseB,'Color',[0.5 0.5 0.5],'LineWidth',1.5);
% hold off
% ylim([-4,4]);
% xlim([0,EXAM_PERIOD]);



% %% FFT解析
% %%%%%%%%%%%%位置情報のFFT
% fs = 1/dt;%サンプリング周波数
% n = pow2(nextpow2(length(position_s)));
% y_position = fft(position_s,n);
% power_position = y_position.*conj(y_position)/n;
% f = (0:(n/2-1))*(fs/n);     % Frequency range
% 
% 
% 
% figure(11)
% hold on
% loglog(f,power_position(1:n/2),'Color',[0 0 0],'LineWidth',0.5);
% hold off
% 
% 
% %%%%%%%%%%%%重心情報のFFT
% n_ja = pow2(nextpow2(length(jyusin_A_y(100:end))));
% y_ja = fft(0.001*jyusin_A_y(100:end),n_ja);
% f_ja = (0:(n_ja/2-1))*(fs/n_ja);     % Frequency range
% power_ja = y_ja.*conj(y_ja)/n_ja;
% 
% n_jb = pow2(nextpow2(length(jyusin_B_y(100:end))));
% y_jb = fft(0.001*jyusin_B_y(100:end),n_jb);
% f_jb = (0:(n_jb/2-1))*(fs/n_jb);     % Frequency range
% power_jb = y_jb.*conj(y_jb)/n_jb;
% 
% figure(12)
% hold on
% loglog(f_ja,power_ja(1:n_ja/2),'Color',[1 0 0],'LineWidth',0.5);
% hold off
% 
% figure(13)
% hold on
% loglog(f_jb,power_jb(1:n_jb/2),'Color',[0 0 1],'LineWidth',0.5);
% hold off
%% ピークを算出できない割合の算出

NotFoundGMaxANum = sum(GKyoku_MaxAFlag);
NotFoundGMaxBNum = sum(GKyoku_MaxBFlag);
NotFoundGMinANum = sum(GKyoku_MinAFlag);
NotFoundGMinBNum = sum(GKyoku_MinBFlag);

NotFoundGANum = NotFoundGMaxANum +NotFoundGMinANum; 
NotFoundGBNum = NotFoundGMaxBNum +NotFoundGMinBNum; 




