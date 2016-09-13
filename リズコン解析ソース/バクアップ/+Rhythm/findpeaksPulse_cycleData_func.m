function[peaktime_zx, peakValue_zx] = findpeaksPulse_cycleData_func(Pul, cycle_data)

% 
%   input tempPul
%         x_avt0 data0
%   output avt_data         1[ms]
%       1���    �A�o�^���x
%       2���    �A�o�^�ʒu
%   cycle_data  �[���N���X�T�C�N��
%       1���    �[���N���X����
%       2���    �[���N���X�ώZ�l
%       3���    �ΐ����Z�O�̑��x
%       4���    �A�o�^���x


k=1;
bBreak = 0;
bPlus = 1;
bMinus = 1;
n_data = length(tempPul);
n_data0 = length(data0);

for Pul0=1:1000     %�R���g���[������ʂ̏����l
    
    for signPul0 =1:2     %�R���g���[������ʂ̏����l�̐���
        
        for bCalc=1:2       %�A�o�^�ʒu�Z�o�^�C�~���O
            
            if signPul0 == 1 && bMinus    %�����l�}�C�i�X
            	[avt_temp_data, cycle_data] = Rhythm.rhythm1_temp_cycle_data(data0(1,2), tempPul, cnst_a, cnst_b, -(Pul0-1), bCalc-1);
            elseif signPul0 == 2 && bPlus    %�����l�v���X
                [avt_temp_data, cycle_data] = Rhythm.rhythm1_temp_cycle_data(data0(1,2), tempPul, cnst_a, cnst_b, Pul0-1, bCalc-1);
            end
                
            for i=1:n_data0
                error(i) = avt_temp_data(i*20,2)-data0(i,2);
            end
            Err(k,1) = mean(abs(error));
            Err(k,2) = std( error(100:n_data0) );

            if signPul0 == 1 && Pul0 >1    %�����l�}�C�i�X
            	bMinus = Err(k,1)- Err(k-4,1) <0 ;     %�덷���傫���Ȃ�����CbMinus��false
            elseif signPul0 == 2 && Pul0 >1    %�����l�v���X
            	bPlus = Err(k,1)- Err(k-4,1) <0 ;     %�덷���傫���Ȃ�����CbPlus��false
            end

            k=k+1;
            
            figure(50);
            t=1:n_data;
            plot(t, avt_temp_data(:,2), data0(:,1), data0(:,2));
            
            if Err(k-1,1) <5 && Err(k-1,2) <5
                bBreak =1;
                break
            end
        end
        if bBreak ==1
            break
        end
    end
    if bBreak ==1
        break
    end
end

if signPul0 == 1
    Pul = tempPul - Pul0 * ones(n_data,1);
elseif signPul0 == 2
    Pul = tempPul + Pul0 * ones(n_data,1);
end

if Err(k-1,1) <10
    avt_data = avt_temp_data;
else
    avt_data = avt_temp_data - error(end);
end



