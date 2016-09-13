classdef ZCDataCorrelation3d_approxiFlatSurf_group < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = ZCDataCorrelation3d_approxiFlatSurf_group(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
           [period_zx, peak_zx] = Rhythm.setZeroCrossPeriodData(user.zeroCrossData);
           %　ゼロクロス間でのピーク回数取得
           [zeroCrossTimes] = Rhythm.setZeroCrossCount(user.zeroCrossData);
            
            Y = abs( user.zeroCrossData.nonlogAvtVelocity );
            dT = abs( period_zx(:,3)  );
            dA = abs( peak_zx(:,3)  );
            time =  user.zeroCrossData.zeroCrossTime;
%             analyzeTime = obj.config.analyzeTime(1);
            analyzeTime  =3000;
            if obj.currentRunType == obj.runTypePlayer1 ...
                    || ( obj.currentRunType == obj.runTypeArchive && obj.config.isExistPlayer1 )
                IndexZeroCross = find(zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2 ...
                    & obj.data.player1.zeroCrossData.zeroCrossTime > analyzeTime + obj.data.player1.time.highSampled(1) );
                IndexNonZeroCross = find( zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1 ...
                    & obj.data.player1.zeroCrossData.zeroCrossTime > analyzeTime + obj.data.player1.time.highSampled(1) );
            elseif obj.currentRunType == obj.runTypePlayer2 ...
                    || ( obj.currentRunType == obj.runTypeArchive && obj.config.isExistPlayer2 )
                IndexZeroCross = find(zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2 ...
                    & obj.data.player2.zeroCrossData.zeroCrossTime > analyzeTime + obj.data.player2.time.highSampled(1) );
                IndexNonZeroCross = find( zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1 ...
                    & obj.data.player2.zeroCrossData.zeroCrossTime > analyzeTime + obj.data.player2.time.highSampled(1) );
            end

            Y_zc  = Y(IndexZeroCross);        Y_nzc  = Y(IndexNonZeroCross);
            dT_zc = dT(IndexZeroCross,:);     dT_nzc = dT(IndexNonZeroCross,:);
            dA_zc = dA(IndexZeroCross,:);     dA_nzc = dA(IndexNonZeroCross,:);
            time_zc = time(IndexZeroCross);     time_nzc = time(IndexNonZeroCross);

            %外れ値を除外するため，最大データ２つをカット
            [dT_max,dT_imax] = max(dT_zc);     dT_zc(dT_imax)= [];	 dA_zc(dT_imax)= [];     Y_zc(dT_imax)= [];     time_zc(dT_imax)= [];
            [dT_max,dT_imax] = max(dT_zc);     dT_zc(dT_imax)= [];	 dA_zc(dT_imax)= [];     Y_zc(dT_imax)= [];     time_zc(dT_imax)= [];
            [dA_max,dA_imax] = max(dA_zc);     dT_zc(dA_imax)= [];	 dA_zc(dA_imax)= [];     Y_zc(dA_imax)= [];     time_zc(dA_imax)= [];
            [dA_max,dA_imax] = max(dA_zc);     dT_zc(dA_imax)= [];	 dA_zc(dA_imax)= [];     Y_zc(dA_imax)= [];     time_zc(dA_imax)= [];
%             [Y_max,Y_imax] = max(Y_zc);     dT_zc(Y_imax)= [];	 dA_zc(Y_imax)= [];     Y_zc(Y_imax)= [];
%             [Y_max,Y_imax] = max(Y_zc);     dT_zc(Y_imax)= [];	 dA_zc(Y_imax)= [];     Y_zc(Y_imax)= [];
%             while max(Y_zc./dT_zc) > 1000
%                 [Y_dT_max,Y_dT_imax] = max(Y_zc./dT_zc);     dT_zc(Y_dT_imax)= [];	 dA_zc(Y_dT_imax)= [];     Y_zc(Y_dT_imax)= [];
%                 [Y_dT_max,Y_dT_imax] = max(Y_zc./dT_zc);     dT_zc(Y_dT_imax)= [];	 dA_zc(Y_dT_imax)= [];     Y_zc(Y_dT_imax)= [];
%             end
%             while max(Y_zc./dA_zc) > 1000
%                 [Y_dA_max,Y_dA_imax] = max(Y_zc./dA_zc);
%                 dT_zc(Y_dA_imax)= [];	 dA_zc(Y_dA_imax)= [];
%                 Y_zc(Y_dA_imax)= [];
%                 [Y_dA_max,Y_dA_imax] = max(Y_zc./dA_zc);     dT_zc(Y_dA_imax)= [];	 dA_zc(Y_dA_imax)= [];     Y_zc(Y_dA_imax)= [];
%             end

%%
            figure;
            MonitorSize = [ 0, 0, 500, 500];
            set(gcf, 'Position', MonitorSize);
            
            [fitParam3, dTFIT, dAFIT, YFIT , fitR, yhat, fitR2 ,resError, SER ]  = Rhythm.approxiSurface_flat(dT_zc , dA_zc , Y_zc );
%             Yzc_sh =10000;      %安井　閾値
            Yzc_sh =3000;      %木村　閾値
            dT_sh = 75;
%             t_st1 =13000;   t_end1 = 14000;
%             t_st2 =25620;   t_end2 = 28820;
            
%             index_nonBreak = find( (time_zc>t_st1 & time_zc<t_end1 ) );
%             index_else =  find( ~( (time_zc>t_st1 & time_zc<t_end1 ) ));
%             index_nonBreak = find( (time_zc>t_st1 & time_zc<t_end1 ) | (time_zc>t_st2 & time_zc<t_end2 )  );
%             index_else =  find( ~( (time_zc>t_st1 & time_zc<t_end1 ) | (time_zc>t_st2 & time_zc<t_end2 )  ));
%             indexG1 = find(Y_zc <= Yzc_sh);
%             indexG2 = find( Y_zc > Yzc_sh);
%             indexG1 = find( (Y_zc -1500)./dT_zc >40 );
%             indexG2 = find( (Y_zc -1500)./dT_zc <=40);

            indexG1 = find( ~( ( Y_zc./(dT_zc-50) <200 ) & Y_zc > Yzc_sh & dT_zc>dT_sh)  );
            indexG2 = find( ( Y_zc./(dT_zc-50) <200 ) & Y_zc > Yzc_sh & dT_zc>dT_sh);

%             indexG1 = find( ~( ( Y_zc./(dT_zc-50) >200 ) & Y_zc > Yzc_sh)  );
%             indexG2 = find( ( Y_zc./(dT_zc-50) >200 ) & Y_zc > Yzc_sh);

%             plot3( dT_zc  , dA_zc , Y_zc,   'Marker','*', 'LineStyle','none');
            plot3( dT_zc(indexG1)  , dA_zc(indexG1) , Y_zc(indexG1),   'Marker','*', 'LineStyle','none');
            hold on
                plot3( dT_zc(indexG2)  , dA_zc(indexG2) , Y_zc(indexG2),   'Marker','*', 'LineStyle','none'  , 'Color' , 'r');
%                 plot3( dT_zc(index_nonBreak)  , dA_zc(index_nonBreak) , Y_zc(index_nonBreak),   'Marker','*', 'LineStyle','none'  , 'Color' , 'r');
                plot3( dT_nzc  , dA_nzc , Y_nzc, 'Marker','o', 'LineStyle','none');
                mesh(dTFIT,dAFIT,YFIT, 'faceAlpha',0.5);
            hold off
            grid on
            view(-30,30);
            xlabel('操作波形 周期の差');  ylabel('操作波形 振幅の差');  zlabel('対数演算前アバタ速さ');
            xlim([0 600]);            ylim([0 600]);          zlim([0 50000]);

            if isempty(  findstr( char( obj.config.examType ) , '自由操作'))
                xlim([0,600]);      ylim([0,600]);         zlim([0 50000]);
            end

            [zY_zc , m_Y , s_Y]  = zscore( Y_zc);
            [zdT_zc , m_dT , s_dT] = zscore( dT_zc);
            [zdA_zc , m_dA , s_dA] = zscore( dA_zc);
            [zfitParam, zdTFIT, zdAFIT, zYFIT , zfitR, zyhat, zfitR2 ]  = Rhythm.approxiSurface_flat(zdT_zc , zdA_zc , zY_zc );

            title({['V = (' num2str(fitParam3(1)) ') + (' num2str( fitParam3(2) ) ') * dPeriod + (' num2str( fitParam3(3)) ') * dPeak']; ...
                      ['標準化係数　dPeriod：' num2str( zfitParam(2) ) '，dPeak：' num2str( zfitParam(3) )];...
                    ['相関係数R：' num2str( fitR ) '，決定係数R^2：' num2str( fitR2 ) '，標準誤差(残差の標準偏差)：' num2str(SER) ];...
                  ['データ数:' num2str( length(user.time.highSampled)  - analyzeTime ) '[ms],(' num2str( length(Y_zc) ) ')' ] });
            axis square
%             if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
%                 obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state ]);
%             else
%                 obj.saveGraph();
%             end

                %%  
                bFig =0;
            % クラスター1
            [k1_g1 , k2_g1, X1_g1, fitParam_X1Y_g1, fitLineR_X1Y_g1] = Rhythm.PCA_regress_3dplot(dT_zc(indexG1) , dA_zc(indexG1) , Y_zc(indexG1) , bFig) ;
            [k1_g2 , k2_g2, X1_g2, fitParam_X1Y_g2, fitLineR_X1Y_g2] = Rhythm.PCA_regress_3dplot(dT_zc(indexG2) , dA_zc(indexG2) , Y_zc(indexG2) , bFig) ;

            figure;
            MonitorSize = [ 0, 0, 500, 500];
            set(gcf, 'Position', MonitorSize);
    %%        全体データ散布図
    %              figure(220);
                MonitorSize = [ 0, 0, 500, 500];
                set(gcf, 'Position', MonitorSize);
                lineEdgePoint_X1Y_g1 = [ min(X1_g1)*k1_g1 , min(X1_g1)*k2_g1 , polyval( fitParam_X1Y_g1, min(X1_g1) ) ;...
                                        max(X1_g1)*k1_g1 , max(X1_g1)*k2_g1 , polyval( fitParam_X1Y_g1, max(X1_g1) ) ];
                lineEdgePoint_X1Y_g2 = [ min(X1_g2)*k1_g2 , min(X1_g2)*k2_g2 , polyval( fitParam_X1Y_g2, min(X1_g2) ) ;...
                                        max(X1_g2)*k1_g2 , max(X1_g2)*k2_g2 , polyval( fitParam_X1Y_g2, max(X1_g2) ) ];
                plot3( [0 0],[0 0],[0 0],'k' );
                hold on
    %                 plot3(dT_zc, dA_zc , Y_zc ,'Color' , 'k' );
                    plot3(dT_zc(indexG1) , dA_zc(indexG1) , Y_zc(indexG1) ,'Color' , 'b' ,'Marker','*', 'LineStyle','none');   %,'MarkerSize',2);
                    plot3(dT_zc(indexG2) , dA_zc(indexG2) , Y_zc(indexG2) ,'Color' , [0 .5 0] ,'Marker','*', 'LineStyle','none');   %,'MarkerSize',3);

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
                title({['theta1 =(' num2str( atan(k2_g1/k1_g1) *180 / pi ) ')[deg]，X1-Vの傾き：' num2str( fitParam_X1Y_g1(1) ) ...
                            '，相関係数R：' num2str( fitLineR_X1Y_g1(1)) '，決定係数R^2：' num2str( fitLineR_X1Y_g1(1)^2)];...
                       ['theta2 =(' num2str( atan(k2_g2/k1_g2) *180 / pi ) ')[deg]，dA-Vの傾き：' num2str( fitParam_X1Y_g2(1) ) ...
                            '，相関係数R：' num2str( fitLineR_X1Y_g2(1)) '，決定係数R^2：' num2str( fitLineR_X1Y_g2(1)^2)]});
                xlabel('操作波形 周期の差dT');  ylabel('操作波形 振幅の差dA');  zlabel('対数演算前アバタ速さV');
                xlim([0 400]);            ylim([0 400]);          zlim([0 40000]);

    %            title({ ['V = (' num2str(fitParam3d(1)) ') + (' num2str( fitParam3d(2) ) ') * ΔT + (' num2str( fitParam3d(3)) ') * ΔA'] ;...
    %                 []});
                axis square

