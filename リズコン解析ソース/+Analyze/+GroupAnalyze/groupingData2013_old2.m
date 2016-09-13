% 常にsinの速度によるグループ分け
function[dataGroup] = groupingData2013_old1(dataGroup,excel)

%input  obj ←　dataGroup

% データグループ分け
    for i=1: length(dataGroup)
        dataGroup(i,1).data= zeros(1,1);
        eval(['j' num2str(i) '=1;']);
    end
    for i = 1: length(excel.num)
        dataFileName = char( strtok( excel.txt(i+1,1), '-' ) );
        load( [ cd(), '\vars\', dataFileName, '.mat' ] );

        %dataGroupソート条件
        if ~isempty(strfind( char( excel.txt(i+1,1) ) , 'ランダム')) ...         %sin運動
                && excel.num(i,2)-excel.num(i,1)==3500 ...
                && excel.num(i,5)< 0.05                         %誤差が小　
            suffix = 1;
            [ dataGroup(suffix,1).data ] = Rhythm.storeDataGroup( ...
                                    dataGroup(suffix,1).data , data.player1, excel.num(i,1), excel.num(i,2), j1);
            [ dataGroup(suffix,1).data ] = Rhythm.storeTaskData( ...
                                    dataGroup(suffix).data , data.task, excel.num(i,1), excel.num(i,2));
            eval(['j' num2str(suffix) '=j' num2str(suffix) '+1;']);
        end    
        %dataGroupソート条件
        if ~isempty(strfind( char( excel.txt(i+1,1) ) , 'ランダム')) ...         %等速０．１６
                && excel.num(i,2)-excel.num(i,1)==2500 ...
                && excel.num(i,5)< 0.05                         %誤差が小　
            suffix = 2;
            [ dataGroup(suffix,1).data ] = Rhythm.storeDataGroup( ...
                                    dataGroup(suffix,1).data , data.player1, excel.num(i,1), excel.num(i,2), j2);
            [ dataGroup(suffix,1).data ] = Rhythm.storeTaskData( ...
                                    dataGroup(suffix).data , data.task, excel.num(i,1), excel.num(i,2));
            eval(['j' num2str(suffix) '=j' num2str(suffix) '+1;']);
        end
        %dataGroupソート条件
        if ~isempty(strfind( char( excel.txt(i+1,1) ) , 'ランダム')) ...         %等速０．２
                && excel.num(i,2)-excel.num(i,1)==2000 ...
                && excel.num(i,5)< 0.05                           %誤差が小　
            suffix = 3;
            [ dataGroup(suffix,1).data ] = Rhythm.storeDataGroup( ...
                                    dataGroup(suffix,1).data , data.player1, excel.num(i,1), excel.num(i,2), j3);
            [ dataGroup(suffix,1).data ] = Rhythm.storeTaskData( ...
                                    dataGroup(suffix).data , data.task, excel.num(i,1), excel.num(i,2));
            eval(['j' num2str(suffix) '=j' num2str(suffix) '+1;']);
        end    

    end


