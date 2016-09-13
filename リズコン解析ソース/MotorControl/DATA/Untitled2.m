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
            xlabel('����g�` �����̍�');  ylabel('����g�` �U���̍�');  zlabel('�ΐ����Z�O�A�o�^����');
            xlim([0 600]);            ylim([0 600]);          zlim([0 50000]);

%             if isempty(  findstr( char( obj.config.examType ) , '���R����'))
%                 xlim([0,600]);      ylim([0,600]);         zlim([0 50000]);
%             end

            [zY_zc , m_Y , s_Y]  = zscore( Y_zc(indexG1) );
            [zX1_zc , m_X1 , s_X1] = zscore( dT_zc(indexG1));
            [zX2_zc , m_X2 , s_X2] = zscore( dA_zc(indexG1));
            [zfitParam_g1, zX1FIT, zX2FIT, zYFIT , zfitR, zyhat, zfitR2 ]  = Rhythm.approxiSurface_flat(zX1_zc , zX2_zc , zY_zc );

            title({['V = (' num2str(fitParam_g1(1)) ') + (' num2str( fitParam_g1(2) ) ') * dPeriod + (' num2str( fitParam_g1(3)) ') * dPeak']; ...
                      ['�W�����W���@dPeriod�F' num2str( zfitParam_g1(2) ) '�CdPeak�F' num2str( zfitParam_g1(3) )];...
                    ['���֌W��R�F' num2str( fitR ) '�C����W��R^2�F' num2str( fitR2 ) '�C�W���덷(�c���̕W���΍�)�F' num2str(SER) ]; });
            axis square
%             %%
%             if ~isempty(strfind( char(obj.config.examType) , '�����ΐ�'))
%                 obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_�W���Ή�A�W��(�O���[�v1)']);
%             else
%                 obj.saveGraphWithName('_�W���Ή�A�W��(�O���[�v1)');
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
            xlabel('����g�` �����̍�');  ylabel('����g�` �U���̍�');  zlabel('�ΐ����Z�O�A�o�^����');
            xlim([0 600]);            ylim([0 600]);          zlim([0 50000]);

%             if isempty(  findstr( char( obj.config.examType ) , '���R����'))
%                 xlim([0,600]);      ylim([0,600]);         zlim([0 50000]);
%             end

            [zY_zc , m_Y , s_Y]  = zscore( Y_zc(indexG2) );
            [zX1_zc , m_X1 , s_X1] = zscore( dT_zc(indexG2));
            [zX2_zc , m_X2 , s_X2] = zscore( dA_zc(indexG2));
            [zfitParam_g2, zX1FIT, zX2FIT, zYFIT , zfitR, zyhat, zfitR2 ]  = Rhythm.approxiSurface_flat(zX1_zc , zX2_zc , zY_zc );

            title({['V = (' num2str(fitParam_g2(1)) ') + (' num2str( fitParam_g2(2) ) ') * dPeriod + (' num2str( fitParam_g2(3)) ') * dPeak']; ...
                      ['�W�����W���@dPeriod�F' num2str( zfitParam_g2(2) ) '�CdPeak�F' num2str( zfitParam_g2(3) )];...
                    ['���֌W��R�F' num2str( fitR ) '�C����W��R^2�F' num2str( fitR2 ) '�C�W���덷(�c���̕W���΍�)�F' num2str(SER) ]; });
            axis square
            %%
%             if ~isempty(strfind( char(obj.config.examType) , '�����ΐ�'))
%                 obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_�W���Ή�A�W��(�O���[�v2)']);
%             else
%                 obj.saveGraphWithName('_�W���Ή�A�W��(�O���[�v2)');
%             end

