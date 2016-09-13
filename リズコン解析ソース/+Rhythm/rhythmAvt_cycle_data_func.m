function[Pul, avt_data, cycle_data, Err] = rhythmAvt_cycle_data_func(tempPul, data0, cnst_a, cnst_b, suffix)

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

Err_1_border = 20; %Err(?,1)のボーダー100
Err_2_border = 3;  %Err(?,2)のボーダー10

k=1;
bErrIncrease =0;
bPlus = 0;
bMinus = 0;
bPlusC = 0;
bMinusC = 0;
n_data = length(tempPul);
n_data0 = length(data0);

tempPul = tempPul - round( mean(tempPul) );

Pul_max = max(abs(tempPul));
disp('Pul_max');
disp(Pul_max);



for border = 1:3
    for Pul0 = 1:Pul_max     %コントローラ操作量の初期値(300→Pul_max)
        for signPul0 = 1:2     %コントローラ操作量の初期値の正負
            if signPul0 == 1      %初期値マイナス 
                [avt_temp_data1, cycle_data1] ...
                    = Rhythm.rhythm_temp_cycle_data(data0(1,2), tempPul, cnst_a, cnst_b, -(Pul0-1), 0, suffix);
                [avt_temp_data2, cycle_data2] ...
                    = Rhythm.rhythm_temp_cycle_data(data0(1,2), tempPul, cnst_a, cnst_b, -(Pul0-1), 1, suffix);
            elseif signPul0 == 2     %初期値プラス
                [avt_temp_data1, cycle_data1] ...
                    = Rhythm.rhythm_temp_cycle_data(data0(1,2), tempPul, cnst_a, cnst_b, Pul0-1, 0, suffix);
                [avt_temp_data2, cycle_data2] ...
                    = Rhythm.rhythm_temp_cycle_data(data0(1,2), tempPul, cnst_a, cnst_b, Pul0-1, 1, suffix);
            end

            for i=1:floor( n_data0)
                error(i,1) = avt_temp_data1(i*20,2)-data0(i,2);
                error(i,2) = avt_temp_data2(i*20,2)-data0(i,2);
            end
            Err(k,1) = min( mean(abs(error)) );
            Err(k,2) = min( std( error(100:end,:) ) );
            
            disp('Err');
            disp(Err);

            %誤差の傾向から，初期値の正負と誤差の極小値を判定
            if signPul0 == 1 && Pul0 > 1    %初期値マイナス
                if bMinus && ( Err(k-2,1) < Err_1_border || Err(k-2,2) < Err_2_border )  %前回誤差小
                    bErrIncrease = Err(k,1)- Err(k-2,1) >0; %誤差が大きくなったら，bErrIncreaseがtrueに
                    bMinusC = true;
                else
                    bMinus = Err(k,1)- Err(k-2,1) <0 ;      %誤差が小さくなったら，bMinusをtureに
                end
            elseif signPul0 == 2 && Pul0 > 1    %初期値プラス
                if bPlus && ( Err(k-2,1) < Err_1_border || Err(k-2,2) < Err_2_border )  %前回誤差小
                    bErrIncrease = Err(k,1)- Err(k-2,1) >0; %誤差が大きくなったら，bErrIncreaseがtrueに
                    bPlusC = true;
                else
                    bPlus = Err(k,1)- Err(k-2,1) <0 ;     %誤差が小さくなったら，bPlusはtrueに
                end
            end
            if bErrIncrease ==1
                break
            end

            k=k+1;

        end     % for signPul0 =1:2　閉じ

        if Pul0 > 1 && bMinus==0 && bPlus==0 && Err(1,1) < Err_1_border     
            bErrIncrease = 1;       % 正負共に誤差が大きくなり，かつ，はじめの誤差が小さい時
                                    %           (Pul0が0の時)
        end
        if Pul0 > 150 && bMinus==0 && bPlus==0 && Err(k-2,1) > 100  && Err(k-1,1) > 100
            %150→300 20160823
            if border == 3
                disp('2P再計算不能');
                pause on;
                pause;
            else
                break
            end
        end

        if bMinus==1 && bPlus==1
            if Err(k-2,1) < Err(k-1,1)
                bPlus =0;
            else
                bMinus =0;
            end
        end

        if bErrIncrease ==1
            break
        end

    end         % for Pul0=1:1000　閉じ
    if bErrIncrease == 1
        break
    end
    Err_1_border = Err_1_border + 40; %Err(?,1)のボーダー100
    Err_2_border = Err_2_border + 3;  %Err(?,2)のボーダー10
    
    
