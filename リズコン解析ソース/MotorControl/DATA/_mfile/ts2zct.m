function [ output_args ] = ts2zct( input_args )
%UNTITLED6 ���̊֐��̊T�v�������ɋL�q
%   �ڍא����������ɋL�q
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

