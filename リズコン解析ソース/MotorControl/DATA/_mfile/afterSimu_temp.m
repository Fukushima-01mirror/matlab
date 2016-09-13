
%%
main_path = 'C:\Users\cell\Desktop\リズコン解析ソース\MotorControl\DATA';
cd(main_path);
%  ↓要変更
bSaveMat = 1;
bSaveFig = 1;
bAppData = 1;
b2line = 1;

player = 'kimura';                    %%
setPoint= 0;                         %%
% cond = '_Kp0.5_Kd0.5_Km-PID(0.2_0.05_0)';      %%
cond = '_Kp0.5_Kd0.5_Km0';                       %%
% cond = 'Follower_Kp0.5_Kd0.5_Km-PID(0.2_0.05_0)';      %%
% cond = '_Follower_Km-10';
% Date = '0124_2152';
Date = datestr( now, 'mmdd_HHMM');

%%  データ読み込み
if bAppData == 1
%     app_path = 'C:\Users\cell\Desktop\Processing\processing-1.5.1\program\rythmctrl\AvatarExperimentApp_ZC_otherData';
    app_path = 'C:\Users\cell\Desktop\Processing\processing-1.5.1\program\rythmctrl\draw_avator_2player_archive';
    avt_list =  dir([app_path,'\avt*.csv'] );
    [ ~ , dateIndex] = sort( [ avt_list.datenum ] );
    avt_list = avt_list(dateIndex) ;
    appData.data0 = csvread([app_path,'\',avt_list(end).name],1,0);
    
%     task_list =  dir([app_path,'\task*.csv']);
%     sameDateIndex = find( [ task_list.datenum ] == avt_list(end).datenum );
%     appData.task = csvread([app_path,'\',task_list( sameDateIndex).name],1,0);

    mbed_path = 'N:\';
    mbed_list =  dir([mbed_path,'\*.csv'] );
    appData.mbed = csvread([mbed_path,'\',mbed_list(end).name],1,0);

    mbed1_path = 'G:\';
    mbed1_list =  dir([mbed1_path,'\*.csv'] );
    appData.mbed1 = csvread([mbed1_path,'\',mbed1_list(end).name],1,0);

end

%%
if bSaveMat ==1
    if bAppData == 1
        save( [main_path '\' player '\' Date ,cond '_sp' num2str(setPoint) ,'.mat'], ...
            'ZCycle_A_T_Fcontrol' , 'dataZcycle' , 'appData');
    else
        save( [main_path '\' player '\' Date ,cond '_sp' num2str(setPoint) ,'.mat'], ...
            'ZCycle_A_T_Fcontrol' , 'dataZcycle' );
    end
else
    if bAppData == 1
        load( [main_path '\' player '\' Date ,cond '_sp' num2str(setPoint) ,'.mat'], ...
            'ZCycle_A_T_Fcontrol' , 'dataZcycle' , 'appData');
    else
        load( [main_path '\' player '\' Date ,cond '_sp' num2str(setPoint) ,'.mat'], ...
            'ZCycle_A_T_Fcontrol' , 'dataZcycle' );
    end
    
end    

%% アバタ速度，周期，振幅，ゼロクロスミス分析
index_Pul =1;
% index_V =2;     index_dT =3;     index_dA=4;    index_T =5;     index_A =6;
data_zct = ts2zct_set( dataZcycle );
time = dataZcycle.time * 1000;  %ms
timeLength = time(end);
t = [0: timeLength-1];

Pul_ts = dataZcycle.signals(index_Pul).values;
contParam = ZCycle_A_T_Fcontrol.signals(3).values;

% Pul_ts = dataZcycle.signals.values(:,index_Pul);
Pul = interp1(time, Pul_ts , t');
zcPoint = zeros( length(Pul) , 1);

[ cycleData , period_zc, peak_zc , zcTimes] = rhythm2cycleData(Pul, zcPoint, -200, 7500);
    
t_st = 10000;
time_zc = cycleData(:,1);
Y = abs( cycleData(:,3) );    dT = abs( period_zc(:,3) );    dA = abs( peak_zc(:,3) );
IndexZeroCross = find(  zcTimes(:,1)<2 & zcTimes(:,2)<2  &  time_zc  > t_st  );
IndexNonZeroCross = find( zcTimes(:,1)>1 | zcTimes(:,2)>1 &  time_zc  >  t_st );
Y_zc  = Y(IndexZeroCross);        Y_nzc  = Y(IndexNonZeroCross);
dT_zc = dT(IndexZeroCross,:);     dT_nzc = dT(IndexNonZeroCross,:);
dA_zc = dA(IndexZeroCross,:);     dA_nzc = dA(IndexNonZeroCross,:);
t_zc =time_zc(IndexZeroCross);    t_nzc = time_zc(IndexNonZeroCross);

Nzc= length(IndexZeroCross);    Nnzc= length(IndexNonZeroCross);

%%  振幅・周期・制御パラメータの時系列変化
% コントローラ操作，制御パラメータ，周期，振幅，周期の差，振幅の差，アバタ速さ
figure;     set(gcf, 'Position', [ 0, 0, 1200, 1000]);
contParam_ts = interp1(time , contParam ,t');
T_ts = interp1(time_zc , period_zc(:,2) ,t');
A_ts = interp1(time_zc , peak_zc(:,2) ,t');
dT_ts = interp1(time_zc , dT ,t');
dA_ts = interp1(time_zc , dA ,t');
V_ts = interp1(time_zc , Y ,t');
plot_data = [ Pul, contParam_ts, T_ts, A_ts, dT_ts, dA_ts, V_ts ];
n_fig = 7;
for i= 1:n_fig
    hAxes(i) = subplot(n_fig,1,i);
    plot( t' , plot_data(:,i) );
    hold on 
    if i==1
        ylabel('コントローラ操作');        ylim([-400 400]);
        for j= 1:Nnzc
            plot([t_nzc(j) t_nzc(j)] ,[-400 400],'r');
        end
    elseif i==2
        ylabel('制御パラメータ');        ylim([-50 50]);
        for j= 1:Nnzc
            plot([t_nzc(j) t_nzc(j)] ,[-50 50],'r');
        end
    elseif i==3
        ylabel('周期');        ylim([0 800]);
        for j= 1:Nnzc
            plot([t_nzc(j) t_nzc(j)] ,[0 800],'r');
        end
    elseif i==4
        ylabel('振幅');        ylim([0 800]);
        for j= 1:Nnzc
            plot([t_nzc(j) t_nzc(j)] ,[0 800],'r');
        end
    elseif i==5
        ylabel('周期の差');        ylim([0 500]);
        for j= 1:Nnzc
            plot([t_nzc(j) t_nzc(j)] ,[0 500],'r');
        end
    elseif  i==6
        ylabel('振幅の差');        ylim([0 500]);
        for j= 1:Nnzc
            plot([t_nzc(j) t_nzc(j)] ,[0 500],'r');
        end
    elseif i==7
        ylabel('アバタ速さ');                ylim([0 50000]);
        for j= 1:Nnzc
            plot([t_nzc(j) t_nzc(j)] ,[0 50000],'r');
        end
    end
end
linkaxes(hAxes, 'x');
name = [ '..\Fig\' player '\tsData\' ...
    Date, '_tsData' ,cond '_sp' num2str(setPoint) ];
savefig( bSaveFig , name);

%%  操作周期のヒストグラム

figure;     set(gcf, 'Position', [ 0, 0, 600, 150]);
hist_ZCycleData( time_zc , period_zc(:,2) , zcTimes )
if setPoint ~= 0
    hold on 
        plot([setPoint setPoint] , [0 1],'g');    hold off
end
name = [ '..\Fig\' player '\Hist_period\' ...
    Date , '_HistPeriod' ,cond '_sp' num2str(setPoint) ];
savefig( bSaveFig , name);

%%  操作振幅のヒストグラム

figure;     set(gcf, 'Position', [ 0, 0, 600, 150]);
hist_ZCycleData( time_zc , peak_zc(:,2) , zcTimes )
xlim([0 1000]);    set(gca, 'XTick', [0:100:1000]);
name = [ '..\Fig\' player '\Hist_peak\' ...
    Date , '_HistPeak' ,cond '_sp' num2str(setPoint) ];
savefig( bSaveFig , name);

%%  V-dT,dAの3次元散布図

figure;     set(gcf, 'Position', [ 0, 0, 500, 500]);    bFig = 1;
[k1 , k2, X1, fitParam_X1Y, fitLineR_X1Y, distError , distMean] ...
            = PCA_regress(dT_zc , dA_zc , Y_zc , bFig) ;
hold on
    plot3(dT_nzc, dA_nzc , Y_nzc ,'Color' , 'b' ,'Marker','o', 'LineStyle','none' );
hold off
name = [ '..\Fig\' player '\PCA_regress\' ...
    Date , '_PCA_regress' ,cond '_sp' num2str(setPoint) ];
savefig( bSaveFig , name);

%%  2直線の主成分回帰分析
if b2line ==1
    dA_border =100;
    dT_border = 50;
    k_border =2;
    indexG0 = find( dT_zc < dT_border & dA_zc < dA_border );
    indexG01 = find( dT_zc >= dT_border & (dA_zc)./dT_zc <= k_border );
    indexG02 = find( dA_zc >= dA_border & (dA_zc)./dT_zc > k_border );
    indexG1 = sort([indexG0 ; indexG01]);
    indexG2 = sort([indexG0 ; indexG02]);
    figure;     set(gcf, 'Position', [ 0, 0, 700, 600]);    bFig = 1;
        subplot(2,2,1);
    plot( dT_zc(indexG1) , dA_zc(indexG1)  , 'Marker','*', 'LineStyle','none');
    hold on
        plot( dT_zc(indexG0) , dA_zc(indexG0) ,'Color', 'c' , 'Marker','*', 'LineStyle','none');
 %                 plot([ 0:50:300 ], [100 100 200 300 400 500 600],'m');
    hold off
    grid on
    axis square
    xlabel('操作波形 周期の差　ΔT group1');    ylabel('操作波形　振幅の差　ΔA group1'); 
    xlim([0,600]);            ylim([0,600]);
    title({['データ数' num2str(length(Y_zc(indexG1)))]});

        subplot(2,2,2);
    plot(dT_zc(indexG2) , dA_zc(indexG2)  , 'Marker','*', 'LineStyle','none');
    hold on
        plot( dT_zc(indexG0) , dA_zc(indexG0) ,'Color', 'c' , 'Marker','*', 'LineStyle','none');
%                 plot([ 50 50 100:50:300 ], [0:100:600],'c');
    hold off
    grid on
    axis square
    xlabel('操作波形 周期の差　ΔT group2');    ylabel('操作波形　振幅の差　ΔA group2'); 
    xlim([0,600]);            ylim([0,600]);
    title({['データ数' num2str( length( Y_zc(indexG2) ) )]});

        subplot(2,2,[3 4]);
    plot( dT_zc , dA_zc  , 'Marker','*', 'LineStyle','none');
    grid on
    axis square
    xlabel('操作波形 周期の差　ΔT');    ylabel('操作波形　振幅の差　ΔA'); 
    xlim([0,600]);            ylim([0,600]);
    title({['データ数' num2str(length(Y_zc))]});
    name = [ '..\Fig\' player '\TwoLines_splitGroup\' ...
        Date , '_TwoLines_splitGroup' ,cond '_sp' num2str(setPoint) ];
    savefig( bSaveFig , name);

    %%      % クラスター1
    figure;     set(gcf, 'Position', [ 0, 0, 500, 500]);    bFig = 1;
    [k1_g1 , k2_g1, X1_g1, fitParam_X1Y_g1, fitLineR_X1Y_g1, distError_g1 , distMean_g1]...
        = PCA_regress(dT_zc(indexG1) , dA_zc(indexG1) , Y_zc(indexG1) , bFig) ;
    name = [ '..\Fig\' player '\TwoLines_Group1_PCR\' ...
        Date , '_TwoLines_Group1_PCR' ,cond '_sp' num2str(setPoint) ];
    savefig( bSaveFig , name);

    %%      % クラスター2
    figure;     set(gcf, 'Position', [ 0, 0, 500, 500]);    bFig = 1;
    [k1_g2 , k2_g2, X1_g2, fitParam_X1Y_g2, fitLineR_X1Y_g2, distError_g2 , distMean_g2]...
        = PCA_regress(dT_zc(indexG2) , dA_zc(indexG2) , Y_zc(indexG2) , bFig) ;
    name = [ '..\Fig\' player '\TwoLines_Group2_PCR\' ...
        Date , '_TwoLines_Group2_PCR' ,cond '_sp' num2str(setPoint) ];
    savefig( bSaveFig , name);
    
%%
    figure;     set(gcf, 'Position', [ 0, 0, 500, 500]);    bFig = 1;
    lineEdgePoint_X1Y_g1 = [ min(X1_g1)*k1_g1 , min(X1_g1)*k2_g1 , polyval( fitParam_X1Y_g1, min(X1_g1) ) ;...
                            max(X1_g1)*k1_g1 , max(X1_g1)*k2_g1 , polyval( fitParam_X1Y_g1, max(X1_g1) ) ];
    lineEdgePoint_X1Y_g2 = [ min(X1_g2)*k1_g2 , min(X1_g2)*k2_g2 , polyval( fitParam_X1Y_g2, min(X1_g2) ) ;...
                            max(X1_g2)*k1_g2 , max(X1_g2)*k2_g2 , polyval( fitParam_X1Y_g2, max(X1_g2) ) ];
    plot3( [0 0],[0 0],[0 0],'k' );
    hold on
%                 plot3(dT_zc, dA_zc , Y_zc ,'Color' , 'k' );
        plot3(dT_zc(indexG01) , dA_zc(indexG01) , Y_zc(indexG01) ,'Color' , 'b' ,'Marker','*', 'LineStyle','none');
        plot3(dT_zc(indexG02) , dA_zc(indexG02) , Y_zc(indexG02) ,'Color' , 'g' ,'Marker','*', 'LineStyle','none');
        plot3(dT_zc(indexG0) , dA_zc(indexG0) , Y_zc(indexG0) ,'Color' , 'c' ,'Marker','*', 'LineStyle','none');

        plot3(  [ -100*k1_g1 ; 500*k1_g1 ] + mean(dT_zc(indexG1)) , [ -100*k2_g1 ; 500*k2_g1 ] + mean(dA_zc(indexG1)) , zeros(2,1) , 'r');
        plot3( lineEdgePoint_X1Y_g1(:,1) + mean(dT_zc(indexG1)) , lineEdgePoint_X1Y_g1(:,2) + mean(dA_zc(indexG1)), lineEdgePoint_X1Y_g1(:,3) ,'r' ,'LineWidth',3 );
        plot3( [ lineEdgePoint_X1Y_g1(2,1) + mean(dT_zc(indexG1)) ,lineEdgePoint_X1Y_g1(2,1)+ mean(dT_zc(indexG1)) ] ,...
               [ lineEdgePoint_X1Y_g1(2,2)+ mean(dA_zc(indexG1)) , lineEdgePoint_X1Y_g1(2,2)+ mean(dA_zc(indexG1)) ] ,...
               [0 lineEdgePoint_X1Y_g1(2,3)] ,'--r' );              % 垂線

        plot3(  [ -100*k1_g2 ; 500*k1_g2 ] + mean(dT_zc(indexG2)) , [ -100*k2_g2 ; 500*k2_g2 ] + mean(dA_zc(indexG2)) , zeros(2,1) , 'r');
        plot3( lineEdgePoint_X1Y_g2(:,1) + mean(dT_zc(indexG2)) , lineEdgePoint_X1Y_g2(:,2) + mean(dA_zc(indexG2)), lineEdgePoint_X1Y_g2(:,3) ,'r' ,'LineWidth',3 );
        plot3( [ lineEdgePoint_X1Y_g2(2,1) + mean(dT_zc(indexG2)) , lineEdgePoint_X1Y_g2(2,1) + mean(dT_zc(indexG2)) ] ,...
               [ lineEdgePoint_X1Y_g2(2,2) + mean(dA_zc(indexG2))  lineEdgePoint_X1Y_g2(2,2) + mean(dA_zc(indexG2))  ] ,...
               [0 lineEdgePoint_X1Y_g2(2,3)] ,'--r' );              % 垂線
        plot3(dT_nzc, dA_nzc , Y_nzc ,'Color' , 'b' ,'Marker','o', 'LineStyle','none' );
    hold off
    grid on
    axis square
            view(-30,25);
    xlabel('操作波形 周期の差dT');  ylabel('操作波形 振幅の差dA');  zlabel('対数演算前アバタ速さV');
    xlim([0 400]);            ylim([0 400]);          zlim([0 40000]);    
                title({['theta1 =(' num2str( atan(k2_g1/k1_g1) *180 / pi ) ')[deg]，X1-Vの傾き：' num2str( fitParam_X1Y_g1(1) ) ...
                            '，相関係数R：' num2str( fitLineR_X1Y_g1(1)) '，決定係数R^2：' num2str( fitLineR_X1Y_g1(1)^2)];...
                       ['theta2 =(' num2str( atan(k2_g2/k1_g2) *180 / pi ) ')[deg]，X2-Vの傾き：' num2str( fitParam_X1Y_g2(1) ) ...
                            '，相関係数R：' num2str( fitLineR_X1Y_g2(1)) '，決定係数R^2：' num2str( fitLineR_X1Y_g2(1)^2)]});
   name = [ '..\Fig\' player '\TwoLines_PCR\' ...
        Date , '_TwoLines_PCR' ,cond '_sp' num2str(setPoint) ];
    savefig( bSaveFig , name);

end


