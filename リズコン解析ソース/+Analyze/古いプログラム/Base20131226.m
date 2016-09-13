classdef Base
%BASE ���̃N���X�̊T�v�������ɋL�q
%   �ڍא����������ɋL�q

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
%%      ��̓v���O�����̍\���@�v����
           if(obj.config.isExistPlayer1 )   % �v���C���[1
                if(obj.config.isExistArchiveData )   % �A�[�J�C�u:�v���C���[2
                    obj.currentRunType = Analyze.Base.runTypeArchive;
                    obj.runForAlone(obj.data.player1);
                else
                   obj.currentRunType = Analyze.Base.runTypePlayer1;
                   obj.runForAlone(obj.data.player1);
                end
           end
           if(obj.config.isExistPlayer2 )   % �v���C���[2
                if(obj.config.isExistArchiveData )   % �A�[�J�C�u:�v���C���[2
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

%%  ��͌��ʃO���t�o�͊֌W
%   �t�H���_��
       function name = folderName(obj)
           name  = strrep( class(obj), 'Analyze.', '');
           %strrep�@������u��
       end
%    �t�@�C����
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
       
%     �ۑ��p�X�\���@���@�v����       
       function name = saveFilePath(obj, ext)
         
         % ���������t�H���_�쐬
         if ~exist( [obj.config.saveDataDir ,'\', char(obj.config.examType)],'dir')
            mkdir( [obj.config.saveDataDir] , char(obj.config.examType));
         end
         % �v���C���[���t�H���_�쐬
         if obj.currentRunType == Analyze.Base.runTypeBoth   %2�v���C���[
             playerName = [char(obj.config.player1UserName) '-' char(obj.config.player2UserName)];
         elseif obj.currentRunType == obj.runTypePlayer1 ...    %1P���@�A�[�J�C�u������
                || ( obj.currentRunType == obj.runTypeArchive && obj.config.isExistPlayer1 )
             playerName = char(obj.config.player1UserName);
         elseif obj.currentRunType == obj.runTypePlayer2 ...    %2P���@�A�[�J�C�u������
                || ( obj.currentRunType == obj.runTypeArchive && obj.config.isExistPlayer2 )
             playerName = char(obj.config.player2UserName);
         end
         if ~exist( [obj.config.saveDataDir,'\', char(obj.config.examType),'\', playerName],'dir')
            mkdir( [obj.config.saveDataDir,'\', char(obj.config.examType)] , playerName);
         end
         % ��͖��t�H���_�쐬
         if ~exist([obj.config.saveDataDir,'\',char(obj.config.examType), '\', ...
                            playerName,'\', obj.folderName()],'dir' )
            mkdir([obj.config.saveDataDir,'\',char(obj.config.examType),'\', ...
                           playerName] , obj.folderName() );
         end
         
         name =  [obj.config.saveDataDir,'\', char(obj.config.examType),'\', ...
                    playerName,'\', obj.folderName(), '\' ,obj.saveFileName(ext)];
         
       end

% �O���t�ۑ�
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
         % �v���C���[���t�H���_�쐬
         if obj.currentRunType == Analyze.Base.runTypeBoth   %2�v���C���[
             playerName = [char(obj.config.player1UserName) '-' char(obj.config.player2UserName)];
         elseif obj.currentRunType == obj.runTypePlayer1 ...    %1P���@�A�[�J�C�u������
                || ( obj.currentRunType == obj.runTypeArchive && obj.config.isExistPlayer1 )
             playerName = char(obj.config.player1UserName);
         elseif obj.currentRunType == obj.runTypePlayer2 ...    %2P���@�A�[�J�C�u������
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

       %�f�[�^�ۑ�
       function saveTextData(obj, output, name)
            if ~exist( obj.saveFilePath('') ,'dir')
                mkdir(obj.saveFilePath(''));
            end
            dlmwrite( obj.saveFilePath(char(strcat('\',name,'.txt'))) , output , 'delimiter', '\t');
       end
       
       
%%  excel�f�[�^�o�͊֌W
       function outputAllToXls(obj, row, titles)
         global  outputArray;
         
         if ~exist([obj.config.saveDataDir,'\Execl�\�f�[�^'],'dir')
            mkdir([obj.config.saveDataDir],'Execl�\�f�[�^');
         end
         
         name = '';
         if obj.currentRunType == Analyze.Base.runTypeBoth
             name = [obj.config.saveDataDir '\Execl�\�f�[�^\' obj.folderName() '-' datestr( now, 'mmdd_HH')  '.xlsx'];
             storeName = obj.folderName();
         elseif obj.currentRunType == Analyze.Base.runTypePlayer1
             name = [obj.config.saveDataDir '\Execl�\�f�[�^\' obj.folderName() '-' datestr( now, 'mmdd_HH') '-Player1.xlsx'];
             storeName =  char(strcat(obj.folderName(),'Player1'));   
         elseif obj.currentRunType == Analyze.Base.runTypePlayer2 
             name = [obj.config.saveDataDir '\Execl�\�f�[�^\' obj.folderName() '-' datestr( now, 'mmdd_HH') '-Player2.xlsx'];
             storeName =  char(strcat(obj.folderName(),'Player2'));    
         elseif obj.currentRunType == Analyze.Base.runTypeArchive
             name = [obj.config.saveDataDir '\Execl�\�f�[�^\' obj.folderName() '-' datestr( now, 'mmdd_HH') '-Archive.xlsx'];
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
         
         if(isempty(output))        % ���g���Ȃ��Ƃ�
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
         

         if ~exist([obj.config.saveDataDir,'\Execl�\�f�[�^'],'dir')
            mkdir([obj.config.saveDataDir],'Execl�\�f�[�^');
         end
                  
         name = '';
         if obj.currentRunType == Analyze.Base.runTypeBoth
             name = [obj.config.saveDataDir '\Execl�\�f�[�^\' obj.folderName() '-' datestr( now, 'mmdd_HH')  '.xlsx'];
             storeName = obj.folderName();
         elseif obj.currentRunType == Analyze.Base.runTypePlayer1
             name = [obj.config.saveDataDir '\Execl�\�f�[�^\' obj.folderName() '-' datestr( now, 'mmdd_HH') '-Player1.xlsx'];
             storeName =  char(strcat(obj.folderName(),'Player1'));   
         elseif obj.currentRunType == Analyze.Base.runTypePlayer2 
             name = [obj.config.saveDataDir '\Execl�\�f�[�^\' obj.folderName() '-' datestr( now, 'mmdd_HH') '-Player2.xlsx'];
             storeName =  char(strcat(obj.folderName(),'Player2'));    
         elseif obj.currentRunType == Analyze.Base.runTypeArchive
             name = [obj.config.saveDataDir '\Execl�\�f�[�^\' obj.folderName() '-' datestr( now, 'mmdd_HH') '-Archive.xlsx'];
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
         
         if(isempty(output))        % ���g���Ȃ��Ƃ�
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
