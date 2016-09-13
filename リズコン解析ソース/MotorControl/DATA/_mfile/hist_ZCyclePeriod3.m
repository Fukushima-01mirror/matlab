function hist_ZCyclePeriod3( t_zc , data, zcTimes )

    t_st = 5000;
    data_zc = data(  zcTimes(:,1)<2 & zcTimes(:,2)<2  &  t_zc  > t_st  );
    data_nzc = data( zcTimes(:,1)>1 | zcTimes(:,2)>1 &  t_zc  >  t_zc );

    x = 10:20:590;
    nData_zc = hist( data_zc , x);
    nData_nzc = hist( data_nzc , x);
    N = sum(nData_zc) + sum(nData_nzc);
    mdata = mean(data_zc);
    sdata = std(data_zc);
    hBar = bar( x, [nData_zc.'/N nData_nzc.'/N], 'Stack');
    hold on
        plot([mdata mdata] ,[0 1] , 'r');
        plot([mdata-sdata mdata-sdata] ,[0 1] , ':k');
        plot([mdata+sdata mdata+sdata] ,[0 1] , ':k');
    hold off
    set(hBarV(2),'FaceColor', 'w' );
    xlim([0 600]);    ylim([0 0.8]);
    set(gca, 'XTick', [0:100:600]);
    title( ['平均' num2str(mdata) ', 標準偏差' num2str(sdata) ', データ数' num2str(length(period_zct))]);
    


end