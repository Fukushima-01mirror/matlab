%��푬�x : sin,����(0.16, 0.20)
%% Excel�f�[�^����\�[�g���ĉ��

clf;
% clearvars *;
clc;
clear all;

addpath('G:\���Y�R����̓\�[�X');
cd('G:\���Y�R����̓\�[�X');
saveDataDir = 'G:\��̓f�[�^\���Y�R����̓f�[�^';


%% settings
numGroup = 3;
groupName1 = '���sin';
groupName2 = '��ɓ���(�x��0.16)';
groupName3 = '��ɓ���(����0.20)';

analysisName =  'LineTrace0816_kimura';
readExcelFile =  [cd() '\_excelData\' analysisName '.xlsx'];   % config.xlsx(�ݒ�t�@�C���C��������)��ǂݍ���
saveDir =[saveDataDir '\resultsFromExcel\' analysisName '\' datestr( now, 'yyyymmdd_HH') ];
% saveDir =[cd() '\resultsFromExcel\' analysisName];
if ~exist(saveDir,'dir')
    mkdir(saveDir);
end
excelPath = [saveDir '\fitParam.xlsx'];

colorData = colormap('lines');
colorSurf = colormap('jet');

%% �f�[�^�O���[�v�ǂݍ���
alwaysLoadRawData = 0;          % ���f�[�^����荞�ނ��̐ݒ�
if exist([saveDir '\dataGroup.mat'],'file') && alwaysLoadRawData ~=1
    load([saveDir '\dataGroup.mat']);
else

    %% �f�[�^�O���[�v����
    for i=1:numGroup
        eval(['dataGroup' num2str(i) ' = zeros(1,1);        j' num2str(i) '=1;']);
    end
    [excel.num, excel.txt, excel.raw] = xlsread( readExcelFile );
    for i = 1: length(excel.num)
        dataFileName = char( strtok( excel.txt(i+1,1), '-' ) );
        load( [ cd(), '\vars\', dataFileName, '.mat' ] );

        %dataGroup�\�[�g����
        if ~isempty(strfind( char( excel.txt(i+1,1) ) , 'sin')) ...         %sin�^��
                && excel.num(i,2)-excel.num(i,1)==2500 ...
                && excel.num(i,5)< 0.075                         %�덷�����@
            suffix = 1;
            eval(['[dataGroup' num2str(suffix) '] = Rhythm.storeDataGroup(dataGroup'...
                num2str(suffix) ', data.player1, excel.num(i,1), excel.num(i,2), j' num2str(suffix) ');']);
            eval(['[dataGroup' num2str(suffix) '] = Rhythm.storeTaskData(dataGroup'...
                num2str(suffix) ', data.task, excel.num(i,1), excel.num(i,2));']);
            eval(['j' num2str(suffix) '=j' num2str(suffix) '+1;']);
        end    
        %dataGroup�\�[�g����
        if ~isempty(strfind( char( excel.txt(i+1,1) ) , '0.16')) ...         %�����O�D�P�U
                && excel.num(i,2)-excel.num(i,1)==2500 ...
                && excel.num(i,5)< 0.075                         %�덷�����@
            suffix = 2;
            eval(['[dataGroup' num2str(suffix) '] = Rhythm.storeDataGroup(dataGroup'...
                num2str(suffix) ', data.player1, excel.num(i,1), excel.num(i,2), j' num2str(suffix) ');']);
            eval(['[dataGroup' num2str(suffix) '] = Rhythm.storeTaskData(dataGroup'...
                num2str(suffix) ', data.task, excel.num(i,1), excel.num(i,2));']);
            eval(['j' num2str(suffix) '=j' num2str(suffix) '+1;']);
        end
        %dataGroup�\�[�g����
        if ~isempty(strfind( char( excel.txt(i+1,1) ) , '0.2')) ...         %�����O�D�Q
                && excel.num(i,2)-excel.num(i,1)==2000 ...
                && excel.num(i,5)< 0.075                           %�덷�����@
            suffix = 3;
            eval(['[dataGroup' num2str(suffix) '] = Rhythm.storeDataGroup(dataGroup'...
                num2str(suffix) ', data.player1, excel.num(i,1), excel.num(i,2), j' num2str(suffix) ');']);
            eval(['[dataGroup' num2str(suffix) '] = Rhythm.storeTaskData(dataGroup'...
                num2str(suffix) ', data.task, excel.num(i,1), excel.num(i,2));']);
            eval(['j' num2str(suffix) '=j' num2str(suffix) '+1;']);
        end    

    end

    save( [saveDir '\dataGroup.mat'],'dataGroup*'); 
end


%% �f�[�^�`��  �A�o�^���x�E�ʒu�C�R���g���[������

%�@�f�[�^���@���ς̑���덷
MonitorSize = [ 0, 0, numGroup*400, 1000];
set(gcf, 'Position', MonitorSize);
for i =1:numGroup
    subplot(3,numGroup,i);
    eval( ['plot(dataGroup' num2str(i) '.time.highSampled , dataGroup' num2str(i) '.avatarVelocity.highSampled  );']);
    hold on 
        eval( ['Htp = plot(dataGroup' num2str(i) '.taskTime, dataGroup' num2str(i) '.taskVelocity );']);
        eval( ['Htm = plot(dataGroup' num2str(i) '.taskTime, -dataGroup' num2str(i) '.taskVelocity );']);
    hold off
    set(Htp, 'Color', 'k', 'LineWidth', 2.5 , 'LineStyle', ':');   
    set(Htm, 'Color', 'k', 'LineWidth', 2.5 , 'LineStyle', ':');
    eval( [ 'dataLength = length(dataGroup' num2str(i) '.zeroCrossData);'] );
    title( [ '�A�o�^���x �@�f�[�^��:' num2str(dataLength) ] );
    ylim([-0.5 0.5]);    set(gca,'YTick', [-0.5:0.1:0.5]);
    
    subplot(3,numGroup,numGroup+i);
    eval( ['plot(dataGroup' num2str(i) '.time.highSampled , dataGroup' num2str(i) '.avatarPosition.highSampled  );']);
    hold on 
        eval( ['Htp = plot( dataGroup' num2str(i) '.taskTime, dataGroup' num2str(i) '.taskPosition );']);
        eval( ['Htm = plot(  flipud( dataGroup' num2str(i) '.taskTime ), dataGroup' num2str(i) '.taskPosition );']);
    hold off
    set(Htp, 'Color', 'k', 'LineWidth', 2.5 , 'LineStyle', ':');   
    set(Htm, 'Color', 'k', 'LineWidth', 2.5 , 'LineStyle', ':');
    eval( [ 'dataLength = length(dataGroup' num2str(i) '.zeroCrossData);'] );
    title( [ '�A�o�^�ʒu �@�f�[�^��:' num2str(dataLength) ] );
    ylim([0,1000]);    set(gca,'YTick', [0:100:1000]);

    subplot(3,numGroup,2*numGroup+i);
    eval( ['plot(dataGroup' num2str(i) '.time.highSampled , dataGroup' num2str(i) '.operatePulse.highSampled  );']);
    eval( [ 'dataLength = length(dataGroup' num2str(i) '.zeroCrossData);'] );
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
    eval(['jj = length(dataGroup' num2str(i) '.zeroCrossData);']);
    t_zc = [0];      Y_zc = [0];    X1_zc = [0 0 0];     X2_zc =[0 0 0];
    t_nzc = [0];      Y_nzc = [0];    X1_nzc = [0 0 0];     X2_nzc =[0 0 0];
    for j= 1:jj
        eval([ 'zcIndex_sPeak = find(dataGroup' num2str(i) '.zeroCrossData(j).zcPeakCount(:,1)==1 & dataGroup' ...
            num2str(i) '.zeroCrossData(j).zcPeakCount(:,2)==1);']);
        eval([ 'zcIndex_mPeak = find(dataGroup' num2str(i) '.zeroCrossData(j).zcPeakCount(:,1)>1 | dataGroup' ...
            num2str(i) '.zeroCrossData(j).zcPeakCount(:,2)>1);']);
        eval(['t_zc  = vertcat( t_zc , dataGroup' num2str(i) '.zeroCrossData(j).time (zcIndex_sPeak)) ; ']); 
        eval(['Y_zc  = vertcat(Y_zc , abs( dataGroup' num2str(i) '.zeroCrossData(j).nonlogAvtVelocity (zcIndex_sPeak) ) ) ; ']); 
        eval(['X1_zc  = vertcat(X1_zc , abs( dataGroup' num2str(i) '.zeroCrossData(j).period(zcIndex_sPeak,:) ) ) ; ']); 
        eval(['X2_zc  = vertcat(X2_zc , abs( dataGroup' num2str(i) '.zeroCrossData(j).peak(zcIndex_sPeak,:) ) ) ; ']);
        eval(['t_nzc  = vertcat( t_nzc , dataGroup' num2str(i) '.zeroCrossData(j).time (zcIndex_mPeak)) ; ']); 
        eval(['Y_nzc  = vertcat(Y_nzc , abs( dataGroup' num2str(i) '.zeroCrossData(j).nonlogAvtVelocity (zcIndex_mPeak) ) ) ; ']);
        eval(['X1_nzc  = vertcat(X1_nzc , abs( dataGroup' num2str(i) '.zeroCrossData(j).period(zcIndex_mPeak,:) ) ) ; ']);
        eval(['X2_nzc  = vertcat(X2_nzc , abs(dataGroup' num2str(i) '.zeroCrossData(j).peak(zcIndex_mPeak,:) ) ) ; ']);
    end
    t_zc(1,:)=[];   Y_zc(1,:)=[];    X1_zc(1,:)=[];     X2_zc(1,:)=[];
    t_nzc(1,:)=[];      Y_nzc(1,:)=[];    X1_nzc(1,:)=[];     X2_nzc(1,:)=[];

    %�@�d��A���́@�v���b�g
    [fitParam, X1FIT, X2FIT, YFIT ]  = Rhythm.approxiSurface(X1_zc(:,3), X2_zc(:,3), Y_zc );
    plot3( X1_zc(:,3) , X2_zc(:,3), Y_zc,   'Marker','o', 'LineStyle','none','Color', colorData(i,:));
    hold on
        plot3( X1_nzc(:,3) , X2_nzc(:,3), Y_nzc, 'Marker','*', 'LineStyle','none','Color', colorData(i,:));
        mesh(X1FIT,X2FIT,YFIT, 'FaceAlpha',0);
    hold off
    grid on
    axis square
    xlabel('����g�` �����̍�');  ylabel('����g�` �U���̍�');  zlabel('�ΐ����Z�O�A�o�^����');
    xlim([0,600]);      ylim([0,600]);         zlim([0 50000]);
    eval( [ 'dataLength = length(dataGroup' num2str(i) '.zeroCrossData);'] );
    title({['V = (' num2str(fitParam(1)) ') + (' num2str( fitParam(2) ) ') * dPeriod + (' ...
                        num2str( fitParam(3)) ') * dPeak + (' num2str(fitParam(4)) ') * dPeriod*dPeak'];...
        ['�f�[�^��:' num2str(dataLength) ] } );
    eval(['Models.saveGraphWithName(saveDir, groupName' num2str(i) ');']);
    
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
    plot3( X1_zc1(:,3) , X2_zc1(:,3), Y_zc1,   'Marker','o', 'LineStyle','none' ,'Color', colorData(1,:));
hold on
    plot3( X1_nzc1(:,3) , X2_nzc1(:,3), Y_nzc1, 'Marker','*', 'LineStyle','none' ,'Color', colorData(1,:));
for i= 2:numGroup
    eval(['Hzc = plot3( X1_zc' num2str(i) '(:,3) , X2_zc' num2str(i) '(:,3), Y_zc' num2str(i) ');']);
        set(Hzc,  'Marker','o', 'LineStyle','none' ,'Color', colorData(i,:));
    eval(['Hnzc = plot3( X1_nzc' num2str(i) '(:,3) , X2_nzc' num2str(i) '(:,3), Y_nzc' num2str(i) ');']);
        set(Hnzc , 'Marker','*', 'LineStyle','none' ,'Color', colorData(i,:));
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
    eval(['columnTitle = horzcat( columnTitle, groupName' num2str(i) ' );']);
    eval(['rowData = horzcat( rowData, num2cell( fitParam' num2str(i) ' ) );']); 
end
columnTitle = horzcat( columnTitle, '�S�̃f�[�^');
rowData = horzcat( rowData, num2cell( fitParam ) );

output = vertcat(columnTitle, rowData);
xlswrite(excelPath,output);


