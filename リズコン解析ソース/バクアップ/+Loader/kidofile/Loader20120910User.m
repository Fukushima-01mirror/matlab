function [ obj ] = Loader20120910User( config )
%LOADER20120820 この関数の概要をここに記述
%   詳細説明をここに記述

obj = Models.Experiment();

deviceFileName = char(strcat(cd(),'\data\',config.fileName,'.csv'));
device = load(deviceFileName);

optiDirName = char(strcat(cd(),'\data\',config.fileName,'\'));


adFileName = char(strcat(cd(),'\data\',config.fileName,'\ad.csv'));
adOffsetCsv = importdata('ad.csv');
adOffset = mean(adOffsetCsv.data);

adData = importdata(adFileName);
adData.data(:, 1) = adData.data(:, 1) / 1000;

adCaribration =  [1 ...
    704.6969234 680.8358363 705.5169798 777.5147644 ...
    18908.59431 39860.36531 51835.79850 16838.46654 ...
    12985.88554 12891.85296 21198.05169 24627.38253 ...
    ...
    696.9379141 706.7056351 748.3413948 696.1289266 ...
    9827.121    19815.3984  17121.6358  14596.1732  ...
    21356.59377 15224.09441 15133.59702 21704.29744 ...
    ];


leftHandBoradWidth = 139;
leftHandBoradHeight = 228;
wiiBoadWidth = 430;
wiiBoadHeight = 240;


if config.isExistMaster();
    obj.master = Models.User();
    %device
    obj.master.device = Models.Device();
    obj.master.device.time = device(:, 1) / 1000;
    obj.master.device.rotate.x =  (device(:, 2) - 10000)  * 0.036;
    obj.master.device.rotate.z = - (device(:, 3) - 10000)  * 0.036;
    obj.master.device.force.x =  ((device(:, 4) - 8000) / 50) * 5 / 1024;
    obj.master.device.force.z = - ((device(:, 5) - 8000) / 50) * 5 / 1024;
    obj.master.device.offset(-0.04); %デバイスが0.04s早い
    
    %opti
    obj.master.opti = Models.OptiGroup(optiDirName,'1');
    obj.master.opti.transformFor20120910();

    %ad
    obj.master.adBoard = Models.AdBoardGroup();
    for i = 1:3
        board =  Models.AdBoard();
        board.time = adData.data(:, 1);        
        for j = 1:4
            num = (i-1) * 4 + j + 1 + 12;
            board.setData(j+1,(adData.data(:,num) - adOffset(num)) * adCaribration(num));
        end
        obj.master.adBoard.setData(i,board);
    end

    obj.master.adBoard.leftHand.width  =   leftHandBoradWidth; 
    obj.master.adBoard.leftHand.height =   leftHandBoradHeight; 
    obj.master.adBoard.seat.width      =   wiiBoadWidth; 
    obj.master.adBoard.seat.height     =   wiiBoadHeight; 
    obj.master.adBoard.foot.width      =   wiiBoadWidth; 
    obj.master.adBoard.foot.height     =   wiiBoadHeight; 
    obj.master.adBoard.leftHandPos.x = -112.5;
    obj.master.adBoard.leftHandPos.z = 440;
    obj.master.adBoard.footPos.x = 0;
    obj.master.adBoard.footPos.z = 350;
    
    
    obj.master.adBoard.seat.supplement(3); %右下補完
    %obj.master.adBoard.foot.supplement(2); %右上補完
    obj.master.adBoard.supplementFor20120910(50000);
    obj.master.adBoard.offset(-0.10); %asBoardが0.10s早い
end

if config.isExistSlave();
    obj.slave = Models.User();
    
    %device
    obj.slave.device = Models.Device();
    obj.slave.device.time = device(:, 1) / 1000;
    obj.slave.device.rotate.x =  (device(:, 6) - 10000)  * 0.036;
    obj.slave.device.rotate.z = - (device(:, 7) - 10000)  * 0.036;
    obj.slave.device.force.x =   ((device(:, 8) - 8000) / 50) * 5 / 1024;
    obj.slave.device.force.z =  - ((device(:, 9) - 8000) / 50) * 5 / 1024;
    obj.slave.device.offset(-0.04); %デバイスが0.04s早い

    %opti
    obj.slave.opti = Models.OptiGroup(optiDirName,'2');
    obj.slave.opti.transformFor20120910();

    %ad
    obj.slave.adBoard = Models.AdBoardGroup();
    for i = 1:3
        board =  Models.AdBoard();
        board.time = adData.data(:, 1);        
        for j = 1:4
            num = (i-1) * 4 + j + 1;
            board.setData(j+1,(adData.data(:,num) - adOffset(num)) * adCaribration(num));
        end
        obj.slave.adBoard.setData(i,board);
    end
    obj.slave.adBoard.leftHand.width  =   leftHandBoradWidth; 
    obj.slave.adBoard.leftHand.height =   leftHandBoradHeight; 
    obj.slave.adBoard.seat.width      =   wiiBoadWidth; 
    obj.slave.adBoard.seat.height     =   wiiBoadHeight; 
    obj.slave.adBoard.foot.width      =   wiiBoadWidth; 
    obj.slave.adBoard.foot.height     =   wiiBoadHeight; 
    
    obj.slave.convertFromSlaveToGlobal();
    obj.slave.adBoard.leftHandPos.x = 205.5;
    obj.slave.adBoard.leftHandPos.z = -440;
    obj.slave.adBoard.footPos.x = 0;
    obj.slave.adBoard.footPos.z = -350;
    obj.slave.adBoard.offset(-0.10); %asBoardが0.10s早い
    
    
end


obj.backupToRaw();
obj.removeDoubleData();
obj.offset(config.startTime);

if config.isExistMaster();
    obj.master.opti.removeErrors(2);
end
if config.isExistSlave();
    obj.slave.opti.removeErrors(2);
end
obj.spline();
obj.useLowpassFilter(config.lowpassSamplingTime,config.lowpassTc);

obj.splineTrim(0,config.timeLength);

if config.isExistMaster();
    obj.master.opti.yOffsetAvg();
end
if config.isExistSlave();
    obj.slave.opti.yOffsetAvg();
end
end
