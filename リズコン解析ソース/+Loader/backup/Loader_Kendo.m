function [ obj ] = Loader_Kendo( config )
%LOADER20130515 この関数の概要をここに記述
% 剣道対戦
%   詳細説明をここに記述

%            deviceFileName = char(strcat(cd(),'\data\',config.fileName,'.csv'));
%            obj.device = Models.Device(deviceFileName);
           
           dataDirName = char(strcat(cd(),'\data\',config.fileName,'\'));           
           
           if config.isExistPlayer1() && config.isExistPlayer2()      %二人で実験 剣道
                match_list =  dir([dataDirName,'match*.csv']);

                if  ~isempty( match_list )          % 剣道試合情報
                    match_data = csvread([dataDirName, match_list.name],2,0);
                    %%csvファイルズレ修正
                    if length(match_data(1,:)) > 3
                        match_data(1,1) = match_data(1,2);
                        match_data(1,2) = match_data(1,3);
                        match_data(1,3) = match_data(1,4);
                    end
                    match_data(1,1) = 20;
                    match_data(end,2) = 60000;
                    match_data(end,3) = 0;
                end
                
                obj.player1 = Models.RhythmAvatar_splitTime(dataDirName , match_data ,'1');
                obj.player2 = Models.RhythmAvatar_splitTime(dataDirName , match_data ,'2');
               
           else
               disp('Error: 剣道対戦のプレイヤーデータが足りない')

           end
           
           
           

end
