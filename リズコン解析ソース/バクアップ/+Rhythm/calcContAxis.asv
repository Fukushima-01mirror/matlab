function [k1, k2, lineEdgePoint] = calcContAxis( a ,b , alpha, beta , dT  , dA )

        theta = atan( a );  % âÒì]äp
        Rotate = [ cos(theta) sin(theta); -sin(theta) cos(theta)];      % âÒì]çsóÒ
        k1 =  Rotate(1,1);    k2 = Rotate(1,2);
        Rotate_inv = [ cos(-theta) sin(-theta); -sin(-theta) cos(-theta)];      % ãtâÒì]çsóÒ
        m1 =Rotate_inv(1,1);    m2 = Rotate_inv(1,2);
        n1 =Rotate_inv(2,1);    n2 = Rotate_inv(2,2);

        X = k1 * dT + k2 * ( dA - b);
        [Xmax ,imax] = max(X);
        Vmax = alpha * Xmax + beta ;
        dTmax = m1*Xmax;
        dAmax = n1*Xmax;
        lineEdgePoint = [0, b, beta ; dTmax, dAmax+b , Vmax];

