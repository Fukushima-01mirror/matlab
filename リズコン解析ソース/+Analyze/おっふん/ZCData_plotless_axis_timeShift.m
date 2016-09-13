classdef ZCData_plotless_axis_timeShift < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = ZCData_plotless_axis_timeShift(config,data)
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
%             spotTimeSeries = spotTime+startTime : user.time.highSampled(end);
%             spotTimeSeries = spotTimeSeries.';
            Num = 1;

            for spotTimeMax =  500 * floor( (spotTime+startTime) /500) : 500: 500 * ceil(user.time.highSampled(end) /500)

                %ここから上の200はすべてもともと500
                startIndex1 = find( user.zeroCrossData.zeroCrossTime(IndexZeroCross) >= ( spotTimeMax - spotTime +1 ) ,1 ,'first');
                endIndex1 = find( user.zeroCrossData.zeroCrossTime(IndexZeroCross) < spotTimeMax ,1 ,'last');  

                if length(Y_zc(startIndex1:endIndex1))>2
%%  3D散布図
                    subplot(3,4,[7 8 11 12])

                    dTg_zc = mean(dT_zc(startIndex1:endIndex1));
                    dAg_zc = mean(dA_zc(startIndex1:endIndex1));
                    dT0_zc = dT_zc - dTg_zc;
                    dA0_zc = dA_zc - dAg_zc;
                    [coeff,score,latent,tsquare] = princomp( [dT_zc(startIndex1:endIndex1) dA_zc(startIndex1:endIndex1)] );
                    k1 = abs(coeff(1,1));            k2 = abs(coeff(2,1));
                    
                    X1 = k1 * dT0_zc + k2 * dA0_zc;
                    [ fitParam_X1Y, fitLineR_X1Y, lineEdgePoint_X1Y] = Rhythm.approxiLine2d(X1, Y_zc );
                    
                    theta = atan(k2/k1) *180 / pi ;
                    alpha = fitParam_X1Y(1);
                    
                    THETA(1,spotTimeMax-spotTime+1:spotTimeMax)=decround(theta,3);
                    ALPHA(1,spotTimeMax-spotTime+1:spotTimeMax)=decround(alpha,3);
                    
                    Num = Num +1;
                end
   
            end
            
                        
              for i =1:60000
                if(rem(i,20) == 0)
                    Exl(i/20,1)=mean(THETA(1,20*((i/20)-1)+1:i));
                    Exl(i/20,2)=mean(ALPHA(1,20*((i/20)-1)+1:i));
                end
              end   
            c = clock;
            c(6)=round(c(6));
            filename = (strcat(num2str(c(4)),'_',num2str(c(5)),'_',num2str(c(6)),'回帰直線方位角'));
            %filename = (strcat(c(6),'回帰直線方位角'));
            disp(filename);
            A = Exl;
            sheet = 1;
            xlRange = 'A1';
            xlswrite(filename,A,sheet,xlRange);
        end

        function runForPair(obj,user1 ,user2)
%             obj.runForAlone(user1);
%             obj.runForAlone(user2);
%             
            
        end

        
    end
end
