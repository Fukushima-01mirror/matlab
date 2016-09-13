Time_zc = zcData(:,1);
Y_zc = zcData(:,2);
dT_zc = zcData(:,3);
dA_zc = zcData(:,4);
cluster = zcData(:,7);

time = avt_data(:,1);
avtPos = avt_data(:,4);


%             %�O��l�����O���邽�߁C�ő�f�[�^�Q���J�b�g
%             [dT_max,dT_imax] = max(dT_zc);     dT_zc(dT_imax)= [];	 dA_zc(dT_imax)= [];     Y_zc(dT_imax)= [];
%             [dT_max,dT_imax] = max(dT_zc);     dT_zc(dT_imax)= [];	 dA_zc(dT_imax)= [];     Y_zc(dT_imax)= [];
%             [dA_max,dA_imax] = max(dA_zc);     dT_zc(dA_imax)= [];	 dA_zc(dA_imax)= [];     Y_zc(dA_imax)= [];
%             [dA_max,dA_imax] = max(dA_zc);     dT_zc(dA_imax)= [];	 dA_zc(dA_imax)= [];     Y_zc(dA_imax)= [];
% %             [Y_max,Y_imax] = max(Y_zc);     dT_zc(Y_imax)= [];	 dA_zc(Y_imax)= [];     Y_zc(Y_imax)= [];
% %             [Y_max,Y_imax] = max(Y_zc);     dT_zc(Y_imax)= [];	 dA_zc(Y_imax)= [];     Y_zc(Y_imax)= [];
%             while max(Y_zc./dT_zc) > 500
%                 [Y_dT_max,Y_dT_imax] = max(Y_zc./dT_zc);     dT_zc(Y_dT_imax)= [];	 dA_zc(Y_dT_imax)= [];     Y_zc(Y_dT_imax)= [];
%                 [Y_dT_max,Y_dT_imax] = max(Y_zc./dT_zc);     dT_zc(Y_dT_imax)= [];	 dA_zc(Y_dT_imax)= [];     Y_zc(Y_dT_imax)= [];
%             end
%             while max(Y_zc./dA_zc) > 500
%                 [Y_dA_max,Y_dA_imax] = max(Y_zc./dA_zc);     dT_zc(Y_dA_imax)= [];	 dA_zc(Y_dA_imax)= [];     Y_zc(Y_dA_imax)= [];
%                 [Y_dA_max,Y_dA_imax] = max(Y_zc./dA_zc);     dT_zc(Y_dA_imax)= [];	 dA_zc(Y_dA_imax)= [];     Y_zc(Y_dA_imax)= [];
%             end
%  
            Nzc = length(Y_zc) ;

%%           �听����A����
    bFig =1 ;
    figure
    [k1 , k2, X1, fitParam_X1Y, fitLineR_X1Y] = Rhythm.PCA_regress(dT_zc , dA_zc , Y_zc , bFig) ;

%     %%
%     if ~isempty(strfind( char(obj.config.examType) , '�����ΐ�'))
%         obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_�听����A����']);
%     else
%         obj.saveGraphWithName('_�听����A����');
%     end

%%           �e�f�[�^�̉�A�����Ƃ̋���
     figure
     [vector_HP , distError , distMean] = Rhythm.PCA_regDist(dT_zc , dA_zc , Y_zc , k1, k2 ,X1, mean([dT_zc, dA_zc]) , fitParam_X1Y, bFig );

% %%
%     if ~isempty(strfind( char(obj.config.examType) , '�����ΐ�'))
%         obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_��A��������̋���']);
%     else
%         obj.saveGraphWithName('_��A��������̋���');
%     end


%%

indexG1 = find( cluster == 1);
indexG2 = find( cluster == 2);
indexG3 = find( cluster == 3);

    %%  
% �N���X�^�[1
     figure
    [k1_g1 , k2_g1, X1_g1, fitParam_X1Y_g1, fitLineR_X1Y_g1] = Rhythm.PCA_regress(dT_zc(indexG1) , dA_zc(indexG1) , Y_zc(indexG1) , bFig) ;
%%
% ��A����(�N���X�^�P)�Ƃ̋���(�N���X�^�P�̃f�[�^)
     figure
    [vector_HP_g1a , distError_g1a , distMean_g1a] = Rhythm.PCA_regDist(dT_zc(indexG1) , dA_zc(indexG1) , Y_zc(indexG1) , k1_g1, k2_g1 , X1_g1, mean([dT_zc(indexG1) , dA_zc(indexG1)]) ,  fitParam_X1Y_g1, bFig );
%%
% ��A����(�N���X�^�P)�Ƃ̋���(�S�f�[�^)
    figure
    [vector_HP_g1 , distError_g1 , distMean_g1] = Rhythm.PCA_regDist(dT_zc , dA_zc , Y_zc , k1_g1, k2_g1 , X1_g1, mean([dT_zc(indexG1) , dA_zc(indexG1)]) ,  fitParam_X1Y_g1, bFig );
    view(-30 , 30)
    
    
%%
% �N���X�^�[2
     figure
    [k1_g2 , k2_g2, X1_g2, fitParam_X1Y_g2, fitLineR_X1Y_g2] = Rhythm.PCA_regress(dT_zc(indexG2) , dA_zc(indexG2) , Y_zc(indexG2) , bFig) ;
%%
% ��A�����i�N���X�^�Q�j�Ƃ̋���(�N���X�^2�̃f�[�^)
     figure
    [vector_HP_g2a , distError_g2a , distMean_g2a] = Rhythm.PCA_regDist(dT_zc(indexG2) , dA_zc(indexG2) , Y_zc(indexG2) , k1_g2, k2_g2 ,X1_g2, mean([dT_zc(indexG2) , dA_zc(indexG2)]) , fitParam_X1Y_g2, bFig );
%%
% ��A����(�N���X�^2)�Ƃ̋���(�S�f�[�^)
    figure
    [vector_HP_g2 , distError_g2 , distMean_g2] = Rhythm.PCA_regDist(dT_zc , dA_zc , Y_zc , k1_g2, k2_g2 ,X1_g2, mean([dT_zc(indexG2) , dA_zc(indexG2)]) , fitParam_X1Y_g2, bFig );
    view(-30 , 30)
    
    %%
    figure
    MonitorSize = [ 0, 0, 800, 800];
    set(gcf, 'Position', MonitorSize);
    plot3(dT_zc(indexG3) , dA_zc(indexG3) , Y_zc(indexG3) ,'Color' , 'r' ,'Marker','*', 'LineStyle','none');
    lineEdgePoint_X1Y_g1 = [ min(X1_g1)*k1_g1 , min(X1_g1)*k2_g1 , polyval( fitParam_X1Y_g1, min(X1_g1) ) ;...
                            max(X1_g1)*k1_g1 , max(X1_g1)*k2_g1 , polyval( fitParam_X1Y_g1, max(X1_g1) ) ];
    lineEdgePoint_X1Y_g2 = [ min(X1_g2)*k1_g2 , min(X1_g2)*k2_g2 , polyval( fitParam_X1Y_g2, min(X1_g2) ) ;...
                            max(X1_g2)*k1_g2 , max(X1_g2)*k2_g2 , polyval( fitParam_X1Y_g2, max(X1_g2) ) ];
    hold on
        plot3(dT_zc(indexG1) , dA_zc(indexG1) , Y_zc(indexG1) ,'Color' , 'b' ,'Marker','*', 'LineStyle','none');
        plot3(dT_zc(indexG2) , dA_zc(indexG2) , Y_zc(indexG2) ,'Color' , 'g' ,'Marker','*', 'LineStyle','none');

        plot3(  [ -100*k1_g1 ; 500*k1_g1 ] + mean(dT_zc(indexG1)) , [ -100*k2_g1 ; 500*k2_g1 ] + mean(dA_zc(indexG1)) , zeros(2,1) , 'r');
        plot3( lineEdgePoint_X1Y_g1(:,1) + mean(dT_zc(indexG1)) , lineEdgePoint_X1Y_g1(:,2) + mean(dA_zc(indexG1)), lineEdgePoint_X1Y_g1(:,3) ,'r' ,'LineWidth',3 );
        plot3( [ lineEdgePoint_X1Y_g1(2,1) + mean(dT_zc(indexG1)) ,lineEdgePoint_X1Y_g1(2,1)+ mean(dT_zc(indexG1)) ] ,...
               [ lineEdgePoint_X1Y_g1(2,2)+ mean(dA_zc(indexG1)) , lineEdgePoint_X1Y_g1(2,2)+ mean(dA_zc(indexG1)) ] ,...
               [0 lineEdgePoint_X1Y_g1(2,3)] ,'--r' );              % ����

        plot3(  [ -100*k1_g2 ; 500*k1_g2 ] + mean(dT_zc(indexG2)) , [ -100*k2_g2 ; 500*k2_g2 ] + mean(dA_zc(indexG2)) , zeros(2,1) , 'r');
        plot3( lineEdgePoint_X1Y_g2(:,1) + mean(dT_zc(indexG2)) , lineEdgePoint_X1Y_g2(:,2) + mean(dA_zc(indexG2)), lineEdgePoint_X1Y_g2(:,3) ,'r' ,'LineWidth',3 );
        plot3( [ lineEdgePoint_X1Y_g2(2,1) + mean(dT_zc(indexG2)) , lineEdgePoint_X1Y_g2(2,1) + mean(dT_zc(indexG2)) ] ,...
               [ lineEdgePoint_X1Y_g2(2,2) + mean(dA_zc(indexG2))  lineEdgePoint_X1Y_g2(2,2) + mean(dA_zc(indexG2))  ] ,...
               [0 lineEdgePoint_X1Y_g2(2,3)] ,'--r' );              % ����

    hold off
    grid on
    axis square
            view(-30,25);
    xlabel('����g�` �����̍�dT');  ylabel('����g�` �U���̍�dA');  zlabel('�ΐ����Z�O�A�o�^����V');
    xlim([0 600]);            ylim([0 600]);          zlim([0 50000]);
    
    
    
    %% �N���X�^�̎��n��ω�
figure
subplot(2,1,1)
plot( [0 0],[0 0],'k' );
hold on
    for i = 1 : length(indexG2)
        fill([Time_zc(indexG2(i)-2) Time_zc(indexG2(i)-2) Time_zc(indexG2(i)) Time_zc(indexG2(i))] , ...
             [0 1000 1000 0]  ,[0.8 1 .8], 'LineStyle', 'none');
    end
    for i = 1 : length(indexG3)
        fill([Time_zc(indexG3(i)-2) Time_zc(indexG3(i)-2) Time_zc(indexG3(i)) Time_zc(indexG3(i))] , ...
             [0 1000 1000 0]  ,[1 .8 .8], 'LineStyle', 'none');
    end
    plot(time , avtPos );
hold off
xlabel('����');  ylabel('�A�o�^�ʒu');
xlim([0 60000]);            ylim([0 1000]);
    
subplot(2,1,2)
plot( [0 0],[0 0],'k' );
hold on
    for i = 1 : length(indexG2)
        fill([Time_zc(indexG2(i)-2) Time_zc(indexG2(i)-2) Time_zc(indexG2(i)) Time_zc(indexG2(i))] , ...
             [0 1000 1000 0]  ,[0.8 1 .8], 'LineStyle', 'none');
    end
    for i = 1 : length(indexG3)
        fill([Time_zc(indexG3(i)-2) Time_zc(indexG3(i)-2) Time_zc(indexG3(i)) Time_zc(indexG3(i))] , ...
             [0 1000 1000 0]  ,[1 .8 .8], 'LineStyle', 'none');
    end
    plot(Time_zc , distError_g1 , 'b' );
    plot(Time_zc , distError_g2 , 'Color' , [0 .5 0]);
hold off
xlabel('����');   ylabel('�e�N���X�^�̋ߎ������Ƃ̋���');
xlim([0 60000]);             ylim([0 200]);
title('�F�N���X�^1�̋ߎ������Ƃ̋����@�΁F�N���X�^�Q�̋ߎ������Ƃ̋���');

    
    
