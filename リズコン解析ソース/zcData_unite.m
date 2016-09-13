

i=3;
saveName_ZC = ['ゼロクロスデータ_' char( dataGroup(i).name) ];

jj = length(dataGroup(i).data.zeroCrossData);
t_zc = [0];      V_zc = [0];    dT_zc = [0];     dA_zc =[0];    T_zc = [0];     A_zc =[0];  v_zc =[0];
% t_nzc = [0];      Y_nzc = [0];    X1_nzc = [0 0 0];     X2_nzc =[0 0 0];
for j= 1:jj
    zcIndex_sPeak = find(dataGroup(i).data.zeroCrossData(j).zcPeakCount(:,1)==1 ...
                            & dataGroup(i).data.zeroCrossData(j).zcPeakCount(:,2)==1);
    zcIndex_mPeak = find(dataGroup(i).data.zeroCrossData(j).zcPeakCount(:,1)>1 ...
                            | dataGroup(i).data.zeroCrossData(j).zcPeakCount(:,2)>1);
    t_zc  = vertcat( t_zc , dataGroup(i).data.zeroCrossData(j).time (zcIndex_sPeak)) ;
    V_zc  = vertcat(V_zc , abs( dataGroup(i).data.zeroCrossData(j).nonlogAvtVelocity (zcIndex_sPeak) ) ) ; 
    dT_zc  = vertcat(dT_zc , abs( dataGroup(i).data.zeroCrossData(j).period(zcIndex_sPeak,3) ) ) ;
    dA_zc  = vertcat(dA_zc , abs( dataGroup(i).data.zeroCrossData(j).peak(zcIndex_sPeak,3) ) ) ;
    T_zc  = vertcat(T_zc , abs( dataGroup(i).data.zeroCrossData(j).period(zcIndex_sPeak,2) ) ) ;
    A_zc  = vertcat(A_zc , abs( dataGroup(i).data.zeroCrossData(j).peak(zcIndex_sPeak,2) ) ) ;
    v_zc  = vertcat(v_zc , abs( dataGroup(i).data.zeroCrossData(j).avtVelocity (zcIndex_sPeak) ) ) ; 
    
%     t_nzc  = vertcat( t_nzc , dataGroup(i).data.zeroCrossData(j).time (zcIndex_mPeak)) ; 
%     Y_nzc  = vertcat(Y_nzc , abs( dataGroup(i).data.zeroCrossData(j).nonlogAvtVelocity (zcIndex_mPeak) ) ) ;
%     X1_nzc  = vertcat(X1_nzc , abs( dataGroup(i).data.zeroCrossData(j).period(zcIndex_mPeak,:) ) ) ;
%     X2_nzc  = vertcat(X2_nzc , abs(dataGroup(i).data.zeroCrossData(j).peak(zcIndex_mPeak,:) ) ) ;
end

t_zc(1,:)=[];   V_zc(1,:)=[];    
dT_zc(1,:)=[];     dA_zc(1,:)=[];   T_zc(1,:)=[];     A_zc(1,:)=[];
v_zc(1,:)=[];    

zcData(:,1) = t_zc;
zcData(:,2) = V_zc;
zcData(:,3) = dT_zc;
zcData(:,4) = dA_zc;
zcData(:,5) = T_zc;
zcData(:,6) = A_zc;
zcData(:,7) = v_zc;

xlswrite( [saveName_ZC '.xlsx' ]  ,zcData);

