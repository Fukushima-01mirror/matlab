function[peaktime_zx, peakValue_zx] = findpeaksPulse_cycleData_func(Pul, cycle_data)

% 
%   input tempPul
%         x_avt0 data0
%   output avt_data         1[ms]
%       1列目    アバタ速度
%       2列目    アバタ位置
%   cycle_data  ゼロクロスサイクル
%       1列目    ゼロクロス時間
%       2列目    ゼロクロス積算値
%       3列目    対数演算前の速度
%       4列目    アバタ速度


k=1;
bBreak = 0;
bPlus = 1;
bMinus = 1;
n_data = length(tempPul);
n_data0 = length(data0);

for Pul0=1:1000     %コントローラ操作量の初期値
    
    for signPul0 =1:2     %コントローラ操作量の初期値の正負
        
        for bCalc=1:2       %アバタ位置算出タイミング
            
            if signPul0 == 1 && bMinus    %初期値マイナス
            	[avt_temp_data, cycle_data] = Rhythm.rhythm1_temp_cycle_data(data0(1,2), tempPul, cnst_a, cnst_b, -(Pul0-1), bCalc-1);
            elseif signPul0 == 2 && bPlus    %初期値プラス
                [avt_temp_data, cycle_data] = Rhythm.rhythm1_temp_cycle_data(data0(1,2), tempPul, cnst_a, cnst_b, Pul0-1, bCalc-1);
            end
                
            for i=1:n_data0
                error(i) = avt_temp_data(i*20,2)-data0(i,2);
            end
            Err(k,1) = mean(abs(error));
            Err(k,2) = std( error(100:n_data0) );

            if signPul0 == 1 && Pul0 >1    %初期値マイナス
            	bMinus = Err(k,1)- Err(k-4,1) <0 ;     %誤差が大きくなったら，bMinusはfalse
            elseif signPul0 == 2 && Pul0 >1    %初期値プラス
            	bPlus = Err(k,1)- Err(k-4,1) <0 ;     %誤差が大きくなったら，bPlusはfalse
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



