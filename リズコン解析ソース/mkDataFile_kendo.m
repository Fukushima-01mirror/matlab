clear;

excelPath = 'C:\Users\cell\Documents\リズコンシステム\リズコン解析ソース\_configData\config_20140730協調.xlsx';
DestinationPath = 'C:\Users\cell\Documents\リズコンシステム\リズコン解析ソース\data';

avt_list = dir('avt*');
[ A , dateIndex] = sort( [ avt_list.datenum ] );
avt_list = avt_list(dateIndex) ;

data1_list = dir('DATA1_*');
data2_list = dir('DATA2_*');
acv_list = dir('acv*');
com_list = dir('com*');
task_list = dir('task*');
press_list = dir('press*');
match_list = dir('match*');

UserNamePlayer1 = '福島';
contParam1 = [0 0 0.25 0.05];        %[ PulsesCP spMot Kp Kd ]
bContModeList1 = 0;

UserNamePlayer2 = '須藤';
contParam2 = [0 0 0.25 0.05];
bContModeList2 = 0;
ExamTime = '60000';
bExamTypeList = 0;
ExamType = '協調移動';

if exist( 'タスク内容.txt' , 'file')
    bExamTypeList = 1;
    examTypeList = textread('タスク内容.txt' , '%s');
end
if exist( 'CONTPARA.txt' , 'file')
    bContModeList1 = 1;
    contModeList1 = dlmread('CONTPARA.txt' , '\t', 1,1);
end
if exist( 'CONTPARA2.txt' , 'file')
    bContModeList2 = 1;
    contModeList2 = dlmread('CONTPARA2.txt' , '\t', 1,1);
end

[obj.num, obj.txt, obj.raw] = xlsread(excelPath);
output =  obj.raw;
RowNum = length(output(:,1));


for n_list = 1: length(avt_list)
    
    path = cd;
    datenum = avt_list(n_list).datenum;
    folderName = datestr( datenum, 'yyyymmdd_HHMMSS');
    mkdir(folderName);
    copyfile( avt_list(n_list).name, [path, '\' folderName] );
    copyfile( match_list(n_list).name, [path, '\' folderName] );
    
    if bContModeList1 || bContModeList2
        avt_data = csvread( avt_list(n_list).name );
        if ~isempty( UserNamePlayer1 )
            contMode1 = avt_data(1,1);
            contParam1 = contModeList1(contMode1,:);
        end
        if ~isempty( UserNamePlayer2 )
            contMode2 = avt_data(1,2);
            contParam2 = contModeList2(contMode2,:);
        end
    end
    
    
    if ~isempty( com_list )
        sameDateIndex = find( [ com_list.datenum ] == avt_list(n_list).datenum );
        if ~isempty(sameDateIndex) 
            copyfile( com_list( sameDateIndex).name, [path, '\' folderName] );
        end
    end
    
    if ~isempty( task_list )
        sameDateIndex = find( [ task_list.datenum ] == avt_list(n_list).datenum );
        if ~isempty(sameDateIndex) 
            copyfile( task_list( sameDateIndex).name, [path, '\' folderName] );
        end
        
        task_data = csvread( task_list( sameDateIndex ).name );
        if task_data(1,1) == 1
            ExamType = '前後移動';
        elseif task_data(1,1) == 2 
            ExamType = '信号実験';
        elseif task_data(1,1) == 3
            ExamType = '目標追従実験';
        elseif task_data(1,1) == 4
            ExamType = '追い込まれ実験';
        elseif task_data(1,1) == 5
            ExamType = '両側追い込まれ実験';
        end
            
    end

    if ~isempty( press_list )
        sameDateIndex = find( [ press_list.datenum ] == avt_list(n_list).datenum );
        if ~isempty(sameDateIndex) 
            copyfile( press_list( sameDateIndex).name, [path, '\' folderName] );
        end
    end

    if ~isempty( UserNamePlayer1 )
        copyfile( data1_list(n_list).name, [path, '\' folderName] );
    end
    if ~isempty( UserNamePlayer2 )
        copyfile( data2_list(n_list).name, [path, '\' folderName] );
    end

    if exist( 'CONTPARA.txt' , 'file')
        copyfile( 'CONTPARA.txt', [path, '\' folderName] );
    end
    if exist( 'CONTPARA2.txt' , 'file')
        copyfile( 'CONTPARA2.txt', [path, '\' folderName] );
    end
    
    acvFolderName = '';
    if ~isempty( acv_list )
        acvDatenum = acv_list(n_list).datenum;
        acvFolderName = datestr( acvDatenum, 'yyyymmdd_HHMMSS');
    end

    movefile( [path, '\' folderName] , DestinationPath );
    
    output(RowNum + n_list,1) = cellstr(folderName); 
    
    output(RowNum + n_list,2) = cellstr(UserNamePlayer1); 
    output(RowNum + n_list,3:6) = num2cell(contParam1); 

    output(RowNum + n_list,7) = cellstr(UserNamePlayer2); 
    output(RowNum + n_list,8:11) = num2cell(contParam2); 
    
    if bExamTypeList ==1
        ExamType = examTypeList(n_list) ; 
    end
    output(RowNum + n_list,12) = cellstr(ExamType); 
    output(RowNum + n_list,13) = cellstr(ExamTime); 
    output(RowNum + n_list,14) = cellstr(acvFolderName); 
    
end
xlswrite(excelPath,output);
