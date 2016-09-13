function[avt_temp_data, cycle_temp_data] = rhythm1_temp_cycle_data(x0, Pul, cnst_a, cnst_b, Pul0, bCalc)
%   output avt_data         1[ms]
%       1列目    アバタ速度
%       2列目    アバタ位置
%   cycle_temp_data  ゼロクロスサイクル
%       1列目    ゼロクロス時間
%       2列目    ゼロクロス積算値
%       3列目    対数演算前の速度
%       4列目    アバタ速度

n_data = length(Pul);
%n_data0 = length(data0);

%コントローラ操作量
avt_temp_data = zeros(n_data,2);
avt_temp_data(1,2) = x0;    %アバタ位置初期値

devPul = Pul + Pul0 * ones(n_data,1);   

v_avt = zeros(n_data,1);
S_Pul = zeros(1000,2);
% S_pul(1,2)=devPul(1); %←0?

j=1;                            %ゼロクロスカウント
for t= 2 : n_data
    if bCalc == 1
        S_Pul(j,2) = S_Pul(j,2) + devPul(t);
    end
    v_avt(t) = v_avt(t-1);
    
    if devPul(t-1) * devPul(t) <0 || (devPul(t)==0 && devPul(t) - devPul(t-1) ~= 0)
    % ゼロクロス時
        bCalc =1;
        S_Pul(j,1)=t;
        cycle_temp_data(j,1) = t; 
        cycle_temp_data(j,2) = S_Pul(j,2); 
        
        if j>1 && S_Pul(j-1,2) ~= 0   % アバター速度計算
            v_avt(t) = S_Pul(j,2) + S_Pul(j-1,2);
            cycle_temp_data(j,3) = v_avt(t); 
            if v_avt(t)>0
            % アバター位置計算
                avt_temp_data(t,1) = - cnst_a *log(v_avt(t)/cnst_b +1)*0.001;
            else
                avt_temp_data(t,1) = + cnst_a *log(-v_avt(t)/cnst_b +1)*0.001;
            end
            cycle_temp_data(j,4) = avt_temp_data(t,1); 
        end
        
        j=j+1;
    end
    
    if v_avt(t)>0
    % アバター位置計算
        avt_temp_data(t,1) = - cnst_a *log(v_avt(t)/cnst_b +1)*0.001;
    else
        avt_temp_data(t,1) = + cnst_a *log(-v_avt(t)/cnst_b +1)*0.001;
    end
    avt_temp_data(t,2) = avt_temp_data(t-1,2) +avt_temp_data(t,1);
    
%     % 5秒毎に修正
%     if mod(i,5000)==0
%         val_mdfy = avt_data(i,3) -data0(i/20+1,3);
%         avt_data(i-4999:i,3) = avt_data(i-4999:i,3) - val_mdfy *ones(5000,1);
%     end
%     
    x_min = 0;
    x_max = 1000;
    if avt_temp_data(t,2) < x_min
        avt_temp_data(t,2) = x_min;
    elseif avt_temp_data(t,2) > x_max
        avt_temp_data(t,2) = x_max;
    end
    
%     val_mdfy = avt(end,3) -data0(end,3);
%     avt(:,3) = avt(:,3) - val_mdfy *ones(n_data,1);

end


