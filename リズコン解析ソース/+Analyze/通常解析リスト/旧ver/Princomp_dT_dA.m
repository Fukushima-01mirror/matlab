classdef Princomp_dT_dA < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = Princomp_dT_dA(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
           [period_zx, peak_zx] = Rhythm.setZeroCrossPeriodData(user.zeroCrossData);
           %　ゼロクロス間でのピーク回数取得
           [zeroCrossTimes] = Rhythm.setZeroCrossCount(user.zeroCrossData);
            
            Y = abs( user.zeroCrossData.nonlogAvtVelocity );
            dT = abs( period_zx(:,3) );
            dA = abs( peak_zx(:,3) );
            
            
            if obj.currentRunType == obj.runTypePlayer1
                IndexZeroCross = find(zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2 ...
                    & obj.data.player1.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) );
                IndexNonZeroCross = find( zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1 ...
                    & obj.data.player1.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) );
            elseif obj.currentRunType == obj.runTypePlayer2
                IndexZeroCross = find(zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2 ...
                    & obj.data.player2.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) );
                IndexNonZeroCross = find( zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1 ...
                    & obj.data.player2.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) );
            end

            Y_zc  = Y(IndexZeroCross);        Y_nzc  = Y(IndexNonZeroCross);
            dT_zc = dT(IndexZeroCross,:);     dT_nzc = dT(IndexNonZeroCross,:);
            dA_zc = dA(IndexZeroCross,:);     dA_nzc = dA(IndexNonZeroCross,:);
            
            %外れ値を除外するため，最大データ２つをカット
            [dT_max,dT_imax] = max(dT_zc);     dT_zc(dT_imax)= [];	 dA_zc(dT_imax)= [];     Y_zc(dT_imax)= [];
            [dT_max,dT_imax] = max(dT_zc);     dT_zc(dT_imax)= [];	 dA_zc(dT_imax)= [];     Y_zc(dT_imax)= [];
            [dA_max,dA_imax] = max(dA_zc);     dT_zc(dA_imax)= [];	 dA_zc(dA_imax)= [];     Y_zc(dA_imax)= [];
            [dA_max,dA_imax] = max(dA_zc);     dT_zc(dA_imax)= [];	 dA_zc(dA_imax)= [];     Y_zc(dA_imax)= [];
%             [Y_max,Y_imax] = max(Y_zc);     dT_zc(Y_imax)= [];	 dA_zc(Y_imax)= [];     Y_zc(Y_imax)= [];
%             [Y_max,Y_imax] = max(Y_zc);     dT_zc(Y_imax)= [];	 dA_zc(Y_imax)= [];     Y_zc(Y_imax)= [];
            while max(Y_zc./dT_zc) > 500
                [Y_dT_max,Y_dT_imax] = max(Y_zc./dT_zc);     dT_zc(Y_dT_imax)= [];	 dA_zc(Y_dT_imax)= [];     Y_zc(Y_dT_imax)= [];
                [Y_dT_max,Y_dT_imax] = max(Y_zc./dT_zc);     dT_zc(Y_dT_imax)= [];	 dA_zc(Y_dT_imax)= [];     Y_zc(Y_dT_imax)= [];
            end
            while max(Y_zc./dA_zc) > 500
                [Y_dA_max,Y_dA_imax] = max(Y_zc./dA_zc);     dT_zc(Y_dA_imax)= [];	 dA_zc(Y_dA_imax)= [];     Y_zc(Y_dA_imax)= [];
                [Y_dA_max,Y_dA_imax] = max(Y_zc./dA_zc);     dT_zc(Y_dA_imax)= [];	 dA_zc(Y_dA_imax)= [];     Y_zc(Y_dA_imax)= [];
            end
 
            Nzc = length(Y_zc) ;
            Nnzc = length(Y_nzc) ;
%%        ΔAとΔTの主成分分析
            figure(1)
            [coeff,score] = princomp( [dT_zc dA_zc] );
%             [ fitParam_dTdA, fitLineR_dTdA, lineEdgePoint] = Rhythm.approxiLine2d(dT_zc  ,dA_zc );
%             a = fitParam_dTdA(1);   b = fitParam_dTdA(2);
            plot( dT_zc - mean(dT_zc)   ,dA_zc - mean(dA_zc) , 'Marker','*', 'LineStyle','none');
            hold on
                plot( dT_nzc   ,dA_nzc ,'Marker','o', 'LineStyle','none' );
                plot(  [ zeros(1,2) ; 300*coeff(1,:) ] , [ zeros(1,2) ; 300*coeff(2,:) ] , 'r')
                plot(  [ zeros(1,2) ; -300*coeff(1,:) ] , [ zeros(1,2) ; -300*coeff(2,:) ] , 'r')
            hold off
            text(200*coeff(1,1), 200*coeff(2,1), ['X1:(' num2str(coeff(1,1)) ','  num2str(coeff(2,1)) ')'] )
            text(200*coeff(1,2), 200*coeff(2,2), ['X2:(' num2str(coeff(1,2)) ','  num2str(coeff(2,2)) ')'] )
            grid on
            xlabel('操作波形 周期の差　ΔT');    ylabel('操作波形　振幅の差　ΔA'); 
            xlim([-300 300]);            ylim([-300 300]);

%             title({['']; ...
%                     [''] });

                MonitorSize = [ 0, 0, 800, 800];
            set(gcf, 'Position', MonitorSize);
            if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state ]);
            else
                obj.saveGraph();
            end

            %%      近似面　係数　エクセルデータ出力  
%             VIF = Rhythm.getVIF([X1_zc , X2_zc ]);
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
