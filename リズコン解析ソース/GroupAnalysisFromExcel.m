% 
%% Excelデータからソートして解析

clf;
% clearvars *;
clc;
clear all;

addpath('G:\リズコン解析ソース');
cd('G:\リズコン解析ソース');

saveDataDir = 'G:\解析データ\リズコン解析データ';

% addpath('C:\Users\taketo\Desktop\リズコン解析ソース');
% cd('C:\Users\taketo\Desktop\リズコン解析ソース');
% 
% saveDataDir = 'C:\Users\taketo\Desktop\リズコン解析データ';


%% settings
dataGroup(1,1).name = {'ランダム(sin_T=2500)'};
dataGroup(2,1).name = {'ランダム(低速_T=2500)'};
dataGroup(3,1).name = {'ランダム(高速_T=2000)'};

analysisName =  'LineTrace0827_yasui';
% analysisName = 'LineTrace0816_kimura';
readExcelFile =  [cd() '\_excelData\' analysisName '.xlsx'];   % config.xlsx(設定ファイル，実験条件)を読み込む
[excel.num, excel.txt, excel.raw] = xlsread( readExcelFile );

saveDir =[saveDataDir '\resultsFromExcel\' analysisName '\' datestr( now, 'yyyymmdd_HH') ];
if ~exist(saveDir,'dir')
    mkdir(saveDir);
end
saveParamPath = [saveDir '\fitParam.xlsx'];
saveCorrDataPath = [saveDir '\CorrData.xlsx'];

colorData = colormap('lines');
colorSurf = colormap('jet');

%% データグループ読み込み
alwaysLoadRawData = 1;          % 生データを取り込むかの設定
if exist([saveDir '\dataGroup.mat'],'file') && alwaysLoadRawData ~=1
    load([saveDir '\dataGroup.mat']);
else

    %% データグループ分け
    %　
    [dataGroup] = GroupAnalyze.groupingData20130819_3(dataGroup,excel);
    save( [saveDir '\dataGroup.mat'],'dataGroup'); 
end

numGroup = length(dataGroup);

%% データ描画  アバタ速度・位置，コントローラ操作
GroupAnalyze.plotAvtContData(dataGroup);
Models.saveGraphWithName(saveDir, '各条件のアバタ動作')
    
%% 各変数のヒストグラム
GroupAnalyze.histAllData(dataGroup);
Models.saveGraphWithName(saveDir, '各変数のヒストグラム');

%% 各条件のコントローラ3次元相関図と近似面
%　全体データのバッファ変数
tGroup_zc = [0];      YGroup_zc = [0];    X1Group_zc = [0 0 0];     X2Group_zc =[0 0 0];
tGroup_nzc = [0];      YGroup_nzc = [0];    X1Group_nzc = [0 0 0];     X2Group_nzc =[0 0 0];
dataGroupLength = 0;

for i= 1:numGroup
    colorSurf = colormap('jet');
    MonitorSize = [ 0, 0, 600, 600];
    set(gcf, 'Position', MonitorSize);
    %　各グループのデータを整理
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

    %　重回帰分析　プロット
    [fitParam, X1FIT, X2FIT, YFIT , fitR , Yhat ]  = Rhythm.approxiSurface(X1_zc(:,3), X2_zc(:,3), Y_zc );
    plot3( X1_zc(:,3) , X2_zc(:,3), Y_zc,   'Marker','*', 'LineStyle','none','Color', colorData(i,:));
    hold on
        plot3( X1_nzc(:,3) , X2_nzc(:,3), Y_nzc, 'Marker','o', 'LineStyle','none','Color', colorData(i,:));
        mesh(X1FIT,X2FIT,YFIT, 'FaceAlpha',0);
    hold off
    grid on
    axis square
    xlabel('操作波形 周期の差');  ylabel('操作波形 振幅の差');  zlabel('対数演算前アバタ速さ');
    xlim([0,600]);      ylim([0,600]);         zlim([0 50000]);
    dataLength = length(dataGroup(i).data.zeroCrossData);
    title({['V = (' num2str(fitParam(1)) ') + (' num2str( fitParam(2) ) ') * dPeriod + (' ...
                        num2str( fitParam(3)) ') * dPeak + (' num2str(fitParam(4)) ') * dPeriod*dPeak'];...
        ['操作速度誤差:' num2str(dataGroup(i).data.errorVelocity) ] } );
    Models.saveGraphWithName(saveDir, char( dataGroup(i).name ) );
    
    %標準化したデータのプロット
    [zX1_zc , mX1, sX1] = zscore( X1_zc(:,3));
    [zX2_zc , mX2, sX2] = zscore( X2_zc(:,3));
    [zY_zc , mY, sY] = zscore( Y_zc);
    [fitParam_std, X1FIT_std, X2FIT_std, YFIT_std , fitR_std ]  ....
                        = Rhythm.approxiSurface(zX1_zc, zX2_zc,  zY_zc );
    plot3( zX1_zc, zX2_zc,  zY_zc,   'Marker','*', 'LineStyle','none','Color', colorData(i,:));
    hold on
        mesh(X1FIT_std, X2FIT_std, YFIT_std, 'FaceAlpha',0);
    hold off
    grid on
    axis square
    xlabel({'操作波形 周期の差(標準化)';['平均:' num2str(mX1) '  標準偏差:' num2str(sX1)]});
    ylabel({'操作波形 振幅の差(標準化)';['平均:' num2str(mX2) '  標準偏差:' num2str(sX2)]});
    zlabel({'対数演算前アバタ速さ(標準化)';['平均:' num2str(mY) '  標準偏差:' num2str(sY)]});
    xlim([-3,3]);      ylim([-3,3]);         zlim([-3 3]);
    dataLength = length(dataGroup(i).data.zeroCrossData);
    title({['V = (' num2str(fitParam_std(1)) ') + (' num2str( fitParam_std(2) ) ') * dPeriod + (' ...
                        num2str( fitParam_std(3)) ') * dPeak + (' num2str(fitParam_std(4)) ') * dPeriod*dPeak'];...
        ['操作速度誤差:' num2str(dataGroup(i).data.errorVelocity) ] } );
    Models.saveGraphWithName(saveDir, [char( dataGroup(i).name ) '(標準化)'] );

    %　各データのバッファ
    eval(['t_zc' num2str(i) ' = t_zc;   Y_zc' num2str(i) ' = Y_zc;   X1_zc' num2str(i) ' = X1_zc;     X2_zc' num2str(i) ' = X2_zc; ']);
    eval(['t_nzc' num2str(i) ' = t_nzc;   Y_nzc' num2str(i) ' = Y_nzc;   X1_nzc' num2str(i) ' = X1_nzc;     X2_nzc' num2str(i) ' = X2_nzc; ']);
    eval(['fitParam' num2str(i) ' =  fitParam ;                 fitR' num2str(i) '_std =  fitR_std ;']);
    eval(['fitParam' num2str(i) '_std =  fitParam_std ;         fitR' num2str(i) ' =  fitR ;']);
 
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
    plot3( X1_zc1(:,3) , X2_zc1(:,3), Y_zc1,   'Marker','*', 'LineStyle','none' ,'Color', colorData(1,:));
hold on
    plot3( X1_nzc1(:,3) , X2_nzc1(:,3), Y_nzc1, 'Marker','o', 'LineStyle','none' ,'Color', colorData(1,:));
    for i= 2:numGroup
        eval(['Hzc = plot3( X1_zc' num2str(i) '(:,3) , X2_zc' num2str(i) '(:,3), Y_zc' num2str(i) ');']);
            set(Hzc,  'Marker','*', 'LineStyle','none' ,'Color', colorData(i,:));
        eval(['Hnzc = plot3( X1_nzc' num2str(i) '(:,3) , X2_nzc' num2str(i) '(:,3), Y_nzc' num2str(i) ');']);
            set(Hnzc , 'Marker','o', 'LineStyle','none' ,'Color', colorData(i,:));
    end
    [fitParam, X1FIT, X2FIT, YFIT , fitR]  = Rhythm.approxiSurface(X1Group_zc(:,3), X2Group_zc(:,3), YGroup_zc );
    [fitParam_std, X1FIT_std, X2FIT_std, YFIT_std , fitR_std ]  ....
                 = Rhythm.approxiSurface(zscore( X1Group_zc(:,3)), zscore( X2Group_zc(:,3)),  zscore( YGroup_zc) );
    mesh(X1FIT,X2FIT,YFIT, 'FaceAlpha',0);
hold off
grid on
xlabel('操作波形 周期の差');  ylabel('操作波形 振幅の差');  zlabel('対数演算前アバタ速さ');
xlim([0,600]);      ylim([0,600]);         zlim([0 50000]);

title({['V = (' num2str(fitParam(1)) ') + (' num2str( fitParam(2) ) ') * dPeriod + (' ...
                    num2str( fitParam(3)) ') * dPeak + (' num2str(fitParam(4)) ') * dPeriod*dPeak']} );
axis square
Models.saveGraphWithName(saveDir, 'アバタ操作分布（全体データ）');


    
%% 重回帰分析に関するExcel出力(偏回帰係数)
fitSurfData = { '定数項' ; '周期差の係数' ; '振幅差の係数' ; '周期差＊振幅差の係数' ;'重相関係数'};
columnTitle = {'重回帰式の係数'};
for i= 1:numGroup
    columnTitle = horzcat( columnTitle, char( dataGroup(i).name ) ,'std');
    eval(['fitSurfData = horzcat( fitSurfData, num2cell( [ fitParam' num2str(i) '; fitR' num2str(i) '] ) ,'...
                         'num2cell( [ fitParam' num2str(i) '_std; fitR' num2str(i) '_std] ) );']); 
end
columnTitle = horzcat( columnTitle, '全体データ', 'std');
fitSurfData = horzcat( fitSurfData, num2cell( [ fitParam ; fitR ] ), num2cell( [ fitParam_std ; fitR_std ] ) );

output = vertcat(columnTitle, fitSurfData );
xlswrite(saveParamPath,output);

%% 各条件での各変数間の相関
[ xsCorrParam ] = GroupAnalyze.xsCorrAnalysis(dataGroup);
Models.saveGraphWithName(saveDir, '各変数の単回帰分析');

% 全体データ
[ fitLineParam1 , fitLineR1, lineEdgePoint] = Rhythm.approxiLine2d(X1Group_zc(:,3), YGroup_zc );
[ fitLineParam2 , fitLineR2, lineEdgePoint] = Rhythm.approxiLine2d(X2Group_zc(:,3), YGroup_zc );
[ fitLineParam3 , fitLineR3, lineEdgePoint] = Rhythm.approxiLine2d(X1Group_zc(:,3)  ,X2Group_zc(:,3) );
totalCorrParam = [fitLineParam1(1) ; fitLineR1(1); fitLineParam2(1) ; fitLineR2(1); fitLineParam3(1) ; fitLineR3(1)];
xsCorrParam = [ xsCorrParam  num2cell(totalCorrParam) ];

columnTitle = {'各変数間の相関'};
for i= 1:numGroup
    columnTitle = horzcat( columnTitle, char( dataGroup(i).name ) );
end
columnTitle = horzcat( columnTitle, '全体データ');

output = vertcat(columnTitle, xsCorrParam );
xlswrite(saveCorrDataPath , output);


