function [ fitParam, fitLineR, lineEdgePoint] = approxiLine2d(x, y )
    

            fitParam = polyfit( x ,y  ,1);
            [R,P] = corrcoef( x , y );
            fitLineR(1,:) = [R(1,2), P(1,2)]; 
            lineEdgePoint(1,:) = [ min(x) , polyval( fitParam, min(x) ) ];
            lineEdgePoint(2,:) = [ max(x) , polyval( fitParam, max(x) ) ];
    
end