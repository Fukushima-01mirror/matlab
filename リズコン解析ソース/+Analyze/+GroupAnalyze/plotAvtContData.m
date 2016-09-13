% �e�����f�[�^�i�A�o�^���x�C�ΐ������O�����C�����i�������C�a�C���j�C�U���i�������C�a�C���j�̃q�X�g�O����
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
    title( [ '�A�o�^���x �@���쑬�x�덷:' num2str(dataGroup(i).data.errorVelocity) ] );
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
    title( [ '�A�o�^�ʒu �@���쑬�x�덷:' num2str(dataGroup(i).data.errorVelocity) ] );
    ylim([0,1000]);    set(gca,'YTick', [0:100:1000]);

    subplot(3,numGroup,2*numGroup+i);
    plot(dataGroup(i).data.time.highSampled , dataGroup(i).data.operatePulse.highSampled  );
    dataLength = length(dataGroup(i).data.zeroCrossData);
    title( [ '�R���g���[������ �@���쑬�x�덷:' num2str(dataGroup(i).data.errorVelocity) ] );
    ylim([-500,500]);    set(gca,'YTick', [-500:100:500]);

end

