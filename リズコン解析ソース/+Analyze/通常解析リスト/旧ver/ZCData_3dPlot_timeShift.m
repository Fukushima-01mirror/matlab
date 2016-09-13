classdef ZCData_3dPlot_timeShift < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = ZCData_3dPlot_timeShift(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
           [period_zx, peak_zx] = Rhythm.setZeroCrossPeriodData(user.zeroCrossData);
           %　ゼロクロス間でのピーク回数取得
           [zeroCrossTimes] = Rhythm.setZeroCrossCount(user.zeroCrossData);
            
            Y = abs( user.zeroCrossData.nonlogAvtVelocity );
            X1 = abs( period_zx );
            X2 = abs( peak_zx );
            
            V_max = 30000;
            dT_max = 300;
            dA_max = 300;
            
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
            X1_zc = X1(IndexZeroCross,:);     X1_nzc = X1(IndexNonZeroCross,:);
            X2_zc = X2(IndexZeroCross,:);     X2_nzc = X2(IndexNonZeroCross,:);

            %　時間スケールの設定            
            spotTime = 2000;    %  時間スケールの設定    
            startTime =  500 * floor( obj.data.player1.time.highSampled(1) /500) ;
%             spotTimeSeries = spotTime+startTime : user.time.highSampled(end);
%             spotTimeSeries = spotTimeSeries.';
            Num = 1;

            for spotTimeMax =  500 * floor( (spotTime+startTime) /500) : 500: 500 * ceil(user.time.highSampled(end) /500)
                if spotTimeMax == user.time.highSampled(end)
                
                end
               startIndex1 = find( user.zeroCrossData.zeroCrossTime(IndexZeroCross) >= ( spotTimeMax - spotTime ) ,1 ,'first');
               endIndex1 = find( user.zeroCrossData.zeroCrossTime(IndexZeroCross) < spotTimeMax ,1 ,'last');  

                MonitorSize = [ 0, 0, 1200, 800];
                set(gcf, 'Position', MonitorSize);
                     figure(1);
                subplot(3,2,1);
                [ fitParam1, fitLineR1, lineEdgePoint] = Rhythm.approxiLine2d(X1_zc(:,3), Y_zc );
                plot( X1_zc(:,3)  ,Y_zc,  'Marker','o', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none' );
                hold on
                    plot( X1_nzc(:,3)  ,Y_nzc,'Marker','.', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none' );
                    plot( X1_zc(startIndex1:endIndex1 ,3) ,  Y_zc(startIndex1:endIndex1),...
                        'Marker','o', 'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'LineStyle','none');
                hold off
                grid on
                xlabel('操作波形 周期の差'); ylabel('対数演算前アバタ速さ');
                xlim([0,dT_max]);         ylim([0 V_max]);
                title({['V =  (' num2str( fitParam1(1) ) ') * dPeriod  + (' num2str(fitParam1(2)) ')']; ...
                        ['相関係数：' num2str( fitLineR1(1))]} );
                axis square

                %　振幅差とアバタ速さの相関
                subplot(3,2,3);
                [ fitParam2, fitLineR2, lineEdgePoint] = Rhythm.approxiLine2d(X2_zc(:,3), Y_zc );
                plot( X2_zc(:,3)  ,Y_zc ,  'Marker','o', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none' );
                hold on
                    plot( X2_nzc(:,3)  ,Y_nzc,'Marker','.', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none' );
                    plot(  X2_zc(startIndex1:endIndex1,3), Y_zc(startIndex1:endIndex1),...
                        'Marker','o', 'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'LineStyle','none');
                hold off
                grid on
                xlabel('操作波形　振幅の差'); ylabel('対数演算前アバタ速さ');
                xlim([0,dA_max]);            ylim([0 V_max]);
                title({['V =  (' num2str( fitParam2(1) ) ') * dPeak  + (' num2str(fitParam2(2)) ')']; ...
                        ['相関係数：' num2str( fitLineR2(1))]});
                axis square

                %　周期差と振幅差の相関
                subplot(3,2,5);
                [ fitParam3, fitLineR3, lineEdgePoint] = Rhythm.approxiLine2d(X1_zc(:,3)  ,X2_zc(:,3) );
                plot( X1_zc(:,3)  ,X2_zc(:,3) , 'Marker','o', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none' );
                hold on
                    plot( X1_nzc(:,3)  ,X2_nzc(:,3),'Marker','.', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none' );
                    plot( X1_zc(startIndex1:endIndex1 ,3) , X2_zc(startIndex1:endIndex1,3),...
                        'Marker','o', 'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'LineStyle','none');
                hold off
                grid on
                xlabel('操作波形 周期の差');    ylabel('操作波形　振幅の差'); 
                xlim([0,dT_max]);            ylim([0,dA_max]);
                title({['V =  (' num2str( fitParam3(1) ) ') * dPeak  + (' num2str(fitParam3(2)) ')']; ...
                        ['相関係数：' num2str( fitLineR3(1))]});
                axis square
                
                subplot(1,2,2)
%                 [fitParam3, X1FIT, X2FIT, YFIT , fitR, yhat, fitR2 ]  = Rhythm.approxiSurface_flat(X1_zc(:,3), X2_zc(:,3), Y_zc );
                plot3( X1_zc(:,3) , X2_zc(:,3), Y_zc,   'Marker','o', 'MarkerEdgeColor' , [.7 .7 .7] ,'LineStyle','none');
                axis square
                grid on
                hold on
                    plot3( X1_nzc(:,3) , X2_nzc(:,3), Y_nzc, 'Marker','.', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none');
    %                 mesh(X1FIT,X2FIT,YFIT, 'faceAlpha',0.5);
                    plot3( X1_zc(startIndex1:endIndex1 ,3) , X2_zc(startIndex1:endIndex1,3), Y_zc(startIndex1:endIndex1),...
                        'Marker','o', 'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'LineStyle','none');
                hold off
                xlabel('操作波形 周期の差');  ylabel('操作波形 振幅の差');  zlabel('対数演算前アバタ速さ');
                xlim([0,dT_max]);      ylim([0,dA_max]);         zlim([0 V_max]);
                if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
                     title({['GameTime: ' num2str(obj.data.player1.time.highSampled(1)) '〜' num2str( obj.data.player1.time.highSampled(end))];...
                         ['time:' num2str(spotTimeMax-spotTime ) '〜'  num2str(spotTimeMax)  ]});
                else
                    title({['time:' num2str(spotTimeMax-spotTime ) '〜'  num2str(spotTimeMax)  ]});
                end

                if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
                    obj.saveGraphWithNameToFolder( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_'  num2str(Num)]);
                else
                    obj.saveGraphWithNameToFolder( [  num2str(Num) ]);
                end

                Num = Num +1;
            end

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
