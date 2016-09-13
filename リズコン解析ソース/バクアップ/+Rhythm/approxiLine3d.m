function [dirVect, lineEdgePoint] = approxiLine3d(x1, x2, y )
    

    [coeff,score,roots] = princomp( [x1 x2 y] );
    dirVect = coeff(:,1);       % 直線の方向ベクトル
    t = [min(score(:,1))-.2, max(score(:,1))+.2];
    lineEdgePoint = [mean([x1 x2 y]) + t(1)*dirVect' ; ...          % 始点(x1,x2,y)
                     mean([x1 x2 y]) + t(2)*dirVect' ];             % 終点(x1,x2,y)

    
end