% �e�����f�[�^�i�A�o�^���x�C�ΐ������O�����C�����i�������C�a�C���j�C�U���i�������C�a�C���j�̃q�X�g�O����
function histAllData(dataGroup)

numGroup = length(dataGroup);
colorData = colormap('lines');

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

    %�@�ΐ����Z�O�A�o�^�����̃q�X�g�O����
    subplot(3, numGroup ,i);
%     Ycenters = [500:1000:49500];
%     [nY_zc] = hist( Y_zc ,Ycenters );
%     [nY_nzc] = hist( Y_nzc ,Ycenters );
%     hBarY = barh(Ycenters.' , [nY_zc.' nY_nzc.'], 'Stack');
%     hBarY = barh(Ycenters.' , [nY_zc.' nY_nzc.'], 'Stack');
%     set(hBarY(1),'FaceColor', colorData(i,:), 'EdgeColor' , 'k' );
%     set(hBarY(2),'FaceColor', 'w', 'EdgeColor' , colorData(i,:) );
% %     grid on

    [nY_zc ,Ycenters] = hist( Y_zc ,10 );
    [nY_nzc] = hist( Y_nzc ,Ycenters );
    N = sum(nY_zc) + sum(nY_nzc);
    hBarY = barh(Ycenters.' , [nY_zc.'/N nY_nzc.'/N], 'Stack');
    set(hBarY(1),'FaceColor', colorData(i,:), 'EdgeColor' , 'k' );
    set(hBarY(2),'FaceColor', 'w', 'EdgeColor' , colorData(i,:) );
%     grid on    
    xlabel('�x��'); ylabel('�ΐ����Z�O�A�o�^����');
    ylim([0,50000]);        xlim([0,1]);

    
    %�@�������̃q�X�g�O����
    subplot(3,numGroup,numGroup+i);
%     X1centers = [10:20:590];
%     [nX1_zc] = hist( X1_zc(:,3) ,X1centers );
%     [nX1_nzc] = hist( X1_nzc(:,3) ,X1centers );
%     hBarX1 = bar(X1centers.' , [nX1_zc.' nX1_nzc.'], 'Stack');
%     set(hBarX1(1),'FaceColor', colorData(i,:), 'EdgeColor' ,  'k' );
%     set(hBarX1(2),'FaceColor', 'w', 'EdgeColor' , 'k' );
% %     grid on
%     ylabel('�x��'); xlabel('�U����');

    [nX1_zc ,X1centers ] = hist( X1_zc(:,3) ,10 );
    [nX1_nzc] = hist( X1_nzc(:,3) ,X1centers );
    hBarX1 = bar(X1centers.' , [nX1_zc.'/N nX1_nzc.'/N], 'Stack');
    set(hBarX1(1),'FaceColor', colorData(i,:), 'EdgeColor' ,  'k' );
    set(hBarX1(2),'FaceColor', 'w', 'EdgeColor' , 'k' );
%     grid on
    ylabel('�x��'); xlabel('������');
    xlim([0,600]);       ylim([0,1]);

    
    %�@�U�����̃q�X�g�O����
    subplot(3,numGroup,2*numGroup+i);
%     X2centers = [10:20:590];
%     [nX2_zc] = hist( X2_zc(:,3) ,X2centers );
%     [nX2_nzc] = hist( X2_nzc(:,3) ,X2centers );
%     hBarX2 = bar(X2centers.' , [nX2_zc.' nX2_nzc.'], 'Stack');
%     set(hBarX2(1),'FaceColor', colorData(i,:), 'EdgeColor' ,  'k' );
%     set(hBarX2(2),'FaceColor', 'w', 'EdgeColor' ,  'k' );
% %     grid on
%     ylabel('�x��'); xlabel('������');

    [nX2_zc,X2centers ] = hist( X2_zc(:,3) ,10 );
    [nX2_nzc] = hist( X2_nzc(:,3) ,X2centers );
    hBarX2 = bar(X2centers.' , [nX2_zc.'/N nX2_nzc.'/N], 'Stack');
    set(hBarX2(1),'FaceColor', colorData(i,:), 'EdgeColor' ,  'k' );
    set(hBarX2(2),'FaceColor', 'w', 'EdgeColor' ,  'k' );
%     grid on
    ylabel('�x��'); xlabel('�U����');
    xlim([0,600]);       ylim([0,1]);
    

end

