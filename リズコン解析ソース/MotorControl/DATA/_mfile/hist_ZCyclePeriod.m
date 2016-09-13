function hist_ZCyclePeriod( data_ts ,ts )

    temp_zct = zeros(6000);
    j=1;
    for i = 5/ts+1 : length(data_ts)
        if data_ts(i) ~= data_ts(i-1)
            temp_zct(j) = data_ts(i);
            j= j+1;
        end
    end
    data_zct = temp_zct(temp_zct ~=0);
    x = 10:20:590;
    hist( data_zct , x);
    xlim([0 600]);    ylim([0 200]);
    set(gca, 'XTick', [0:100:600]);
    
%     title( ['•½‹Ï' mean]);


end