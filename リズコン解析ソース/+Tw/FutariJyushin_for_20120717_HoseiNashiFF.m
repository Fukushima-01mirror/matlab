%%%��l�̑S�g�̏d�S�ʒu�i�VAD�{�[�h�ɂ��Ă���j

%%���ʂ̃f�[�^�̂����������̂ŁC���͂̃f�[�^����␳(2010.2.19�̎����Ɋւ���)

time_data = data(:,1);%�f�[�^�̎��Ԓ��o

EXAM_PERIOD = 191;

%�f�[�^�Ԏ��Ԃ𓙊Ԋu��
dt = (time_data(end,1)-time_data(1,1))/length(time_data);
%dt = 0.005;

%%%%%%%%%%%%�G���R�[�_�f�[�^�̏���
%�G���R�[�_�̎��Ԃ̖`����0���J�b�g
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
%�������Ԃ������Ă���z�����邩�ǂ����`�F�b�N
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


% %mtime_data�ɂR�������Ԃ������Ă���z������Ƃ�
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
Position = Encoder * (-0.00025);%�p���X���ʒum�ɕϊ�
mPosition = Position(m:length(time_data),1);
position_s=spline(mtime_data,mPosition,time_s);%�X�v���C���⊮

%�t�B���^���̂P�i�G���R�[�_����ї́j�̍쐬
N=1;%�t�B���^�̎���
Fs=200; %�T���v�����O���g��
t=0.015;
Fc=1/(2*pi*t);
Wn = Fc/(Fs/2); %�J�b�g�I�t���g��
[b,a]= butter(N, Wn);

%���x�̎Z�o
dposition = diff(position_s);
vel = dposition/dt;
timeV=time_s(1,1:length(time_s)-1);
filtered_vel=filtfilt(b,a,vel);%���x�f�[�^�Ƀt�B���^��������

%�ʒu���ɒl���Ƃ�ۂ̊e�l�̎Z�o
nMax=0;%�ɑ�l�J�E���g
nMin=0;%�ɏ��l�J�E���g

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
%�����̎Z�o���̂P�i�������d���^�j
%

%��̓����̃s�[�N�Ԏ��Ԃ��Z�o������������Ƃ����B
diff_Kyoku_timeMax = diff(Kyoku_timeMax);
diff_Kyoku_timeMin = diff(Kyoku_timeMin);

for I = 1:length(diff_Kyoku_timeMax)
    time_diff_Kyoku_timeMax(I,1) = Kyoku_timeMax(I,1)+0.5*diff_Kyoku_timeMax(I,1);%�ɑ�l�Ԃ̐^�񒆂̎���
end
for I = 1:length(diff_Kyoku_timeMin)
    time_diff_Kyoku_timeMin(I,1) = Kyoku_timeMin(I,1)+0.5*diff_Kyoku_timeMin(I,1);%�ɏ��l�Ԃ̐^�񒆂̎���
end

pre_diff_Kyoku_time = [diff_Kyoku_timeMax;diff_Kyoku_timeMin];
pre_time_diff_Kyoku_time = [time_diff_Kyoku_timeMax; time_diff_Kyoku_timeMin];
[time_diff_Kyoku_time, IndexTDK] = sort(pre_time_diff_Kyoku_time);
diff_Kyoku_time = zeros(length(IndexTDK),1);

for I=1:length(IndexTDK)
	diff_Kyoku_time(I,1) =  pre_diff_Kyoku_time(IndexTDK(I,1),1);
end




time_data_wii = data_wii(:,1);%wii�̎��Ԏ擾
time_data_wii = time_data_wii + 0.0025176; 

%%%%%%%%%%%%�e�Z���T���f�[�^
for i = 1:24;
    sensor_data_now(:,i)  = data_wii(:,i+1);
end

%%%offset���f�[�^
for i = 1:24;
    sensor_data_off(:,i)  = data_off(:,i+1);
end

%%%���f�[�^�̕���
for i = 1:24;
    sensor_data_off_ave(:,i) = sum(sensor_data_off(:,i))/length(sensor_data_off(:,i));
end

%%%%�Z���T�f�[�^
for i = 1:24;
    sensor_data(:,i) = sensor_data_now(:,i) - sensor_data_off_ave(:,i);
end

%%%%%%%%%%%���f�[�^�׏d�O�����ϊ�
%%%%%%%%%%A�̉׏d�ϊ�
%%%%����2
    sensor_g(:,1) = 704.6969234   * sensor_data(:,1) ;%rf
    sensor_g(:,2) = 680.8358363   * sensor_data(:,2) ;%rb
    sensor_g(:,3) = 705.5169798   * sensor_data(:,3) ;%lf
    sensor_g(:,4) = 777.5147644   * sensor_data(:,4) ;%lb   
%%%%�{�[�h3
    sensor_g(:,5) =  18908.59431 * sensor_data(:,5) ;%rf
    sensor_g(:,6) =  39860.36531 * sensor_data(:,6) ;%rb
    sensor_g(:,7) =  51835.79850 * sensor_data(:,7) ;%lf
    sensor_g(:,8) =  16838.46654 * sensor_data(:,8) ;%lb  
%%%%�{�[�h4
    sensor_g(:,9) =  12985.88554 * sensor_data(:,9) ;%rf
    sensor_g(:,10) =  12891.85296 * sensor_data(:,10) ;%rb
    sensor_g(:,11) =  21198.05169 * sensor_data(:,11) ;%lf
    sensor_g(:,12) =  24627.38253 * sensor_data(:,12) ;%lb  
%%%%%%%%%%B�̉׏d�ϊ�
%%%%����1
    sensor_g(:,13) =  696.9379141 * sensor_data(:,13) ;%rf
    sensor_g(:,14) =  706.7056351 * sensor_data(:,14) ;%rb
    sensor_g(:,15) =  748.3413948 * sensor_data(:,15) ;%lf
    sensor_g(:,16) =  696.1289266 * sensor_data(:,16) ;%lb  
%%%%�{�[�h1
    sensor_g(:,17) = 9827.121   * sensor_data(:,17) ;%rf
    sensor_g(:,18) = 19815.3984   * sensor_data(:,18) ;%rb
    sensor_g(:,19) = 17121.6358   * sensor_data(:,19) ;%lf
    sensor_g(:,20) = 14596.1732   * sensor_data(:,20) ;%lb   
%%%%�{�[�h2
    sensor_g(:,21) = 21356.59377  * sensor_data(:,21)  ;%rf
    sensor_g(:,22) = 15224.09441  * sensor_data(:,22) ;%rb
    sensor_g(:,23) = 15133.59702  * sensor_data(:,23) ;%lf
    sensor_g(:,24) = 21704.29744  * sensor_data(:,24) ;%lb 



%%%%%%%%%%%�X�v���C�����
%%time_data_wii�ɓ������Ԃ������Ă���z�����邩�ǂ����`�F�b�N
hoge=0;
hoge2=0;
L=1;
%�������Ԃ������Ă���z�����邩�ǂ����`�F�b�N
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


%%%%%%%%%%%%�׏d�f�[�^�Ƀt�B���^��������
%%%�t�B���^�[���������Z���T�̒l
N=1;%�t�B���^�̎���
Fs=1/dt; %�T���v�����O���g��
t=0.05;
Fc=1/(2*pi*t);
Wn = Fc/(Fs/2); %�J�b�g�I�t���g��
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
figure(7)%�팱��A��B�̊e�{�[�h�Ɋ|����׏d���O���t��
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


%%%%%%%%%%%%�d�S�ʒu�v�Z(����p)
hidarite_w = 139;
hidarite_h = 228;

jyusin_x(:,1) = ((filtered_sensor_g(:,1) + filtered_sensor_g(:,2)) - (filtered_sensor_g(:,3) + filtered_sensor_g(:,4))) ./ filtered_weight_data(:,1) * (hidarite_w/2);
jyusin_y(:,1) = ((filtered_sensor_g(:,1) + filtered_sensor_g(:,3)) - (filtered_sensor_g(:,2) + filtered_sensor_g(:,4))) ./ filtered_weight_data(:,1) * (hidarite_h/2);
jyusin_x(:,4) = ((filtered_sensor_g(:,13) + filtered_sensor_g(:,14)) - (filtered_sensor_g(:,15) + filtered_sensor_g(:,16))) ./ filtered_weight_data(:,4) * (hidarite_w/2);
jyusin_y(:,4) = ((filtered_sensor_g(:,13) + filtered_sensor_g(:,15)) - (filtered_sensor_g(:,14) + filtered_sensor_g(:,16))) ./ filtered_weight_data(:,4) * (hidarite_h/2);
%%%%%%%%%%%%�d�S�ʒu�v�Z�i�{�[�h�p�j
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

%%%A�̏d�S�ʒu�i�����j
jyusin_A_x = (filtered_weight_data(:,2).*jyusin_x(:,2) + filtered_weight_data(:,3).*jyusin_x(:,3) + filtered_weight_data(:,1).*(jyusin_x(:,1)+80)) ./ M_A;
jyusin_A_y = (filtered_weight_data(:,2).*jyusin_y(:,2) + filtered_weight_data(:,3).*(jyusin_y(:,3)+350) + filtered_weight_data(:,1).*(jyusin_y(:,1)+440)) ./ M_A;
jyusin_B_x = (filtered_weight_data(:,5).*jyusin_x(:,5) + filtered_weight_data(:,6).*jyusin_x(:,6) + filtered_weight_data(:,4).*(jyusin_x(:,4)+80)) ./ M_B;
jyusin_B_y = (filtered_weight_data(:,5).*jyusin_y(:,5) + filtered_weight_data(:,6).*(jyusin_y(:,6)+350) + filtered_weight_data(:,4).*(jyusin_y(:,4)+440)) ./ M_B;

%%%��΍��W�n�ւ̕ϊ�
jyusin_A_y_w = jyusin_A_y-580;
jyusin_B_y_w = 580-jyusin_B_y;

jyusin_B_yDash = -jyusin_B_y;

%%
% %�Z���T�̔�т̒l���C��(2010.02.02�̃f�[�^�Ɋւ���)

% Kari_M_A = zeros(length(time_s),1);
% for i = 1:12
%     Kari_M_A = Kari_M_A + filtered_sensor_g(:,i);
% end
% filtered_sensor_g(:,7) = M_A_HOSEI - (Kari_M_A -
% filtered_sensor_g(:,7));%�m�C�Y���ڂ�7�Ԗڂ̃Z���T�̒l����菜��




%�d�S�̋ɒl�̎Z�o�i��̓����̋ɒl�̊Ԃɂ���ɒl��T���j
for I=1: length(Kyoku_timeMax)+1
    if 1<I && I<length(Kyoku_timeMax)+1
        StartIndex = find(Kyoku_timeMax(I-1,1)==time_s);
        EndIndex = find(Kyoku_timeMax(I,1)==time_s);
        [GKyoku_MinA(I,1), GKyoku_timeMinA(I,1),GKyoku_MinAFlag(I,1)] = TW_MinPeakMin(time_s(1,StartIndex:EndIndex)',jyusin_A_y(StartIndex:EndIndex,1));
        [GKyoku_MinB(I,1), GKyoku_timeMinB(I,1),GKyoku_MinBFlag(I,1)] = TW_MinPeakMin(time_s(1,StartIndex:EndIndex)',jyusin_B_yDash(StartIndex:EndIndex,1));
    elseif I == 1
        StartIndex = 10;%�ŏ��X�v���C�����Ńf�[�^��������Ԃ̂Œ���
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
        StartIndex = 10;%�ŏ��X�v���C�����Ńf�[�^��������Ԃ̂Œ���
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


%% �d�S�Ǝ�̓����̍��𒲂ׂ�Z��

%�ŏ��ƍŌ�𒲐�
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


%�ŏ��ƍŌ�𒲐�
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

precedenceGapNumMax = sum((GapMaxA>0) & (GapMaxB>0));%��ɒ��ׂĂ����Ȃ��Ƃ߂��Ⴍ����ɂȂ����Ⴄ�D
precedenceGapNumMin = sum((GapMinA>0) & (GapMinB>0));%��ɒ��ׂĂ����Ȃ��Ƃ߂��Ⴍ����ɂȂ����Ⴄ�D

precedenceGapNumBoth = precedenceGapNumMax + precedenceGapNumMin;

%�d�S�s�[�N����`�ł��Ȃ��ӏ����J�b�g
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

%�Y�����Ԃ̒�`
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

%�ȉ����v�ʂ̎Z�o
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
%�ȉ�
pre_Kyoku_time = [Kyoku_timeMax;Kyoku_timeMin];
[Kyoku_time, IndexKT] = sort(pre_Kyoku_time);
time_Gap_s = Kyoku_time(1,1):dt:Kyoku_time(end,1);

%���`���
GapA_s=interp1(GaptimeA(:,1),GapA(:,1),time_Gap_s);
GapB_s=interp1(GaptimeB(:,1),GapB(:,1),time_Gap_s);

%�M���b�v���Ԃ̕��ςƕW���΍����Z�o
mean_GapA_s = mean(GapA_s(~isnan(GapA_s)));
std_GapA_s = std(GapA_s(~isnan(GapA_s)));
mean_GapB_s = mean(GapB_s(~isnan(GapB_s)));
std_GapB_s = std(GapB_s(~isnan(GapB_s)));

%��s���Ԋ���
precedenceGapRateA_s = sum(GapA_s>0)/length(GapA_s);
precedenceGapRateB_s = sum(GapB_s>0)/length(GapB_s);

%�o�����Ԑ�s����
precedenceGapRateBoth_s = sum((GapA_s>0) & (GapB_s>0))/length(GapA_s);

%%%%%%%%%%%%�d�S�������̐�s���鎞�ԑт̎Z�o
PrecedenceGapFlagBoth_s = (GapA_s>0) & (GapB_s>0);

%���[��0��t���� 
PrecedenceGapFlagBoth_s = [0 PrecedenceGapFlagBoth_s 0];
diff_PrecedenceGapFlagBoth_s = diff(PrecedenceGapFlagBoth_s);

StartGapBothIndex_s = find(diff_PrecedenceGapFlagBoth_s>0);%������s���鎞�̎n�܂��Index�D
EndGapBothIndex_s = find(diff_PrecedenceGapFlagBoth_s<0);


StartGapBothTime_s = (StartGapBothIndex_s-1)*dt+time_Gap_s(1,1);
EndGapBothTime_s = (EndGapBothIndex_s-1)*dt+time_Gap_s(1,1);


%%

% %�ʑ��̒�`(�{�[�h�̓���)
% PhaseMax = zeros(length(Kyoku_timeMax),1);%��ɓʂ̏ꏊ
% PhaseMax = PhaseMax+2*pi;
% PhaseMin = zeros(length(Kyoku_timeMin),1);%���ɓʂ̏ꏊ
% PhaseMin = PhaseMin + pi;
% PhaseZero = zeros(length(Kyoku_timeMax),1);%��ɓʂ̏ꏊ�̂�����
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
% %�ʑ��̒�`(�d�S�팱��A)
% GPhaseMaxA = zeros(length(GKyoku_timeMaxA),1);%��ɓʂ̏ꏊ
% GPhaseMaxA = GPhaseMaxA+2*pi;
% GPhaseMinA = zeros(length(GKyoku_timeMinA),1);%���ɓʂ̏ꏊ
% GPhaseMinA = GPhaseMinA + pi;
% GPhaseZeroA = zeros(length(GKyoku_timeMaxA),1);%��ɓʂ̏ꏊ�̂�����
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
% %�ʑ��̒�`(�d�S�팱��B)
% GPhaseMaxB = zeros(length(GKyoku_timeMaxB),1);%��ɓʂ̏ꏊ
% GPhaseMaxB = GPhaseMaxB+2*pi;
% GPhaseMinB = zeros(length(GKyoku_timeMinB),1);%���ɓʂ̏ꏊ
% GPhaseMinB = GPhaseMinB + pi;
% GPhaseZeroB = zeros(length(GKyoku_timeMaxB),1);%��ɓʂ̏ꏊ�̂�����
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
% %�M���b�v���Ԃ̕��ςƕW���΍����Z�o
% mean_GapPhaseA_s = mean(HoseiGapPhaseA(~isnan(HoseiGapPhaseA)));
% std_GapPhaseA_s = std(HoseiGapPhaseA(~isnan(HoseiGapPhaseA)));
% mean_GapPhaseB_s = mean(HoseiGapPhaseB(~isnan(HoseiGapPhaseB)));
% std_GapPhaseB_s = std(HoseiGapPhaseB(~isnan(HoseiGapPhaseB)));
% 
% %��s�ʑ�����
% precedencePhaseRateA_s = sum(HoseiGapPhaseA>0)/length(HoseiGapPhaseA);
% precedencePhaseRateB_s = sum(HoseiGapPhaseB>0)/length(HoseiGapPhaseB);
% 
% %�o�����Ԋ���
% precedencePhaseRateBoth_s = sum((HoseiGapPhaseA>0) & (HoseiGapPhaseB>0))/length(HoseiGapPhaseA);
% 
% %%%%%%%%%%%%�����̏d�S�̈ʑ�����s���鎞�ԑт̎Z�o
% 
% PrecedencePhaseFlagBoth_s = (HoseiGapPhaseA>0) & (HoseiGapPhaseB>0);
% 
% 
% PrecedencePhaseFlagBoth_s = [0 PrecedencePhaseFlagBoth_s 0];
% diff_PrecedencePhaseFlagBoth_s = diff(PrecedencePhaseFlagBoth_s);
% StartPhaseBothIndex_s = find(diff_PrecedencePhaseFlagBoth_s>0);%������s���鎞�̎n�܂��Index�D
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
%%%%%�ʑ��̍������邽�߂̃O���t
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

% N=1;%�t�B���^�̎���
% Fs=200; %�T���v�����O���g��
% t=0.015;
% Fc=1/(2*pi*t);
% Wn = Fc/(Fs/2); %�J�b�g�I�t���g��
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



% %% FFT���
% %%%%%%%%%%%%�ʒu����FFT
% fs = 1/dt;%�T���v�����O���g��
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
% %%%%%%%%%%%%�d�S����FFT
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
%% �s�[�N���Z�o�ł��Ȃ������̎Z�o

NotFoundGMaxANum = sum(GKyoku_MaxAFlag);
NotFoundGMaxBNum = sum(GKyoku_MaxBFlag);
NotFoundGMinANum = sum(GKyoku_MinAFlag);
NotFoundGMinBNum = sum(GKyoku_MinBFlag);

NotFoundGANum = NotFoundGMaxANum +NotFoundGMinANum; 
NotFoundGBNum = NotFoundGMaxBNum +NotFoundGMinBNum; 




