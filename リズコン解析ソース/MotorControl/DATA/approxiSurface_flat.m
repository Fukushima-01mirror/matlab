function [fitParam, x1fit, x2fit, yfit , fitR, yhat, fitR2 ,resError, SER ] = approxiSurface_flat(x1, x2, y )
    
    X = [ ones(size(x1)) x1 x2 ];
    [fitParam, bint, r, rint, stats] = regress_(y, X);
    [x1fit,x2fit] = meshgrid(linspace(min(x1),max(x1),10),linspace(min(x2),max(x2),10));
    yfit = fitParam(1) + fitParam(2)*x1fit + fitParam(3)*x2fit ;
    fitR = sqrt( stats(1) );
    fitR2 = stats(1);
    yhat = fitParam(1) + fitParam(2)*x1 + fitParam(3)*x2 ;
    resError = y - yhat;        %残差
    n= length(y);
    SER  = sqrt( sum(resError.^2)/(n-3)) ;  %標準誤差( 残差の標準偏差 )
    VE = SER^2;
    %各係数の標準誤差
    mx1 = mean(x1);   sx1 = x1-mx1;
    mx2 = mean(x2);   sx2 = x2-mx2;
    S = [sum( sx1.^2 ) sum(sx1.*sx2);...
         sum(sx1.*sx2) sum( sx2.^2 )];
%     Sinv = inv(S);
%     SE = [ sqrt( VE*(1/n + mahal(x1,x2)^2  ) , sqrt( VE / Sinv(1,1) ) , sqrt( VE / Sinv(2,2) ) ) ];
%     SE = [ sqrt( VE*(1/n + mx^2 / sum( sx.^2 ) ) ) , sqrt( VE / sum( sx.^2 ) ) ];
    
end