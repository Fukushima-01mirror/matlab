classdef ConfigGroup_Km
%CONFIG このクラスの概要をここに記述
%   詳細説明をここに記述

   properties (Constant)
       columnIndexFileName        = 1
       columnIndexPlayer1UserName  = 2
       columnIndexPlayer2UserName   = 8
       columnIndexExamType        = 14
       columnIndexTimeLength      = 15
       columnIndexArchiveDataFileName      = 16
   end
   
   
   properties
       num
       txt
       raw
       configs
   end

   methods 
       
       function obj = ConfigGroup_Km(filename, saveDataDir)
            [obj.num, obj.txt, obj.raw] = xlsread(filename);
            for i = 1 : obj.length()
                c = Models.Config();        %configクラス
                %文字列はgetData関数で，数値はcell2matでデータ取得
                c.fileName = obj.getData(i, Models.ConfigGroup_Km.columnIndexFileName);
                c.player1UserName = obj.getData(i, Models.ConfigGroup_Km.columnIndexPlayer1UserName);
                c.player2UserName = obj.getData(i, Models.ConfigGroup_Km.columnIndexPlayer2UserName);
                c.examType = obj.getData(i, Models.ConfigGroup_Km.columnIndexExamType);
                c.timeLength = cell2mat(obj.getData(i, Models.ConfigGroup_Km.columnIndexTimeLength));
                c.archiveDataFileName = obj.getData(i, Models.ConfigGroup_Km.columnIndexArchiveDataFileName);
                
                c.player1ContParam = cell2mat( obj.raw(i+1,3:7) );
                contParam1 = [ num2str( c.player1ContParam(1) ) '_' num2str( c.player1ContParam(2) ) ...
                                    '_' num2str( c.player1ContParam(3) ) '_' num2str( c.player1ContParam(4) ) '_' num2str( c.player1ContParam(5) ) ];
                c.player2ContParam = cell2mat( obj.raw(i+1,9:13) );
                contParam2 = [ num2str( c.player2ContParam(1) ) '_' num2str( c.player2ContParam(2) ) ...
                                    '_' num2str( c.player2ContParam(3) ) '_' num2str( c.player2ContParam(4) ) '_' num2str( c.player2ContParam(5) ) ];
                if ~c.isExistPlayer2()
                    c.saveDataDir = [saveDataDir '_alone1P(' contParam1 ')' ];
                end
                if ~c.isExistPlayer1()
                    c.saveDataDir = [saveDataDir '_alone2P(' contParam2 ')' ];
                end
                if c.isExistPlayer1() && c.isExistPlayer2()
                    c.saveDataDir = [saveDataDir '_pair(' contParam1 '-' contParam2 ')' ];
                end
                c.analyzeTime =[ 5000 , c.timeLength ];
                configs(i) = c;
            end
            obj.configs = configs;
        end
        
        function data = getData(obj, row, index)
            data = obj.raw(row + 1, index);
        end
        
        function data = length(obj)
            data = length(obj.raw(:,1)) - 1;
        end

   end
end 
