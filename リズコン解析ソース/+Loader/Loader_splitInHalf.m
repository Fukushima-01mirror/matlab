function [ obj ] = Loader_splitInHalf( config )
%LOADER20130515 この関数の概要をここに記述
% 剣道対戦
%   詳細説明をここに記述

%            deviceFileName = char(strcat(cd(),'\data\',config.fileName,'.csv'));
%            obj.device = Models.Device(deviceFileName);
           
           dataDirName = char(strcat(cd(),'\data\',config.fileName,'\'));           
           
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
           
           
           

end
