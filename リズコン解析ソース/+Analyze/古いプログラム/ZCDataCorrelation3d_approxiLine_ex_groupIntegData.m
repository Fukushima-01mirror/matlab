classdef ZCDataCorrelation3d_approxiLine_ex_groupIntegData < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = ZCDataCorrelation3d_approxiLine_ex_groupIntegData(config,data)
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
            
            X1sin = zeros(1,3);
            X2sin = zeros(1,3);
            Ysin = zeros(1,1);
            
            figure(1);  
            MonitorSize = [ 0, 0, 800, 800];
            set(gcf, 'Position', MonitorSize);
            
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
                stIndex = find( obj.data.task.time == swTiming(i-1) );
                endIndex = find( obj.data.task.time == swTiming(i) );
                if  std( obj.data.task.otherData(stIndex:endIndex,4) )< 0.01
                    moveMode = mean( obj.data.task.otherData( stIndex:endIndex ,4) );
                else
                    moveMode = 0;
                end
                moveMode = round(moveMode*1000) /1000;
                

                [dirVect3, lineEdgePoint] = Rhythm.approxiLine3d(X1_zc(:,3),  X2_zc(:,3),  Y_zc );
                if moveMode == 0
                    plot3( X1_zc(:,3) , X2_zc(:,3), Y_zc,   'Marker','*', 'LineStyle','none', 'Color','b' );
                    hold on
                    plot3( X1_nzc(:,3) , X2_nzc(:,3), Y_nzc, 'Marker','o', 'LineStyle','none', 'Color','b' );
                    plot3(lineEdgePoint(:,1),lineEdgePoint(:,2),lineEdgePoint(:,3),'c-');
%                     X1sin = vertcat(X1sin, X1_zc);  X2sin = vertcat(X2sin, X2_zc);   Ysin = vertcat(Ysin, Y_zc);
                elseif moveMode ==  0.16
                    plot3( X1_zc(:,3) , X2_zc(:,3), Y_zc,   'Marker','*', 'LineStyle','none', 'Color',[0 .5 0] );
                    hold on
                    plot3( X1_nzc(:,3) , X2_nzc(:,3), Y_nzc, 'Marker','o', 'LineStyle','none', 'Color',[0 .5 0] );
                    plot3(lineEdgePoint(:,1),lineEdgePoint(:,2),lineEdgePoint(:,3),'g-');
                elseif moveMode ==  0.20
                    plot3( X1_zc(:,3) , X2_zc(:,3), Y_zc,   'Marker','*', 'LineStyle','none', 'Color','r' );
                    hold on
                    plot3( X1_nzc(:,3) , X2_nzc(:,3), Y_nzc, 'Marker','o', 'LineStyle','none', 'Color','r' );
                    plot3(lineEdgePoint(:,1),lineEdgePoint(:,2),lineEdgePoint(:,3),'m-');
                end
                grid on
                xlabel('操作波形 周期の差');  ylabel('操作波形 振幅の差');  zlabel('対数演算前アバタ速さ');
                xlim([0,600]);      ylim([0,600]);         zlim([0 50000]);
%                 title(['方向ベクトル ( dPeriod, dPeak, V ) = ( ' num2str(dirVect3(1)) ',  ' num2str(dirVect3(2)) ',  '  num2str(dirVect3(3)) , ')'] );
                axis square
                
                %%      近似直線方向ベクトル　エクセルデータ出力  
                
%                 outputTitle = { '周期の差の係数成分' , '振幅の差の係数成分' , 'アバタ速さ（大数演算前）の係数成分' , '線速度モード'};
%                 output = num2cell( [dirVect3'   moveMode] );
%                 obj.outputAllToXlsWithName(num2str(i) ,output , outputTitle);


            end
            hold off
            obj.saveGraph();

        end

        
        
    end
end

