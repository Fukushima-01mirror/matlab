                %%
figure
            MonitorSize = [ 0, 0, 500, 500];
            set(gcf, 'Position', MonitorSize);

            [fitParam_g1, X1FIT, X2FIT, YFIT , fitR, yhat, fitR2 ,resError, SER ]  = Rhythm.approxiSurface_flat(dT_zc(indexG1) , dA_zc(indexG1) , Y_zc(indexG1) );
            plot3( dT_zc(indexG1) , dA_zc(indexG1) , Y_zc(indexG1),   'Marker','*', 'LineStyle','none');
            hold on
%                 plot3( X1_nzc  , X2_nzc , Y_nzc, 'Marker','o', 'LineStyle','none');
                mesh(X1FIT,X2FIT,YFIT, 'faceAlpha',0.5);
            hold off
            grid on
            view(-30,30);
            xlabel('操作波形 周期の差');  ylabel('操作波形 振幅の差');  zlabel('対数演算前アバタ速さ');
            xlim([0 600]);            ylim([0 600]);          zlim([0 50000]);

%             if isempty(  findstr( char( obj.config.examType ) , '自由操作'))
%                 xlim([0,600]);      ylim([0,600]);         zlim([0 50000]);
%             end

            [zY_zc , m_Y , s_Y]  = zscore( Y_zc(indexG1) );
            [zX1_zc , m_X1 , s_X1] = zscore( dT_zc(indexG1));
            [zX2_zc , m_X2 , s_X2] = zscore( dA_zc(indexG1));
            [zfitParam_g1, zX1FIT, zX2FIT, zYFIT , zfitR, zyhat, zfitR2 ]  = Rhythm.approxiSurface_flat(zX1_zc , zX2_zc , zY_zc );

            title({['V = (' num2str(fitParam_g1(1)) ') + (' num2str( fitParam_g1(2) ) ') * dPeriod + (' num2str( fitParam_g1(3)) ') * dPeak']; ...
                      ['標準化係数　dPeriod：' num2str( zfitParam_g1(2) ) '，dPeak：' num2str( zfitParam_g1(3) )];...
                    ['相関係数R：' num2str( fitR ) '，決定係数R^2：' num2str( fitR2 ) '，標準誤差(残差の標準偏差)：' num2str(SER) ]; });
            axis square
%             %%
%             if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
%                 obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_標準偏回帰係数(グループ1)']);
%             else
%                 obj.saveGraphWithName('_標準偏回帰係数(グループ1)');
%             end
% 

            
            %%                %%
            figure
            MonitorSize = [ 0, 0, 500, 500];
            set(gcf, 'Position', MonitorSize);
            

            [fitParam_g2, X1FIT, X2FIT, YFIT , fitR, yhat, fitR2 ,resError, SER ]  = Rhythm.approxiSurface_flat(dT_zc(indexG2) , dA_zc(indexG2) , Y_zc(indexG2) );
            plot3( dT_zc(indexG2) , dA_zc(indexG2) , Y_zc(indexG2),   'Marker','*', 'LineStyle','none');
            hold on
%                 plot3( X1_nzc  , X2_nzc , Y_nzc, 'Marker','o', 'LineStyle','none');
                mesh(X1FIT,X2FIT,YFIT, 'faceAlpha',0.5);
            hold off
            grid on
            view(-30,30);
            xlabel('操作波形 周期の差');  ylabel('操作波形 振幅の差');  zlabel('対数演算前アバタ速さ');
            xlim([0 600]);            ylim([0 600]);          zlim([0 50000]);

%             if isempty(  findstr( char( obj.config.examType ) , '自由操作'))
%                 xlim([0,600]);      ylim([0,600]);         zlim([0 50000]);
%             end

            [zY_zc , m_Y , s_Y]  = zscore( Y_zc(indexG2) );
            [zX1_zc , m_X1 , s_X1] = zscore( dT_zc(indexG2));
            [zX2_zc , m_X2 , s_X2] = zscore( dA_zc(indexG2));
            [zfitParam_g2, zX1FIT, zX2FIT, zYFIT , zfitR, zyhat, zfitR2 ]  = Rhythm.approxiSurface_flat(zX1_zc , zX2_zc , zY_zc );

            title({['V = (' num2str(fitParam_g2(1)) ') + (' num2str( fitParam_g2(2) ) ') * dPeriod + (' num2str( fitParam_g2(3)) ') * dPeak']; ...
                      ['標準化係数　dPeriod：' num2str( zfitParam_g2(2) ) '，dPeak：' num2str( zfitParam_g2(3) )];...
                    ['相関係数R：' num2str( fitR ) '，決定係数R^2：' num2str( fitR2 ) '，標準誤差(残差の標準偏差)：' num2str(SER) ]; });
            axis square
            %%
%             if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
%                 obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_標準偏回帰係数(グループ2)']);
%             else
%                 obj.saveGraphWithName('_標準偏回帰係数(グループ2)');
%             end

