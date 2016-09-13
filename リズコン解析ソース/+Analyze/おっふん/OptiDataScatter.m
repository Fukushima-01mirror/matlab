classdef OptiDataScatter < Analyze.Base
    %STANDARDDEVIATION ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q

    properties
    end

    methods
        function obj = OptiDataScatter(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
 filename = '���_�������Y�R��675�Œ�.csv';
%%          Opti�ł̃}�[�J�[�̕ψ�
    x=xlsread(filename,1,'Y5:Y1805');disp('X_Done');
    y=xlsread(filename,1,'Z5:Z1805');disp('Y_Done');
    z=xlsread(filename,1,'AA5:AA1805');disp('Z_Done');
    
    Num = 1;
    
    for spot = 1:5:length(x)
        if spot > 2 && (spot+5) < length(x)
            start = spot;
            cut = spot + 5;
            MonitorSize = [ 0, 0, 1200, 800];
            set(gcf, 'Position', MonitorSize);
            figure
            
    WaistMotion = [x,y,z];
    disp(WaistMotion);
    scatter3(x(start:cut),y(start:cut),z(start:cut),'*')
    view(-30,10)
    
    % ����
    drawnow             % drawnow������ƃA�j���[�V�����ɂȂ�
    movmov(Num) = getframe(gcf,MonitorSize);           % �A�j���[�V�����̃t���[�����Q�b�g����

    % �ꖇ���ۑ�
    if ~isempty(strfind( char(obj.config.examType) , '�����ΐ�'))
         obj.saveGraphWithNameToFolder( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_'  num2str(Num)]);
    else
         obj.saveGraphWithNameToFolder( [  num2str(Num) ]);
    end
    
    Num = Num + 1;
        end
    end
    %obj.saveGraphWithName('�����S�J��');   
        end

        function runForPair(obj,user1 ,user2)
%             obj.runForAlone(user1);
%             obj.runForAlone(user2);
%             
            
        end

        
    end
end
