% データの作成
x = [0:0.01:20]'; 
y1 = 200*exp(-0.05*x).*sin(x);
y2 = 0.8*exp(-0.5*x).*sin(10*x);
% 第1軸にデータをプロットし、第1軸のハンドル番号を取得
hl1 = line(x,y1,'Color','b');
ax1 = gca;
set(ax1,'XColor','k','YColor','b','Ylim',[-300 300])
set(get(ax1,'Ylabel'),'String','Left Y-axis')
% 第1軸のハンドル番号から情報を取得し、第1軸の位置に、第2軸を重ねて表示
ax2 = axes('Position',get(ax1,'Position'),...   % (1)
             'Color','none',...                   % (1)
             'XColor','k','YColor','r',...
             'Ylim',[-1 1]); 
set(ax2,'YAxisLocation','right')                % (2)
set(ax2,'XAxisLocation','top','XTickLabel',[])  % (3)
set(get(ax2,'Ylabel'),'String','Right Y-axis')
% 第2軸のハンドルを親に指定し、ラインをプロット
hl2 = line(x,y2,'Color','r','Parent',ax2);