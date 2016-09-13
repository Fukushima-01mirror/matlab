classdef Base
%BASE このクラスの概要をここに記述
%   詳細説明をここに記述

   properties (Constant)
       runTypeBoth    = 1
       runTypePlayer1  = 2
       runTypePlayer2   = 3
       runTypeArchive   = 4
   end
   
   properties
       data 
       config
       currentRunType
   end

   methods
       function obj = Base(config, data )
           obj.config = config;
           obj.data = data;
       end

       function start(obj)
%%      解析プログラムの構造　要検討
           if(obj.config.isExistPlayer1 )   % プレイヤー1
                if(obj.config.isExistArchiveData )   % アーカイブ:プレイヤー2
                    obj.currentRunType = Analyze.Base.runTypeArchive;
                    obj.runForAlone(obj.data.player1);
                else
                   obj.currentRunType = Analyze.Base.runTypePlayer1;
                   obj.runForAlone(obj.data.player1);
                end
           end
           if(obj.config.isExistPlayer2 )   % プレイヤー2
                if(obj.config.isExistArchiveData )   % アーカイブ:プレイヤー2
                        obj.currentRunType = Analyze.Base.runTypeArchive;
                        obj.runForAlone(obj.data.player2);
                else
                       obj.currentRunType = Analyze.Base.runTypePlayer2;
                       obj.runForAlone(obj.data.player2);
                end
           end
                   
                   
           if(obj.config.isExistPlayer1 && obj.config.isExistPlayer2 )  %1P & 2P
               obj.currentRunType = Analyze.Base.runTypeBoth;
               obj.runForPair(obj.data.player1, obj.data.player2);
           end
           
       end

       function runForPair(obj,user1,user2)
       end
       
       function runForAlone(obj,user)
       end

%%  解析結果グラフ出力関係
%   フォルダ名
       function name = folderName(obj)
           name  = strrep( class(obj), 'Analyze.', '');
           %strrep　文字列置換
       end
%    ファイル名
       function name = saveFileName(obj, ext)
         if obj.currentRunType == Analyze.Base.runTypeBoth
            name = char(strcat(obj.config.filenameForBoth(),ext));
         elseif obj.currentRunType == Analyze.Base.runTypePlayer1
            name = char(strcat(obj.config.filenameForPlayer1(),ext));             
         elseif obj.currentRunType == Analyze.Base.runTypePlayer2
            name = char(strcat(obj.config.filenameForPlayer2(),ext));             
         elseif obj.currentRunType == Analyze.Base.runTypeArchive
            name = char(strcat(obj.config.filenameForArchive(),ext));             
         end
       end
       
