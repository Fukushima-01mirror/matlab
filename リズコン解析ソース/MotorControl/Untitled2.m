% �f�[�^�̍쐬
x = [0:0.01:20]'; 
y1 = 200*exp(-0.05*x).*sin(x);
y2 = 0.8*exp(-0.5*x).*sin(10*x);
% ��1���Ƀf�[�^���v���b�g���A��1���̃n���h���ԍ����擾
hl1 = line(x,y1,'Color','b');
ax1 = gca;
set(ax1,'XColor','k','YColor','b','Ylim',[-300 300])
set(get(ax1,'Ylabel'),'String','Left Y-axis')
% ��1���̃n���h���ԍ���������擾���A��1���̈ʒu�ɁA��2�����d�˂ĕ\��
ax2 = axes('Position',get(ax1,'Position'),...   % (1)
             'Color','none',...                   % (1)
             'XColor','k','YColor','r',...
             'Ylim',[-1 1]); 
set(ax2,'YAxisLocation','right')                % (2)
set(ax2,'XAxisLocation','top','XTickLabel',[])  % (3)
set(get(ax2,'Ylabel'),'String','Right Y-axis')
% ��2���̃n���h����e�Ɏw�肵�A���C�����v���b�g
hl2 = line(x,y2,'Color','r','Parent',ax2);