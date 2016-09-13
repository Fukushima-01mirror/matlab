function [ obj ] = Loader_FreeOrPress( config )
%LOADER20130515 ���̊֐��̊T�v�������ɋL�q
% ���[�_�[�t�H�����[�����@�A�[�J�C�u�@or�@�l
%   �ڍא����������ɋL�q

%            deviceFileName = char(strcat(cd(),'\data\',config.fileName,'.csv'));
%            obj.device = Models.Device(deviceFileName);
           
           dataDirName = char(strcat(cd(),'\data\',config.fileName,'\'));           
           
           if config.isExistPlayer1() && config.isExistPlayer2()      %��l�Ŏ�����
                obj.player1 = Models.RhythmAvatar(dataDirName,'1');
                obj.player2 = Models.RhythmAvatar(dataDirName,'2');
                
           elseif config.isExistPlayer1() && config.isExistArchiveData      % �A�[�J�C�u
                obj.player1 = Models.RhythmAvatar(dataDirName,'1');
                archiveVarFilename = char(strcat(cd(),'\vars\',config.archiveDataFileName,'.mat'));
                load(archiveVarFilename,'data');
                obj.archive = data.player2;
           elseif config.isExistPlayer2() && config.isExistArchiveData      % �A�[�J�C�u
                obj.player2 = Models.RhythmAvatar(dataDirName,'2');
                archiveVarFilename = char(strcat(cd(),'\vars\',config.archiveDataFileName,'.mat'));
                load(archiveVarFilename,'data');
                obj.archive = data.player1;
           elseif config.isExistPlayer1() 
                obj.player1 = Models.RhythmAvatar(dataDirName,'1');
                if strcmp( config.examType, '�ǂ����܂����')...
                        || strcmp( config.examType, '�ǂ����ގ���')
                    
                    com_list =  dir([dataDirName,'com*.csv']);
                    task_list =  dir([dataDirName,'task*.csv']);
                    
                    if ~isempty( com_list )
                        task_data = csvread([dataDirName,com_list.name],0,0);
                        if task_data(1,1) ~= 20
                            task_data(1,:)=[];
                        end
                        if task_data(end,1) ~= 60000
                            task_data(end,:)=[];
                        end
                    end
                    
                    if ~isempty( task_list )
                        task_data = csvread([dataDirName,task_list.name],0,0);
                        if task_data(1,1) ~= 20
                            task_data(1,:)=[];
                        end
                        if task_data(end,1) ~= 60000
                            task_data(end,:)=[];
                        end
                    end
                    obj.com.time = task_data(:,1);
                    obj.com.avatarPosition = task_data(:,3);
                    obj.com.avatarVelocity = task_data(:,2);
                end

           elseif config.isExistPlayer2() 
                obj.player2 = Models.RhythmAvatar(dataDirName,'2');
               
           end
           
           
           

end
