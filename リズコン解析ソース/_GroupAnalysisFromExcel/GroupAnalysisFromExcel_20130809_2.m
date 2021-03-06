%定常速度(sin速度_速め，普通，遅め）データの描画
%% Excelデータからソートして解析
clf;
% clearvars *;
clc;
clear all;

addpath('G:\リズコン解析ソース');
cd('G:\リズコン解析ソース');


%% settings
numGroup = 3;

analysisName = 'sameCondition_differMotion';
readExcelFile =  [cd() '\_excelData\' analysisName '.xlsx'];   % config.xlsx(設定ファイル，実験条件)を読み込む
saveDir =[cd() '\resultsFromExcel\' analysisName '\' datestr( now, 'yyyymmdd_HH') ];
% saveDir =[cd() '\resultsFromExcel\' analysisName];
if ~exist(saveDir,'dir')
    mkdir(saveDir);
end

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

        %dataGroup1ソート条件
        if ~isempty(strfind( char( excel.txt(i+1,1) ) , '速め')) ...         %ランダム
                && excel.num(i,3) == 0 && excel.num(i,2)-excel.num(i,1)==2000 && excel.num(i,5)< 0.06           %動き：　誤差が小　
            suffix = 1;
            eval(['[dataGroup' num2str(suffix) '] = Rhythm.storeDataGroup(dataGroup'...
                num2str(suffix) ', data.player1, excel.num(i,1), excel.num(i,2), j' num2str(suffix) ');']);
            eval(['j' num2str(suffix) '=j' num2str(suffix) '+1;']);
        end
        %dataGroup2ソート条件
        if ~isempty(strfind( char( excel.txt(i+1,1) ) , '普通')) ...         %ランダム
                && excel.num(i,3) == 0 && excel.num(i,2)-excel.num(i,1)==2500 && excel.num(i,5)< 0.06               %動き：　誤差が小　
            suffix = 2;
            eval(['[dataGroup' num2str(suffix) '] = Rhythm.storeDataGroup(dataGroup'...
                num2str(suffix) ', data.player1, excel.num(i,1), excel.num(i,2), j' num2str(suffix) ');']);
            eval(['j' num2str(suffix) '=j' num2str(suffix) '+1;']);
        end

        %dataGroup3ソート条件
        if ~isempty(strfind( char( excel.txt(i+1,1) ) , '遅め')) ...         %ランダム
                && excel.num(i,3) == 0 && excel.num(i,2)-excel.num(i,1)==3500 && excel.num(i,5)< 0.06               %動き：　誤差が小　
            suffix = 3;
            eval(['[dataGroup' num2str(suffix) '] = Rhythm.storeDataGroup(dataGroup'...
                num2str(suffix) ', data.player1, excel.num(i,1), excel.num(i,2), j' num2str(suffix) ');']);
            eval(['j' num2str(suffix) '=j' num2str(suffix) '+1;']);
        end
    end

    save( [saveDir '\dataGroup.mat'],'dataGroup*'); 
end

%% データ描画
MonitorSize = [ 0, 0, numGroup*400, 1000];
set(gcf, 'Position', MonitorSize);
    
for i =1:numGroup
    subplot(3,numGroup,i);
    eval( ['plot(dataGroup' num2str(i) '.time.highSampled , dataGroup' num2str(i) '.avatarVelocity.highSampled  );']);
    eval( [ 'dataLength = length(dataGroup' num2str(i) '.zeroCrossData);'] );
    title( [ 'アバタ速度 　データ数:' num2str(dataLength) ] );
    ylim([-0.5 0.5]);    set(gca,'YTick', [-0.5:0.1:0.5]);
    
    subplot(3,numGroup,numGroup+i);
    eval( ['plot(dataGroup' num2str(i) '.time.highSampled , dataGroup' num2str(i) '.avatarPosition.highSampled  );']);
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

    
for i= 1:numGroup
    
    MonitorSize = [ 0, 0, 600, 600];
    set(gcf, 'Position', MonitorSize);
    
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
    
    [fitParam3, X1FIT, X2FIT, YFIT ]  = Rhythm.approxiSurface(X1_zc(:,3), X2_zc(:,3), Y_zc );
    plot3( X1_zc(:,3) , X2_zc(:,3), Y_zc,   'Marker','*', 'LineStyle','none');
    hold on
        plot3( X1_nzc(:,3) , X2_nzc(:,3), Y_nzc, 'Marker','o', 'LineStyle','none');
        mesh(X1FIT,X2FIT,YFIT);
    hold off
    grid on
    xlabel('操作波形 周期の差');  ylabel('操作波形 振幅の差');  zlabel('対数演算前アバタ速さ');
    xlim([0,600]);      ylim([0,600]);         zlim([0 50000]);
    
    eval( [ 'dataLength = length(dataGroup' num2str(i) '.zeroCrossData);'] );
    title( [ 'アバタ位置 　データ数:' num2str(dataLength) ] );
    title({['V = (' num2str(fitParam3(1)) ') + (' num2str( fitParam3(2) ) ') * dPeriod + (' ...
                        num2str( fitParam3(3)) ') * dPeak + (' num2str(fitParam3(4)) ') * dPeriod*dPeak'];...
        ['データ数:' num2str(dataLength) ] } );
    axis square
    
    if i==1
        Models.saveGraphWithName(saveDir, 'アバタ操作分布_ランダム速度(sin)')
    elseif i==2
        Models.saveGraphWithName(saveDir, 'アバタ操作分布_ランダム速度(低速)')
    elseif i==3
        Models.saveGraphWithName(saveDir, 'アバタ操作分布_ランダム速度(高速)')
    end

end
