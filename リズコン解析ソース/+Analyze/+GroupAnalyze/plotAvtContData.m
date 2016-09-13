% 各条件データ（アバタ速度，対数処理前速さ，周期（半周期，和，差），振幅（半周期，和，差）のヒストグラム
function plotAvtContData(dataGroup)

numGroup = length(dataGroup);
MonitorSize = [ 0, 0, numGroup*400, 1000];
set(gcf, 'Position', MonitorSize);

for i= 1:numGroup
    
    subplot(3,numGroup,i);
    plot(dataGroup(i).data.time.highSampled , dataGroup(i).data.avatarVelocity.highSampled  );
    hold on 
        Htp = plot(dataGroup(i).data.taskTime, dataGroup(i).data.taskVelocity );
        Htm = plot(dataGroup(i).data.taskTime, -dataGroup(i).data.taskVelocity );
    hold off
    set(Htp, 'Color', 'k', 'LineWidth', 2.5 , 'LineStyle', ':');   
    set(Htm, 'Color', 'k', 'LineWidth', 2.5 , 'LineStyle', ':');
    dataLength = length(dataGroup(i).data.zeroCrossData);
    title( [ 'アバタ速度 　操作速度誤差:' num2str(dataGroup(i).data.errorVelocity) ] );
    ylim([-0.5 0.5]);    set(gca,'YTick', [-0.5:0.1:0.5]);
    
    subplot(3,numGroup,numGroup+i);
    plot(dataGroup(i).data.time.highSampled , dataGroup(i).data.avatarPosition.highSampled  );
    hold on 
        Htp = plot( dataGroup(i).data.taskTime, dataGroup(i).data.taskPosition );
        Htm = plot(  flipud( dataGroup(i).data.taskTime ), dataGroup(i).data.taskPosition );
    hold off
    set(Htp, 'Color', 'k', 'LineWidth', 2.5 , 'LineStyle', ':');   
    set(Htm, 'Color', 'k', 'LineWidth', 2.5 , 'LineStyle', ':');
    dataLength = length(dataGroup(i).data.zeroCrossData);
    title( [ 'アバタ位置 　操作速度誤差:' num2str(dataGroup(i).data.errorVelocity) ] );
    ylim([0,1000]);    set(gca,'YTick', [0:100:1000]);

    subplot(3,numGroup,2*numGroup+i);
    plot(dataGroup(i).data.time.highSampled , dataGroup(i).data.operatePulse.highSampled  );
    dataLength = length(dataGroup(i).data.zeroCrossData);
    title( [ 'コントローラ操作 　操作速度誤差:' num2str(dataGroup(i).data.errorVelocity) ] );
    ylim([-500,500]);    set(gca,'YTick', [-500:100:500]);

end

