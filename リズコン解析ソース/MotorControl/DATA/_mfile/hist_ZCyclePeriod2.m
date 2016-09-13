function hist_ZCyclePeriod2( data_ts ,ts )

    temp_zct = zeros(6000);
    j=1;
    period = data_ts.signals(1, 2).values;
    peak = data_ts.signals(1, 1).values;
    for i = 5/ts+1 : length(period)
        if peak(i) ~= peak(i-1)
            temp_zct(j) = period(i);
            j= j+1;
        end
    end
    period_zct = temp_zct( temp_zct >0 & temp_zct <500 );
    x = 10:20:590;
    n = hist( period_zct , x);
    mPeriod = mean(period_zct);
    sPeriod = std(period_zct);
    bar(x,n/length(period_zct),1)
    hold on
        plot([mPeriod mPeriod] ,[0 1] , 'r');
        plot([mPeriod-sPeriod mPeriod-sPeriod] ,[0 1] , ':k');
        plot([mPeriod+sPeriod mPeriod+sPeriod] ,[0 1] , ':k');
    hold off
    xlim([0 600]);    ylim([0 0.8]);
    set(gca, 'XTick', [0:100:600]);
    title( ['平均' num2str(mPeriod) ', 標準偏差' num2str(sPeriod) ', データ数' num2str(length(period_zct))]);
    


end