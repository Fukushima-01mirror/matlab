function [ output_args ] = ts2zct( input_args )
%UNTITLED6 この関数の概要をここに記述
%   詳細説明をここに記述
    temp_zct = zeros(10000);
    j=1;

    for i = 2 : length(input_args)
        if input_args(i) ~= input_args(i-1)
            temp_zct(j) = input_args(i);
            j= j+1;
        end
    end
    output_args = temp_zct( temp_zct ~=0  );

end

