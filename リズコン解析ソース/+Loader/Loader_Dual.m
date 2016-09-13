function [ obj ] = Loader_Dual( config )
%LOADER20130515 ���̊֐��̊T�v�������ɋL�q
% �����ΐ�
%   �ڍא����������ɋL�q

%            deviceFileName = char(strcat(cd(),'\data\',config.fileName,'.csv'));
%            obj.device = Models.Device(deviceFileName);
           
            
    dataDirName = char(strcat(cd(),'\data\',config.fileName,'\'));           
           
    if config.isExistPlayer1() && config.isExistPlayer2()      %��l�Ŏ��� ����
        match_list1 =  dir([dataDirName,'match_*.csv']);
        match_list2 =  dir([dataDirName,'match2P_*.csv']);

        if  ~isempty( match_list1 )          % �����������1P
            match_data_1 = csvread([dataDirName, match_list1.name],2,0);
            %%csv�t�@�C���Y���C��
            if length(match_data_1(1,:)) > 3
                match_data_1(1,1) = match_data_1(1,2);
                match_data_1(1,2) = match_data_1(1,3);
                match_data_1(1,3) = match_data_1(1,4);
            end
            match_data_1(1,1) = 20;
            match_data_1(end,2) = 60000;
            match_data_1(end,3) = 0;
        end

        if  ~isempty( match_list2 )          % �����������2P
            match_data_2 = csvread([dataDirName, match_list2.name],2,0);
            
            % csv�t�@�C���Y���C��
            if length(match_data_2(1,:)) > 3
                match_data_2(1,1) = match_data_2(1,2);
                match_data_2(1,2) = match_data_2(1,3);
                match_data_2(1,3) = match_data_2(1,4);
            end
            match_data_2(1,1) = 20;
            match_data_2(end,2) = 60000;
            match_data_2(end,3) = 0;
        end
        %% ���f���f�[�^�쐬
        obj.player1 = Models.RhythmAvatar_splitTime(dataDirName , match_data_1 ,'1');
        if ~isempty( match_list2 )
            obj.player2 = Models.RhythmAvatar_splitTime(dataDirName , match_data_2 ,'3');   %���u�p
        else
            obj.player2 = Models.RhythmAvatar_splitTime(dataDirName , match_data_1 ,'2');   %���ꏊ�p
        end
    else
        disp('Error: �����ΐ�̃v���C���[�f�[�^������Ȃ�')
    end
end
