function [ obj ] = Loader20130515( config )
%LOADER20130515 この関数の概要をここに記述
% リーダーフォロワー実験　アーカイブ　or　人
%   詳細説明をここに記述

%            deviceFileName = char(strcat(cd(),'\data\',config.fileName,'.csv'));
%            obj.device = Models.Device(deviceFileName);
           
           dataDirName = char(strcat(cd(),'\data\',config.fileName,'\'));           
           
           if config.isExistPlayer1() && config.isExistPlayer2()      %二人で実験の
                obj.player1 = Models.RhythmAvatar(dataDirName,'1');
                obj.player2 = Models.RhythmAvatar(dataDirName,'2');
                
           elseif config.isExistPlayer1() && config.isExistArchiveData      % アーカイブ
                obj.player1 = Models.RhythmAvatar(dataDirName,'1');
                archiveVarFilename = char(strcat(cd(),'\vars\',config.archiveDataFileName,'.mat'));
                load(archiveVarFilename,'data');
                obj.archive = data.player2;
           elseif config.isExistPlayer2() && config.isExistArchiveData      % アーカイブ
                obj.player2 = Models.RhythmAvatar(dataDirName,'2');
                archiveVarFilename = char(strcat(cd(),'\vars\',config.archiveDataFileName,'.mat'));
                load(archiveVarFilename,'data');
                obj.archive = data.player1;
           end
           
           
%                obj.master = Models.OptiGroup(dataDirName,'1');
%                obj.master.offset(config.startTime);
%                obj.master.trim(0,config.timeLength); 
%                obj.master.body.removeErrors(3);
%                obj.master.head.removeErrors(1.5);
%                obj.master.rightHand.removeErrors(3);
%                obj.master.yOffsetAvg();
%                obj.master.spline();
           

end
