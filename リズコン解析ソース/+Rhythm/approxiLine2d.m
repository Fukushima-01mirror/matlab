function [ fitParam, fitLineR, lineEdgePoint, yhat, resError, SER, SE] = approxiLine2d(x, y )

    fitParam = polyfit( x ,y  ,1);
    [R,P] = corrcoef( x , y );
    fitLineR(1,:) = [R(1,2), P(1,2)]; 
    disp('��������');
    disp([ min(x) , polyval( fitParam, min(x) ) ]);
    disp('�����܂�');
    lineEdgePoint(1,:) = [ min(x) , polyval( fitParam, min(x) ) ];
    lineEdgePoint(2,:) = [ max(x) , polyval( fitParam, max(x) ) ];
    yhat = polyval( fitParam , x );
    resError = y - yhat;                % �c��
    n= length(y);
    SER = sqrt( sum( resError.^2 )/ n-2 );      %�W���덷�@(�c���̕W���΍�)
    VE = SER^2;
    %�e�W���̕W���덷
    mx = mean(x);   sx = x-mx;
    SE = [ sqrt( VE*(1/n + mx^2 / sum( sx.^2 ) ) ) , sqrt( VE / sum( sx.^2 ) ) ];
end