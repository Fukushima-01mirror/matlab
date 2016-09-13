

player = 'yasui';

main_path = 'C:\Users\cell\Desktop\リズコン解析ソース\MotorControl\DATA';
cd([ main_path '\' player]);

n_from = datenum('0119_1800','mmdd_HHMM');
% n_from = datenum('0122_1900','mmdd_HHMM');
% n_from = datenum('0121_2300','mmdd_HHMM');
% n_to = datenum('0124_2156','mmdd_HHMM');
n_to = now;    
file_list = dir('*.mat');
readIndex = find(  [file_list.datenum] > n_from & [file_list.datenum] < n_to );
file_list = file_list(readIndex) ;

for i = 1: length(file_list)
    
   filename = [file_list(i).name] ;
   Date = filename(1:9);
   i_sp = strfind(filename,'_sp');
   setPoint = str2double( filename(i_sp+3:end-4) );
   cond = filename( 10: i_sp-1);
   afterSimufunc(player, Date , cond , setPoint);
   
end