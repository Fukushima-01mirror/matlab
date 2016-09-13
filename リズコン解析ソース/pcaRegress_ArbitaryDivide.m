
index = find(Time_zc > 5000); 
zcData1 = zcData(index,:);
time = avt_data(5000:end,1);
avtPos = avt_data(5000:end,4);
avtPosL = avt_dataL(5000:end,4);

% 
%     %外れ値を除外するため，最大データ２つをカット
%     [dT_max,dT_imax] = max(dT_zc);     zcData1(dT_imax) = [];
%     [dT_max,dT_imax] = max(dT_zc);     zcData1(dT_imax) = [];
%     [dA_max,dA_imax] = max(dA_zc);     zcData1(dA_imax) = [];
%     [dA_max,dA_imax] = max(dA_zc);     zcData1(dA_imax) = [];
%             [Y_max,Y_imax] = max(Y_zc);     dT_zc(Y_imax)= [];	 dA_zc(Y_imax)= [];     Y_zc(Y_imax)= [];
%             [Y_max,Y_imax] = max(Y_zc);     dT_zc(Y_imax)= [];	 dA_zc(Y_imax)= [];     Y_zc(Y_imax)= [];
%             while max(Y_zc./dT_zc) > 500
%                 [Y_dT_max,Y_dT_imax] = max(Y_zc./dT_zc);     dT_zc(Y_dT_imax)= [];	 dA_zc(Y_dT_imax)= [];     Y_zc(Y_dT_imax)= [];
%                 [Y_dT_max,Y_dT_imax] = max(Y_zc./dT_zc);     dT_zc(Y_dT_imax)= [];	 dA_zc(Y_dT_imax)= [];     Y_zc(Y_dT_imax)= [];
%             end
%             while max(Y_zc./dA_zc) > 500
%                 [Y_dA_max,Y_dA_imax] = max(Y_zc./dA_zc);     dT_zc(Y_dA_imax)= [];	 dA_zc(Y_dA_imax)= [];     Y_zc(Y_dA_imax)= [];
%                 [Y_dA_max,Y_dA_imax] = max(Y_zc./dA_zc);     dT_zc(Y_dA_imax)= [];	 dA_zc(Y_dA_imax)= [];     Y_zc(Y_dA_imax)= [];
%             end
    Time_zc = zcData1(:,1);
    Y_zc = zcData1(:,2);
    dT_zc = zcData1(:,3);
    dA_zc = zcData1(:,4);
    cluster = zcData1(:,7);
 
     Nzc = length(Y_zc) ;

%%           主成分回帰分析
    bFig =1 ;
    figure
    [k1 , k2, X1, fitParam_X1Y, fitLineR_X1Y] = Rhythm.PCA_regress(dT_zc , dA_zc , Y_zc , bFig) ;

%     %%
%     if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
%         obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_主成分回帰分析']);
%     else
%         obj.saveGraphWithName('_主成分回帰分析');
%     end

%%           各データの回帰直線との距離
     figure
     [vector_HP , distError , distMean] = Rhythm.PCA_regDist(dT_zc , dA_zc , Y_zc , k1, k2 ,X1, mean([dT_zc, dA_zc]) , fitParam_X1Y, bFig );

%%
     figure
        alpha = fitParam_X1Y(1);    % 傾き
        direction = [k1, k2, alpha]; 
        direct = direction / norm(direction);
        distVect_ts = vector_HP + Time_zc * direct;
        plot3([0 60000*direct(:,1)] ,[0 60000*direct(:,2)] ,[0 60000*direct(:,3)] ,'k')
     hold on
%          plot3(  vector_HP(:,1)+Time_zc * direct(1)  , vector_HP(:,2)+Time_zc * direct(2) , vector_HP(:,3)+Time_zc * direct(3)  );
     for i= 1: length(vector_HP)
         plot3( [0 vector_HP(i,1)]+Time_zc(i) * direct(1)  ,[0 vector_HP(i,2)]+Time_zc(i) * direct(2) ,[0 vector_HP(i,3)]+Time_zc(i) * direct(3) ,'k' );
     end
    grid on 
    axis square
     xlim([ 0 600]);     ylim([ 0 600]);
 %%
     figure
     plot3([-1*direction(:,1) 1*direction(:,1)] , [-1*direction(:,2) 1*direction(:,2)] , [-1*direction(:,3) 1*direction(:,3)] ,'r');
     hold on
     for i= 1: length(vector_HP)
%          plot3( [0 vector_HP(i,1)]  ,[0 vector_HP(i,2)] ,[0 vector_HP(i,3)]  );
         plot3(  vector_HP(i,1)  , vector_HP(i,2) , vector_HP(i,3)  ,'*');
     end
     hold off
     grid on
     axis square
     view(-30 ,45);
