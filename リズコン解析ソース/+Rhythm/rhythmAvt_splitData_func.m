function[Pul, avt_data, cycle_data, Err] ....
    = rhythmAvt_splitData_func(tempPul, data0, cnst_a, cnst_b , match_data, suffix)

Pul = zeros( 60000 , 1 );
avt_data = zeros( 60000 , 2 );
cycle_data = zeros( 1000 , 4 );
Err = zeros( length(match_data),2 );
    zcI_st = 1;
    [Nmatch, m ] = size( match_data(:,1) );

for n_match = 1 : Nmatch
    
    t_st = match_data(n_match,1);
    t_end = match_data(n_match,2);
    
    %%アバタ速度・位置計算
    tempPul_local = tempPul(t_st:t_end,1);
    disp('CHECK');
    disp(size(tempPul_local));
    avt0_local = data0( t_st/20+1 : t_end/20 , :);
    disp('CHECK');
    disp(size(avt0_local));

    avt0_local(:,1) = avt0_local(:,1) - avt0_local(1,1) + 20;     % 開始時間をオフセットして計算
    [Pul_local, avt_data_local, cycle_data_local , Err_local] ...
        = Rhythm.rhythmAvt_cycle_data_func(tempPul_local, avt0_local, cnst_a, cnst_b, suffix);
    Pul(  t_st:t_end, : ) = Pul_local;
    avt_data( t_st:t_end , : ) = avt_data_local;
   
    n_cycle_data = length(cycle_data_local);
    cycle_data_local(:,1) = cycle_data_local(:,1) + t_st;  
    zcI_end = zcI_st + n_cycle_data-1;
    cycle_data( zcI_st : zcI_end ,: ) = cycle_data_local;
    zcI_st = zcI_end + 1;
    Err(n_match ,:) = Err_local;

    
    
end
cycle_data = cycle_data( cycle_data(:,1)>0 ,: );

