function[pks, locs] = findpeaksPulse(t,Pul)

%角度差分が0の時を除く
difNonZero = (diff(Pul) ~= 0);
n_difNonZero = length( difNonZero );

Pul_rmDouble = Pul(difNonZero);
t = t';
t_rmDouble = t(difNonZero);

if  n_difNonZero < 4
    pks =0; locs = 0;
else
    [pks,n_locs] = findpeaks(Pul_rmDouble);
    if isempty(pks)
        pks = max(Pul);
    end
    locs = t_rmDouble(n_locs);
end
    
