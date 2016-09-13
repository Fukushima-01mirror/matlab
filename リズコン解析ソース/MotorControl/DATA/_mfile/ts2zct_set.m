function [ output_args ] = ts2zct_set( input_args )
%UNTITLED6 この関数の概要をここに記述
%   詳細説明をここに記述
    n = length( input_args.signals );
    temp_zct = zeros(10000,n-1);
    j=1;
    data = input_args.signals(2).values;
    for i = 2 : length(input_args.time )
        if data(i) ~= data(i-1)
            for k = 2 : n
                temp_zct(j,k-1) = input_args.signals(1,k).values(i);
            end
            j= j+1;
        end
    end
    output_args = zeros(j-1,n-1);
    for k = 1 : n-1
        output_args(1:j-1,k) = temp_zct( 1:j-1, k  );
    end

end


