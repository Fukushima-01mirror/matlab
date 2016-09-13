% 
%% Excel�f�[�^����\�[�g���ĉ��

clf;
% clearvars *;
clc;
clear all;

addpath('G:\���Y�R����̓\�[�X');
cd('G:\���Y�R����̓\�[�X');
saveDataDir = 'G:\��̓f�[�^\���Y�R����̓f�[�^';


%% settings
dataGroup(1,1).name = {'���sin(�ᑬ_T=3500)'};
dataGroup(2,1).name = {'���sin(����_T=2500)'};
dataGroup(3,1).name = {'���sin(����T=2000)'};
numGroup = length(dataGroup);

analysisName =   'LineTrace0813_randomSinUniV_yasui';
% analysisName = 'LineTrace0816_kimura';
readExcelFile =  [cd() '\_excelData\' analysisName '.xlsx'];   % config.xlsx(�ݒ�t�@�C���C��������)��ǂݍ���
[excel.num, excel.txt, excel.raw] = xlsread( readExcelFile );

saveDir =[saveDataDir '\resultsFromExcel\' analysisName '\' datestr( now, 'yyyymmdd_HH') ];
if ~exist(saveDir,'dir')
    mkdir(saveDir);
end
saveExcelPath = [saveDir '\fitParam.xlsx'];

colorData = colormap('lines');
colorSurf = colormap('jet');

%% �f�[�^�O���[�v�ǂݍ���
alwaysLoadRawData = 1;          % ���f�[�^����荞�ނ��̐ݒ�
if exist([saveDir '\dataGroup.mat'],'file') && alwaysLoadRawData ~=1
    load([saveDir '\dataGroup.mat']);
else

    %% �f�[�^�O���[�v����
    [dataGroup] = GroupAnalyze.groupingData2013_old1(dataGroup,excel);
    save( [saveDir '\dataGroup.mat'],'dataGroup'); 
end


%% �f�[�^�`��  �A�o�^���x�E�ʒu�C�R���g���[������
%�@�f�[�^���@���ς̑���덷
MonitorSize = [ 0, 0, numGroup*400, 1000];
set(gcf, 'Position', MonitorSize);
for i =1:length(dataGroup)
    subplot(3,numGroup,i);
    plot(dataGroup(i).data.time.highSampled , dataGroup(i).data.avatarVelocity.highSampled  );
    hold on 
        Htp = plot(dataGroup(i).data.taskTime, dataGroup(i).data.taskVelocity );
        Htm = plot(dataGroup(i).data.taskTime, -dataGroup(i).data.taskVelocity );
    hold off
    set(Htp, 'Color', 'k', 'LineWidth', 2.5 , 'LineStyle', ':');   
    set(Htm, 'Color', 'k', 'LineWidth', 2.5 , 'LineStyle', ':');
    dataLength = length(dataGroup(i).data.zeroCrossData);
    title( [ '�A�o�^���x �@�f�[�^��:' num2str(dataLength) ] );
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
    title( [ '�A�o�^�ʒu �@�f�[�^��:' num2str(dataLength) ] );
    ylim([0,1000]);    set(gca,'YTick', [0:100:1000]);

    subplot(3,numGroup,2*numGroup+i);
    plot(dataGroup(i).data.time.highSampled , dataGroup(i).data.operatePulse.highSampled  );
    dataLength = length(dataGroup(i).data.zeroCrossData);
    title( [ '�R���g���[������ �@�f�[�^��:' num2str(dataLength) ] );
    ylim([-500,500]);    set(gca,'YTick', [-500:100:500]);
end
Models.saveGraphWithName(saveDir, '�e�����̃A�o�^����')
    

%% �e�����̃R���g���[��3�������֐}�Ƌߎ���
%�@�S�̃f�[�^�̃o�b�t�@�ϐ�
tGroup_zc = [0];      YGroup_zc = [0];    X1Group_zc = [0 0 0];     X2Group_zc =[0 0 0];
tGroup_nzc = [0];      YGroup_nzc = [0];    X1Group_nzc = [0 0 0];     X2Group_nzc =[0 0 0];
dataGroupLength = 0;

for i= 1:numGroup
    
    MonitorSize = [ 0, 0, 600, 600];
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

    %�@�d��A���́@�v���b�g
    [fitParam, X1FIT, X2FIT, YFIT ]  = Rhythm.approxiSurface(X1_zc(:,3), X2_zc(:,3), Y_zc );
    plot3( X1_zc(:,3) , X2_zc(:,3), Y_zc,   'Marker','*', 'LineStyle','none','Color', colorData(i,:));
    hold on
        plot3( X1_nzc(:,3) , X2_nzc(:,3), Y_nzc, 'Marker','o', 'LineStyle','none','Color', colorData(i,:));
        mesh(X1FIT,X2FIT,YFIT, 'FaceAlpha',0);
    hold off
    grid on
    axis square
    xlabel('����g�` �����̍�');  ylabel('����g�` �U���̍�');  zlabel('�ΐ����Z�O�A�o�^����');
    xlim([0,600]);      ylim([0,600]);         zlim([0 50000]);
    dataLength = length(dataGroup(i).data.zeroCrossData);
    title({['V = (' num2str(fitParam(1)) ') + (' num2str( fitParam(2) ) ') * dPeriod + (' ...
                        num2str( fitParam(3)) ') * dPeak + (' num2str(fitParam(4)) ') * dPeriod*dPeak'];...
        ['�f�[�^��:' num2str(dataLength) ] } );
    Models.saveGraphWithName(saveDir, char( dataGroup(i).name ) );
    
    %�@�e�f�[�^�̃o�b�t�@
    eval(['t_zc' num2str(i) ' = t_zc;   Y_zc' num2str(i) ' = Y_zc;   X1_zc' num2str(i) ' = X1_zc;     X2_zc' num2str(i) ' = X2_zc; ']);
    eval(['t_nzc' num2str(i) ' = t_nzc;   Y_nzc' num2str(i) ' = Y_nzc;   X1_nzc' num2str(i) ' = X1_nzc;     X2_nzc' num2str(i) ' = X2_nzc; ']);
    eval(['fitParam' num2str(i) ' =  fitParam ;']);

    %�@�S�̃f�[�^�̃o�b�t�@
    tGroup_zc = vertcat( tGroup_zc , t_zc);        YGroup_zc = vertcat( YGroup_zc , Y_zc); 
    X1Group_zc = vertcat( X1Group_zc , X1_zc);        X2Group_zc = vertcat( X2Group_zc , X2_zc); 
    tGroup_nzc = vertcat( tGroup_nzc , t_nzc);        YGroup_nzc = vertcat( YGroup_nzc , Y_nzc); 
    X1Group_nzc = vertcat( X1Group_nzc , X1_nzc);        X2Group_nzc = vertcat( X2Group_nzc , X2_nzc); 
    dataGroupLength = dataGroupLength + dataLength;
end

tGroup_zc(1,:)=[];   YGroup_zc(1,:)=[];    X1Group_zc(1,:)=[];     X2Group_zc(1,:)=[];
tGroup_nzc(1,:)=[];      YGroup_nzc(1,:)=[];    X1Group_nzc(1,:)=[];     X2Group_nzc(1,:)=[];


%% �S�̃f�[�^�̃O���t�Ƌߎ���
MonitorSize = [ 0, 0, 600, 600];
set(gcf, 'Position', MonitorSize);
    plot3( X1_zc1(:,3) , X2_zc1(:,3), Y_zc1,   'Marker','*', 'LineStyle','none' ,'Color', colorData(1,:));
hold on
    plot3( X1_nzc1(:,3) , X2_nzc1(:,3), Y_nzc1, 'Marker','o', 'LineStyle','none' ,'Color', colorData(1,:));
for i= 2:numGroup
    eval(['Hzc = plot3( X1_zc' num2str(i) '(:,3) , X2_zc' num2str(i) '(:,3), Y_zc' num2str(i) ');']);
        set(Hzc,  'Marker','*', 'LineStyle','none' ,'Color', colorData(i,:));
    eval(['Hnzc = plot3( X1_nzc' num2str(i) '(:,3) , X2_nzc' num2str(i) '(:,3), Y_nzc' num2str(i) ');']);
        set(Hnzc , 'Marker','o', 'LineStyle','none' ,'Color', colorData(i,:));
end
    [fitParam, X1FIT, X2FIT, YFIT ]  = Rhythm.approxiSurface(X1Group_zc(:,3), X2Group_zc(:,3), YGroup_zc );
    mesh(X1FIT,X2FIT,YFIT, 'FaceAlpha',0);
hold off
grid on
xlabel('����g�` �����̍�');  ylabel('����g�` �U���̍�');  zlabel('�ΐ����Z�O�A�o�^����');
xlim([0,600]);      ylim([0,600]);         zlim([0 50000]);

title({['V = (' num2str(fitParam(1)) ') + (' num2str( fitParam(2) ) ') * dPeriod + (' ...
                    num2str( fitParam(3)) ') * dPeak + (' num2str(fitParam(4)) ') * dPeriod*dPeak'];...
    ['�f�[�^��:' num2str(dataGroupLength) ] } );
axis square
Models.saveGraphWithName(saveDir, '�A�o�^���앪�z�i�S�̃f�[�^�j');

%% �d��A�ʂ̕������̌W����Excel�o��
rowData = { '�萔��' ; '�������̌W��' ; '�U�����̌W��' ; '���������U�����̌W��' };
columnTitle = {''};
for i= 1:numGroup
    columnTitle = horzcat( columnTitle, char( dataGroup(i).name ) );
    eval(['rowData = horzcat( rowData, num2cell( fitParam' num2str(i) ' ) );']); 
end
columnTitle = horzcat( columnTitle, '�S�̃f�[�^');
rowData = horzcat( rowData, num2cell( fitParam ) );

output = vertcat(columnTitle, rowData);
xlswrite(saveExcelPath,output);


