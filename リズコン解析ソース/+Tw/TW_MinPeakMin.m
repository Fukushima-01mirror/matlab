function [Min,Time,RES] = TW_MinPeakMin(X,Y)

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

MinPeakIndex = find(hoge<0);
hresult = isempty(MinPeakIndex);

if hresult==0
    if sum(dposition(MinPeakIndex)<0)>0
        MinPeak = Y(MinPeakIndex+1,1);
        [MinPeakMin MinPeakMinIndex]= min(MinPeak);
        MinPeakMinTime = (MinPeakIndex(MinPeakMinIndex,1)) * dt+ X(1,1);
        RES = hresult;
        Min = MinPeakMin;
        Time = MinPeakMinTime;
    else
        RES = 1;
        Min = 0;
        Time = 0;
    end
else
    RES = hresult;
    Min = 0;
    Time = 0;
end


