
% Date = datestr( now, 'mmdd_HHMM');
%%
main_path = 'C:\Users\cell\Desktop\リズコン解析ソース\MotorControl\DATA';
cd(main_path);
%  ↓要変更
bSaveMat = 0;
bSaveFig = 1;
bAppData = 0;
player = 'yasui';                    %%
setPoint= 0;                         %%
% cond = 'Km-PID(0.3_0_0)';      %%
cond = 'Km0';                       %%
Date = '0119_0312';

%%  データ読み込み
if bAppData == 1
    app_path = 'C:\Users\cell\Desktop\Processing\processing-1.5.1\program\rythmctrl\AvatarExperimentApp_ZC_otherData';
    avt_list =  dir([app_path,'\avt*.csv'] );
    [ A , dateIndex] = sort( [ avt_list.datenum ] );
    avt_list = avt_list(dateIndex) ;
    appData.data0 = csvread([app_path,'\',avt_list(end).name],1,0);
    
    task_list =  dir([app_path,'\task*.csv']);
    sameDateIndex = find( [ task_list.datenum ] == avt_list(end).datenum );
    appData.task = csvread([app_path,'\',task_list( sameDateIndex).name],1,0);
end

%%
% if bSaveMat ==1
%     if bAppData == 1
%         save( [ main_path '\' player '\' Date ,cond '_sp' num2str(setPoint) ,'.mat'], ...
%             'ZCycle_A_T_Fcontrol' , 'dataZcycle' , 'appData');
%     else
%         save( [ main_path '\' player '\' Date ,cond '_sp' num2str(setPoint) ,'.mat'], ...
%             'ZCycle_A_T_Fcontrol' , 'dataZcycle' );
%     end
% else
%     if bAppData == 1
%         load( [ main_path '\' player '\' Date ,cond '_sp' num2str(setPoint) ,'.mat'], ...
%             'ZCycle_A_T_Fcontrol' , 'dataZcycle' , 'appData');
%     else
%         load( [ main_path '\' player '\' Date ,cond '_sp' num2str(setPoint) ,'.mat'], ...
%             'ZCycle_A_T_Fcontrol' , 'dataZcycle' );
%     end
%     
% end    

%% アバタ速度，周期，振幅，ゼロクロスミス分析
index_Pul =1;    index_V =2;
index_dT =3;     index_dA=4;    index_T =5;     index_A =6;
% data_zct = ts2zct_set( dataZcycle );
time = dataZcycle.time * 1000;  %ms
timeLength = time(end);
t = [0: timeLength-1];

Pul_ts = dataZcycle.signals(index_Pul,1).values;
% Pul_ts = dataZcycle.signals.values(:,index_Pul);
Pul = interp1(time, Pul_ts , t');
zcPoint = zeros( length(Pul) , 1);

%%

% [ cycleData , period_zc, peak_zc , zcTimes] = rhythm2cycleData(Pul, zcPoint, -200, 7500);
% t_st = 5000;
% time_zc = cycleData(:,1);
% Y = abs( cycleData(:,3) );    dT = abs( period_zc(:,3) );    dA = abs( peak_zc(:,3) );
% IndexZeroCross = find(  zcTimes(:,1)<2 & zcTimes(:,2)<2  &  time_zc  > t_st  );
% IndexNonZeroCross = find( zcTimes(:,1)>1 | zcTimes(:,2)>1 &  time_zc  >  t_st );
% Y_zc  = Y(IndexZeroCross);        Y_nzc  = Y(IndexNonZeroCross);
% dT_zc = dT(IndexZeroCross,:);     dT_nzc = dT(IndexNonZeroCross,:);
% dA_zc = dA(IndexZeroCross,:);     dA_nzc = dA(IndexNonZeroCross,:);

%%  振幅・周期・制御パラメータの時系列変化
% figure;     set(gcf, 'Position', [ 0, 0, 1000, 800]);
% [hFig, hAxes ] = simplots( ZCycle_A_T_Fcontrol );
% set( hAxes(1) , 'Ylim' , [0 600]);
% set( hAxes(2) , 'Ylim' , [0 600]);
% set( hAxes(3) , 'Ylim' , [-50 50]);
% name = [ '..\Fig\' player '\tsData\' ...
%     Date, '_tsData' ,cond '_sp' num2str(setPoint) ];
% savefig( bSaveFig , name);

%%  操作周期のヒストグラム
% figure;     set(gcf, 'Position', [ 0, 0, 600, 150]);
% hist_ZCycleData( time_zc , period_zc(:,2) , zcTimes )
% if setPoint ~= 0
%     hold on 
%         plot([setPoint setPoint] , [0 1],'g');    hold off
% end
% name = [ '..\Fig\' player '\Hist_period\' ...
%     Date , '_HistPeriod' ,cond '_sp' num2str(setPoint) ];
% savefig( bSaveFig , name);

%%  操作振幅のヒストグラム
figure;     set(gcf, 'Position', [ 0, 0, 600, 150]);
hist_ZCyclePeak2(  dataZcycle , 1/50 )
% hist_ZCycleData( time_zc , peak_zc(:,2) , zcTimes )
name = [ '..\Fig\' player '\Hist_peak\' ...
    Date , '_HistPeak' ,cond '_sp' num2str(setPoint) ];
savefig( bSaveFig , name);

%%  V-dT,dAの3次元散布図
% figure;     set(gcf, 'Position', [ 0, 0, 500, 500]);    bFig = 1;
% [k1 , k2, X1, fitParam_X1Y, fitLineR_X1Y, distError , distMean] ...
%             = PCA_regress(dT_zc , dA_zc , Y_zc , bFig) ;
% hold on
%     plot3(dT_nzc, dA_nzc , Y_nzc ,'Color' , 'b' ,'Marker','o', 'LineStyle','none' );
% hold off
% name = [ '..\Fig\' player '\PCA_regress\' ...
%     Date , '_PCA_regress' ,cond '_sp' num2str(setPoint) ];
% savefig( bSaveFig , name);

%%




