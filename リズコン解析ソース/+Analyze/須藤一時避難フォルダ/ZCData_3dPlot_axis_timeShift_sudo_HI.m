classdef ZCData_3dPlot_axis_timeShift_sudo_HI < Analyze.Base
    %STANDARDDEVIATION ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q

    properties
    end

    methods
        function obj = ZCData_3dPlot_axis_timeShift_sudo_HI(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
            
        end

        function runForPair(obj,user1 ,user2)

           Time_LowSampled = (20 : 20 : 60000);
           [period_zx, peak_zx] = Rhythm.setZeroCrossPeriodData(user1.zeroCrossData);
           [period_zx2, peak_zx2] = Rhythm.setZeroCrossPeriodData(user2.zeroCrossData);           
%            disp(peak_zx(2,1));
          
           %�@�[���N���X�Ԃł̃s�[�N�񐔎擾
           [zeroCrossTimes] = Rhythm.setZeroCrossCount(user1.zeroCrossData);
           [zeroCrossTimes2] = Rhythm.setZeroCrossCount(user2.zeroCrossData);

           filterdPul = Rhythm.BPfilter( user1.operatePulse.lowSampled);
           filterdPul2 = Rhythm.BPfilter( user2.operatePulse.lowSampled);
           [timeCorr, AB_Series0, AB_Series_Max] = Rhythm.AllCorr__func(filterdPul, filterdPul2, user2.time.lowSampled, 100);
%            [timeCorr, AB_Series0, AB_Series_Max] = Rhythm.AllCorr__func(user1.operatePulse.lowSampled,user2.operatePulse.lowSampled, user2.time.lowSampled, 100);
%            disp(length(filterdPul));
%            disp(AB_Series_Max);           
%            disp(length(AB_Series_Max(:,2)));
%            disp(zeroCrossTimes);

            Y = abs( user1.zeroCrossData.nonlogAvtVelocity );
            dT = abs( period_zx(:,3) );
            dA = abs( peak_zx(:,3) );
            Time = abs( user1.zeroCrossData.zeroCrossTime );
            Y2 = abs( user2.zeroCrossData.nonlogAvtVelocity );
            dT2 = abs( period_zx2(:,3) );
            dA2 = abs( peak_zx2(:,3) );
            Time2 = abs( user2.zeroCrossData.zeroCrossTime );
            
            V_max = 50000;
            dT_max = 500;
            dA_max = 500;
            
                IndexZeroCross = find(zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2);
                IndexNonZeroCross = find( zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1);
                IndexZeroCross2 = find(zeroCrossTimes2(:,1)<2&zeroCrossTimes2(:,2)<2);
                IndexNonZeroCross2 = find( zeroCrossTimes2(:,1)>1|zeroCrossTimes2(:,2)>1);

            Y_zc  = Y(IndexZeroCross);          Y_nzc  = Y(IndexNonZeroCross);
            dT_zc = dT(IndexZeroCross);         dT_nzc = dT(IndexNonZeroCross);
            dA_zc = dA(IndexZeroCross);         dA_nzc = dA(IndexNonZeroCross);
            Time_zc = Time(IndexZeroCross);     Time_nzc  = Time(IndexNonZeroCross);
            Y_zc2  = Y2(IndexZeroCross2);       Y_nzc2  = Y2(IndexNonZeroCross2);
            dT_zc2 = dT2(IndexZeroCross2);      dT_nzc2 = dT2(IndexNonZeroCross2);
            dA_zc2 = dA2(IndexZeroCross2);      dA_nzc2 = dA2(IndexNonZeroCross2);
            Time_zc2 = Time2(IndexZeroCross2);  Time_nzc2  = Time2(IndexNonZeroCross2);
            
            
            dA_border =100;
            dT_border = 50;
            k_border =2;
            indexG0 = find( dT_zc < dT_border & dA_zc < dA_border );
            indexG01 = find( dT_zc >= dT_border & (dA_zc)./dT_zc <= k_border );
            indexG02 = find( dA_zc >= dA_border & (dA_zc)./dT_zc > k_border );
            indexG1 = sort([indexG0 ; indexG01]);
            indexG2 = sort([indexG0 ; indexG02]);
            indexG0_2 = find( dT_zc2 < dT_border & dA_zc2 < dA_border );
            indexG01_2 = find( dT_zc2 >= dT_border & (dA_zc2)./dT_zc2 <= k_border );
            indexG02_2 = find( dA_zc2 >= dA_border & (dA_zc2)./dT_zc2 > k_border );
            indexG1_2 = sort([indexG0_2 ; indexG01_2]);
            indexG2_2 = sort([indexG0_2 ; indexG02_2]);
            
            Nzc = length(Y_zc) ;            Nnzc = length(Y_nzc) ;
            Nzc2 = length(Y_zc2) ;          Nnzc2 = length(Y_nzc2) ;                       
            %�@���ԃX�P�[���̐ݒ�            
            spotTime = 15000;    
            startTime =  500 * floor( user1.time.highSampled(1) /500);
            spotTimeMax = 15000;
            Num = 1;

%             for spotTimeMax =  500 * floor( (spotTime+startTime) /500) : 500: 500 * ceil(user1.time.highSampled(end) /500);

                startIndex = find( user1.zeroCrossData.zeroCrossTime(IndexZeroCross) >= ( spotTimeMax - spotTime +1 ) ,1 ,'first');
                endIndex = find( user1.zeroCrossData.zeroCrossTime(IndexZeroCross) < spotTimeMax ,1 ,'last');  
                startIndex2 = find( user2.zeroCrossData.zeroCrossTime(IndexZeroCross2) >= ( spotTimeMax - spotTime +1 ) ,1 ,'first');
                endIndex2 = find( user2.zeroCrossData.zeroCrossTime(IndexZeroCross2) < spotTimeMax ,1 ,'last');  
                
                if length(Y_zc(startIndex:endIndex))>2

%                     MonitorSize = [ 0, 0, 1600, 800];
%                     set(gcf, 'Position', MonitorSize);
                    figure(1);
                    
                    
                    %% �A�o�^�ʒu�@���ݑ���
                    set(gcf, 'Position', [ 0, 0, 500, 400]);                    
                    
                    [corr, lags] = xcorr(user1.avatarPosition.highSampled , user2.avatarPosition.highSampled , 5000 , 'coeff');

                    [maxcorr,indexlag] = max(corr);
                    
                    
                    
                    lags_integ = 0;
                    for n = 30:(length(user1.avatarPosition.highSampled)/200)
                        [corr_split, lags_split] = xcorr(user1.avatarPosition.highSampled((n-5)*200+1 : n*200, 1) , user2.avatarPosition.highSampled((n-5)*200+1 : n*200, 1) , 2000 , 'coeff');
                        [maxcorr_split,indexlag_split] = max(corr_split);
                        disp([maxcorr_split , lags_split(indexlag_split)]);
                        lags_integ = lags_integ + abs(lags_split(indexlag_split));
                        hold on
                        plot(user1.time.highSampled((n-5)*200+1 : n*200, 1), user1.avatarPosition.highSampled((n-5)*200+1 : n*200, 1));
                        plot(user2.time.highSampled((n-5)*200+1 : n*200, 1), user2.avatarPosition.highSampled((n-5)*200+1 : n*200, 1));
                        hold off
                        pause on
                        pause(1)
                        clf
                    end
                    disp(n)
                    plot(lags,corr);
                    title( ['maxlag= ' num2str(lags(indexlag)) ' [ms] , maxcorr= ' num2str(maxcorr) ' , mean lag= ' num2str(lags_integ/(n-29)) ' [ms]'] );
                     obj.saveGraphWithNameToFolder( 'xcorr' );
                     
                     
                     
                     %% �R���g���[������@���ݑ���
                    set(gcf, 'Position', [ 0, 0, 500, 400]);                    
                    
                    [corr, lags] = xcorr(filterdPul , filterdPul2 , 50 , 'coeff');

                    [maxcorr,indexlag] = max(corr);
                    
                    plot(lags,corr);
                    
                    title( ['maxlag= ' num2str(lags(indexlag)) ' [ms] , maxcorr= ' num2str(maxcorr)] );
%                     disp(length(soukan));
%                     disp(length(lags));
                    
                    
%                     pause;
%                     pause on;
                     obj.saveGraphWithNameToFolder( 'pulsecorr' );
                    
                     %% �A�o�^���x�@���ݑ���
                    set(gcf, 'Position', [ 0, 0, 500, 400]);                    
                    
                    nonlogvel = zeros(60000,2);
                    nonlogvel(1 : user1.zeroCrossData.zeroCrossTime(1,1), 1) = user1.zeroCrossData.nonlogAvtVelocity(1,1);
                    nonlogvel(1 : user2.zeroCrossData.zeroCrossTime(1,1), 2) = user2.zeroCrossData.nonlogAvtVelocity(1,1);
                    
                    for n = 1:(length(user1.zeroCrossData.zeroCrossTime)-1)
                        nonlogvel(user1.zeroCrossData.zeroCrossTime(n,1) : user1.zeroCrossData.zeroCrossTime(n+1,1), 1) = user1.zeroCrossData.nonlogAvtVelocity(n,1);
                    end
                    nonlogvel(user1.zeroCrossData.zeroCrossTime(end,1) : 60000, 1) = user1.zeroCrossData.nonlogAvtVelocity(end,1);

                    for n = 1:(length(user2.zeroCrossData.zeroCrossTime)-1)
                        nonlogvel(user2.zeroCrossData.zeroCrossTime(n,1) : user2.zeroCrossData.zeroCrossTime(n+1,1), 2) = user2.zeroCrossData.nonlogAvtVelocity(n,1);
                    end
                    nonlogvel(user2.zeroCrossData.zeroCrossTime(end,1) : 60000, 2) = user2.zeroCrossData.nonlogAvtVelocity(end,1);
                    
                    [corr, lags] = xcorr(nonlogvel(:,1), (zeros(60000,1) - nonlogvel(:,2)) ,1000 , 'coeff');

                    [maxcorr,indexlag] = max(corr);
                    
                    plot(lags,corr);
                    
                    title( ['maxlag= ' num2str(lags(indexlag)) ' [ms] , maxcorr= ' num2str(maxcorr)] );
%                     disp(length(soukan));
%                     disp(length(lags));
                    
                    
%                     pause;
%                     pause on;
                     obj.saveGraphWithNameToFolder( 'velocitycorr' );
                    %% �RD�U�z�}1P�i�����ŃO���[�v�����j
                    set(gcf, 'Position', [ 0, 0, 500, 500]);
                    
%                     subplot(4,10,[6:10,16:20]);
                    
                    bFig =0;
            % �N���X�^�[1
                [k1_g1 , k2_g1, X1_g1, fitParam_X1Y_g1, fitLineR_X1Y_g1] = Rhythm.PCA_regress_3dplot(dT_zc(indexG1) , dA_zc(indexG1) , Y_zc(indexG1) , bFig) ;
            % �N���X�^�[2
                [k1_g2 , k2_g2, X1_g2, fitParam_X1Y_g2, fitLineR_X1Y_g2] = Rhythm.PCA_regress_3dplot(dT_zc(indexG2) , dA_zc(indexG2) , Y_zc(indexG2) , bFig) ;
                
            % ��A����(�N���X�^�P)�Ƃ̋���(�S�f�[�^)     
                [vector_HP_g1 , distError_g1 , distMean_g1] = Rhythm.PCA_regDist(dT_zc , dA_zc , Y_zc , k1_g1, k2_g1 , X1_g1, mean([dT_zc(indexG1) , dA_zc(indexG1)]) ,  fitParam_X1Y_g1, bFig );
            % ��A����(�N���X�^2)�Ƃ̋���(�S�f�[�^)    
                [vector_HP_g2 , distError_g2 , distMean_g2] = Rhythm.PCA_regDist(dT_zc , dA_zc , Y_zc , k1_g2, k2_g2 ,X1_g2, mean([dT_zc(indexG2) , dA_zc(indexG2)]) , fitParam_X1Y_g2, bFig );                
                
                d_threshold = 12;
                for i = 1:Nzc
                    if distError_g1(i) - distError_g2(i) < 0
                        group_d(i,1) = 1;
                    elseif distError_g2(i) - distError_g1(i) < 0
                        group_d(i,1) = 2;
                    end
                    if abs( distError_g1(i) - distError_g2(i) ) < d_threshold && i > 1
                        group_d(i,1) = group_d(i-1,1);
                    end
                end
                
                group_d_spot = 0;
                for i = startIndex:endIndex
                    if distError_g1(i) - distError_g2(i) < 0
                        group_d_spot(i , 1) = 1;
                    elseif distError_g2(i) - distError_g1(i) < 0
                        group_d_spot(i , 1) = 2;
                    end
                    if abs( distError_g1(i) - distError_g2(i) ) < d_threshold && i > 1
                        group_d_spot(i , 1) = group_d_spot(i , 1);
                    end
                end

                indexGd1 = find( group_d == 1 );
                indexGd2 = find( group_d == 2 );
                indexGd1_spot = find( group_d_spot == 1 );
                indexGd2_spot = find( group_d_spot == 2 );
                
                lineEdgePoint_X1Y_g1 = [ min(X1_g1)*k1_g1 , min(X1_g1)*k2_g1 , polyval( fitParam_X1Y_g1, min(X1_g1) ) ;...
                                        max(X1_g1)*k1_g1 , max(X1_g1)*k2_g1 , polyval( fitParam_X1Y_g1, max(X1_g1) ) ];
                lineEdgePoint_X1Y_g2 = [ min(X1_g2)*k1_g2 , min(X1_g2)*k2_g2 , polyval( fitParam_X1Y_g2, min(X1_g2) ) ;...
                                        max(X1_g2)*k1_g2 , max(X1_g2)*k2_g2 , polyval( fitParam_X1Y_g2, max(X1_g2) ) ];
                plot3( [0 0],[0 0],[0 0],'k' );
                hold on
                    plot3(dT_nzc, dA_nzc , Y_nzc ,'Marker','.','MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none' );
%                     plot3(dT_zc , dA_zc , Y_zc ,'Marker','o','MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none','MarkerSize',5);
                    
                    plot3(dT_zc(indexGd1) , dA_zc(indexGd1) , Y_zc(indexGd1) ,'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'Marker','o', 'LineStyle','none','MarkerSize',5);
                    plot3(dT_zc(indexGd2) , dA_zc(indexGd2) , Y_zc(indexGd2) ,'MarkerEdgeColor' , [0 .5 0] ,'MarkerFaceColor',[0 .5 0], 'Marker','o', 'LineStyle','none','MarkerSize',5);

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
  
                x = [ -100*k1_g1 ; 500*k1_g1 ] + mean(dT_zc(indexG1));
                y = [ -100*k2_g1 ; 500*k2_g1 ] + mean(dA_zc(indexG1));
                dx = x(2,1)-x(1,1);
                dy = y(2,1)-y(1,1);
                x2 = [ -100*k1_g2 ; 500*k1_g2 ] + mean(dT_zc(indexG2));
                y2 = [ -100*k2_g2 ; 500*k2_g2 ] + mean(dA_zc(indexG2));
                dx2 = x2(2,1)-x2(1,1);
                dy2 = y2(2,1)-y2(1,1);
                
                title({ ['player1 ��1 = ' num2str(atan(dy/dx)*360/2/pi) ' , ��1 = ' num2str(atan(fitParam_X1Y_g1(1))*360/2/pi) ', �X��1�F' num2str( fitParam_X1Y_g1(1) )];...
                    ['�ؕ�1�F' num2str(fitParam_X1Y_g1(2)) '�C���֌W��R1�F' num2str( fitLineR_X1Y_g1(1)) '�C����W��R^2_1�F' num2str( fitLineR_X1Y_g1(1)^2)];...
                    ['��2 = ' num2str(atan(dy2/dx2)*360/2/pi) ' , ��2 = ' num2str(atan(fitParam_X1Y_g2(2))*360/2/pi) ', �X��2�F' num2str( fitParam_X1Y_g2(1) )];...
                    ['�ؕ�2�F' num2str(fitParam_X1Y_g2(2)) '�C���֌W��R1�F' num2str( fitLineR_X1Y_g2(1)) '�C����W��R^2_1�F' num2str( fitLineR_X1Y_g2(1)^2)]});
%                 title({ ['X�F(' num2str(coeff(1,1)) ', '  num2str(coeff(2,1)) ')�@\theta =(' num2str( atan(k2/k1) *180 / pi ) ')[deg] ��=(' num2str(alpha) ')[deg]'] ;...
%                 ['X-V�̌X���F' num2str( alpha ) ', �ؕЁF' num2str(beta) '�C���֌W��R�F' num2str( fitLineR_X1Y(1)) '�C����W��R^2�F' num2str( fitLineR_X1Y(1)^2)];...
%                 [ '��A��������̋����̓�敽�ϕ������F' num2str( distMean ) ]});
                axis square
                
%                  obj.saveGraphWithNameToFolder( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_'  num2str(Num) '_1P']);
                obj.saveGraphWithNameToFolder('sub')
                 
                %% �RD�U�z�}2P�i�����ŃO���[�v�����j
%                  set(gcf, 'Position', [ 0, 0, 500, 500]);
%                     subplot(4,10,[26:30,36:40]);
                    
                    bFig =0;
             % �N���X�^�[1
                [k1_g1_2 , k2_g1_2, X1_g1_2, fitParam_X1Y_g1_2, fitLineR_X1Y_g1_2] = Rhythm.PCA_regress_3dplot(dT_zc2 , dA_zc2 , Y_zc2 , bFig) ;
%             % �N���X�^�[1
%                 [k1_g1_2 , k2_g1_2, X1_g1_2, fitParam_X1Y_g1_2, fitLineR_X1Y_g1_2] = Rhythm.PCA_regress_3dplot(dT_zc2(indexG1_2) , dA_zc2(indexG1_2) , Y_zc2(indexG1_2) , bFig) ;
%             % �N���X�^�[2
                [k1_g2_2 , k2_g2_2, X1_g2_2, fitParam_X1Y_g2_2, fitLineR_X1Y_g2_2] = Rhythm.PCA_regress_3dplot(dT_zc2(indexG2_2) , dA_zc2(indexG2_2) , Y_zc2(indexG2_2) , bFig) ;
                
            % ��A����(�N���X�^�P)�Ƃ̋���(�S�f�[�^)     
                [vector_HP_g1_2 , distError_g1_2 , distMean_g1_2] = Rhythm.PCA_regDist(dT_zc2 , dA_zc2 , Y_zc2 , k1_g1_2, k2_g1_2 , X1_g1_2, mean([dT_zc2(indexG1_2) , dA_zc2(indexG1_2)]) ,  fitParam_X1Y_g1_2, bFig );
            % ��A����(�N���X�^2)�Ƃ̋���(�S�f�[�^)    
                [vector_HP_g2_2 , distError_g2_2 , distMean_g2_2] = Rhythm.PCA_regDist(dT_zc2 , dA_zc2 , Y_zc2 , k1_g2_2, k2_g2_2 , X1_g2_2, mean([dT_zc2(indexG2_2) , dA_zc2(indexG2_2)]) ,  fitParam_X1Y_g2_2, bFig );                
                
                d_threshold = 12;
                for i = 1:Nzc2
                    if distError_g1_2(i) - distError_g2_2(i) < 0
                        group_d_2(i,1) = 1;
                    elseif distError_g2_2(i) - distError_g1_2(i) < 0
                        group_d_2(i,1) = 2;
                    end
                    if abs( distError_g1_2(i) - distError_g2_2(i) ) < d_threshold && i > 1
                        group_d_2(i,1) = group_d_2(i-1,1);
                    end
                end
                
                group_d_spot_2 = 0;
                for i = startIndex2:endIndex2
                    if distError_g1_2(i) - distError_g2_2(i) < 0
                        group_d_spot_2(i , 1) = 1;
                    elseif distError_g2_2(i) - distError_g1_2(i) < 0
                        group_d_spot_2(i , 1) = 2;
                    end
                    if abs( distError_g1_2(i) - distError_g2_2(i) ) < d_threshold && i > 1
                        group_d_spot_2(i , 1) = group_d_spot_2(i , 1);
                    end
                end
                
%                 indexGd1_2 = find( group_d_2 == 1 );
%                 indexGd2_2 = find( group_d_2 == 2 );
%                 lengthGd2_2=length(indexGd2_2);
                indexGd1_spot_2 = find( group_d_spot_2 == 1 );
                indexGd2_spot_2 = find( group_d_spot_2 == 2 );
                
%                 disp(indexGd1_2);
                
                lineEdgePoint_X1Y_g1_2 = [ min(X1_g1_2)*k1_g1_2 , min(X1_g1_2)*k2_g1_2 , polyval( fitParam_X1Y_g1_2, min(X1_g1_2) ) ;...
                                        max(X1_g1_2)*k1_g1_2 , max(X1_g1_2)*k2_g1_2 , polyval( fitParam_X1Y_g1_2, max(X1_g1_2) ) ];
                lineEdgePoint_X1Y_g2_2 = [ min(X1_g2_2)*k1_g2_2 , min(X1_g2_2)*k2_g2_2 , polyval( fitParam_X1Y_g2_2, min(X1_g2_2) ) ;...
                                        max(X1_g2_2)*k1_g2_2 , max(X1_g2_2)*k2_g2_2 , polyval( fitParam_X1Y_g2_2, max(X1_g2_2) ) ];
                plot3( [0 0],[0 0],[0 0],'k' );
                hold on
                                
                    plot3(dT_nzc2, dA_nzc2 , Y_nzc2 ,'Marker','.','MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none' );
                    plot3(dT_zc2(1:length(dT_zc2)/2) , dA_zc2(1:length(dT_zc2)/2) , Y_zc2(1:length(dT_zc2)/2) ,'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'Marker','o', 'LineStyle','none','MarkerSize',5);
%                     plot3(dT_zc2(1:length(dT_zc2)/2) , dA_zc2(1:length(dT_zc2)/2) , Y_zc2(1:length(dT_zc2)/2) ,'Marker','o','MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none','MarkerSize',5);
                    
%                     plot3(dT_zc2(indexGd1_spot_2) , dA_zc2(indexGd1_spot_2) , Y_zc2(indexGd1_spot_2) ,'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'Marker','o', 'LineStyle','none','MarkerSize',5);
%                     plot3(dT_zc2(indexGd2_spot_2) , dA_zc2(indexGd2_spot_2) , Y_zc2(indexGd2_spot_2) ,'MarkerEdgeColor' , 'b','MarkerFaceColor','b', 'Marker','o', 'LineStyle','none','MarkerSize',5);

%                     plot3(  [ -100*k1_g1_2 ; 500*k1_g1_2 ] + mean(dT_zc2(indexG1_2)) , [ -100*k2_g1_2 ; 500*k2_g1_2 ] + mean(dA_zc2(indexG1_2)) , zeros(2,1) , 'r');
%                     plot3( lineEdgePoint_X1Y_g1_2(:,1) + mean(dT_zc2(indexG1_2)) , lineEdgePoint_X1Y_g1_2(:,2) + mean(dA_zc2(indexG1_2)), lineEdgePoint_X1Y_g1(:,3) ,'r' ,'LineWidth',3 );
%                     plot3( [ lineEdgePoint_X1Y_g1_2(2,1) + mean(dT_zc2(indexG1_2)) ,lineEdgePoint_X1Y_g1_2(2,1)+ mean(dT_zc2(indexG1_2)) ] ,...
%                            [ lineEdgePoint_X1Y_g1_2(2,2)+ mean(dA_zc2(indexG1_2)) , lineEdgePoint_X1Y_g1_2(2,2)+ mean(dA_zc2(indexG1_2)) ] ,...
%                            [0 lineEdgePoint_X1Y_g1_2(2,3)] ,'--r' );              % ����
% 
%                     plot3(  [ -100*k1_g2_2 ; 500*k1_g2_2 ] + mean(dT_zc2(indexG2_2)) , [ -100*k2_g2_2 ; 500*k2_g2_2 ] + mean(dA_zc2(indexG2_2)) , zeros(2,1) , 'r');
%                     plot3( lineEdgePoint_X1Y_g2_2(:,1) + mean(dT_zc2(indexG2_2)) , lineEdgePoint_X1Y_g2_2(:,2) + mean(dA_zc2(indexG2_2)), lineEdgePoint_X1Y_g2_2(:,3) ,'r' ,'LineWidth',3 );
%                     plot3( [ lineEdgePoint_X1Y_g2_2(2,1) + mean(dT_zc2(indexG2_2)) , lineEdgePoint_X1Y_g2_2(2,1) + mean(dT_zc2(indexG2_2)) ] ,...
%                            [ lineEdgePoint_X1Y_g2_2(2,2) + mean(dA_zc2(indexG2_2))  lineEdgePoint_X1Y_g2_2(2,2) + mean(dA_zc2(indexG2_2))  ] ,...
%                            [0 lineEdgePoint_X1Y_g2_2(2,3)] ,'--r' );              % ����
                       
                    plot3(  [ -100*k1_g1_2 ; 500*k1_g1_2 ] + mean(dT_zc2) , [ -100*k2_g1_2 ; 500*k2_g1_2 ] + mean(dA_zc2) , zeros(2,1) , 'r');
                    plot3( lineEdgePoint_X1Y_g1_2(:,1) + mean(dT_zc2) , lineEdgePoint_X1Y_g1_2(:,2) + mean(dA_zc2), lineEdgePoint_X1Y_g1_2(:,3) ,'r' ,'LineWidth',3 );
                    plot3( [ lineEdgePoint_X1Y_g1_2(2,1) + mean(dT_zc2) ,lineEdgePoint_X1Y_g1_2(2,1)+ mean(dT_zc2) ] ,...
                           [ lineEdgePoint_X1Y_g1_2(2,2)+ mean(dA_zc2) , lineEdgePoint_X1Y_g1_2(2,2)+ mean(dA_zc2) ] ,...
                           [0 lineEdgePoint_X1Y_g1_2(2,3)] ,'--r' );              % ����

                hold off
                grid on
                axis square
                        view(60,25);
                xlabel('����g�` �����̍�dT');  ylabel('����g�` �U���̍�dA');  zlabel('�ΐ����Z�O�A�o�^����V');
                xlim([0 600]);            ylim([0 600]);          zlim([0 50000]);

                x_2 = [ -100*k1_g1_2 ; 500*k1_g1_2 ] + mean(dT_zc2(indexG1_2));
                y_2 = [ -100*k2_g1_2 ; 500*k2_g1_2 ] + mean(dA_zc2(indexG1_2));
                dx_2 = x_2(2,1)-x_2(1,1);
                dy_2 = y_2(2,1)-y_2(1,1);
                x2_2 = [ -100*k1_g2_2 ; 500*k1_g2_2 ] + mean(dT_zc2(indexG2_2));
                y2_2 = [ -100*k2_g2 ; 500*k2_g2 ] + mean(dA_zc2(indexG2_2));
                dx2_2 = x2_2(2,1)-x2_2(1,1);
                dy2_2 = y2_2(2,1)-y2_2(1,1);
                
                title({ ['player2 �� = ' num2str(atan(dy_2/dx_2)*360/2/pi) ' , �� = ' num2str(atan(fitParam_X1Y_g1_2(1))*360/2/pi) ', �X���F' num2str( fitParam_X1Y_g1_2(1) )];...
                    ['�ؕЁF' num2str(fitParam_X1Y_g1_2(2)) '�C���֌W��R�F' num2str( fitLineR_X1Y_g1_2(1)) '�C����W��R^2�F' num2str( fitLineR_X1Y_g1_2(1)^2)]});

                axis square
                
                obj.saveGraphWithNameToFolder( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_'  num2str(Num) '_2P']);
                
 
               %% �R���g���[������Ƒ���
                    
                set(gcf, 'position', [ 0, 0, 1200, 950]);
                    
                for i = 1:6    
                    
                    subplot(6,1,i);
                    hold on
                        plot([0 60000],[0 0],'k');
                        [haxes,hline1,hline2] = plotyy(user1.time.highSampled, user1.operatePulse.highSampled,  timeCorr, AB_Series_Max(:,2));

                        set(hline1,'Color','b');
                        set(hline2,'Color','r');
                        set(haxes(1),'YColor','k');
                        set(haxes(2),'YColor','r');
                        
                    hold off

                    hold( haxes(1),'on') % �d�ˏ������[�h�I��
                    
                        a = plot(   haxes(1), user2.time.highSampled,  user2.operatePulse.highSampled ,'g');

                    hold( haxes(2),'on') % �d�ˏ������[�h�I��
                    
                        plot( haxes(2),[0 60000], [0.8 0.8],'k:');
                        
                    hold off
                    
                    if ~isempty(  findstr( char( obj.config.examType ) , '����'))
                        title( [ '�R���g���[������g�`�@�ő告�ݑ���  ( ' char( obj.data.splitTimeInfo.state ) ' �j']);
                    end
                    
                    axes(haxes(1))
                    xlabel('����t ms'); ylabel('�R���g���[������');
                    xlim([(i-1)*10000 i*10000]);    ylim([-400 400]);
                    set(gca,'YTick',[-400:200:400]);

                    axes(haxes(2))
                    if i==1
                        legend([hline1,a,hline2],'1P','2P', '�ő告�ݑ���','Location', 'NorthWest');
                        xlabel('����t ms'); ylabel('�ő告�ݑ���');
                    end
                    xlim([(i-1)*10000 i*10000]);    ylim([0 1]);
                    set(gca,'YTick',[0:0.2:1]);
                    
                end

            %% ����������i��T�j,����U�����i��A�j
%                 subplot(3,10,[21:25]);
%                 hold on
%                     for(i = 1:n_group)
%                        area([time_s(i) time_e(i)],[1000 1000],'FaceColor',[.7 1 1],'EdgeColor','none');
%                     end
%                     for(i = 1:n_group_2)
%                        area([time_s_2(i) time_e_2(i)],[1000 1000],'FaceColor',[1 1 .7],'EdgeColor',[1 1 .7]);
%                     end
%                     for(i = 1:n_group_lap)
%                         area([time_s_lap(i) time_e_lap(i)],[1000 1000],'FaceColor',[1 .9 1],'EdgeColor',[1 .9 1]);
%                     end
%                     a = plot( user1.zeroCrossData.zeroCrossTime , abs(period_zx(:,3)) , 'b'); 
%                     plot([spotTimeMax-spotTime+1 spotTimeMax-spotTime+1],[0 1000],'--k');
%                     plot([spotTimeMax spotTimeMax],[0 1000],'--k');
%                     b = plot( user2.zeroCrossData.zeroCrossTime , abs(period_zx2(:,3)) , 'g');
%                     c = plot( user1.zeroCrossData.zeroCrossTime , abs(peak_zx(:,3)) , 'b:' ,'LineWidth',2.5 );
%                     d = plot( user2.zeroCrossData.zeroCrossTime , abs(peak_zx2(:,3)) , 'g:' ,'LineWidth',2.5 );
% 
%                 hold off
% 
%                 title( [ '�R���g���[������@������  ( ' char( obj.data.splitTimeInfo.state ) ' �j']);
%                 legend([a,b,c,d],'1P��T', '2P��T','1P��A', '2P��A','Location', 'NorthWest');
%                 xlabel('����t ms'); ylabel('��������T ms');
%                 xlim([spotTimeMax-3500-2500+1250 spotTimeMax+3500-2500+1250]);    ylim([0 600]);

                    %%  3D�U�z�}�i�PP�j
%                     subplot(4,10,[7:10,17:20]);
%                     
%                     dTg_zc = mean(dT_zc(startIndex:endIndex));
%                     dAg_zc = mean(dA_zc(startIndex:endIndex));
%                     dT0_zc = dT_zc - dTg_zc;
%                     dA0_zc = dA_zc - dAg_zc;
%                     [coeff,score,latent,tsquare] = princomp( [dT_zc(startIndex:endIndex) dA_zc(startIndex:endIndex)] );
%                     k1 = abs(coeff(1,1));            k2 = abs(coeff(2,1));
%                     theta = atan(k2/k1) *180 / pi ;
% 
%                     X1 = k1 * dT0_zc(startIndex:endIndex) + k2 * dA0_zc(startIndex:endIndex);
%                     [ fitParam_X1Y, fitLineR_X1Y, lineEdgePoint_X1Y] = Rhythm.approxiLine2d(X1, Y_zc(startIndex:endIndex) );
%                     plot3( dT_zc , dA_zc, Y_zc,   'Marker','o', 'MarkerEdgeColor' , [.7 .7 .7] ,'LineStyle','none');
%                     axis square
%                     grid on
%                     hold on
%                         plot3( dT_nzc , dA_nzc, Y_nzc, 'Marker','.', 'MarkerEdgeColor' , [.7 .7 .7] , 'LineStyle','none');
%                         plot3( dT_zc(startIndex:endIndex) , dA_zc(startIndex:endIndex), Y_zc(startIndex:endIndex),...
%                             'Marker','o', 'MarkerEdgeColor' , 'b' ,'MarkerFaceColor','b', 'LineStyle','none');
%                         plot(  [ -150*coeff(1,1)+dTg_zc ; 150*coeff(1,1)+dTg_zc ] , [ -150*coeff(2,1)+dAg_zc ; 150*coeff(2,1)+dAg_zc ] , 'r')
%                         plot(  [ -50*coeff(1,2)+dTg_zc ; 50*coeff(1,2)+dTg_zc ] , [ -50*coeff(2,2)+dAg_zc ; 50*coeff(2,2)+dAg_zc ] , 'r')
%                         plot3( lineEdgePoint_X1Y(:,1)*k1 +dTg_zc , lineEdgePoint_X1Y(:,1)*k2 +dAg_zc, lineEdgePoint_X1Y(:,2) ,'r' ,'LineWidth',3 );
% 
%                         plot3( [ lineEdgePoint_X1Y(2,1)*k1+dTg_zc lineEdgePoint_X1Y(2,1)*k1+dTg_zc ] ,...
%                                [ lineEdgePoint_X1Y(2,1)*k2+dAg_zc lineEdgePoint_X1Y(2,1)*k2+dAg_zc ] ,...
%                                [0 lineEdgePoint_X1Y(2,2)] ,'--r' );              % ����
%                     hold off
%                     
%                     xlabel('����g�` �����̍�');  ylabel('����g�` �U���̍�');  zlabel('�ΐ����Z�O�A�o�^����');
%                     xlim([0,dT_max]);      ylim([0,dA_max]);         zlim([0 V_max]);
% 
%                     title(['Player1 time:' num2str(spotTimeMax-spotTime ) '�`'  num2str(spotTimeMax)  ]);
                    

                %% ���n��@���쒼���ω�
                
%                 subplot(4,10,31:35);
%                 hold on
%                     for(i = 1:n_group)
%                         area([time_s(i) time_e(i)],[1000 1000],'FaceColor',[.7 1 1],'EdgeColor','none');
%                     end
%                     for(i = 1:n_group_2)
%                         area([time_s_2(i) time_e_2(i)],[1000 1000],'FaceColor',[1 1 .7],'EdgeColor',[1 1 .7]);
%                     end
%                     for(i = 1:n_group_lap)
%                         area([time_s_lap(i) time_e_lap(i)],[1000 1000],'FaceColor',[1 .9 1],'EdgeColor',[1 .9 1]);
%                     end
%                     a = plot( Time_zc, group_d , 'b');
%                     plot([spotTimeMax-spotTime+1 spotTimeMax-spotTime+1],[0 1000],'--k');
%                     plot([spotTimeMax spotTimeMax],[0 1000],'--k');
%                     b = plot( Time_zc2, group_d_2 , 'g');
%                 hold off
%                     
%                 title( [ '����K���̕ϑJ  ( ' char( obj.data.splitTimeInfo.state ) ' �j']);
%                 legend([a,b],'1P', '2P','Location', 'NorthWest');
%                 xlabel('����t ms'); ylabel('����K������');
%                 xlim([spotTimeMax-3500-2500+1250 spotTimeMax+3500-2500+1250]);    ylim([0 3]);
%                 set(gca,'YTick',[0:1:3]);
                

      
              %% �ۑ�

                    % ����
%                     drawnow             % drawnow������ƃA�j���[�V�����ɂȂ�
%                     movmov(Num) = getframe(gcf,MonitorSize);           % �A�j���[�V�����̃t���[�����Q�b�g����

                    % �ꖇ���ۑ�
%                     if ~isempty(strfind( char(obj.config.examType) , '�����ΐ�'))
                        obj.saveGraphWithNameToFolder('operatepulse_corr');
%                     else
%                         obj.saveGraphWithNameToFolder( [  num2str(Num) ]);
%                     end

                    Num = Num +1;
                end
%             end
            
%             saveMovieName = obj.saveFilePath(['_' num2str( obj.data.splitTimeInfo.index ) '.avi']);
%             movie2avi(movmov, saveMovieName,  'compression', 'None', 'fps', 2);

            %%      �ߎ��ʁ@�W���@�G�N�Z���f�[�^�o��  
% %             VIF = Rhythm.getVIF([X1_zc(:,3), X2_zc(:,3)]);
%             VIF = [ NaN ,NaN ];
%             outputTitle = { '�萔��' , '������' , '�U����',...
%                                     'VIF(������)', 'VIF�i�U�����j','�d����R','�d����R2' };
%             output = num2cell( [fitParam3' VIF fitR fitR2] );
%             
%             if ~isempty(strfind( char(obj.config.examType) , '�����ΐ�'))
%                 obj.outputAllToXlsWithName([ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state ] , output , outputTitle)
%             else
%                 obj.outputAllToXls(output , outputTitle);
%             end
            
        end

        
    end
end
