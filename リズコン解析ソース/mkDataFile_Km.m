clear;

excelPath = 'C:\Users\cell\Desktop\リズコン解析ソース\_configData\__.xlsx';
DestinationPath = 'C:\Users\cell\Desktop\リズコン解析ソース\data';

avt_list = dir('avt*');
[ A , dateIndex] = sort( [ avt_list.datenum ] );
avt_list = avt_list(dateIndex) ;

data1_list = dir('DATA1_*');
data2_list = dir('DATA2_*');
acv_list = dir('acv*');
com_list = dir('com*');
task_list = dir('task*');
press_list = dir('press*');

UserNamePlayer1 = '木村';
contParam1 = [0 0 0.25 0.05 0];        %[ PulsesCP spMot Kp Kd ]
bContModeList1 = 0;

UserNamePlayer2 = '安井';
contParam2 = [0 0 NaN NaN NaN];
bContModeList2 = 0;

ExamTime = '60000';
bExamTypeList = 0;
ExamType = 'LF実験_同画面';

if exist( 'タスク内容.txt' , 'file')
    bExamTypeList = 1;
    examTypeList = textread('タスク内容.txt' , '%s');
end
if exist( 'CON1PARA.txt' , 'file')
    bContModeList1 = 1;
    contModeList1 = dlmread('CON1PARA.txt' , '\t', 1,1);
end
if exist( 'CON2PARA.txt' , 'file')
    bContModeList2 = 1;
    contModeList2 = dlmread('CON2PARA.txt' , '\t', 1,1);
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
    
    avt_data = csvread( avt_list(n_list).name );
    if bContModeList1
        contMode1 = avt_data(1,1);
        contParam1 = contModeList1(contMode1,:);
    end
    if  bContModeList2
        contMode2 = avt_data(1,2);
        contParam2 = contModeList2(contMode2,:);
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

    if exist( 'CON1PARA.txt' , 'file')
        copyfile( 'CON1PARA.txt', [path, '\' folderName] );
    end
    if exist( 'CON2PARA.txt' , 'file')
        copyfile( 'CON2PARA.txt', [path, '\' folderName] );
    end
    
    acvFolderName = '';
    if ~isempty( acv_list )
        acvDatenum = acv_list(n_list).datenum;
        acvFolderName = datestr( acvDatenum, 'yyyymmdd_HHMMSS');
    end

    movefile( [path, '\' folderName] , DestinationPath );
    
    output(RowNum + n_list,1) = cellstr(folderName); 
    
    output(RowNum + n_list,2) = cellstr(UserNamePlayer1); 
    output(RowNum + n_list,3:7) = num2cell(contParam1); 

    output(RowNum + n_list,8) = cellstr(UserNamePlayer2); 
    output(RowNum + n_list,9:13) = num2cell(contParam2); 
    
    if bExamTypeList ==1
        ExamType = examTypeList(n_list) ; 
    end
    output(RowNum + n_list,14) = cellstr(ExamType); 
    output(RowNum + n_list,15) = cellstr(ExamTime); 
    output(RowNum + n_list,16) = cellstr(acvFolderName); 
    
end
xlswrite(excelPath,output);
