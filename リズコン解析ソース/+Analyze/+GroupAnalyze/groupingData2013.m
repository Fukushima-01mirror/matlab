% ฦ่ ฆธCsinCฌi0.16C0.20jฬO[vชฏ
function[dataGroup] = groupingData2013(dataGroup,excel)

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
        if ~isempty(strfind( char( excel.txt(i+1,1) ) , 'sin')) ...         %sin^ฎ
                && excel.num(i,2)-excel.num(i,1)==2500 ...
                && excel.num(i,5)< 0.075                         %๋ทชฌ@
            suffix = 1;
            [ dataGroup(suffix,1).data ] = Rhythm.storeDataGroup( ...
                                    dataGroup(suffix,1).data , data.player1, excel.num(i,1), excel.num(i,2), j1);
            [ dataGroup(suffix,1).data ] = Rhythm.storeTaskData( ...
                                    dataGroup(suffix).data , data.task, excel.num(i,1), excel.num(i,2));
            eval(['j' num2str(suffix) '=j' num2str(suffix) '+1;']);
        end    
        %dataGroup\[g๐
        if ~isempty(strfind( char( excel.txt(i+1,1) ) , '0.16')) ...         %ฌODPU
                && excel.num(i,2)-excel.num(i,1)==2500 ...
                && excel.num(i,5)< 0.075                         %๋ทชฌ@
            suffix = 2;
            [ dataGroup(suffix,1).data ] = Rhythm.storeDataGroup( ...
                                    dataGroup(suffix,1).data , data.player1, excel.num(i,1), excel.num(i,2), j2);
            [ dataGroup(suffix,1).data ] = Rhythm.storeTaskData( ...
                                    dataGroup(suffix).data , data.task, excel.num(i,1), excel.num(i,2));
            eval(['j' num2str(suffix) '=j' num2str(suffix) '+1;']);
        end
        %dataGroup\[g๐
        if ~isempty(strfind( char( excel.txt(i+1,1) ) , '0.2')) ...         %ฌODQ
                && excel.num(i,2)-excel.num(i,1)==2000 ...
                && excel.num(i,5)< 0.075                           %๋ทชฌ@
            suffix = 3;
            [ dataGroup(suffix,1).data ] = Rhythm.storeDataGroup( ...
                                    dataGroup(suffix,1).data , data.player1, excel.num(i,1), excel.num(i,2), j3);
            [ dataGroup(suffix,1).data ] = Rhythm.storeTaskData( ...
                                    dataGroup(suffix).data , data.task, excel.num(i,1), excel.num(i,2));
            eval(['j' num2str(suffix) '=j' num2str(suffix) '+1;']);
        end    

    end


