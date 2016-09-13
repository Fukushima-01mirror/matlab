function [Max,Time,RES] = TW_MaxPeakMax(X,Y)

dt =(X(end,1)-X(1,1))/(length(X)-1);

%�w�肵���̈�̒��̋ɑ�l�̍ő�l��Ԃ�

% N=1;%�t�B���^�̎���
% t=0.015;
% Fc=1/(2*pi*t);
% Wn = Fc/(Fs/2); %�J�b�g�I�t���g��
% [b,a]= butter(N, Wn);

%���x�̎Z�o
dposition = diff(Y);

hoge = dposition(1:(end-1),1).* dposition(2:end,1);

MaxPeakIndex = find(hoge<0);
hresult = isempty(MaxPeakIndex);

if hresult==0
    if sum(dposition(MaxPeakIndex)>0)>0
        MaxPeak = Y(MaxPeakIndex+1,1);
        [MaxPeakMax MaxPeakMaxIndex]= max(MaxPeak);
        MaxPeakMaxTime = (MaxPeakIndex(MaxPeakMaxIndex,1)) * dt+ X(1,1);
        RES = hresult;
        Max = MaxPeakMax;
        Time = MaxPeakMaxTime;
    else
        RES = 1;
        Max = 0;
        Time = 0;
    end
else
    RES = hresult;
    Max = 0;
    Time = 0;
end


