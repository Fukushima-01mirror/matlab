classdef Config
%CONFIG このクラスの概要をここに記述
%   詳細説明をここに記述

   properties
       fileName
       player1UserName
       player2UserName
       player1ContParam
       player2ContParam
       examType
       timeLength
       archiveDataFileName
       saveDataDir
       analyzeTime
   end

   methods         
       % bool　データがあるかどうか？
       function bool = isExistPlayer1(obj)
            bool = sum(isnan(cell2mat(obj.player1UserName) )) == 0;
       end

       function bool = isExistPlayer2(obj)
            bool = sum(isnan(cell2mat(obj.player2UserName) )) == 0;
       end
       
       function bool = isExistArchiveData(obj)
            bool = sum(isnan(cell2mat(obj.archiveDataFileName) )) == 0;
       end

       %　ファイル名取得
       function name = filenameForBoth(obj)
          name = char(strcat(obj.fileName,'-',obj.player1UserName,'-',obj.player2UserName, '(',obj.examType,')'));
       end
       
       function name = filenameForPlayer1(obj)
          name = char(strcat(obj.fileName,'-',obj.player1UserName, '(',obj.examType,')'));
       end
       
       function name = filenameForPlayer2(obj)
          name = char(strcat(obj.fileName,'-',obj.player2UserName, '(',obj.examType,')'));
       end

       function name = filenameForArchive(obj)
          if obj.isExistPlayer1()
                name = char(strcat(obj.fileName,'-',obj.player1UserName,'-アーカイブ(',obj.examType,')'));
          elseif obj.isExistPlayer2()
                name = char(strcat(obj.fileName,'-アーカイブ-',obj.player2UserName, '(',obj.examType,')'));
          end
       end
       
   end
end 
