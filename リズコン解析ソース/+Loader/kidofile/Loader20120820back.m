function [ obj ] = Loader20120820( config )
%LOADER20120820 この関数の概要をここに記述
%   詳細説明をここに記述

           deviceFileName = char(strcat(cd(),'\data\',config.fileName,'.csv'));
           obj.device = Models.Device(deviceFileName);
           
           optiDirName = char(strcat(cd(),'\data\',config.fileName,'\'));           
           if config.isExistMaster();
                obj.master = Models.OptiGroup(optiDirName,'1');
                obj.master.offset(config.startTime);
                obj.master.trim(0,config.timeLength); 
                obj.master.body.removeErrors(3);
                obj.master.head.removeErrors(1.5);
                obj.master.rightHand.removeErrors(3);
                obj.master.yOffsetAvg();
                obj.master.spline();
           end
           
           if config.isExistSlave();
                obj.slave = Models.OptiGroup(optiDirName,'2');
                obj.slave.offset(config.startTime);
                obj.slave.trim(0,config.timeLength);       
                obj.slave.body.removeErrors(3);
                obj.slave.head.removeErrors(1.5);
                obj.slave.rightHand.removeErrors(3);
                obj.slave.yOffsetAvg();        
                obj.slave.spline(); 
           end
           

end
