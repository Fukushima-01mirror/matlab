function tsPlot_Period( data_ts )

    simplot(data_ts)
    xlim([0 60]);    ylim([0 150]);
    set(gca, 'XTick', [0:100:600]);
    
%     title( ['•½‹Ï' mean]);


end