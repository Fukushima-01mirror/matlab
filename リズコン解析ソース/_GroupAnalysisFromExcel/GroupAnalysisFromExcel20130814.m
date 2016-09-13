%定常速度 : sin,等速(0.16, 0.20)
%% Excelデータからソートして解析

clf;
% clearvars *;
clc;
clear all;

addpath('G:\リズコン解析ソース');
cd('G:\リズコン解析ソース');
saveDataDir = 'G:\解析データ\リズコン解析データ';


%% settings
numGroup = 3;
groupName1 = '常にsin';
groupName2 = '常に等速(遅め0.16)';
groupName3 = '常に等速(速め0.20)';

analysisName =  'LineTrace0816_kimura';
readExcelFile =  [cd() '\_excelData\' analysisName '.xlsx'];   % config.xlsx(設定ファイル，実験条件)を読み込む
saveDir =[saveDataDir '\resultsFromExcel\' analysisName '\' datestr( now, 'yyyymmdd_HH') ];
% saveDir =[cd() '\resultsFromExcel\' analysisName];
if ~exist(saveDir,'dir')
    mkdir(saveDir);
end
excelPath = [saveDir '\fitParam.xlsx'];

colorData = colormap('lines');
colorSurf = colormap('jet');

%% データグループ読み込み
alwaysLoadRawData = 0;          % 生データを取り込むかの設定
if exist([saveDir '\dataGroup.mat'],'file') && alwaysLoadRawData ~=1
    load([saveDir '\dataGroup.mat']);
else

    %% データグループ分け
    for i=1:numGroup
        eval(['dataGroup' num2str(i) ' = zeros(1,1);        j' num2str(i) '=1;']);
    end
    [excel.num, excel.txt, excel.raw] = xlsread( readExcelFile );
    for i = 1: length(excel.num)
        dataFileName = char( strtok( excel.txt(i+1,1), '-' ) );
        load( [ cd(), '\vars\', dataFileName, '.mat' ] );

        %dataGroupソート条件
        if ~isempty(strfind( char( excel.txt(i+1,1) ) , 'sin')) ...         %sin運動
                && excel.num(i,2)-excel.num(i,1)==2500 ...
                && excel.num(i,5)< 0.075                         %誤差が小　
            suffix = 1;
            eval(['[dataGroup' num2str(suffix) '] = Rhythm.storeDataGroup(dataGroup'...
                num2str(suffix) ', data.player1, excel.num(i,1), excel.num(i,2), j' num2str(suffix) ');']);
            eval(['[dataGroup' num2str(suffix) '] = Rhythm.storeTaskData(dataGroup'...
                num2str(suffix) ', data.task, excel.num(i,1), excel.num(i,2));']);
            eval(['j' num2str(suffix) '=j' num2str(suffix) '+1;']);
        end    
        %dataGroupソート条件
        if ~isempty(strfind( char( excel.txt(i+1,1) ) , '0.16')) ...         %等速０．１６
                && excel.num(i,2)-excel.num(i,1)==2500 ...
                && excel.num(i,5)< 0.075                         %誤差が小　
            suffix = 2;
            eval(['[dataGroup' num2str(suffix) '] = Rhythm.storeDataGroup(dataGroup'...
                num2str(suffix) ', data.player1, excel.num(i,1), excel.num(i,2), j' num2str(suffix) ');']);
            eval(['[dataGroup' num2str(suffix) '] = Rhythm.storeTaskData(dataGroup'...
                num2str(suffix) ', data.task, excel.num(i,1), excel.num(i,2));']);
            eval(['j' num2str(suffix) '=j' num2str(suffix) '+1;']);
        end
        %dataGroupソート条件
        if ~isempty(strfind( char( excel.txt(i+1,1) ) , '0.2')) ...         %等速０．２
                && excel.num(i,2)-excel.num(i,1)==2000 ...
                && excel.num(i,5)< 0.075                           %誤差が小　
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


%% データ描画  アバタ速度・位置，コントローラ操作

%　データ数　平均の操作誤差
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
    title( [ 'アバタ速度 　データ数:' num2str(dataLength) ] );
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
    title( [ 'アバタ位置 　データ数:' num2str(dataLength) ] );
    ylim([0,1000]);    set(gca,'YTick', [0:100:1000]);

    subplot(3,numGroup,2*numGroup+i);
    eval( ['plot(dataGroup' num2str(i) '.time.highSampled , dataGroup' num2str(i) '.operatePulse.highSampled  );']);
    eval( [ 'dataLength = length(dataGroup' num2str(i) '.zeroCrossData);'] );
    title( [ 'コントローラ操作 　データ数:' num2str(dataLength) ] );
    ylim([-500,500]);    set(gca,'YTick', [-500:100:500]);
end
Models.saveGraphWithName(saveDir, '各条件のアバタ動作')
    

%% 各条件のコントローラ3次元相関図と近似面
%　全体データのバッファ変数
tGroup_zc = [0];      YGroup_zc = [0];    X1Group_zc = [0 0 0];     X2Group_zc =[0 0 0];
tGroup_nzc = [0];      YGroup_nzc = [0];    X1Group_nzc = [0 0 0];     X2Group_nzc =[0 0 0];
dataGroupLength = 0;

for i= 1:numGroup
    
    MonitorSize = [ 0, 0, 600, 600];
    set(gcf, 'Position', MonitorSize);
    %　各グループのデータを整理
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

    %　重回帰分析　プロット
    [fitParam, X1FIT, X2FIT, YFIT ]  = Rhythm.approxiSurface(X1_zc(:,3), X2_zc(:,3), Y_zc );
    plot3( X1_zc(:,3) , X2_zc(:,3), Y_zc,   'Marker','o', 'LineStyle','none','Color', colorData(i,:));
    hold on
        plot3( X1_nzc(:,3) , X2_nzc(:,3), Y_nzc, 'Marker','*', 'LineStyle','none','Color', colorData(i,:));
        mesh(X1FIT,X2FIT,YFIT, 'FaceAlpha',0);
    hold off
    grid on
    axis square
    xlabel('操作波形 周期の差');  ylabel('操作波形 振幅の差');  zlabel('対数演算前アバタ速さ');
    xlim([0,600]);      ylim([0,600]);         zlim([0 50000]);
    eval( [ 'dataLength = length(dataGroup' num2str(i) '.zeroCrossData);'] );
    title({['V = (' num2str(fitParam(1)) ') + (' num2str( fitParam(2) ) ') * dPeriod + (' ...
                        num2str( fitParam(3)) ') * dPeak + (' num2str(fitParam(4)) ') * dPeriod*dPeak'];...
        ['データ数:' num2str(dataLength) ] } );
    eval(['Models.saveGraphWithName(saveDir, groupName' num2str(i) ');']);
    
    %　各データのバッファ
    eval(['t_zc' num2str(i) ' = t_zc;   Y_zc' num2str(i) ' = Y_zc;   X1_zc' num2str(i) ' = X1_zc;     X2_zc' num2str(i) ' = X2_zc; ']);
    eval(['t_nzc' num2str(i) ' = t_nzc;   Y_nzc' num2str(i) ' = Y_nzc;   X1_nzc' num2str(i) ' = X1_nzc;     X2_nzc' num2str(i) ' = X2_nzc; ']);
    eval(['fitParam' num2str(i) ' =  fitParam ;']);

    %　全体データのバッファ
    tGroup_zc = vertcat( tGroup_zc , t_zc);        YGroup_zc = vertcat( YGroup_zc , Y_zc); 
    X1Group_zc = vertcat( X1Group_zc , X1_zc);        X2Group_zc = vertcat( X2Group_zc , X2_zc); 
    tGroup_nzc = vertcat( tGroup_nzc , t_nzc);        YGroup_nzc = vertcat( YGroup_nzc , Y_nzc); 
    X1Group_nzc = vertcat( X1Group_nzc , X1_nzc);        X2Group_nzc = vertcat( X2Group_nzc , X2_nzc); 
    dataGroupLength = dataGroupLength + dataLength;
end

tGroup_zc(1,:)=[];   YGroup_zc(1,:)=[];    X1Group_zc(1,:)=[];     X2Group_zc(1,:)=[];
tGroup_nzc(1,:)=[];      YGroup_nzc(1,:)=[];    X1Group_nzc(1,:)=[];     X2Group_nzc(1,:)=[];


%% 全体データのグラフと近似式
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
xlabel('操作波形 周期の差');  ylabel('操作波形 振幅の差');  zlabel('対数演算前アバタ速さ');
xlim([0,600]);      ylim([0,600]);         zlim([0 50000]);

title({['V = (' num2str(fitParam(1)) ') + (' num2str( fitParam(2) ) ') * dPeriod + (' ...
                    num2str( fitParam(3)) ') * dPeak + (' num2str(fitParam(4)) ') * dPeriod*dPeak'];...
    ['データ数:' num2str(dataGroupLength) ] } );
axis square
Models.saveGraphWithName(saveDir, 'アバタ操作分布（全体データ）');

%% 重回帰面の方程式の係数のExcel出力
rowData = { '定数項' ; '周期差の係数' ; '振幅差の係数' ; '周期差＊振幅差の係数' };
columnTitle = {''};
for i= 1:numGroup
    eval(['columnTitle = horzcat( columnTitle, groupName' num2str(i) ' );']);
    eval(['rowData = horzcat( rowData, num2cell( fitParam' num2str(i) ' ) );']); 
end
columnTitle = horzcat( columnTitle, '全体データ');
rowData = horzcat( rowData, num2cell( fitParam ) );

output = vertcat(columnTitle, rowData);
xlswrite(excelPath,output);


