classdef ZCDataCorrelation3d_approxiLine_ex_group < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = ZCDataCorrelation3d_approxiLine_ex_group(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
            

           [period_zx, peak_zx] = Rhythm.setZeroCrossPeriodData(user.zeroCrossData);
           %　ゼロクロス間でのピーク回数取得
           [zeroCrossTimes] = Rhythm.setZeroCrossCount(user.zeroCrossData);

           bDirect = mean( obj.data.task.avatarPosition(1:10) ) - obj.data.task.avatarPosition(1) >0;
            swTiming(1,1) = 0;
            j=1;
            for i = 1:length(obj.data.task.time)
                if bDirect && obj.data.task.avatarPosition(i) >= obj.data.task.otherData(i,2)
                    swTiming(j,1) = obj.data.task.time(i);
                    bDirect = false;
                    j=j+1;
                end
                if ~bDirect && obj.data.task.avatarPosition(i) <= obj.data.task.otherData(i,1)
                    swTiming(j,1) = obj.data.task.time(i);
                    bDirect = true;
                    j=j+1;
                end
            end
            
%%        切り返しタイミングごとに3次元散布図     
            for i =3:length(swTiming)
                startIndex1 = find( user.zeroCrossData.zeroCrossTime >= swTiming(i-1) ,1 ,'first');
                endIndex1 = find( user.zeroCrossData.zeroCrossTime < swTiming(i) ,1 ,'last');   
                zcIndex = [startIndex1: endIndex1];

               zeroCrossTimes_local = zeroCrossTimes( startIndex1:endIndex1 ,: );   %　C1:波形の前半部のピーク回数　C2:後半部のピーク回数
               %　ゼロクロスしている時のインデックス
               IndexZeroCross = find(zeroCrossTimes_local(:,1)<2&zeroCrossTimes_local(:,2)<2);
               %　ゼロクロスしない時のインデックス
               IndexNonZeroCross = find( zeroCrossTimes_local(:,1)>1 | zeroCrossTimes_local(:,2)>1);

                Y = abs( user.zeroCrossData.nonlogAvtVelocity );
                X1 = abs( period_zx );
                X2 = abs( peak_zx );

                Y_zc  = Y( zcIndex(IndexZeroCross) );      Y_nzc  = Y( zcIndex(IndexNonZeroCross) );
                X1_zc = X1(zcIndex(IndexZeroCross),:);     X1_nzc = X1( zcIndex(IndexNonZeroCross) ,:);
                X2_zc = X2(zcIndex(IndexZeroCross),:);     X2_nzc = X2( zcIndex(IndexNonZeroCross) ,:);

                r_fig= 3;
%%                
%                 figure(1);
% %            アバタ位置描画    
%                subplot(r_fig, 2, 1)     
%                plot(   user.time.highSampled,  user.avatarPosition.highSampled);         
%                 % 自動アバタの位置描画
%                 hold on
%                     % 実験条件の描画
%                     if strcmp( obj.config.examType, '追い込まれ実験')...
%                             || strcmp( obj.config.examType, '追い込む実験')
%                         plot(   obj.data.com.time,  obj.data.com.avatarPosition , 'k:');               
%                     elseif ~isempty(  findstr( char( obj.config.examType ) , '線追従'))
%                             plot(   obj.data.task.time,  obj.data.task.avatarPosition , 'k:');               
%                     end
%                     %　ゼロクロスしないタイミングを描画
%                     for j= 1: length(IndexNonZeroCross)
%                         zeroCrossTime = user.zeroCrossData.zeroCrossTime(IndexNonZeroCross(j) );
%                         plot([zeroCrossTime zeroCrossTime],[0 1000],...
%                             'Color' , [.7 .7 .7] , 'LineStyle', ':');
%                     end
%                 hold off
%                 xlabel('時間t ms'); ylabel('アバタ位置');
%                 xlim([swTiming(i-1) swTiming(i)]);    ylim([0 1000]);
% 
% %            コントローラ操作描画    
%                 subplot(r_fig,2,3)
%                 plot(   user.time.highSampled,  user.operatePulse.highSampled );               
%                 hold on %　ゼロクロスしないタイミングを描画
%                     for j= 1: length(IndexNonZeroCross)
%                         zeroCrossTime = user.zeroCrossData.zeroCrossTime(IndexNonZeroCross(j) );
%                         plot([zeroCrossTime zeroCrossTime],[-400 400],...
%                             'Color' , [.7 .7 .7] , 'LineStyle', ':');
%                     end
%                     plot([0 60000], [0 0] ,'k')
%                 hold off
%                 xlabel('時間t ms'); ylabel('コントローラ操作');
%                 xlim([swTiming(i-1) swTiming(i)]);    ylim([-400 400]);
% %                 grid on;
%                 set(gca,'YTick',[-400:100:400]);
% 
% %            アバタ速度     
%                 subplot(r_fig,2,5)
%                 plot(   user.time.highSampled,  user.avatarVelocity.highSampled );               
%                 hold on %　ゼロクロスしないタイミングを描画
%                     % 実験条件の描画
%                     % 実験条件の描画
%                     if ~isempty(  findstr( char( obj.config.examType ) , '線追従'))
%                         if mean( user.avatarVelocity.highSampled(swTiming(i-1):swTiming(i)) ) >0
%                             plot(   obj.data.task.time,  obj.data.task.otherData(:,4) , 'k:');         
%                         else
%                             plot(   obj.data.task.time,  -obj.data.task.otherData(:,4) , 'k:');  
%                         end
%                     end
%                    for j= 1: length(IndexNonZeroCross)
%                         zeroCrossTime = user.zeroCrossData.zeroCrossTime(IndexNonZeroCross(j) );
%                         plot([zeroCrossTime zeroCrossTime],[-0.5 0.5],...
%                             'Color' , [.7 .7 .7] , 'LineStyle', ':');
%                     end
%                     plot([0 60000], [0 0] ,'k')
%                 hold off
%                 xlabel('時間t ms'); ylabel('アバタ速度');
%                 xlim([swTiming(i-1) swTiming(i)]);    ylim([-0.5 0.5]);
% %                 grid on;
%                 set(gca,'YTick',[-0.5:0.1:0.5]);
%                 
%                 
%                 subplot(1,2,2);
%                 [dirVect1, lineEdgePoint] = Rhythm.approxiLine3d(X1_zc(:,1),  X2_zc(:,1),  Y_zc );
%                 plot3( X1_zc(:,1) , X2_zc(:,1), Y_zc,   'Marker','*', 'LineStyle','none');
%                 hold on
%                     plot3( X1_nzc(:,1) , X2_nzc(:,1), Y_nzc, 'Marker','o', 'LineStyle','none');
%                     plot3(lineEdgePoint(:,1),lineEdgePoint(:,2),lineEdgePoint(:,3),'r-');
%                 hold off
%                 grid on
%                 xlabel('操作波形 半周期'); ylabel('操作波形　ピーク値');  zlabel('対数演算前アバタ速さ');
%                 xlim([0,600]);      ylim([0,600]);         zlim([0 50000]);
%                 title(['方向ベクトル ( dPeriod, dPeak, V ) = ( ' num2str(dirVect1(1)) ',  ' num2str(dirVect1(2)) ',  '  num2str(dirVect1(3)) , ')'] );
%                 axis square
%                 MonitorSize = [ 0, 0, 1280, 800];
%                 set(gcf, 'Position', MonitorSize);
%                 obj.saveGraphWithName(['_halfParam' num2str(i)]);
%                 
% 
% %%
%                 figure(2);
%                subplot(r_fig, 2, 1)     
%                plot(   user.time.highSampled,  user.avatarPosition.highSampled);         
%                 % 自動アバタの位置描画
%                 hold on
%                     % 実験条件の描画
%                     if strcmp( obj.config.examType, '追い込まれ実験')...
%                             || strcmp( obj.config.examType, '追い込む実験')
%                         plot(   obj.data.com.time,  obj.data.com.avatarPosition , 'k:');               
%                     elseif ~isempty(  findstr( char( obj.config.examType ) , '線追従'))
%                             plot(   obj.data.task.time,  obj.data.task.avatarPosition , 'k:');               
%                     end
%                     %　ゼロクロスしないタイミングを描画
%                     for j= 1: length(IndexNonZeroCross)
%                         zeroCrossTime = user.zeroCrossData.zeroCrossTime(IndexNonZeroCross(j) );
%                         plot([zeroCrossTime zeroCrossTime],[0 1000],...
%                             'Color' , [.7 .7 .7] , 'LineStyle', ':');
%                     end
%                 hold off
%                 xlabel('時間t ms'); ylabel('アバタ位置');
%                 xlim([swTiming(i-1) swTiming(i)]);    ylim([0 1000]);
% 
% %            コントローラ操作描画    
%                 subplot(r_fig,2,3)
%                 plot(   user.time.highSampled,  user.operatePulse.highSampled );               
%                 hold on %　ゼロクロスしないタイミングを描画
%                     for j= 1: length(IndexNonZeroCross)
%                         zeroCrossTime = user.zeroCrossData.zeroCrossTime(IndexNonZeroCross(j) );
%                         plot([zeroCrossTime zeroCrossTime],[-400 400],...
%                             'Color' , [.7 .7 .7] , 'LineStyle', ':');
%                     end
%                     plot([0 60000], [0 0] ,'k')
%                 hold off
%                 xlabel('時間t ms'); ylabel('コントローラ操作');
%                 xlim([swTiming(i-1) swTiming(i)]);    ylim([-400 400]);
% %                 grid on;
%                 set(gca,'YTick',[-400:100:400]);
% 
% %            アバタ速度     
%                 subplot(r_fig,2,5)
%                 plot(   user.time.highSampled,  user.avatarVelocity.highSampled );               
%                 hold on %　ゼロクロスしないタイミングを描画
%                     % 実験条件の描画
%                     if ~isempty(  findstr( char( obj.config.examType ) , '線追従'))
%                         if mean( user.avatarVelocity.highSampled(swTiming(i-1):swTiming(i)) ) >0
%                             plot(   obj.data.task.time,  obj.data.task.otherData(:,4) , 'k:');         
%                         else
%                             plot(   obj.data.task.time,  -obj.data.task.otherData(:,4) , 'k:');  
%                         end
%                     end
%                    for j= 1: length(IndexNonZeroCross)
%                         zeroCrossTime = user.zeroCrossData.zeroCrossTime(IndexNonZeroCross(j) );
%                         plot([zeroCrossTime zeroCrossTime],[-0.5 0.5],...
%                             'Color' , [.7 .7 .7] , 'LineStyle', ':');
%                     end
%                     plot([0 60000], [0 0] ,'k')
%                 hold off
%                 xlabel('時間t ms'); ylabel('アバタ速度');
%                 xlim([swTiming(i-1) swTiming(i)]);    ylim([-0.5 0.5]);
% %                 grid on;
%                 set(gca,'YTick',[-0.5:0.1:0.5]);
%   
%                 
%                 subplot(1,2,2);
%                 [dirVect2, lineEdgePoint] = Rhythm.approxiLine3d(X1_zc(:,2),  X2_zc(:,2),  Y_zc );
%                 plot3( X1_zc(:,2) , X2_zc(:,2), Y_zc,   'Marker','*', 'LineStyle','none');
%                 hold on
%                     plot3( X1_nzc(:,2) , X2_nzc(:,2), Y_nzc, 'Marker','o', 'LineStyle','none');
%                     plot3(lineEdgePoint(:,1),lineEdgePoint(:,2),lineEdgePoint(:,3),'r-');
%                 hold off
%                 grid on
%                 xlabel('操作波形 1周期'); ylabel('操作波形 振幅');  zlabel('対数演算前アバタ速さ');
%                 xlim([0,800]);     ylim([0,800]);   zlim([0 50000]);
%                 title(['方向ベクトル ( dPeriod, dPeak, V ) = ( ' num2str(dirVect2(1)) ',  ' num2str(dirVect2(2)) ',  '  num2str(dirVect2(3)) , ')'] );
%                 axis square
%                 MonitorSize = [ 0, 0, 1280, 800];
%                 set(gcf, 'Position', MonitorSize);
%                 obj.saveGraphWithName(['_sumParam' num2str(i)]);

%%
                figure(3);
               subplot(r_fig, 2, 1)     
               plot(   user.time.highSampled,  user.avatarPosition.highSampled);         
                % 自動アバタの位置描画
                hold on
                    % 実験条件の描画
                    if strcmp( obj.config.examType, '追い込まれ実験')...
                            || strcmp( obj.config.examType, '追い込む実験')
                        plot(   obj.data.com.time,  obj.data.com.avatarPosition , 'k:');               
                    elseif ~isempty(  findstr( char( obj.config.examType ) , '線追従'))
                            plot(   obj.data.task.time,  obj.data.task.avatarPosition , 'k:');               
                    end
                    %　ゼロクロスしないタイミングを描画
                    for j= 1: length(IndexNonZeroCross)
                        zeroCrossTime = user.zeroCrossData.zeroCrossTime(IndexNonZeroCross(j) );
                        plot([zeroCrossTime zeroCrossTime],[0 1000],...
                            'Color' , [.7 .7 .7] , 'LineStyle', ':');
                    end
                hold off
                xlabel('時間t ms'); ylabel('アバタ位置');
                xlim([swTiming(i-1) swTiming(i)]);    ylim([0 1000]);

%            コントローラ操作描画    
                subplot(r_fig,2,3)
                plot(   user.time.highSampled,  user.operatePulse.highSampled );               
                hold on %　ゼロクロスしないタイミングを描画
                    for j= 1: length(IndexNonZeroCross)
                        zeroCrossTime = user.zeroCrossData.zeroCrossTime(IndexNonZeroCross(j) );
                        plot([zeroCrossTime zeroCrossTime],[-400 400],...
                            'Color' , [.7 .7 .7] , 'LineStyle', ':');
                    end
                    plot([0 60000], [0 0] ,'k')
                hold off
                xlabel('時間t ms'); ylabel('コントローラ操作');
                xlim([swTiming(i-1) swTiming(i)]);    ylim([-400 400]);
%                 grid on;
                set(gca,'YTick',[-400:100:400]);

%            アバタ速度     
                subplot(r_fig,2,5)
                plot(   user.time.highSampled,  user.avatarVelocity.highSampled );               
         
                hold on %　ゼロクロスしないタイミングを描画
                    % 実験条件の描画
                    if ~isempty(  findstr( char( obj.config.examType ) , '線追従'))
                        if mean( user.avatarVelocity.highSampled(swTiming(i-1):swTiming(i)) ) >0
                            plot(   obj.data.task.time,  obj.data.task.otherData(:,4) , 'k:');         
                        else
                            plot(   obj.data.task.time,  -obj.data.task.otherData(:,4) , 'k:');  
                        end
                    end
                   for j= 1: length(IndexNonZeroCross)
                        zeroCrossTime = user.zeroCrossData.zeroCrossTime(IndexNonZeroCross(j) );
                        plot([zeroCrossTime zeroCrossTime],[-0.5 0.5],...
                            'Color' , [.7 .7 .7] , 'LineStyle', ':');
                    end
                    plot([0 60000], [0 0] ,'k')
               hold off
                xlabel('時間t ms'); ylabel('アバタ速度');
                xlim([swTiming(i-1) swTiming(i)]);    ylim([-0.5 0.5]);
%                 grid on;
                set(gca,'YTick',[-0.5:0.1:0.5]);
                
                
                subplot(1,2,2);
                [dirVect3, lineEdgePoint] = Rhythm.approxiLine3d(X1_zc(:,3),  X2_zc(:,3),  Y_zc );
                plot3( X1_zc(:,3) , X2_zc(:,3), Y_zc,   'Marker','*', 'LineStyle','none');
                hold on
                    plot3( X1_nzc(:,3) , X2_nzc(:,3), Y_nzc, 'Marker','o', 'LineStyle','none');
                    plot3(lineEdgePoint(:,1),lineEdgePoint(:,2),lineEdgePoint(:,3),'r-');
                hold off
                grid on
                xlabel('操作波形 周期の差');  ylabel('操作波形 振幅の差');  zlabel('対数演算前アバタ速さ');
                xlim([0,600]);      ylim([0,600]);         zlim([0 50000]);
                title(['方向ベクトル ( dPeriod, dPeak, V ) = ( ' num2str(dirVect3(1)) ',  ' num2str(dirVect3(2)) ',  '  num2str(dirVect3(3)) , ')'] );
%                 text(300,300,40000, [ 'dPeriod : ' num2str( dirVect3(3)/dirVect3(1) ) ',  dPeak : ' num2str(dirVect3(3)/dirVect3(2) ) ')' ]),
                axis square
                MonitorSize = [ 0, 0, 1280, 800];
                set(gcf, 'Position', MonitorSize);
                obj.saveGraphWithName(['_difParam' num2str(i)]);
                
                %%      近似直線方向ベクトル　エクセルデータ出力  
                
                stIndex = find( obj.data.task.time == swTiming(i-1) );
                endIndex = find( obj.data.task.time == swTiming(i) );
                if  std( obj.data.task.otherData(stIndex:endIndex,4) )< 0.01
                    moveMode = mean( obj.data.task.otherData( stIndex:endIndex ,4) );
                else
                    moveMode = 0;
                end
                outputTitle = { '周期の差の係数成分' , '振幅の差の係数成分' , 'アバタ速さ（大数演算前）の係数成分' , '線速度モード'};
                output = num2cell( [dirVect3'   moveMode] );
                obj.outputAllToXlsWithName(num2str(i) ,output , outputTitle);


            end

        end

        
        
    end
end