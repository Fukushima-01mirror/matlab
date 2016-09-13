function[Pul, avt_data, cycle_data, Err] = rhythmAvt1_cpShift_cycle_data_func(tempPul, data0, crossData, cnst_a, cnst_b)

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
bErrIncrease =0;
bPlus = 0;
bMinus = 0;
bPlusC = 0;
bMinusC = 0;
n_data = length(tempPul);
n_data0 = length(data0);

bPlusNonCross =0;
bMinusNonCross =0;

tempPul = tempPul - round( mean(tempPul) );

for Pul0=1:300     %コントローラ操作量の初期値
    
    for signPul0 =1:2     %コントローラ操作量の初期値の正負

        if signPul0 == 1      %初期値マイナス 
            devPul = tempPul + ( -(Pul0-1)) * ones(n_data,1) - crossData;   
            if max(devPul) > 0
                [avt_temp_data1, cycle_data1] ...
                    = rhythm1_cpShift_temp_cycle_data(data0(1,2), tempPul, crossData, cnst_a, cnst_b, -(Pul0-1), 0);
                 [avt_temp_data2, cycle_data2] ...
                    = rhythm1_cpShift_temp_cycle_data(data0(1,2), tempPul, crossData, cnst_a, cnst_b, -(Pul0-1), 1);
            else
                bMinusNonCross =1;  break;
            end
       elseif signPul0 == 2     %初期値プラス
            devPul = tempPul + ( Pul0-1) * ones(n_data,1) - crossData;   
            if min(devPul) < 0
                [avt_temp_data1, cycle_data1] ...
                    = rhythm1_cpShift_temp_cycle_data(data0(1,2), tempPul, crossData, cnst_a, cnst_b, Pul0-1, 0);
                [avt_temp_data2, cycle_data2] ...
                    = rhythm1_cpShift_temp_cycle_data(data0(1,2), tempPul, crossData, cnst_a, cnst_b, Pul0-1, 1);
            else
                bPlusNonCross =1;   break;
            end
        end

        for i=1:floor( n_data0)
            error(i,1) = avt_temp_data1(i*20,2)-data0(i,2);
            error(i,2) = avt_temp_data2(i*20,2)-data0(i,2);
        end
        Err(k,1) = min( mean(abs(error)) );
        Err(k,2) = min( std( error(500:end,:) ) );
        
        figure(50);
        t=1:n_data;
%         plot(t, avt_temp_data1(:,2), data0(:,1), data0(:,2));


        %誤差の傾向から，初期値の正負と誤差の極小値を判定
        if signPul0 == 1 && Pul0 > 1    %初期値マイナス
            if ( bMinus || bPlusNonCross ) && ( Err(k-2,1) < 20 || Err(k-2,2) <25 ) %前回誤差小
                bErrIncrease = Err(k,1)- Err(k-2,1) >0; %誤差が大きくなったら，bErrIncreaseがtrueに
                bMinusC = true;
            else
                bMinus = Err(k,1)- Err(k-2,1) <0 ;      %誤差が小さくなったら，bMinusをtureに
            end
        elseif signPul0 == 2 && Pul0 > 1    %初期値プラス
            if ( bPlus || bMinusNonCross )&& ( Err(k-2,1) < 20 || Err(k-2,2) <25 ) %前回誤差小
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
    
    if Pul0 > 1 && bMinus==0 && bPlus==0 && Err(1,1) < 15
        bErrIncrease = 1;       % 正負共に誤差が大きくなり，かつ，はじめの誤差が小さい時
                                %           (Pul0が0の時)
    end
    if Pul0 > 300 && bMinus==0 && bPlus==0 && Err(k-2,1) > 100  && Err(k-1,1) > 100     
                disp('1P再計算不能');
                pause on;
                pause;
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
% if bErrIncrease ==1

if Pul0 ==2
    [avt_temp_data1, cycle_data1] ...
     = rhythm1_cpShift_temp_cycle_data(data0(1,2), tempPul, crossData, cnst_a, cnst_b, (Pul0-2), 0);
    [avt_temp_data2, cycle_data2] ...
     = rhythm1_cpShift_temp_cycle_data(data0(1,2), tempPul, crossData, cnst_a, cnst_b, (Pul0-2), 1);
elseif bMinusC    %初期値マイナス
    [avt_temp_data1, cycle_data1] ...
     = rhythm1_cpShift_temp_cycle_data(data0(1,2), tempPul, crossData, cnst_a, cnst_b, -(Pul0-2), 0);
    [avt_temp_data2, cycle_data2] ...
     = rhythm1_cpShift_temp_cycle_data(data0(1,2), tempPul, crossData, cnst_a, cnst_b, -(Pul0-2), 1);
elseif bPlusC    %初期値プラス
    [avt_temp_data1, cycle_data1] ...
     = rhythm1_cpShift_temp_cycle_data(data0(1,2), tempPul, crossData, cnst_a, cnst_b, (Pul0-2), 0);
    [avt_temp_data2, cycle_data2] ...
     = rhythm1_cpShift_temp_cycle_data(data0(1,2), tempPul, crossData, cnst_a, cnst_b, (Pul0-2), 1);
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
    
    figure(50);
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

    figure(50);
    t=1:n_data;
    plot(t, avt_temp_data2(:,2), data0(:,1), data0(:,2));

end

if Pul0 ==2 
    Pul = tempPul - (Pul0-2) * ones(n_data,1);
elseif bMinusC
    Pul = tempPul - (Pul0-2) * ones(n_data,1);
elseif bPlusC
    Pul = tempPul + (Pul0-2) * ones(n_data,1);
end