%     保存パス構造　←　要検討       
       function name = saveFilePath(obj, ext)
         
         % 実験条件フォルダ作成
         if ~exist( [obj.config.saveDataDir ,'\', char(obj.config.examType)],'dir')
            mkdir( [obj.config.saveDataDir] , char(obj.config.examType));
         end
         % プレイヤー名フォルダ作成
         if obj.currentRunType == Analyze.Base.runTypeBoth   %2プレイヤー
             playerName = [char(obj.config.player1UserName) '-' char(obj.config.player2UserName)];
         elseif obj.currentRunType == obj.runTypePlayer1 ...    %1P名　アーカイブ実験も
                || ( obj.currentRunType == obj.runTypeArchive && obj.config.isExistPlayer1 )
             playerName = char(obj.config.player1UserName);
         elseif obj.currentRunType == obj.runTypePlayer2 ...    %2P名　アーカイブ実験も
                || ( obj.currentRunType == obj.runTypeArchive && obj.config.isExistPlayer2 )
             playerName = char(obj.config.player2UserName);
         end
         if ~exist( [obj.config.saveDataDir,'\', char(obj.config.examType),'\', playerName],'dir')
            mkdir( [obj.config.saveDataDir,'\', char(obj.config.examType)] , playerName);
         end
         % 解析名フォルダ作成
         if ~exist([obj.config.saveDataDir,'\',char(obj.config.examType), '\', ...
                            playerName,'\', obj.folderName()],'dir' )
            mkdir([obj.config.saveDataDir,'\',char(obj.config.examType),'\', ...
                           playerName] , obj.folderName() );
         end
         
         name =  [obj.config.saveDataDir,'\', char(obj.config.examType),'\', ...
                    playerName,'\', obj.folderName(), '\' ,obj.saveFileName(ext)];
         
       end

% グラフ保存
       function saveGraph(obj)
            set(gcf, 'Name', obj.saveFileName(''));
            saveas(gcf, obj.saveFilePath('.fig'));
            hgexport(gcf, obj.saveFilePath('.png'),hgexport('factorystyle'),'Format','png');
            hgexport(gcf, obj.saveFilePath('.emf'),hgexport('factorystyle'),'Format','meta');
            clf;
       end
       
       function saveGraphWithName(obj,name)
            set(gcf, 'Name', obj.saveFileName(''));
            saveas(gcf, obj.saveFilePath(char(strcat(name,'.fig'))));
            hgexport(gcf, obj.saveFilePath(char(strcat(name,'.png'))) ,hgexport('factorystyle'),'Format','png' );
            hgexport(gcf, obj.saveFilePath(char(strcat(name,'.emf'))) ,hgexport('factorystyle'),'Format','meta' );
            clf;
       end
       
       function saveGraphWithNameToFolder(obj,name)
         % プレイヤー名フォルダ作成
         if obj.currentRunType == Analyze.Base.runTypeBoth   %2プレイヤー
             playerName = [char(obj.config.player1UserName) '-' char(obj.config.player2UserName)];
         elseif obj.currentRunType == obj.runTypePlayer1 ...    %1P名　アーカイブ実験も
                || ( obj.currentRunType == obj.runTypeArchive && obj.config.isExistPlayer1 )
             playerName = char(obj.config.player1UserName);
         elseif obj.currentRunType == obj.runTypePlayer2 ...    %2P名　アーカイブ実験も
                || ( obj.currentRunType == obj.runTypeArchive && obj.config.isExistPlayer2 )
             playerName = char(obj.config.player2UserName);
         end
         if ~exist([obj.config.saveDataDir,'\', char(obj.config.examType), '\', ...
                            playerName,'\', obj.folderName() ,'\' ,obj.saveFileName('')],'dir' )
            mkdir([obj.config.saveDataDir,'\', char(obj.config.examType), '\', ...
                            playerName,'\', obj.folderName() ], obj.saveFileName('') );
         end
         
        set(gcf, 'Name', obj.saveFileName(''));
%         saveas(gcf,  obj.saveFilePath(char(strcat( ['\' name],'.fig'))));
        hgexport(gcf,  obj.saveFilePath(char(strcat( ['\' name],'.png'))) ,hgexport('factorystyle'),'Format','png' );
%         hgexport(gcf,  obj.saveFilePath(char(strcat( ['\' name],'.emf'))),hgexport('factorystyle'),'Format','meta' );
        clf;
       end

       %データ保存
       function saveTextData(obj, output, name)
            if ~exist( obj.saveFilePath('') ,'dir')
                mkdir(obj.saveFilePath(''));
            end
            dlmwrite( obj.saveFilePath(char(strcat('\',name,'.txt'))) , output , 'delimiter', '\t');
       end
       
       
%%  excelデータ出力関係
       function outputAllToXls(obj, row, titles)
         global  outputArray;
         
         if ~exist([obj.config.saveDataDir,'\Execl表データ'],'dir')
            mkdir([obj.config.saveDataDir],'Execl表データ');
         end
         
         name = '';
         if obj.currentRunType == Analyze.Base.runTypeBoth
             name = [obj.config.saveDataDir '\Execl表データ\' obj.folderName() '-' datestr( now, 'mmdd_HH')  '.xlsx'];
             storeName = obj.folderName();
         elseif obj.currentRunType == Analyze.Base.runTypePlayer1
             name = [obj.config.saveDataDir '\Execl表データ\' obj.folderName() '-' datestr( now, 'mmdd_HH') '-Player1.xlsx'];
             storeName =  char(strcat(obj.folderName(),'Player1'));   
         elseif obj.currentRunType == Analyze.Base.runTypePlayer2 
             name = [obj.config.saveDataDir '\Execl表データ\' obj.folderName() '-' datestr( now, 'mmdd_HH') '-Player2.xlsx'];
             storeName =  char(strcat(obj.folderName(),'Player2'));    
         elseif obj.currentRunType == Analyze.Base.runTypeArchive
             name = [obj.config.saveDataDir '\Execl表データ\' obj.folderName() '-' datestr( now, 'mmdd_HH') '-Archive.xlsx'];
             storeName =  char(strcat(obj.folderName(),'Archive'));    
         end
         
         if( isfield(outputArray,storeName))
            output = outputArray.(storeName);
         else
             if(exist(name,'file'))
                delete(name);
             end
            output = {};
         end
         
         if(isempty(output))        % 中身がないとき
             output = cell(1,length(titles)+1);
             for i = 1:length(row)
                    output(1,i+1) = cellstr(titles(1,i));
             end
         end
         rowNo = length( output(:,1)) + 1;
         output(rowNo,1) = cellstr( obj.saveFileName('') );
         for i = 1:length(row)
             
             if ischar( row(1,i) )
                output(rowNo,i+1) = cellstr( row(1,i) );
             else
                output(rowNo,i+1) = row(1,i);
             end
             
         end
         xlswrite(name,output);
         outputArray.(storeName) = output;
       end
       
%%
       function outputAllToXlsWithName(obj, subName , row, titles)
         global  outputArray;
         

         if ~exist([obj.config.saveDataDir,'\Execl表データ'],'dir')
            mkdir([obj.config.saveDataDir],'Execl表データ');
         end
                  
         name = '';
         if obj.currentRunType == Analyze.Base.runTypeBoth
             name = [obj.config.saveDataDir '\Execl表データ\' obj.folderName() '-' datestr( now, 'mmdd_HH')  '.xlsx'];
             storeName = obj.folderName();
         elseif obj.currentRunType == Analyze.Base.runTypePlayer1
             name = [obj.config.saveDataDir '\Execl表データ\' obj.folderName() '-' datestr( now, 'mmdd_HH') '-Player1.xlsx'];
             storeName =  char(strcat(obj.folderName(),'Player1'));   
         elseif obj.currentRunType == Analyze.Base.runTypePlayer2 
             name = [obj.config.saveDataDir '\Execl表データ\' obj.folderName() '-' datestr( now, 'mmdd_HH') '-Player2.xlsx'];
             storeName =  char(strcat(obj.folderName(),'Player2'));    
         elseif obj.currentRunType == Analyze.Base.runTypeArchive
             name = [obj.config.saveDataDir '\Execl表データ\' obj.folderName() '-' datestr( now, 'mmdd_HH') '-Archive.xlsx'];
             storeName =  char(strcat(obj.folderName(),'Archive'));    
         end
         
         if( isfield(outputArray,storeName))
            output = outputArray.(storeName);
         else
             if(exist(name,'file'))
                delete(name);
             end
            output = {};
         end
         
         if(isempty(output))        % 中身がないとき
             output = cell(1,length(titles)+1);
             for i = 1:length(row)
                    output(1,i+1) = cellstr(titles(1,i));
             end
         end
         rowNo = length( output(:,1)) + 1;
         output(rowNo,1) = cellstr( obj.saveFileName( subName ) );
         for i = 1:length(row)
             if ischar( row(1,i) )
                output(rowNo,i+1) = cellstr( row(1,i) );
             else
                output(rowNo,i+1) = row(1,i);
             end
         end
         xlswrite(name,output);
         outputArray.(storeName) = output;
       end       
       
       
   end
end 
