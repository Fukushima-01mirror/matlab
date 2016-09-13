function [ output_args ] = plot3d_2lines( input_args )
%UNTITLED2 ���̊֐��̊T�v�������ɋL�q
%   �ڍא����������ɋL�q
        lineEdgePoint_X1Y_g1 = [ min(X1_g1)*k1_g1 , min(X1_g1)*k2_g1 , polyval( fitParam_X1Y_g1, min(X1_g1) ) ;...
                                max(X1_g1)*k1_g1 , max(X1_g1)*k2_g1 , polyval( fitParam_X1Y_g1, max(X1_g1) ) ];
        lineEdgePoint_X1Y_g2 = [ min(X1_g2)*k1_g2 , min(X1_g2)*k2_g2 , polyval( fitParam_X1Y_g2, min(X1_g2) ) ;...
                                max(X1_g2)*k1_g2 , max(X1_g2)*k2_g2 , polyval( fitParam_X1Y_g2, max(X1_g2) ) ];
        plot3( [0 0],[0 0],[0 0],'k' );
        hold on
%                 plot3(dT_zc, dA_zc , Y_zc ,'Color' , 'k' );
            plot3(dT_zc(indexG01) , dA_zc(indexG01) , Y_zc(indexG01) ,'Color' , 'b' ,'Marker','*', 'LineStyle','none');
            plot3(dT_zc(indexG02) , dA_zc(indexG02) , Y_zc(indexG02) ,'Color' , 'g' ,'Marker','*', 'LineStyle','none');
            plot3(dT_zc(indexG0) , dA_zc(indexG0) , Y_zc(indexG0) ,'Color' , 'c' ,'Marker','*', 'LineStyle','none');

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

end