%%
            figure
%             MonitorSize = [ 0, 0, 1000, 500];
%             set(gcf, 'Position', MonitorSize);
               time_break = time_zc(indexG2);
               time_else =  time_zc(indexG1);
%                 time_nonBreak = time_zc(index_nonBreak);
               plot(   user.time.highSampled,  user.avatarPosition.highSampled);         
               hold on
                    % 実験条件の描画
                    if ~isempty( strfind( char(obj.config.examType), '追い込まれ') ) ...
                            || ~isempty( strfind( char(obj.config.examType), '追い込む実験') )
                        plot(   obj.data.com.time,  obj.data.com.avatarPosition , 'k:');               
                        if ~isempty(strfind( char(obj.config.examType), '両側') )  
                            plot(   obj.data.com2.time,  obj.data.com2.avatarPosition , 'k:');     
                        end
                    elseif ~isempty(  findstr( char( obj.config.examType ) , '追従'))
                        if ~isempty(  findstr( char( obj.config.examType ) , '目標追従'))
                            plot(   obj.data.task.time,  obj.data.task.avatarPosition , 'color' ,[.8 .8 .8]);   
                            plot(   obj.data.task.time,  obj.data.task.avatarPosition-75 , 'color' ,[.8 .8 .8]);   
                        else
                            plot(   obj.data.task.time,  obj.data.task.avatarPosition , 'k:');   
                        end
                    elseif obj.config.isExistPlayer1 && obj.config.isExistPlayer2
                        if obj.currentRunType == obj.runTypePlayer1
                            dist =abs( user.avatarPosition.highSampled -obj.data.player2.avatarPosition.highSampled);
                            plot( obj.data.player2.time.highSampled , obj.data.player2.avatarPosition.highSampled , 'k');
                            plot( obj.data.player1.time.highSampled , dist,':r');
                            
                        elseif obj.currentRunType == obj.runTypePlayer2
                            dist = user.avatarPosition.highSampled -obj.data.player1.avatarPosition.highSampled;
                            plot( obj.data.player1.time.highSampled , obj.data.player1.avatarPosition.highSampled , 'k');
                            plot( obj.data.player1.time.highSampled , dist,':r');
                            t_20 = 20:20:60000;
                            swd1 = obj.data.player1.avatarSword; swd2 =  obj.data.player2.avatarSword;
                            plot(t_20, swd1 , t_20, swd2)
                            
                        end
                    end
                    for i= 1:length(time_break)
                        plot([time_break(i) time_break(i)], [0 1000], 'm');
                    end
%                     for i= 1:length(time_nonBreak)
%                         plot([time_nonBreak(i) time_nonBreak(i)], [0 1000], 'm');
%                     end
                    xlim([0 18000]);
                hold off

            %%      近似面　係数　エクセルデータ出力  
%             outputTitle = { '定数項', '周期差', '(標準化)',...
%                                     '振幅差', '(標準化)', '重相関R', '重決定R2' ,'標準誤差(残差の標準偏差)' };
%             output = num2cell( [fitParam3(1) fitParam3(2) zfitParam(2) fitParam3(3) zfitParam(3) fitR fitR2 SER ] );
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
