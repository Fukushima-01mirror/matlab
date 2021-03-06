function [k1 , k2, X1, fitParam_X1Y, fitLineR_X1Y,  distError , distMean] = PCA_regress_3dplot(dT_zc , dA_zc , Y_zc , bFig) 
        
            Nzc = length(Y_zc) ;
            
        %ε¬ͺͺΝ
        [coeff,score] = Rhythm.HMpca( [dT_zc dA_zc] );
        %%princomp¨Rhythm.pca,tsquare¨tsquared
        k1 = abs(coeff(1,1));            k2 = abs(coeff(2,1));
        %ε¬ͺXRAZo
        dT0_zc = dT_zc - mean(dT_zc);
        dA0_zc = dA_zc - mean(dA_zc);
        X1 = k1 * dT0_zc + k2 * dA0_zc;
        %ρAͺΝ
        [ fitParam_X1Y, fitLineR_X1Y, lineEdgePoint_X1Y] = Rhythm.approxiLine2d(X1, Y_zc );
        alpha = fitParam_X1Y(1);    % X«
        beta = fitParam_X1Y(2);     % ΨΠ

        %ρAΌόϋόxNg
        direction = [k1, k2, alpha]; 
        direct = direction / norm(direction);
        
        %ρAΌόγΜX1Ε¬l
        Point0 = [  mean(dT_zc) , mean(dA_zc), polyval( fitParam_X1Y, 0 ) ]; 
        Point = [dT_zc, dA_zc , Y_zc ];
        for i = 1 : Nzc
            vector_P0P(i,:) = Point(i,:) - Point0;
            vector_P0H(i,:) = dot( vector_P0P(i,:) , direct) * direct;
            H_Point(i,:) = vector_P0H(i,:) + Point0;
            vector_HP(i,:) = Point(i,:) - H_Point(i,:);
            distError(i,:) = norm( vector_HP(i,:) );     %ε¬ͺρAΌόΖf[^Μ£
        end
        distMean = sqrt( sum( distError.^2 ) / (Nzc-3) );
        
        if bFig == 1
            
%             subplot(2,4,1);
%             plot( dT0_zc , dA0_zc , 'Marker','*', 'LineStyle','none');
%             hold on
% %                 plot( dT_nzc - mean(dT_zc) , dA_nzc - mean(dT_zc) ,'Marker','o', 'LineStyle','none' );
%                 plot(  [ -300*coeff(1,:) ; 300*coeff(1,:) ] , [ -300*coeff(2,:) ; 300*coeff(2,:) ] , 'r')
%             hold off
%             text(200*coeff(1,1), 200*coeff(2,1), ['X1:(' num2str(coeff(1,1)) ','  num2str(coeff(2,1)) ')'] )
%             text(200*coeff(1,2), 200*coeff(2,2), ['X2:(' num2str(coeff(1,2)) ','  num2str(coeff(2,2)) ')'] )
%             grid on
%             axis square
%             xlabel('μg` όϊΜ·@’T');    ylabel('μg`@UΜ·@’A'); 
%             xlim([-300 300]);            ylim([-300 300]);
%             title({['@\theta =  (' num2str( atan(k2/k1) *180 / pi ) ')[degree]']});
% 
%             subplot(2,4,5);
%             %@XΖAo^¬³ΜΦ
%             plot( X1   ,Y_zc  , 'Marker','*', 'LineStyle','none');
%             hold on
%                 plot(lineEdgePoint_X1Y(:,1), lineEdgePoint_X1Y(:,2), 'r')
%             hold off
%             grid on 
%             axis square
%             xlabel('X = k1*’T + k2*’A');    ylabel('ΞΟ·OAo^¬x'); 
%             xlim([-300,300]);            ylim([0 50000]);
%             title({['V =  (' num2str( alpha ) ') * X  + (' num2str( beta ) ')']; ...
%                     ['ΦWRF' num2str( fitLineR_X1Y(1)) '@@θWR^2' num2str( fitLineR_X1Y(1)^2)] });
% 
%         subplot(2,4 ,[2 3 4 ; 6 7 8]);

            plot3( dT_zc  , dA_zc , Y_zc,   'Marker','*', 'LineStyle','none','MarkerSize',2);
            % 
            hold on
%                plot3( dT_nzc  , dA_nzc, Y_nzc, 'Marker','o', 'LineStyle','none');
               plot3(  [ -100*k1 ; 500*k1 ] + mean(dT_zc) , [ -100*k2 ; 500*k2 ] + mean(dA_zc) , zeros(2,1) , 'r')
               plot3( lineEdgePoint_X1Y(:,1)*k1 + mean(dT_zc) , lineEdgePoint_X1Y(:,1)*k2 + mean(dA_zc), lineEdgePoint_X1Y(:,2) ,'r' ,'LineWidth',3 );

               plot3( [ lineEdgePoint_X1Y(2,1)*k1 lineEdgePoint_X1Y(2,1)*k1 ] + mean(dT_zc),...
                       [ lineEdgePoint_X1Y(2,1)*k2 lineEdgePoint_X1Y(2,1)*k2 ] + mean(dA_zc),...
                       [0 lineEdgePoint_X1Y(2,2)] ,'--r' );              % ό
            hold off
            grid on
            view(60,25);
            xlabel('μg` όϊΜ·');  ylabel('μg` UΜ·');  zlabel('ΞZOAo^¬³');
            xlim([0 1000]);            ylim([0 1000]);          zlim([0 100000]);
            %xlim([0 3000]);            ylim([0 3000]);          zlim([0 300000]);
            title({ ['XF(' num2str(coeff(1,1)) ', '  num2str(coeff(2,1)) ')@\theta =(' num2str( atan(k2/k1) *180 / pi ) ')[deg] Σ=(' num2str(alpha) ')[deg]'] ;...
                ['X-VΜX«F' num2str( alpha ) ', ΨΠF' num2str(beta) 'CΦWRF' num2str( fitLineR_X1Y(1)) 'CθWR^2F' num2str( fitLineR_X1Y(1)^2)];...
                [ 'ρAΌό©ηΜ£Μρζ½Ο½ϋͺF' num2str( distMean ) ]});
            axis square
        end


%%
