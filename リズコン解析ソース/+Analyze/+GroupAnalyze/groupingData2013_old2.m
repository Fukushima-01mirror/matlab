% ���sin�̑��x�ɂ��O���[�v����
function[dataGroup] = groupingData2013_old1(dataGroup,excel)

%input  obj ���@dataGroup

% �f�[�^�O���[�v����
    for i=1: length(dataGroup)
        dataGroup(i,1).data= zeros(1,1);
        eval(['j' num2str(i) '=1;']);
    end
    for i = 1: length(excel.num)
        dataFileName = char( strtok( excel.txt(i+1,1), '-' ) );
        load( [ cd(), '\vars\', dataFileName, '.mat' ] );

        %dataGroup�\�[�g����
        if ~isempty(strfind( char( excel.txt(i+1,1) ) , '�����_��')) ...         %sin�^��
                && excel.num(i,2)-excel.num(i,1)==3500 ...
                && excel.num(i,5)< 0.05                         %�덷�����@
            suffix = 1;
            [ dataGroup(suffix,1).data ] = Rhythm.storeDataGroup( ...
                                    dataGroup(suffix,1).data , data.player1, excel.num(i,1), excel.num(i,2), j1);
            [ dataGroup(suffix,1).data ] = Rhythm.storeTaskData( ...
                                    dataGroup(suffix).data , data.task, excel.num(i,1), excel.num(i,2));
            eval(['j' num2str(suffix) '=j' num2str(suffix) '+1;']);
        end    
        %dataGroup�\�[�g����
        if ~isempty(strfind( char( excel.txt(i+1,1) ) , '�����_��')) ...         %�����O�D�P�U
                && excel.num(i,2)-excel.num(i,1)==2500 ...
                && excel.num(i,5)< 0.05                         %�덷�����@
            suffix = 2;
            [ dataGroup(suffix,1).data ] = Rhythm.storeDataGroup( ...
                                    dataGroup(suffix,1).data , data.player1, excel.num(i,1), excel.num(i,2), j2);
            [ dataGroup(suffix,1).data ] = Rhythm.storeTaskData( ...
                                    dataGroup(suffix).data , data.task, excel.num(i,1), excel.num(i,2));
            eval(['j' num2str(suffix) '=j' num2str(suffix) '+1;']);
        end
        %dataGroup�\�[�g����
        if ~isempty(strfind( char( excel.txt(i+1,1) ) , '�����_��')) ...         %�����O�D�Q
                && excel.num(i,2)-excel.num(i,1)==2000 ...
                && excel.num(i,5)< 0.05                           %�덷�����@
            suffix = 3;
            [ dataGroup(suffix,1).data ] = Rhythm.storeDataGroup( ...
                                    dataGroup(suffix,1).data , data.player1, excel.num(i,1), excel.num(i,2), j3);
            [ dataGroup(suffix,1).data ] = Rhythm.storeTaskData( ...
                                    dataGroup(suffix).data , data.task, excel.num(i,1), excel.num(i,2));
            eval(['j' num2str(suffix) '=j' num2str(suffix) '+1;']);
        end    

    end


