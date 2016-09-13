clear;

Path = 'C:\Users\cell\Desktop\リズコン解析ソース\data' ;
folderList = dir;
j=1;

for i= 3:length(folderList)-2
    folderPath = [ Path '\' folderList(i).name];
    cd( folderPath );
    taskList = dir('task*.csv');
    
    if ~isempty( taskList )
        task = csvread( taskList.name );        
        rowNum = length(task);
        if rowNum > 4000
            changeList{j,1} = [folderPath '\' taskList.name];
            j=j+1;
            task_new = task(1:2:rowNum, :);
            csvwrite(taskList.name ,task_new);
        end
        
    end
    
end