function [vector_HP , distError , distMean] = PCA_regDist(dT_zc , dA_zc , Y_zc , k1, k2 , X1, dTdAmean, fitParam_X1Y, bFig )

%   dT_zc , dA_zc , Y_zc       �U�z�}�̊e�f�[�^
%   k1, k2 , X1,dTdAmean, fitParam_X1Y  �听����A�����̃f�[�^
%
            Nzc = length(Y_zc) ;
        %��A���������x�N�g��
        alpha = fitParam_X1Y(1);    % �X��
        direction = [k1, k2, alpha]; 
        direct = direction / norm(direction);
        
        %��A�������X1�ŏ��l
        Point0 = [  dTdAmean(1) , dTdAmean(2), polyval( fitParam_X1Y, 0 ) ]; 
        Point = [dT_zc, dA_zc , Y_zc ];
        for i = 1 : Nzc
            vector_P0P(i,:) = Point(i,:) - Point0;
            vector_P0H(i,:) = dot( vector_P0P(i,:) , direct) * direct;
            H_Point(i,:) = vector_P0H(i,:) + Point0;
            vector_HP(i,:) = Point(i,:) - H_Point(i,:);
            distError(i,:) = norm( vector_HP(i,:) );     %�听����A�����ƃf�[�^�̋���
        end
        distMean = sqrt( sum( distError.^2 ) / (Nzc-3) );

        if bFig == 1 
            MonitorSize = [ 0, 0, 800, 800];
            set(gcf, 'Position', MonitorSize);

            plot3( [0;400*direction(1)]+Point0(1), [0;400*direction(2)]+Point0(2) , [0;400*direction(3)]+Point0(3), 'r' )
            % 
            hold on
                for i = 1 : Nzc
                    % ��A�����ւ̐���
                    plot3( [Point(i,1) H_Point(i,1)] ,[Point(i,2) H_Point(i,2)] ,[Point(i,3) H_Point(i,3)] ,'k' );
                end
                plot3(  [ -100*k1 ; 500*k1 ] + dTdAmean(1) , [ -100*k2 ; 500*k2 ]+ dTdAmean(2)  , zeros(2,1) , 'r');
                lineEdgePoint(1,:) = [ min(X1)*k1 , min(X1)*k2 , polyval( fitParam_X1Y, min(X1) ) ];
                lineEdgePoint(2,:) = [ max(X1)*k1 , max(X1)*k2 , polyval( fitParam_X1Y, max(X1) ) ];
                plot3( lineEdgePoint(:,1) + dTdAmean(1) , lineEdgePoint(:,2) + dTdAmean(2), lineEdgePoint(:,3) ,'r' ,'LineWidth',3 );
                plot3( [ lineEdgePoint(2,1)+ dTdAmean(1) lineEdgePoint(2,1)+ dTdAmean(1) ] ,...
                       [ lineEdgePoint(2,2)+ dTdAmean(2) lineEdgePoint(2,2)+ dTdAmean(2) ] ,...
                       [0 lineEdgePoint(2,3)] ,'--r' );              % ����
                plot3( dT_zc , dA_zc , Y_zc,   'Marker','*', 'LineStyle','none');
%                 plot3( dT_nzc , dA_nzc , Y_nzc, 'Marker','o', 'LineStyle','none');
            hold off
            grid on
            view(35,15);
            xlabel('����g�` �����̍�dT');  ylabel('����g�` �U���̍�dA');  zlabel('�ΐ����Z�O�A�o�^����V');
            xlim([0 600]);            ylim([0 600]);          zlim([0 50000]);
            title({ ['X�F(' num2str(k1) ', '  num2str(k2) ')�@\theta =(' num2str( atan(k2/k1) *180 / pi ) ')[deg]'] ;...
                ['X-V�̌X���F' num2str( alpha ) ];...
                [ '��A��������̋����̓�敽�ϕ������F' num2str( distMean ) ]});
            axis square
        end
