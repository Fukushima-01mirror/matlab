classdef ConfigGroup
%CONFIG このクラスの概要をここに記述
%   詳細説明をここに記述

   properties (Constant)
       columnIndexFileName        = 1
       columnIndexPlayer1UserName  = 2
       columnIndexPlayer2UserName   = 7
       columnIndexExamType        = 12
       columnIndexTimeLength      = 13
       columnIndexArchiveDataFileName      = 14
   end
   
   
   properties
       num
       txt
       raw
       configs
   end

   methods 
       
       function obj = ConfigGroup(filename, saveDataDir)
            [obj.num, obj.txt, obj.raw] = xlsread(filename);
            for i = 1 : obj.length()
                c = Models.Config();        %configクラス
                %文字列はgetData関数で，数値はcell2matでデータ取得
                c.fileName = obj.getData(i, Models.ConfigGroup.columnIndexFileName);
                c.player1UserName = obj.getData(i, Models.ConfigGroup.columnIndexPlayer1UserName);
                c.player2UserName = obj.getData(i, Models.ConfigGroup.columnIndexPlayer2UserName);
                c.examType = obj.getData(i, Models.ConfigGroup.columnIndexExamType);
                c.timeLength = cell2mat(obj.getData(i, Models.ConfigGroup.columnIndexTimeLength));
                c.archiveDataFileName = obj.getData(i, Models.ConfigGroup.columnIndexArchiveDataFileName);
                c.player1ContParam = cell2mat( obj.raw(i+1,3:6) );
                contParam1 = [ num2str( c.player1ContParam(1) ) '_' num2str( c.player1ContParam(2) ) ...
                                    '_' num2str( c.player1ContParam(3) ) '_' num2str( c.player1ContParam(4) ) ];
                c.player2ContParam = cell2mat( obj.raw(i+1,8:11) );
                contParam2 = [ num2str( c.player2ContParam(1) ) '_' num2str( c.player2ContParam(2) ) ...
                                    '_' num2str( c.player2ContParam(3) ) '_' num2str( c.player2ContParam(4) ) ];
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
