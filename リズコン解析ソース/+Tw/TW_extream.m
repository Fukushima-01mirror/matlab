function [AV,BV,A,B] = TW_extream(X,Y,TCX)

if length(X) ~= length(Y)
    error('Error!');
end

%��x�N�g���ɕϊ�
if length(X(1,:)) < length(X(:,1))
    X = X';
end
if length(Y(1,:)) < length(Y(:,1))
    Y = Y';
end

dt =(X(1,end)-X(1,1))/length(X);

%%%%%%%%%%%%�ʒu�f�[�^�Ƀt�B���^��������
% N=1;%�t�B���^�̎���
% Fs=1/dt; %�T���v�����O���g��
% t=TCX;
% Fc=1/(2*pi*t);
% Wn = Fc/(Fs/2); %�J�b�g�I�t���g��
% [b,a]= butter(N, Wn);
% fY=filtfilt(b,a,Y);

vel = diff(Y)/dt;

% %%%%%%%%%%%%���x�f�[�^�Ƀt�B���^��������
% N=1;%�t�B���^�̎���
% Fs=1/dt; %�T���v�����O���g��
% t=TCV;
% Fc=1/(2*pi*t);
% Wn = Fc/(Fs/2); %�J�b�g�I�t���g��
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