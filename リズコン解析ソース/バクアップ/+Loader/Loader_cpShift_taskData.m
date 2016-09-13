function [ obj ] = Loader_cpShift_taskData( config )
%LOADER20130515 この関数の概要をここに記述
% リーダーフォロワー実験　アーカイブ　or　人
%   詳細説明をここに記述

%            deviceFileName = char(strcat(cd(),'\data\',config.fileName,'.csv'));
%            obj.device = Models.Device(deviceFileName);

       dataDirName = char(strcat(cd(),'\data\',config.fileName,'\'));           

       if config.isExistPlayer1() && config.isExistPlayer2()      %二人で実験の
            obj.player1 = Models.RhythmAvatar_cpShift( config ,'1');
            obj.player2 = Models.RhythmAvatar_cpShift( config ,'2');

       elseif config.isExistPlayer1() && config.isExistArchiveData      % アーカイブ
            obj.player1 = Models.RhythmAvatar_cpShift( config ,'1');
            archiveVarFilename = char(strcat(cd(),'\vars\',config.archiveDataFileName,'.mat'));
            load(archiveVarFilename,'data');
            obj.archive = data.player2;
       elseif config.isExistPlayer2() && config.isExistArchiveData      % アーカイブ
            obj.player2 = Models.RhythmAvatar_cpShift( config ,'2');
            archiveVarFilename = char(strcat(cd(),'\vars\',config.archiveDataFileName,'.mat'));
            load(archiveVarFilename,'data');
            obj.archive = data.player1;
       elseif config.isExistPlayer1() 
            obj.player1 = Models.RhythmAvatar_cpShift( config ,'1');
            com_list =  dir([dataDirName,'com*.csv']);
            task_list =  dir([dataDirName,'task*.csv']);
            if ~isempty( strfind( config.examType, '追い込まれ') )...
                    || ~isempty( strfind( config.examType, '追い込む') )
                if ~isempty( task_list )
                    task_data = csvread([dataDirName,task_list.name],0,0);
                    if task_data(1,1) ~= 20
                        task_data(1,:)=[];
                    end
                    if task_data(end,1) ~= 60000
                        task_data(end,:)=[];
                    end
                    obj.com.time = task_data(:,1);
    %                 obj.com.avatarPosition = task_data(:,3);
    %                 obj.com.avatarVelocity = task_data(:,2);
                    obj.com.avatarPosition = task_data(:,2);
                    obj.com.avatarVelocity = task_data(:,6);
                end
                if ~isempty( com_list )
                    task_data2 = csvread([dataDirName,com_list.name],0,0);
                    if task_data2(1,1) ~= 20
                        task_data2(1,:)=[];
                    end
                    if task_data2(end,1) ~= 60000
                        task_data2(end,:)=[];
                    end
                    obj.com2.time = task_data2(:,1);
                    obj.com2.avatarPosition = task_data2(:,2);
                    obj.com2.avatarVelocity = task_data2(:,6);
                end
            end

            if ~isempty(findstr( char( config.examType) , '追従'))
                task_data = csvread([dataDirName, task_list.name],0,0);
                obj.task.const = task_data(1,:);
                taskData_ts = task_data(2:end,:);
                while taskData_ts(1,1) ~= 20
                    taskData_ts(1,:)=[];
                end
                obj.task.time = taskData_ts(:,1);
                obj.task.avatarPosition = taskData_ts(:,2);
                obj.task.otherData = taskData_ts(:,3:6);

%                     obj.task.avtActUnit
                j=1;
                bDirect = mean( obj.task.avatarPosition(1:10) ) - obj.task.avatarPosition(1) >0;
                obj.task.avtActUnit(1,1) = obj.task.time(1);
                if bDirect
                    obj.task.avtActUnit(1,3) = 1;
                else
                    obj.task.avtActUnit(1,3) = -1;
                end
                for i = 1:length(obj.task.time)
                    if bDirect && obj.task.avatarPosition(i) >= obj.task.otherData(i,2)
                        obj.task.avtActUnit(j,2) = obj.task.time(i);    %avtUnit end time
                        bDirect = false;        j=j+1;                  % next unit
                        obj.task.avtActUnit(j,3) = -1;
                        obj.task.avtActUnit(j,1) = obj.task.time(i)+20;
                    end
                    if ~bDirect && obj.task.avatarPosition(i) <= obj.task.otherData(i,1)
                        obj.task.avtActUnit(j,2) = obj.task.time(i);
                        bDirect = true;        j=j+1;
                        obj.task.avtActUnit(j,3) = 1;
                        obj.task.avtActUnit(j,1) = obj.task.time(i)+20;
                    end
                    signIndex(i,1)= obj.task.avtActUnit(j,3);
                end
                obj.task.avtActUnit(j,2) = config.timeLength;
                obj.task.avatarVelocity = obj.task.otherData(:,4) .* signIndex;
            end


       elseif config.isExistPlayer2() 
            obj.player2 = Models.RhythmAvatar_cpShift( config ,'2');

       end

           
           

end
