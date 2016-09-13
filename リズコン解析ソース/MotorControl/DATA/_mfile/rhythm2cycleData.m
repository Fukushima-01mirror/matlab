function[ cycleData , period_zc, peak_zc , zcTimes] = rhythm2cycleData(Pul, crossData , cnst_a, cnst_b)
%   cycleData  �[���N���X�T�C�N��
%       �[���N���X����    �[���N���X�ώZ�l
%       �ΐ����Z�O�̑��x    �A�o�^���x

%   period_zx   �[���N���X���ԊԊu   �����@�����̍�
%   peak_zx     �s�[�N�l   �U���@�s�[�N�l�̍�

n_data = length(Pul);

cycleData = zeros(10000,1);
S_Pul = zeros(10000,2);

devPul = Pul - crossData;
j=1;                            %�[���N���X�J�E���g
for t= 2 : n_data
    S_Pul(j,2) = S_Pul(j,2) + devPul(t);

    if devPul(t-1) * devPul(t) <0 || (devPul(t)==0 && devPul(t) - devPul(t-1) ~= 0)
    % �[���N���X��
        S_Pul(j,1)=t;
        cycleData(j,1) = t; 
        cycleData(j,2) = S_Pul(j,2); 
        if j>1 && S_Pul(j-1,2) ~= 0   % �A�o�^�[���x�v�Z
            cycleData(j,3) = S_Pul(j,2) + S_Pul(j-1,2);
            if cycleData(j,3)>0
            % �A�o�^�[���x�v�Z
                cycleData(j,4) = - cnst_a *log(cycleData(j,3)/cnst_b +1)*0.001;
            else
                cycleData(j,4) = + cnst_a *log(-cycleData(j,3)/cnst_b +1)*0.001;
            end
        end
        j=j+1;
    end
end
cycleData(j:end,:) = [];

n_zc = j-1;
peak_zc = zeros(n_zc,3);
period_zc = zeros(n_zc,3);
zcTimes = zeros(n_zc,2);
for i=2:n_zc
    period_zc(i,1) = cycleData(i) -cycleData(i-1); 
    Pul_zc = Pul( cycleData(i-1,1) : cycleData(i,1) );
    if mean( Pul_zc )  >= 0 && length( Pul_zc ) >3   %�g�`�����̂Ƃ�
        [pks,locs] = findpeaks( abs(Pul_zc) );
        peakValue = max(pks);
        if ~isempty( peakValue)
            peak_zc(i,1) = peakValue;
            zcTimes(i,1) = length(pks);
            zcTimes(i,2) = zcTimes(i-1,1);
        end

    elseif mean( Pul_zc )  < 0 && length( Pul_zc ) >3                                                        %�g�`�����̂Ƃ�
        [pks,locs] = findpeaks( abs(Pul_zc) );
        peakValue = max(pks);
        if ~isempty( peakValue)
            peak_zc(i,1) = -peakValue;
            zcTimes(i,1) = length(pks);
            zcTimes(i,2) = zcTimes(i-1,1);
        end
    end
end

for i= 3 : n_zc
    period_zc(i,2) =  period_zc(i,1) + period_zc(i-1,1);
    period_zc(i,3) =  period_zc(i,1) - period_zc(i-1,1);
end
for i= 3 : n_zc
    peak_zc(i,2) =  abs( peak_zc(i-1,1) ) + abs( peak_zc(i,1) ) ;
    peak_zc(i,3) =  abs( peak_zc(i-1,1) ) - abs( peak_zc(i,1) ) ;
end