%      xlim([ 0 600]);     ylim([ 0 600]);


%%          グループ分け
    figure
    dA_border =100;
    dT_border = 50;
    k_border =2;
    indexG0 = find( dT_zc < dT_border & dA_zc < dA_border );
    indexG01 = find( dT_zc >= dT_border & (dA_zc)./dT_zc <= k_border );
    indexG02 = find( dA_zc >= dA_border & (dA_zc)./dT_zc > k_border );
%     indexG1 = sort([indexG0 ; indexG01]);
    indexG1 = sort([indexG01]);
    indexG2 = sort([indexG0 ; indexG02]);
%     dA_g1 = dA_zc(indexG1);     dT_g1 = dT_zc(indexG1);     Y_g1 = Y_zc(indexG1);
%     dA_g2 = dA_zc(indexG2);     dT_g2 = dT_zc(indexG2);     Y_g2 = Y_zc(indexG2);
        subplot(1,2,1);
    plot( dT_zc(indexG1) , dA_zc(indexG1)  , 'Marker','*', 'LineStyle','none');
    hold on
%         plot( dT_zc(indexG0) , dA_zc(indexG0) ,'Color', 'c' , 'Marker','*', 'LineStyle','none');
 %                 plot([ 0:50:300 ], [100 100 200 300 400 500 600],'m');
    hold off
    grid on
    xlabel('操作波形 周期の差　ΔT group1');    ylabel('操作波形　振幅の差　ΔA group1'); 
    xlim([0,600]);            ylim([0,600]);
    title({['データ数' num2str(length(Y_g1))]});
    
        subplot(1,2,2);
    plot(dT_zc(indexG2) , dA_zc(indexG2)  , 'Marker','*', 'LineStyle','none');
    hold on
%         plot( dT_zc(indexG0) , dA_zc(indexG0) ,'Color', 'c' , 'Marker','*', 'LineStyle','none');
%                 plot([ 50 50 100:50:300 ], [0:100:600],'c');
    hold off
    grid on
    xlabel('操作波形 周期の差　ΔT group2');    ylabel('操作波形　振幅の差　ΔA group2'); 
    xlim([0,600]);            ylim([0,600]);
    title({['データ数' num2str(length(Y_g2))]});


    %%  
% クラスター1
     figure
    [k1_g1 , k2_g1, X1_g1, fitParam_X1Y_g1, fitLineR_X1Y_g1] = Rhythm.PCA_regress(dT_zc(indexG1) , dA_zc(indexG1) , Y_zc(indexG1) , bFig) ;
%%
% 回帰直線(クラスタ１)との距離(クラスタ１のデータ)
     figure
    [vector_HP_g1a , distError_g1a , distMean_g1a] = Rhythm.PCA_regDist(dT_zc(indexG1) , dA_zc(indexG1) , Y_zc(indexG1) , k1_g1, k2_g1 , X1_g1, mean([dT_zc(indexG1) , dA_zc(indexG1)]) ,  fitParam_X1Y_g1, bFig );
%%
% 回帰直線(クラスタ１)との距離(全データ)
    figure
    [vector_HP_g1 , distError_g1 , distMean_g1] = Rhythm.PCA_regDist(dT_zc , dA_zc , Y_zc , k1_g1, k2_g1 , X1_g1, mean([dT_zc(indexG1) , dA_zc(indexG1)]) ,  fitParam_X1Y_g1, bFig );
    view(-30 , 30)
    
    
%%
% クラスター2
     figure
    [k1_g2 , k2_g2, X1_g2, fitParam_X1Y_g2, fitLineR_X1Y_g2] = Rhythm.PCA_regress(dT_zc(indexG2) , dA_zc(indexG2) , Y_zc(indexG2) , bFig) ;
%%
% 回帰直線（クラスタ２）との距離(クラスタ2のデータ)
     figure
    [vector_HP_g2a , distError_g2a , distMean_g2a] = Rhythm.PCA_regDist(dT_zc(indexG2) , dA_zc(indexG2) , Y_zc(indexG2) , k1_g2, k2_g2 ,X1_g2, mean([dT_zc(indexG2) , dA_zc(indexG2)]) , fitParam_X1Y_g2, bFig );
