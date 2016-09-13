classdef ZCData_3dPlot_axis_timeShift_Kaiki < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = ZCData_3dPlot_axis_timeShift_Kaiki(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
           [period_zx, peak_zx] = Rhythm.setZeroCrossPeriodData(user.zeroCrossData);
           %　ゼロクロス間でのピーク回数取得
           [zeroCrossTimes] = Rhythm.setZeroCrossCount(user.zeroCrossData);
            
            Y = abs( user.zeroCrossData.nonlogAvtVelocity );
            dT = abs( period_zx(:,3) );
            dA = abs( peak_zx(:,3) );
            
            V_max = 50000;
            dT_max = 500;
            dA_max = 500;
            
            THETA = ones(1,60000);
            Exl = zeros(3000,1);
            
            if obj.currentRunType == obj.runTypePlayer1 ...
                    || ( obj.currentRunType == obj.runTypeArchive && obj.config.isExistPlayer1 )
                IndexZeroCross = find(zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2);
                IndexNonZeroCross = find( zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1);
            elseif obj.currentRunType == obj.runTypePlayer2 ...
                    || ( obj.currentRunType == obj.runTypeArchive && obj.config.isExistPlayer2 )
                IndexZeroCross = find(zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2 );
                IndexNonZeroCross = find( zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1);
            end

            Y_zc  = Y(IndexZeroCross);        Y_nzc  = Y(IndexNonZeroCross);
            dT_zc = dT(IndexZeroCross);     dT_nzc = dT(IndexNonZeroCross);
            dA_zc = dA(IndexZeroCross);     dA_nzc = dA(IndexNonZeroCross);

            %　時間スケールの設定            
            spotTime = 2000;    %  時間スケールの設定 
            %2000 ここから下の200はすべてもともとは500
            startTime =  500 * floor( obj.data.player1.time.highSampled(1) /500) ;
            spotTimeSeries = spotTime+startTime : user.time.highSampled(end);
            spotTimeSeries = spotTimeSeries.';
            Num = 1;

            for spotTimeMax =  500 * floor( (spotTime+startTime) /500) : 500: 500 * ceil(user.time.highSampled(end) /500)

                %ここから上の200はすべてもともと500
                startIndex1 = find( user.zeroCrossData.zeroCrossTime(IndexZeroCross) >= ( spotTimeMax - spotTime +1 ) ,1 ,'first');
                endIndex1 = find( user.zeroCrossData.zeroCrossTime(IndexZeroCross) < spotTimeMax ,1 ,'last');  

                if length(Y_zc(startIndex1:endIndex1))>2

                    MonitorSize = [ 0, 0, 1200, 800];
                    set(gcf, 'Position', MonitorSize);
                         figure(1);

                         %% アバタ位置
                    subplot(3,4,[3 4])
                    plot(   user.time.lowSampled,  user.avatarPosition.lowSampled , 'Color', 'c'); 
                    hold on 
                        plot([spotTimeMax-spotTime+1 spotTimeMax-spotTime+1],[0 1000],'--k');
                        plot([spotTimeMax spotTimeMax],[0 1000],'--k');

                        stTimeIndex = find(user.time.highSampled > spotTimeMax-spotTime+1, 1, 'first');
                        endTimeIndex = find(user.time.highSampled < spotTimeMax, 1, 'last');
                        plot(   user.time.highSampled(stTimeIndex:endTimeIndex) ,...
                                    user.avatarPosition.highSampled(stTimeIndex:endTimeIndex) );                     
                        % 実験条件の描画
                        if strcmp( obj.config.examType, '追い込まれ実験')...
                                || strcmp( obj.config.examType, '追い込む実験')
                            plot(   obj.data.com.time,  obj.data.com.avatarPosition , 'Color' , [.6 .6 .6]);               
                        elseif ~isempty(  findstr( char( obj.config.examType ) , '追従'))
                            plot(   obj.data.task.time,  obj.data.task.avatarPosition , 'Color' , [.6 .6 .6]);
                            if ~isempty(  findstr( char( obj.config.examType ) , '目標追従'))
                                plot(   obj.data.task.time,  obj.data.task.avatarPosition-150 , 'Color' , [.6 .6 .6]);
                            end
                        elseif obj.config.isExistPlayer1 && obj.config.isExistPlayer2
                            if obj.currentRunType == obj.runTypePlayer1
                                plot( obj.data.player2.time.highSampled , obj.data.player2.avatarPosition.highSampled , 'k:');
                            elseif obj.currentRunType == obj.runTypePlayer2
                                plot( obj.data.player1.time.highSampled , obj.data.player1.avatarPosition.highSampled , 'k:');
                            end
                        end
                    hold off
                    if ~isempty(  findstr( char( obj.config.examType ) , '剣道'))
                        title( [ 'アバタ位置  ( ' char( obj.data.splitTimeInfo.state ) ' ）']);
                    end
                    xlabel('時間t ms'); ylabel('アバタ位置');
                    xlim([0,60000]);    ylim([0 1000]);

                    %%  3D散布図
                    subplot(3,4,[7 8 11 12])

                    dTg_zc = mean(dT_zc(startIndex1:endIndex1));
                    dAg_zc = mean(dA_zc(startIndex1:endIndex1));
                    dT0_zc = dT_zc - dTg_zc;
                    dA0_zc = dA_zc - dAg_zc;
                    [coeff,score,latent,tsquare] = princomp( [dT_zc(startIndex1:endIndex1) dA_zc(startIndex1:endIndex1)] );
                    k1 = abs(coeff(1,1));            k2 = abs(coeff(2,1));
                    theta = atan(k2/k1) *180 / pi ;

                    X1 = k1 * dT0_zc(startIndex1:endIndex1) + k2 * dA0_zc(startIndex1:endIndex1);
                    [ fitParam_X1Y, fitLineR_X1Y, lineEdgePoint_X1Y] = Rhythm.approxiLine2d(X1, Y_zc(startIndex1:endIndex1) );
%                     plot3( dT_zc , dA_zc, Y_zc,   'Marker','o', 'MarkerEdgeColor' , [.7 .7 .7] ,'LineStyle','none');
%                     axis square
%                     grid on
%                     hold on
%                         plot3( dT_nzc , dA_nzc, Y_nzc, 'Marker','.', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none');
%                         plot3( dT_zc(startIndex1:endIndex1) , dA_zc(startIndex1:endIndex1), Y_zc(startIndex1:endIndex1),...
%                             'Marker','o', 'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'LineStyle','none');
%                         plot(  [ -150*coeff(1,1)+dTg_zc ; 150*coeff(1,1)+dTg_zc ] , [ -150*coeff(2,1)+dAg_zc ; 150*coeff(2,1)+dAg_zc ] , 'r')
%                         plot(  [ -50*coeff(1,2)+dTg_zc ; 50*coeff(1,2)+dTg_zc ] , [ -50*coeff(2,2)+dAg_zc ; 50*coeff(2,2)+dAg_zc ] , 'r')
%                         plot3( lineEdgePoint_X1Y(:,1)*k1 +dTg_zc , lineEdgePoint_X1Y(:,1)*k2 +dAg_zc, lineEdgePoint_X1Y(:,2) ,'r' ,'LineWidth',3 );
% 
%                         plot3( [ lineEdgePoint_X1Y(2,1)*k1+dTg_zc lineEdgePoint_X1Y(2,1)*k1+dTg_zc ] ,...
%                                [ lineEdgePoint_X1Y(2,1)*k2+dAg_zc lineEdgePoint_X1Y(2,1)*k2+dAg_zc ] ,...
%                                [0 lineEdgePoint_X1Y(2,2)] ,'--r' );              % 垂線
%                     hold off
%                     xlabel('操作波形 周期の差');  ylabel('操作波形 振幅の差');  zlabel('対数演算前アバタ速さ');
%                     xlim([0,dT_max]);      ylim([0,dA_max]);         zlim([0 V_max]);
% 
%                     if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
%                          title({['GameTime: ' num2str(obj.data.player1.time.highSampled(1)) '～' num2str( obj.data.player1.time.highSampled(end))];...
%                              ['time:' num2str(spotTimeMax-spotTime ) '～'  num2str(spotTimeMax)  ]});
%                     else
%                         title({['time:' num2str(spotTimeMax-spotTime ) '～'  num2str(spotTimeMax)  ]});
%                     end

                    %%  周期差とアバタ速さの相関

%                     subplot(3,4,1);
                    [ fitParam1, fitLineR1, lineEdgePoint] = Rhythm.approxiLine2d(dT_zc(startIndex1:endIndex1), Y_zc(startIndex1:endIndex1) );
%                     plot( dT_zc  ,Y_zc,  'Marker','o', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none' );
%                     hold on
%                         plot( dT_nzc  ,Y_nzc,'Marker','.', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none' );
%                         plot( dT_zc(startIndex1:endIndex1) ,  Y_zc(startIndex1:endIndex1),...
%                             'Marker','o', 'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'LineStyle','none');
%                         plot(lineEdgePoint(:,1), lineEdgePoint(:,2), 'r')
%                     hold off
%                     grid on
%                     xlabel('操作波形 周期の差'); ylabel('対数演算前アバタ速さ');
%                     xlim([0,dT_max]);         ylim([0 V_max]);
%                     title({['V =  (' num2str( fitParam1(1) ) ') * dPeriod  + (' num2str(fitParam1(2)) ')']; ...
%                             ['決定係数：' num2str( fitLineR1(1)^2)]} );
%                     axis square

                    %% 　振幅差とアバタ速さの相関
                    subplot(3,4,5);
                    [ fitParam2, fitLineR2, lineEdgePoint] = Rhythm.approxiLine2d(dA_zc(startIndex1:endIndex1), Y_zc(startIndex1:endIndex1) );
%                     plot( dA_zc  ,Y_zc ,  'Marker','o', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none' );
%                     hold on
%                         plot( dA_nzc  ,Y_nzc,'Marker','.', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none' );
%                         plot(  dA_zc(startIndex1:endIndex1), Y_zc(startIndex1:endIndex1),...
%                             'Marker','o', 'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'LineStyle','none');
%                         plot(lineEdgePoint(:,1), lineEdgePoint(:,2), 'r')
%                     hold off
%                     grid on
%                     xlabel('操作波形　振幅の差'); ylabel('対数演算前アバタ速さ');
%                     xlim([0,dA_max]);            ylim([0 V_max]);
%                     title({['V =  (' num2str( fitParam2(1) ) ') * dPeak  + (' num2str(fitParam2(2)) ')']; ...
%                             ['相関係数：' num2str( fitLineR2(1))]});
%                     axis square
% 
%                     %% 　周期差と振幅差の相関
%                     subplot(3,4,9);
%                     [ fitParam3, fitLineR3, lineEdgePoint] = Rhythm.approxiLine2d(dT_zc(startIndex1:endIndex1)  ,dA_zc(startIndex1:endIndex1) );
%                     plot( dT_zc  ,dA_zc , 'Marker','o', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none' );
%                     hold on
%                         plot(  [ -150*coeff(1,1)+dTg_zc ; 150*coeff(1,1)+dTg_zc ] , [ -150*coeff(2,1)+dAg_zc ; 150*coeff(2,1)+dAg_zc ] , 'r')
%                         plot(  [ -50*coeff(1,2)+dTg_zc ; 50*coeff(1,2)+dTg_zc ] , [ -50*coeff(2,2)+dAg_zc ; 50*coeff(2,2)+dAg_zc ] , 'r')
%                         plot( dT_nzc  ,dA_nzc,'Marker','.', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none' );
%                         plot( dT_zc(startIndex1:endIndex1) , dA_zc(startIndex1:endIndex1),...
%                             'Marker','o', 'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'LineStyle','none');
%                     hold off
%                     grid on
%                     xlabel('操作波形 周期の差');    ylabel('操作波形　振幅の差'); 
%                     
%                     xlim([0,dT_max]);            ylim([0,dA_max]);
%                     title({ ['相関係数：' num2str( fitLineR3(1))]});
%                     axis square

                    %%  合成変数X1とアバタ速さの相関
                    subplot(3,4,6);
                    alpha = fitParam_X1Y(1);   beta = fitParam_X1Y(2);
%                     plot( k1 * dT0_zc + k2 * dA0_zc  ,Y_zc  , 'Marker','o', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none');
%                     hold on
%                         plot( X1   ,Y_zc(startIndex1:endIndex1),...
%                             'Marker','o', 'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'LineStyle','none');
%                         plot(lineEdgePoint_X1Y(:,1), lineEdgePoint_X1Y(:,2), 'r')
%                     hold off
%                     grid on 
%                     axis square
%                     xlabel('X = k1*ΔT + k2*ΔA');    ylabel('対数変換前アバタ速度'); 
%                     xlim([-dT_max/2,dT_max/2]);            ylim([0 V_max]);
%                     title({['V =  (' num2str( alpha ) ') * X  + (' num2str( beta ) ')']; ...
%                             ['決定係数R^2' num2str( fitLineR_X1Y(1)^2)] });
%                     axis square
% 
%                     %%  合成変数X1
%                     subplot(3,4,10);
%                     plot( dT0_zc , dA0_zc , 'Marker','o', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none');
%                     hold on
%                         plot( dT_nzc - mean(dT_zc(startIndex1:endIndex1)) , dA_nzc - mean(dT_zc(startIndex1:endIndex1)) ,'Marker','.', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none');
%                         plot( dT0_zc(startIndex1:endIndex1) , dA0_zc(startIndex1:endIndex1) ,...
%                             'Marker','o', 'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'LineStyle','none');
%                         plot(  [ -150*coeff(1,1) ; 150*coeff(1,1) ] , [ -150*coeff(2,1) ; 150*coeff(2,1) ] , 'r')
%                         plot(  [ -50*coeff(1,2) ; 50*coeff(1,2) ] , [ -50*coeff(2,2) ; 50*coeff(2,2) ] , 'r')
%                     hold off
%                     grid on
%                     axis square
%                     xlabel('操作波形 周期の差　ΔT');    ylabel('操作波形　振幅の差　ΔA'); 
%                     xlim([-dT_max/2,dT_max/2]);             xlim([-dA_max/2,dA_max/2]); 
%                     title({['k1 : ' num2str( decround(k1,3) ) ' , k2 : ' num2str( decround(k2,3) )]; ...
%                         ['　\theta =  (' num2str( decround(theta,3) ) ')[degree]']});
                    
                    disp(spotTimeMax);
                    disp(spotTime);
                    THETA(1,spotTimeMax-spotTime+1:spotTimeMax)=decround(theta,3);
                    %PHI(1,spotTimeMax-spotTime+1:spotTimeMax)=alpha;
                    %VEL(1,spotTimeMax-spotTime:spotTimeMax)= Y_zc(startIndex1:endIndex1);
                    axis square               
                    %%

                    % 動画
%                     drawnow             % drawnowを入れるとアニメーションになる
%                     movmov(Num) = getframe(gcf,MonitorSize);           % アニメーションのフレームをゲットする
% 
%                     % 一枚ずつ保存
%                     if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
%                         obj.saveGraphWithNameToFolder( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_'  num2str(Num)]);
%                     else
%                         obj.saveGraphWithNameToFolder( [  num2str(Num) ]);
%                     end

                    Num = Num +1;
                end
   
            end
%             
%             MonitorSize = [ 0, 0, 800, 800];
%             set(gcf, 'Position', MonitorSize);
%             a1 = subplot( 2,1,1 );
%             plot(1:1:60000,THETA(1,:),'k');
%             A = std((optiData(1:6000,3)+optiData(1:6000,6)+optiData(1:6000,9)+optiData(1:6000,12))/4);
%             xlabel('時間t s'); ylabel('方位角θ');
%             xlim([0 60000]);ylim([0 90]);
%             title('回帰直線方位角');
%             a2 = subplot( 2,1,2 );
%             plot(1:1:60000,PHI(1,:),'k');
%             xlabel('時間t s'); ylabel('仰角φ');
%             xlim([0 60000]);ylim([0 200]);
%             title('回帰直線仰角');
%              
%             linkaxes([a1 a2],'x');
%             obj.saveGraphWithName('回帰直線遷移');
                        
              for i =1:60000
                if(rem(i,20) == 0)
                    Exl(i/20,1)=mean(THETA(1,20*((i/20)-1)+1:i));
                end
              end    
              disp(obj.config.fileName);
            filename = [char(obj.config.fileName) '回帰直線方位角'];
            disp(filename);
            A = Exl;
            sheet = 1;
            xlRange = 'A1';
            xlswrite(filename,A,sheet,xlRange)
            
                      
%             if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
%                 saveMovieName = obj.saveFilePath(['_' num2str( obj.data.splitTimeInfo.index ) '.avi']);
%             else
%                 saveMovieName = obj.saveFilePath('.avi');
%             end
%             movie2avi(movmov, saveMovieName,  'compression', 'None', 'fps', 2);

            %%      近似面　係数　エクセルデータ出力  
% %             VIF = Rhythm.getVIF([X1_zc(:,3), X2_zc(:,3)]);
%             VIF = [ NaN ,NaN ];
%             outputTitle = { '定数項' , '周期差' , '振幅差',...
%                                     'VIF(周期差)', 'VIF（振幅差）','重相関R','重決定R2' };
%             output = num2cell( [fitParam3' VIF fitR fitR2] );
%             
%             if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
%                 obj.outputAllToXlsWithName([ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state ] , output , outputTitle)
%             else
%                 obj.outputAllToXls(output , outputTitle);
%             end

        end

        function runForPair(obj,user1 ,user2)
%             obj.runForAlone(user1);
%             obj.runForAlone(user2);
%             
            
        end

        
    end
end
