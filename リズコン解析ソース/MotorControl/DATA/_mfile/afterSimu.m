
%%
main_path = 'C:\Users\cell\Desktop\リズコン解析ソース\MotorControl\DATA';
cd(main_path);
%  ↓要変更
player = 'yasui';                    %%
setPoint= 0;                         %%
% cond = '_Km-PID(0.3_0_0)';      %%
cond = '_Kd0';                       %%
% Date = '0119_2200';
Date = datestr( now, 'mmdd_HHMM');

%%
afterSimufunc(player, Date , cond , setPoint);

%%