end             % for border=1:3 閉じ


if Pul0 ==2    %初期値マイナス
    [avt_temp_data1, cycle_data1] ...
        = Rhythm.rhythm_temp_cycle_data(data0(1,2), tempPul, cnst_a, cnst_b, (Pul0-2), 0, suffix);
    [avt_temp_data2, cycle_data2] ...
        = Rhythm.rhythm_temp_cycle_data(data0(1,2), tempPul, cnst_a, cnst_b, -(Pul0-2), 1, suffix);
elseif bMinusC    %初期値マイナス
    [avt_temp_data1, cycle_data1] ...
        = Rhythm.rhythm_temp_cycle_data(data0(1,2), tempPul, cnst_a, cnst_b, -(Pul0-2), 0, suffix);
    [avt_temp_data2, cycle_data2] ...
        = Rhythm.rhythm_temp_cycle_data(data0(1,2), tempPul, cnst_a, cnst_b, -(Pul0-2), 1, suffix);
elseif bPlusC    %初期値プラス
    [avt_temp_data1, cycle_data1] ...
        = Rhythm.rhythm_temp_cycle_data(data0(1,2), tempPul, cnst_a, cnst_b, (Pul0-2), 0, suffix);
    [avt_temp_data2, cycle_data2] ...
        = Rhythm.rhythm_temp_cycle_data(data0(1,2), tempPul, cnst_a, cnst_b, (Pul0-2), 1, suffix);
end

for i=1:n_data0
    error1(i) = avt_temp_data1(i*20,2)-data0(i,2);
    error2(i) = avt_temp_data2(i*20,2)-data0(i,2);
end
Err1(1,1) = mean(abs(error1));
Err1(1,2) = std( error1(100:n_data0) );
Err2(1,1) = mean(abs(error2));
Err2(1,2) = std( error2(100:n_data0) );

if Err1(1,1) < Err2(1,1)
    error = error1;
    if Err1(1,2) <1    % 誤差の分散が小さい時
        avt_data(:,1) = avt_temp_data1(:,1);      %誤差の平均値でオフセット
        avt_data(:,2) = avt_temp_data1(:,2) - error1(end);      %誤差の平均値でオフセット
    else
        avt_data = avt_temp_data1;
    end
    cycle_data = cycle_data1;
    Err = Err1;
    
    figure(str2num(suffix));
    t=1:n_data;
    plot(t, avt_temp_data1(:,2), data0(:,1), data0(:,2));
    
else
    error = error2;
    if Err1(1,2) <1    % 誤差の分散が小さい時
        avt_data(:,1) = avt_temp_data2(:,1);      %誤差の平均値でオフセット
        avt_data(:,2) = avt_temp_data2(:,2) - error2(end);      %誤差の平均値でオフセット
    else
        avt_data = avt_temp_data2;
    end
    cycle_data = cycle_data2;
    Err = Err2;

    figure(str2num(suffix));
    t=1:n_data;
    plot(t, avt_temp_data2(:,2), data0(:,1), data0(:,2));

end

if Pul0 ==2 
    Pul = tempPul - (Pul0-2) * ones(n_data,1);
elseif bMinus
    Pul = tempPul - (Pul0-2) * ones(n_data,1);
elseif bPlus
    Pul = tempPul + (Pul0-2) * ones(n_data,1);
end



