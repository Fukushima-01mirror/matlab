function [fitParam, x1fit, x2fit, yfit , fitR, yhat, fitR2] = approxiSurface(x1, x2, y )
    
    X = [ ones(size(x1)) x1 x2 x1.*x2 ];
    [fitParam, bint, r, rint, stats] = regress(y, X);
    [x1fit,x2fit] = meshgrid(linspace(min(x1),max(x1),10),linspace(min(x2),max(x2),10));
    yfit = fitParam(1) + fitParam(2)*x1fit + fitParam(3)*x2fit + fitParam(4)*x1fit.*x2fit;
    yhat = fitParam(1) + fitParam(2)*x1 + fitParam(3)*x2 + fitParam(4)*x1.*x2;
    fitR = sqrt( stats(1) );
    fitR2 = stats(1);
    
end