% ���sin�̑��x�ɂ��O���[�v����(����덷����������60�b�ԃf�[�^)
function[dataGroup] = groupingData20130819_1(dataGroup,excel)
%input  obj ���@dataGroup

    
    dataTime = 60000;
    examTime = 25;
    for i=1: length(dataGroup)
        dataGroup(i).data= zeros(1,1);
        eval(['j' num2str(i) '=1;']);
    end
% �f�[�^�O���[�v����
    for i = 1: length(excel.num)

        %dataGroup�\�[�g����
        if ~isempty(strfind( char( excel.txt(i+1,1) ) , '���sin')) ...         %sin�^���@�ᑬ
                && ~isempty(strfind( char( excel.txt(i+1,1) ) , '2013')) ...
                && excel.num(i,3)==0 ...
                && excel.num(i,2)-excel.num(i,1)==3500 
            suffix = 1;
            dataGroup(suffix).list(j1,:) = excel.raw(i+1,:);
            eval(['j' num2str(suffix) '=j' num2str(suffix) '+1;']);
        end    
        %dataGroup�\�[�g����
        if ~isempty(strfind( char( excel.txt(i+1,1) ) , '���sin')) ...         %sin�^���@����
                && ~isempty(strfind( char( excel.txt(i+1,1) ) , '2013')) ...
                && excel.num(i,3)==0 ...
                && excel.num(i,2)-excel.num(i,1)==2500 
            suffix = 2;
            dataGroup(suffix).list(j2,:) = excel.raw(i+1,:);
            eval(['j' num2str(suffix) '=j' num2str(suffix) '+1;']);
        end
        %dataGroup�\�[�g����
        if ~isempty(strfind( char( excel.txt(i+1,1) ) , '���sin')) ...         %sin�^���@����
                && ~isempty(strfind( char( excel.txt(i+1,1) ) , '2013')) ...
                && excel.num(i,3)==0 ...
                && excel.num(i,2)-excel.num(i,1)==2000 
            suffix = 3;
            dataGroup(suffix).list(j3,:) = excel.raw(i+1,:);
            eval(['j' num2str(suffix) '=j' num2str(suffix) '+1;']);
        end    

    end

    for i=1: length(dataGroup)
        % ����덷�̏��������ɕ��ёւ�
        dataGroup(i).orderList= sortrows( dataGroup(i,1).list , 6);
        T = cell2mat( dataGroup(i,1).list(1,3) ) - cell2mat( dataGroup(i,1).list(1,2) );    %���ړ�����
        for k=1:round(dataTime/T)
%         for k=1:examTime
            dataFileName = char( strtok( dataGroup(i).orderList(k,1), '-' ) );
            load( [ cd(), '\vars\', dataFileName, '.mat' ] );

%          Rhythm.storeDataGroup (dataGroup, obj, stTime, endTime , column) : ���ۂ̃f�[�^�擾
            [ dataGroup(i).data ] = Rhythm.storeDataGroup(  dataGroup(i).data , data.player1, ...
                    cell2mat( dataGroup(i).orderList(k,2) ), cell2mat( dataGroup(i).orderList(k,3) ), k);
%          Rhythm.storeTaskData (dataGroup, obj, stTime, endTime )�@: �^�X�N�f�[�^�擾
            [ dataGroup(i).data ] = Rhythm.storeTaskData(  dataGroup(i).data , data.task, ...
                    cell2mat( dataGroup(i).orderList(k,2) ), cell2mat( dataGroup(i).orderList(k,3) ));
        end
        dataGroup(i).data.errorVelocity =[ cell2mat( dataGroup(i).orderList(1,6) ) ,...
                                           mean( cell2mat( dataGroup(i).orderList(1:round(dataTime/T),6) ) ) , ...
                                           cell2mat( dataGroup(i).orderList(round(dataTime/T),6) ) ];
        
        
    end
    

    


