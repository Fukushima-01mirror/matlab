% ํษsinฬฌxษๆ้O[vชฏ
function[dataGroup] = groupingData2013_old1(dataGroup,excel)

%input  obj ฉ@dataGroup

% f[^O[vชฏ
    for i=1: length(dataGroup)
        dataGroup(i,1).data= zeros(1,1);
        eval(['j' num2str(i) '=1;']);
    end
    for i = 1: length(excel.num)
        dataFileName = char( strtok( excel.txt(i+1,1), '-' ) );
        load( [ cd(), '\vars\', dataFileName, '.mat' ] );

        %dataGroup\[g๐
        if ~isempty(strfind( char( excel.txt(i+1,1) ) , 'ํษ')) ...         %sin^ฎ
                && ~isempty(strfind( char( excel.txt(i+1,1) ) , '0809')) ...
                && excel.num(i,2)-excel.num(i,1)==2500 && excel.num(i,3) == 0 ...
                && excel.num(i,5)< 0.05                         %๋ทชฌ@
            suffix = 1;
            [ dataGroup(suffix,1).data ] = Rhythm.storeDataGroup( ...
                                    dataGroup(suffix,1).data , data.player1, excel.num(i,1), excel.num(i,2), j1);
            [ dataGroup(suffix,1).data ] = Rhythm.storeTaskData( ...
                                    dataGroup(suffix).data , data.task, excel.num(i,1), excel.num(i,2));
            eval(['j' num2str(suffix) '=j' num2str(suffix) '+1;']);
        end    
        %dataGroup\[g๐
        if ~isempty(strfind( char( excel.txt(i+1,1) ) , 'ํษ')) ...         %ฌODPU
                && excel.num(i,2)-excel.num(i,1)==2500 && excel.num(i,3) == 0.16 ...
                && excel.num(i,5)< 0.05                         %๋ทชฌ@
            suffix = 2;
            [ dataGroup(suffix,1).data ] = Rhythm.storeDataGroup( ...
                                    dataGroup(suffix,1).data , data.player1, excel.num(i,1), excel.num(i,2), j2);
            [ dataGroup(suffix,1).data ] = Rhythm.storeTaskData( ...
                                    dataGroup(suffix).data , data.task, excel.num(i,1), excel.num(i,2));
            eval(['j' num2str(suffix) '=j' num2str(suffix) '+1;']);
        end
        %dataGroup\[g๐
        if ~isempty(strfind( char( excel.txt(i+1,1) ) , 'ํษ')) ...         %ฌODQ
                && excel.num(i,2)-excel.num(i,1)==2000 && excel.num(i,3) == 0.2 ...
                && excel.num(i,5)< 0.05                           %๋ทชฌ@
            suffix = 3;
            [ dataGroup(suffix,1).data ] = Rhythm.storeDataGroup( ...
                                    dataGroup(suffix,1).data , data.player1, excel.num(i,1), excel.num(i,2), j3);
            [ dataGroup(suffix,1).data ] = Rhythm.storeTaskData( ...
                                    dataGroup(suffix).data , data.task, excel.num(i,1), excel.num(i,2));
            eval(['j' num2str(suffix) '=j' num2str(suffix) '+1;']);
        end    

    end


