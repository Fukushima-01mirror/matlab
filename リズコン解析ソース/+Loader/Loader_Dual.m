function [ obj ] = Loader_Dual( config )
%LOADER20130515 この関数の概要をここに記述
% 剣道対戦
%   詳細説明をここに記述

%            deviceFileName = char(strcat(cd(),'\data\',config.fileName,'.csv'));
%            obj.device = Models.Device(deviceFileName);
           
            
    dataDirName = char(strcat(cd(),'\data\',config.fileName,'\'));           
           
    if config.isExistPlayer1() && config.isExistPlayer2()      %二人で実験 剣道
        match_list1 =  dir([dataDirName,'match_*.csv']);
        match_list2 =  dir([dataDirName,'match2P_*.csv']);

        if  ~isempty( match_list1 )          % 剣道試合情報1P
            match_data_1 = csvread([dataDirName, match_list1.name],2,0);
            %%csvファイルズレ修正
            if length(match_data_1(1,:)) > 3
                match_data_1(1,1) = match_data_1(1,2);
                match_data_1(1,2) = match_data_1(1,3);
                match_data_1(1,3) = match_data_1(1,4);
            end
            match_data_1(1,1) = 20;
            match_data_1(end,2) = 60000;
            match_data_1(end,3) = 0;
        end

        if  ~isempty( match_list2 )          % 剣道試合情報2P
            match_data_2 = csvread([dataDirName, match_list2.name],2,0);
            
            % csvファイルズレ修正
            if length(match_data_2(1,:)) > 3
                match_data_2(1,1) = match_data_2(1,2);
                match_data_2(1,2) = match_data_2(1,3);
                match_data_2(1,3) = match_data_2(1,4);
            end
            match_data_2(1,1) = 20;
            match_data_2(end,2) = 60000;
            match_data_2(end,3) = 0;
        end
        %% モデルデータ作成
        obj.player1 = Models.RhythmAvatar_splitTime(dataDirName , match_data_1 ,'1');
        if ~isempty( match_list2 )
            obj.player2 = Models.RhythmAvatar_splitTime(dataDirName , match_data_2 ,'3');   %遠隔用
        else
            obj.player2 = Models.RhythmAvatar_splitTime(dataDirName , match_data_1 ,'2');   %同場所用
        end
    else
        disp('Error: 剣道対戦のプレイヤーデータが足りない')
    end
end
