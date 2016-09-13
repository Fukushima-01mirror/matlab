function hist_ZCycleData( t_zc , data, zcTimes )

    t_st = 10000;
    data_zc = data(  zcTimes(:,1)<2 & zcTimes(:,2)<2  &  t_zc  > t_st  );
    data_nzc = data( zcTimes(:,1)>1 | zcTimes(:,2)>1 &  t_zc  >  t_zc );
    
    limMax = ceil(max(data_zc)/100)*100;
    x = 10:20:limMax-10;
    nData_zc = hist( data_zc , x);
    nData_nzc = hist( data_nzc , x);
    N = sum(nData_zc) + sum(nData_nzc);
    mdata = mean(data_zc);
    sdata = std(data_zc);
    hBar = bar( x, [nData_zc.'/N nData_nzc.'/N], 1,'Stack');
    hold on
        plot([mdata mdata] ,[0 1] , 'r');
        plot([mdata-sdata mdata-sdata] ,[0 1] , ':k');
        plot([mdata+sdata mdata+sdata] ,[0 1] , ':k');
    hold off
    set(hBar(2),'FaceColor', 'w' );
    xlim([0 600]);    set(gca, 'XTick', [0:100:600]);
    ylim([0 0.8]);
    title({ ['平均:' num2str(mdata) ', 標準偏差:' num2str(sdata) ]; ...
    ['データ数:' num2str(N) ', ゼロクロス間で複数ピークをもつ割合:' num2str( sum(nData_nzc)/N *100) '[%]' ] });
    


end