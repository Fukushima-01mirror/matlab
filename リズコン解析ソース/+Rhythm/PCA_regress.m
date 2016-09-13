function [k1 , k2, X1, fitParam_X1Y, fitLineR_X1Y] = PCA_regress(dT_zc , dA_zc , Y_zc , bFig) 
        
            Nzc = length(Y_zc) ;
            
        %�听������
        [coeff,score,latent,tsquare] = princomp( [dT_zc dA_zc] );
        k1 = abs(coeff(1,1));            k2 = abs(coeff(2,1));
        %�听���X�R�A�Z�o
        dT0_zc = dT_zc - mean(dT_zc);
        dA0_zc = dA_zc - mean(dA_zc);
        X1 = k1 * dT0_zc + k2 * dA0_zc;
        %��A����
        [ fitParam_X1Y, fitLineR_X1Y, lineEdgePoint_X1Y] = Rhythm.approxiLine2d(X1, Y_zc );
        alpha = fitParam_X1Y(1);    % �X��
        beta = fitParam_X1Y(2);     % �ؕ�

        if bFig == 1
            MonitorSize = [ 0, 0, 1200, 800];
            set(gcf, 'Position', MonitorSize);
            subplot(2,5,1);
            plot( dT0_zc , dA0_zc , 'Marker','*', 'LineStyle','none');
            hold on
%                 plot( dT_nzc - mean(dT_zc) , dA_nzc - mean(dT_zc) ,'Marker','o', 'LineStyle','none' );
                plot(  [ -300*coeff(1,:) ; 300*coeff(1,:) ] , [ -300*coeff(2,:) ; 300*coeff(2,:) ] , 'r')
            hold off
            text(200*coeff(1,1), 200*coeff(2,1), ['X1:(' num2str(coeff(1,1)) ','  num2str(coeff(2,1)) ')'] )
            text(200*coeff(1,2), 200*coeff(2,2), ['X2:(' num2str(coeff(1,2)) ','  num2str(coeff(2,2)) ')'] )
            grid on
            axis square
            xlabel('����g�` �����̍��@��T');    ylabel('����g�`�@�U���̍��@��A'); 
            xlim([-300 300]);            ylim([-300 300]);
            title({['�@\theta =  (' num2str( atan(k2/k1) *180 / pi ) ')[degree]']});

            subplot(2,5,6);
            %�@X�ƃA�o�^�����̑���
            plot( X1   ,Y_zc  , 'Marker','*', 'LineStyle','none');
            hold on
                plot(lineEdgePoint_X1Y(:,1), lineEdgePoint_X1Y(:,2), 'r')
            hold off
            grid on 
            axis square
            xlabel('X = k1*��T + k2*��A');    ylabel('�ΐ��ϊ��O�A�o�^���x'); 
            xlim([-300,300]);            ylim([0 50000]);
            %xlim([-1500,1500]);            ylim([0 300000]);
            title({['V =  (' num2str( alpha ) ') * X  + (' num2str( beta ) ')']; ...
                    ['���֌W��R�F' num2str( fitLineR_X1Y(1)) '�@�@����W��R^2' num2str( fitLineR_X1Y(1)^2)] });
        end


        subplot(2,5 ,[2 3 4 5 ; 7 8 9 10]);
        plot3( dT_zc  , dA_zc , Y_zc,   'Marker','*', 'LineStyle','none');
            % 
            hold on
%                plot3( dT_nzc  , dA_nzc, Y_nzc, 'Marker','o', 'LineStyle','none');
               plot3(  [ -100*k1 ; 500*k1 ] + mean(dT_zc) , [ -100*k2 ; 500*k2 ] + mean(dA_zc) , zeros(2,1) , 'r')
               plot3( lineEdgePoint_X1Y(:,1)*k1 + mean(dT_zc) , lineEdgePoint_X1Y(:,1)*k2 + mean(dA_zc), lineEdgePoint_X1Y(:,2) ,'r' ,'LineWidth',3 );

               plot3( [ lineEdgePoint_X1Y(2,1)*k1 lineEdgePoint_X1Y(2,1)*k1 ] + mean(dT_zc),...
                       [ lineEdgePoint_X1Y(2,1)*k2 lineEdgePoint_X1Y(2,1)*k2 ] + mean(dA_zc),...
                       [0 lineEdgePoint_X1Y(2,2)] ,'--r' );              % ����
            hold off
            grid on
            view(-30,30);
            xlabel('����g�` �����̍�');  ylabel('����g�` �U���̍�');  zlabel('�ΐ����Z�O�A�o�^����');
            xlim([0 400]);            ylim([0 400]);          zlim([0 40000]);
            %xlim([0 3000]);            ylim([0 3000]);          zlim([0 300000]);
            title({ ['X�F(' num2str(coeff(1,1)) ', '  num2str(coeff(2,1)) ')�@\theta =(' num2str( atan(k2/k1) *180 / pi ) ')[deg]'] ;...
                ['X-V�̌X���F' num2str( alpha ) '�C���֌W��R�F' num2str( fitLineR_X1Y(1)) '�C����W��R^2�F' num2str( fitLineR_X1Y(1)^2)];...
                []});
            axis square


%%
