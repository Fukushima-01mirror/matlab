% �������E�U�����̑��֕���
function[output] = xsCorrAnalysis(dataGroup)
%input  obj ���@dataGroup

numGroup = length(dataGroup);
colorData = colormap('lines');
output = {'��T��V�̉�A�W��';'��T��V�̑��֌W��'; ...
            '��A��V�̉�A�W��';'��A��V�̑��֌W��'; ...
            '��T�ƃ�A�̉�A�W��';'��T�ƃ�A�̑��֌W��'};

for i= 1:numGroup
    
    MonitorSize = [ 0, 0, numGroup*400, 1000];
    set(gcf, 'Position', MonitorSize);
    %�@�e�O���[�v�̃f�[�^�𐮗�
    jj = length(dataGroup(i).data.zeroCrossData);
    t_zc = [0];      Y_zc = [0];    X1_zc = [0 0 0];     X2_zc =[0 0 0];
    t_nzc = [0];      Y_nzc = [0];    X1_nzc = [0 0 0];     X2_nzc =[0 0 0];
    for j= 1:jj
        zcIndex_sPeak = find(dataGroup(i).data.zeroCrossData(j).zcPeakCount(:,1)==1 ...
                                & dataGroup(i).data.zeroCrossData(j).zcPeakCount(:,2)==1);
        zcIndex_mPeak = find(dataGroup(i).data.zeroCrossData(j).zcPeakCount(:,1)>1 ...
                                | dataGroup(i).data.zeroCrossData(j).zcPeakCount(:,2)>1);
        t_zc  = vertcat( t_zc , dataGroup(i).data.zeroCrossData(j).time (zcIndex_sPeak)) ;
        Y_zc  = vertcat(Y_zc , abs( dataGroup(i).data.zeroCrossData(j).nonlogAvtVelocity (zcIndex_sPeak) ) ) ; 
        X1_zc  = vertcat(X1_zc , abs( dataGroup(i).data.zeroCrossData(j).period(zcIndex_sPeak,:) ) ) ;
        X2_zc  = vertcat(X2_zc , abs( dataGroup(i).data.zeroCrossData(j).peak(zcIndex_sPeak,:) ) ) ;
        t_nzc  = vertcat( t_nzc , dataGroup(i).data.zeroCrossData(j).time (zcIndex_mPeak)) ; 
        Y_nzc  = vertcat(Y_nzc , abs( dataGroup(i).data.zeroCrossData(j).nonlogAvtVelocity (zcIndex_mPeak) ) ) ;
        X1_nzc  = vertcat(X1_nzc , abs( dataGroup(i).data.zeroCrossData(j).period(zcIndex_mPeak,:) ) ) ;
        X2_nzc  = vertcat(X2_nzc , abs(dataGroup(i).data.zeroCrossData(j).peak(zcIndex_mPeak,:) ) ) ;
    end

    t_zc(1,:)=[];   Y_zc(1,:)=[];    X1_zc(1,:)=[];     X2_zc(1,:)=[];
    t_nzc(1,:)=[];      Y_nzc(1,:)=[];    X1_nzc(1,:)=[];     X2_nzc(1,:)=[];

    %�@�������ƃA�o�^�����̑���
    subplot(3,numGroup,i);
    [ fitParam1, fitLineR1, lineEdgePoint] = Rhythm.approxiLine2d(X1_zc(:,3), Y_zc );
    plot( X1_zc(:,3)  ,Y_zc,  'Marker','*', 'LineStyle','none','Color', colorData(i,:));
    hold on
        plot( X1_nzc(:,3)  ,Y_nzc,'Marker','o', 'LineStyle','none','Color', colorData(i,:));
        plot(lineEdgePoint(:,1), lineEdgePoint(:,2), 'k')
    hold off
    grid on
    xlabel('����g�` �����̍�'); ylabel('�ΐ����Z�O�A�o�^����');
    xlim([0,600]);         ylim([0 50000]);
    title({['V =  (' num2str( fitParam1(1) ) ') * dPeriod  + (' num2str(fitParam1(2)) ')']; ...
            ['���֌W���F' num2str( fitLineR1(1))]} );
    
    %�@�U�����ƃA�o�^�����̑���
    subplot(3,numGroup,numGroup+i);
    [ fitParam2, fitLineR2, lineEdgePoint] = Rhythm.approxiLine2d(X2_zc(:,3), Y_zc );
    plot( X2_zc(:,3)  ,Y_zc ,  'Marker','*', 'LineStyle','none','Color', colorData(i,:));
    hold on
        plot( X2_nzc(:,3)  ,Y_nzc,'Marker','o', 'LineStyle','none','Color', colorData(i,:));
        plot(lineEdgePoint(:,1), lineEdgePoint(:,2), 'k')
    hold off
    grid on
    xlabel('����g�`�@�U���̍�'); ylabel('�ΐ����Z�O�A�o�^����');
    xlim([0,600]);            ylim([0 50000]);
    title({['V =  (' num2str( fitParam2(1) ) ') * dPeak  + (' num2str(fitParam2(2)) ')']; ...
            ['���֌W���F' num2str( fitLineR2(1))]});
    
    %�@�������ƐU�����̑���
    subplot(3,numGroup,2*numGroup+i);
    [ fitParam3, fitLineR3, lineEdgePoint] = Rhythm.approxiLine2d(X1_zc(:,3)  ,X2_zc(:,3) );
    plot( X1_zc(:,3)  ,X2_zc(:,3) , 'Marker','*', 'LineStyle','none','Color', colorData(i,:));
    hold on
        plot( X1_nzc(:,3)  ,X2_nzc(:,3),'Marker','o', 'LineStyle','none','Color', colorData(i,:));
        plot(lineEdgePoint(:,1), lineEdgePoint(:,2), 'k')
    hold off
    grid on
    xlabel('����g�` �����̍�');    ylabel('����g�`�@�U���̍�'); 
    xlim([0,600]);            ylim([0,600]);
    title({['V =  (' num2str( fitParam3(1) ) ') * dPeak  + (' num2str(fitParam3(2)) ')']; ...
            ['���֌W���F' num2str( fitLineR3(1))]});
    
    data =[fitParam1(1) ; fitLineR1(1); fitParam2(1) ; fitLineR2(1); fitParam3(1) ; fitLineR3(1)];
    output = [ output num2cell(data) ];

end

