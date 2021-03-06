function [ obj ] = Loader20120910( config )
%LOADER20120820 この関数の概要をここに記述
%   詳細説明をここに記述

deviceFileName = char(strcat(cd(),'\data\',config.fileName,'.csv'));
obj.device = Models.Device(deviceFileName);


adFileName = char(strcat(cd(),'\data\',config.fileName,'\ad.csv'));
obj.adBoard = Models.AdBoard(adFileName);
obj.adBoard.useLowpassFilter(config.lowpassSamplingTime,config.lowpassTc);

optiDirName = char(strcat(cd(),'\data\',config.fileName,'\'));
if config.isExistMaster();
    obj.master = Models.OptiGroup(optiDirName,'1');


    obj.master.offset(config.startTime);
    obj.master.useLowpassFilter(config.lowpassSamplingTime,config.lowpassTc);
    obj.master.body.removeErrors(2);
    obj.master.head.removeErrors(2);
    obj.master.rightHand.removeErrors(2);
    obj.master.yOffsetAvg();
    obj.master.spline();
    obj.master.splineTrim(0,config.timeLength);
end

if config.isExistSlave();
    obj.slave = Models.OptiGroup(optiDirName,'2');
    obj.slave.offset(config.startTime);
    obj.slave.useLowpassFilter(0.01,0.11);
    obj.slave.body.removeErrors(2);
    obj.slave.head.removeErrors(2);
    obj.slave.rightHand.removeErrors(2);
    obj.slave.yOffsetAvg();
    obj.slave.spline();
    obj.slave.splineTrim(0,config.timeLength);
end


end
