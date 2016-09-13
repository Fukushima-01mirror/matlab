% 常にsinの速度による日にち別グループ分け(操作誤差小さい順に60秒間データ)
function[dataGroup] = groupingData20130827_1(dataGroup,excel)
%input  obj ←　dataGroup

    
    dataTime = 60000;
    examTime = 25;
    for i=1: length(dataGroup)
        dataGroup(i).data= zeros(1,1);
        eval(['j' num2str(i) '=1;']);
    end
% データグループ分け
    for i = 1: length(excel.num)

        %dataGroupソート条件
        if ~isempty(strfind( char( excel.txt(i+1,1) ) , '常にsin')) ...         %sin運動
                && ~isempty(strfind( char( excel.txt(i+1,1) ) , '20130802')) ...
                && excel.num(i,3)==0 ...
                && excel.num(i,2)-excel.num(i,1)==2500 
            suffix = 1;
            dataGroup(suffix).list(j1,:) = excel.raw(i+1,:);
            eval(['j' num2str(suffix) '=j' num2str(suffix) '+1;']);
        end    
        %dataGroupソート条件
        if ~isempty(strfind( char( excel.txt(i+1,1) ) , '常にsin')) ...         %sin運動
                && ~isempty(strfind( char( excel.txt(i+1,1) ) , '20130809')) ...
                && excel.num(i,3)==0 ...
                && excel.num(i,2)-excel.num(i,1)==2500 
            suffix = 2;
            dataGroup(suffix).list(j2,:) = excel.raw(i+1,:);
            eval(['j' num2str(suffix) '=j' num2str(suffix) '+1;']);
        end
        
        %dataGroupソート条件
        if ~isempty(strfind( char( excel.txt(i+1,1) ) , '常にsin')) ...         %sin運動
                && ~isempty(strfind( char( excel.txt(i+1,1) ) , '20130819')) ...
                && excel.num(i,3)==0 ...
                && excel.num(i,2)-excel.num(i,1)==2500 
            suffix = 3;
            dataGroup(suffix).list(j3,:) = excel.raw(i+1,:);
            eval(['j' num2str(suffix) '=j' num2str(suffix) '+1;']);
        end    

    end

    for i=1: length(dataGroup)
        % 操作誤差の小さい順に並び替え
        dataGroup(i).orderList= sortrows( dataGroup(i,1).list , 6);
        T = cell2mat( dataGroup(i,1).list(1,3) ) - cell2mat( dataGroup(i,1).list(1,2) );    %線移動周期
        for k=1:round(dataTime/T)
%         for k=1:examTime
            dataFileName = char( strtok( dataGroup(i).orderList(k,1), '-' ) );
            load( [ cd(), '\vars\', dataFileName, '.mat' ] );

%          Rhythm.storeDataGroup (dataGroup, obj, stTime, endTime , column) : 実際のデータ取得
            [ dataGroup(i).data ] = Rhythm.storeDataGroup(  dataGroup(i).data , data.player1, ...
                    cell2mat( dataGroup(i).orderList(k,2) ), cell2mat( dataGroup(i).orderList(k,3) ), k);
%          Rhythm.storeTaskData (dataGroup, obj, stTime, endTime )　: タスクデータ取得
            [ dataGroup(i).data ] = Rhythm.storeTaskData(  dataGroup(i).data , data.task, ...
                    cell2mat( dataGroup(i).orderList(k,2) ), cell2mat( dataGroup(i).orderList(k,3) ));
        end
        dataGroup(i).data.errorVelocity =[ cell2mat( dataGroup(i).orderList(1,6) ) ,...
                                           mean( cell2mat( dataGroup(i).orderList(1:round(dataTime/T),6) ) ) , ...
                                           cell2mat( dataGroup(i).orderList(round(dataTime/T),6) ) ];
        
        
    end
    

    


