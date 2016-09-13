function hist_ZCyclePeak2( data_ts ,ts )
%UNTITLED3 この関数の概要をここに記述
%   詳細説明をここに記述

    temp_zct = zeros(6000);
    j=1;
    peak = data_ts.signals(1, 1).values;
    for i = 5/ts+1 : length(peak)
        if peak(i) ~= peak(i-1)
            temp_zct(j) = peak(i);
            j= j+1;
        end
    end
    peak_zct = temp_zct( temp_zct >0 & temp_zct <500 );
    x = 10:20:990;
    n = hist( peak_zct , x);
    mPeak = mean(peak_zct);
    sPeak = std(peak_zct);
    bar(x,n/length(peak_zct),1)
    hold on
        plot([mPeak mPeak] ,[0 1] , 'r');
        plot([mPeak-sPeak mPeak-sPeak] ,[0 1] , ':k');
        plot([mPeak+sPeak mPeak+sPeak] ,[0 1] , ':k');
    hold off
    xlim([0 1000]);    ylim([0 0.8]);
    set(gca, 'XTick', [0:100:1000]);
    title( ['平均' num2str(mPeak) ', 標準偏差' num2str(sPeak) ', データ数' num2str(length(peak_zct))]);


end

