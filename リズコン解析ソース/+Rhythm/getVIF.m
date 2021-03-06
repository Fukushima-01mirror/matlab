function [VIF] = getVIF( X )
    
%     X = [ x1 x2 x1.*x2 ];
    [fitParam, bint, r, rint, stats1] = regress(X(:,1), [X(:,2:3) ones(length(X))]);
    [fitParam, bint, r, rint, stats2] = regress(X(:,2), [X(:,1) X(:,3) ones(length(X))]);
    [fitParam, bint, r, rint, stats3] = regress(X(:,3), [X(:,1:2) ones(length(X))]);
    
    VIF(1) = 1/(1-stats1(1));
    VIF(2) = 1/(1-stats2(1));
    VIF(3) = 1/(1-stats3(1));
    
end