%%
% 回帰直線(クラスタ2)との距離(全データ)
    figure
    [vector_HP_g2 , distError_g2 , distMean_g2] = Rhythm.PCA_regDist(dT_zc , dA_zc , Y_zc , k1_g2, k2_g2 ,X1_g2, mean([dT_zc(indexG2) , dA_zc(indexG2)]) , fitParam_X1Y_g2, bFig );
    view(-30 , 30)
    
    %%
    figure
    MonitorSize = [ 0, 0, 800, 800];
    set(gcf, 'Position', MonitorSize);
    lineEdgePoint_X1Y_g1 = [ min(X1_g1)*k1_g1 , min(X1_g1)*k2_g1 , polyval( fitParam_X1Y_g1, min(X1_g1) ) ;...
                            max(X1_g1)*k1_g1 , max(X1_g1)*k2_g1 , polyval( fitParam_X1Y_g1, max(X1_g1) ) ];
    lineEdgePoint_X1Y_g2 = [ min(X1_g2)*k1_g2 , min(X1_g2)*k2_g2 , polyval( fitParam_X1Y_g2, min(X1_g2) ) ;...
                            max(X1_g2)*k1_g2 , max(X1_g2)*k2_g2 , polyval( fitParam_X1Y_g2, max(X1_g2) ) ];
    plot3( [0 0],[0 0],[0 0],'k' );
    hold on
        plot3(dT_zc, dA_zc , Y_zc ,'Color' , 'k' );
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

    hold off
    grid on
    axis square
            view(-30,25);
    xlabel('操作波形 周期の差dT');  ylabel('操作波形 振幅の差dA');  zlabel('対数演算前アバタ速さV');
    xlim([0 600]);            ylim([0 600]);          zlim([0 50000]);
    
    
    
    %% クラスタの時系列変化
    
    NumG0 = 2;
    NumG01 = 1;
    NumG02 = 2;
    figure
    subplot(3,1,1)
    indexGroup = [indexG0 NumG0*ones(length(indexG0),1); ...
                  indexG01 NumG01*ones(length(indexG01),1); ...
                  indexG02 NumG02*ones(length(indexG02),1);];
    indexGroup = sortrows(indexGroup, 1);
    group= indexGroup(:,2);
    plot( Time_zc , group , '-*');
    xlabel('時間');  ylabel('所属グループ');
    xlim([0 60000]);            ylim([0.5 2.5]);
    set(gca, 'YTick' , [ 1 1.5 2]);
 
    subplot(3,1,2)
plot( [0 0],[0 0],'k' );
hold on
%     for i = 1 : length(indexG0)
%         fill([Time_zc(indexG0(i)-2) Time_zc(indexG0(i)-2) Time_zc(indexG0(i)) Time_zc(indexG0(i))] , ...
%              [0 1000 1000 0]  ,[.8 .9 .9], 'LineStyle', 'none');
%     end
    for i = 3 : length(indexG01)
        fill([Time_zc(indexG01(i)-2) Time_zc(indexG01(i)-2) Time_zc(indexG01(i)) Time_zc(indexG01(i))] , ...
             [0 1000 1000 0]  ,[.8 .8 1], 'LineStyle', 'none');
    end
    for i = 1 : length(indexG02)
        fill([Time_zc(indexG02(i)-2) Time_zc(indexG02(i)-2) Time_zc(indexG02(i)) Time_zc(indexG02(i))] , ...
             [0 1000 1000 0]  ,[.8 1 .8], 'LineStyle', 'none');
    end
    plot(time , avtPos ,'k', 'LineWidth' , 2);
    plot(time , avtPosL ,'k' );
hold off
xlabel('時間');  ylabel('アバタ位置');
xlim([0 60000]);            ylim([0 1000]);
    
subplot(3,1,3)
plot( [0 0],[0 0],'k' );
hold on
%     for i = 1 : length(indexG0)
%         fill([Time_zc(indexG0(i)-2) Time_zc(indexG0(i)-2) Time_zc(indexG0(i)) Time_zc(indexG0(i))] , ...
%              [0 1000 1000 0]  ,[.8 .9 .9], 'LineStyle', 'none');
%     end
    for i = 3 : length(indexG01)
        fill([Time_zc(indexG01(i)-2) Time_zc(indexG01(i)-2) Time_zc(indexG01(i)) Time_zc(indexG01(i))] , ...
             [0 1000 1000 0]  ,[.8 .8 1],  'LineStyle', 'none');
    end
    for i = 1 : length(indexG02)
        fill([Time_zc(indexG02(i)-2) Time_zc(indexG02(i)-2) Time_zc(indexG02(i)) Time_zc(indexG02(i))] , ...
             [0 1000 1000 0]  ,[.8 1 .8], 'LineStyle', 'none');
    end
    plot(Time_zc , distError_g1 , 'b' );
    plot(Time_zc , distError_g2 , 'Color' , [0 .5 0]);
hold off
xlabel('時間');   ylabel('各クラスタの近似直線との距離');
xlim([0 60000]);             ylim([0 200]);
title('青：クラスタ1の近似直線との距離　緑：クラスタ２の近似直線との距離');

   
    
