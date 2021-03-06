function [k1 , k2, X1, fitParam_X1Y, fitLineR_X1Y] = PCA_regress(dT_zc , dA_zc , Y_zc , bFig) 
        
            Nzc = length(Y_zc) ;
            
        %åŽŠŠÍ
        [coeff,score,latent,tsquare] = princomp( [dT_zc dA_zc] );
        k1 = abs(coeff(1,1));            k2 = abs(coeff(2,1));
        %åŽŠXRAZo
        dT0_zc = dT_zc - mean(dT_zc);
        dA0_zc = dA_zc - mean(dA_zc);
        X1 = k1 * dT0_zc + k2 * dA0_zc;
        %ņAŠÍ
        [ fitParam_X1Y, fitLineR_X1Y, lineEdgePoint_X1Y] = Rhythm.approxiLine2d(X1, Y_zc );
        alpha = fitParam_X1Y(1);    % XŦ
        beta = fitParam_X1Y(2);     % ØÐ

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
            xlabel('ėg` üúĖ·@ĒT');    ylabel('ėg`@UĖ·@ĒA'); 
            xlim([-300 300]);            ylim([-300 300]);
            title({['@\theta =  (' num2str( atan(k2/k1) *180 / pi ) ')[degree]']});

            subplot(2,5,6);
            %@XÆAo^ŽģĖÖ
            plot( X1   ,Y_zc  , 'Marker','*', 'LineStyle','none');
            hold on
                plot(lineEdgePoint_X1Y(:,1), lineEdgePoint_X1Y(:,2), 'r')
            hold off
            grid on 
            axis square
            xlabel('X = k1*ĒT + k2*ĒA');    ylabel('ÎÏ·OAo^Žx'); 
            xlim([-300,300]);            ylim([0 50000]);
            title({['V =  (' num2str( alpha ) ') * X  + (' num2str( beta ) ')']; ...
                    ['ÖWRF' num2str( fitLineR_X1Y(1)) '@@čWR^2' num2str( fitLineR_X1Y(1)^2)] });
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
                       [0 lineEdgePoint_X1Y(2,2)] ,'--r' );              % ü
            hold off
            grid on
            view(-30,30);
            xlabel('ėg` üúĖ·');  ylabel('ėg` UĖ·');  zlabel('ÎZOAo^Žģ');
            xlim([0 600]);            ylim([0 600]);          zlim([0 50000]);
            title({ ['XF(' num2str(coeff(1,1)) ', '  num2str(coeff(2,1)) ')@\theta =(' num2str( atan(k2/k1) *180 / pi ) ')[deg]'] ;...
                ['X-VĖXŦF' num2str( alpha ) 'CÖWRF' num2str( fitLineR_X1Y(1)) 'CčWR^2F' num2str( fitLineR_X1Y(1)^2)];...
                []});
            axis square


%%
