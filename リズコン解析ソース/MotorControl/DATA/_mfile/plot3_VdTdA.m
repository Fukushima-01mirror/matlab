function plot3_VdTdA( cycleData , period_zx , peak_zx , zcTimes )
%UNTITLED10 この関数の概要をここに記述
%   詳細説明をここに記述

    Y = abs( cycleData(:,3) );    dT = abs( period_zx(:,3) );    dA = abs( peak_zx(:,3) );
    IndexZeroCross = find(  zcTimes(:,1)<2 & zcTimes(:,2)<2  &  cycleData(:,1)  > t_st  );
    IndexNonZeroCross = find( zcTimes(:,1)>1 | zcTimes(:,2)>1 &  cycleData(:,1)  >  t_zc );
    Y_zc  = Y(IndexZeroCross);        Y_nzc  = Y(IndexNonZeroCross);
    dT_zc = dT(IndexZeroCross,:);     dT_nzc = dT(IndexNonZeroCross,:);
    dA_zc = dA(IndexZeroCross,:);     dA_nzc = dA(IndexNonZeroCross,:);

end

