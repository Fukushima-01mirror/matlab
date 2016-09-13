classdef OptiPulseanother_Hand < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = OptiPulseanother_Hand(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
          %%ファイル名設定
           optifilename = 'small1 2015-01-12 11.54.11 AM.csv';
           %Take 2014-11-20 11.13.37 PM.csv
           %dataname = 'DATA1_04.csv';
%%          Optiでのマーカーの変位
            optiData = xlsread(optifilename,1,'B46:C6045'); disp(0);
            optiData(1:6000,3) = xlsread(optifilename,1,'DL46:DL6045');disp('Rhand1x');
            optiData(1:6000,4) = xlsread(optifilename,1,'DM46:DM6045');disp('Rhand1y');
            optiData(1:6000,5) = xlsread(optifilename,1,'DN46:DN6045');disp('Rhand1z');
            
            optiData(1:6000,6) = xlsread(optifilename,1,'DQ46:DQ6045');disp('Rhand2x');
            optiData(1:6000,7) = xlsread(optifilename,1,'DR46:DR6045');disp('Rhand2y');
            optiData(1:6000,8) = xlsread(optifilename,1,'DS46:DS6045');disp('Rhand2z');
            
            optiData(1:6000,9) = xlsread(optifilename,1,'DV46:DV6045');disp('Rhand3x');
            optiData(1:6000,10) = xlsread(optifilename,1,'DW46:DW6045');disp('Rhand3y');
            optiData(1:6000,11) = xlsread(optifilename,1,'DX46:DX6045');disp('Rhand3z');
            
%             optiData(1:6000,12) = xlsread(optifilename,1,'U46:U6045');disp('Hip4x');
%             optiData(1:6000,13) = xlsread(optifilename,1,'V46:V6045');disp('Hip4y');
%             optiData(1:6000,14) = xlsread(optifilename,1,'W46:W6045');disp('Hip4z');
%             
%             optiData(1:6000,15) = xlsread(optifilename,1,'AO46:AO6045');disp('Chest4x');
%             optiData(1:6000,16) = xlsread(optifilename,1,'AP46:AP6045');disp('Chest4y');
%             optiData(1:6000,17) = xlsread(optifilename,1,'AQ46:AQ6045');disp('Chest4z');
%             
%             optiData(1:6000,18) = xlsread(optifilename,1,'BN46:BN6045');disp('Lshol2x');
%             optiData(1:6000,19) = xlsread(optifilename,1,'BO46:BO6045');disp('Lshol2y');
%             optiData(1:6000,20) = xlsread(optifilename,1,'BP46:BP6045');disp('Lshol2z');
            
            %optiData(1:6000,21) = xlsread(optifilename,1,'BS46:BS6045');disp('Luarm1x');
            %optiData(1:6000,22) = xlsread(optifilename,1,'BT46:BT6045');disp('Luarm1y');
            %optiData(1:6000,23) = xlsread(optifilename,1,'BU46:BU6045');disp('Luarm1z');
            
%             optiData(1:6000,21) = xlsread(optifilename,1,'CW46:CW6045');disp('Rshol2x');
%             optiData(1:6000,22) = xlsread(optifilename,1,'CX46:CX6045');disp('Rshol2y');
%             optiData(1:6000,23) = xlsread(optifilename,1,'CY46:CY6045');disp('Rshol2z');
            
            %optiData(1:6000,27) = xlsread(optifilename,1,'DB46:DB6045');disp('Ruarm1x');
            %optiData(1:6000,28) = xlsread(optifilename,1,'DC46:DC6045');disp('Ruarm1y');
            %optiData(1:6000,29) = xlsread(optifilename,1,'DD46:DD6045');disp('Ruarm1z');
            
%             optiData(1:6000,30) = xlsread(optifilename,1,'DL46:DL6045');disp('Rhand1x');
%             optiData(1:6000,31) = xlsread(optifilename,1,'DM46:DM6045');disp('Rhand1y');
%             optiData(1:6000,32) = xlsread(optifilename,1,'DN46:DN6045');disp('Rhand1z');
%             
%             optiData(1:6000,33) = xlsread(optifilename,1,'DQ46:DQ6045');disp('Rhand2x');
%             optiData(1:6000,34) = xlsread(optifilename,1,'DR46:DR6045');disp('Rhand2y');
%             optiData(1:6000,35) = xlsread(optifilename,1,'DS46:DS6045');disp('Rhand2z');
%             
%             optiData(1:6000,36) = xlsread(optifilename,1,'DV46:DV6045');disp('Rhand3x');
%             optiData(1:6000,37) = xlsread(optifilename,1,'DW46:DW6045');disp('Rhand3y');
%             optiData(1:6000,38) = xlsread(optifilename,1,'DX46:DX6045');disp('Rhand3z');
%             
%             optiData(1:6000,39) = xlsread(optifilename,1,'EF46:EF6045');disp('Lthi2x');
%             optiData(1:6000,40) = xlsread(optifilename,1,'EG46:EG6045');disp('Lthi2y');
%             optiData(1:6000,41) = xlsread(optifilename,1,'EH46:EH6045');disp('Lthi2z');
%             
%             optiData(1:6000,42) = xlsread(optifilename,1,'FJ46:FJ6045');disp('Rthi2x');
%             optiData(1:6000,43) = xlsread(optifilename,1,'FK46:FK6045');disp('Rthi2y');
%             optiData(1:6000,44) = xlsread(optifilename,1,'FL46:FL6045');disp('Rthi2z');
            
            
%             opti0(1,1:2) = xlsread(optifilename,1,'B45:C45');
%             opti0(1,3) = xlsread(optifilename,1,'F45');disp('ZEROHip1x');
%             opti0(1,4) = xlsread(optifilename,1,'G45');disp('ZEROHip1y');
%             opti0(1,5) = xlsread(optifilename,1,'H45');disp('ZEROHip1z');
%             opti0(1,6) = xlsread(optifilename,1,'K45');disp('ZEROHip2x');
%             opti0(1,7) = xlsread(optifilename,1,'L45');disp('ZEROHip2y');
%             opti0(1,8) = xlsread(optifilename,1,'M45');disp('ZEROHip2z');
%             opti0(1,9) = xlsread(optifilename,1,'P45');disp('ZEROHip3x');
%             opti0(1,10) = xlsread(optifilename,1,'Q45');disp('ZEROHip3y');
%             opti0(1,11) = xlsread(optifilename,1,'R45');disp('ZEROHip3z');
%             opti0(1,12) = xlsread(optifilename,1,'U45');disp('ZEROHip4x');
%             opti0(1,13) = xlsread(optifilename,1,'V45');disp('ZEROHip4y');
%             opti0(1,14) = xlsread(optifilename,1,'W45');disp('ZEROHip4z');
%             opti0(1,15) = xlsread(optifilename,1,'AO45');disp('ZEROChest4x');
%             opti0(1,16) = xlsread(optifilename,1,'AP45');disp('ZEROChest4y');
%             opti0(1,17) = xlsread(optifilename,1,'AQ45');disp('ZEROChest4z');
%             opti0(1,18) = xlsread(optifilename,1,'BN45');disp('ZEROLshol2x');
%             opti0(1,19) = xlsread(optifilename,1,'BO45');disp('ZEROLshol2y');
%             opti0(1,20) = xlsread(optifilename,1,'BP45');disp('ZEROLshol2z');
%             opti0(1,21) = xlsread(optifilename,1,'CW45');disp('ZEROLuarm1x');
%             opti0(1,22) = xlsread(optifilename,1,'CX45');disp('ZEROLuarm1y');
%             opti0(1,23) = xlsread(optifilename,1,'CY45');disp('ZEROLuarm1z');
%             opti0(1,24) = xlsread(optifilename,1,'CW45');disp('ZERORshol2x');
%             opti0(1,25) = xlsread(optifilename,1,'CX45');disp('ZERORshol2y');
%             opti0(1,26) = xlsread(optifilename,1,'CY45');disp('ZERORshol2z');
%             opti0(1,27) = xlsread(optifilename,1,'DB45');disp('ZERORuarm1x');
%             opti0(1,28) = xlsread(optifilename,1,'DC45');disp('ZERORuarm1y');
%             opti0(1,29) = xlsread(optifilename,1,'DD45');disp('ZERORuarm1z');
%             opti0(1,30) = xlsread(optifilename,1,'DL45');disp('ZERORhand1x');
%             opti0(1,31) = xlsread(optifilename,1,'DM45');disp('ZERORhand1y');
%             opti0(1,32) = xlsread(optifilename,1,'DN45');disp('ZERORhand1z');
%             opti0(1,33) = xlsread(optifilename,1,'DQ45');disp('ZERORhand2x');
%             opti0(1,34) = xlsread(optifilename,1,'DR45');disp('ZERORhand2y');
%             opti0(1,35) = xlsread(optifilename,1,'DS45');disp('ZERORhand2z');
%             opti0(1,36) = xlsread(optifilename,1,'DV45');disp('ZERORhand3x');
%             opti0(1,37) = xlsread(optifilename,1,'DW45');disp('ZERORhand3y');
%             opti0(1,38) = xlsread(optifilename,1,'DX45');disp('ZERORhand3z');
%             opti0(1,39) = xlsread(optifilename,1,'EF45');disp('ZEROLthi2x');
%             opti0(1,40) = xlsread(optifilename,1,'EG45');disp('ZEROLthi2y');
%             opti0(1,41) = xlsread(optifilename,1,'EH45');disp('ZEROLthi2z');
%             opti0(1,42) = xlsread(optifilename,1,'FJ45');disp('ZERORthi2x');
%             opti0(1,43) = xlsread(optifilename,1,'FK45');disp('ZERORthi2y');
%             opti0(1,44) = xlsread(optifilename,1,'FL45');disp('ZERORthi2z');
           
            
            disp('zeroEnd');
            
            
            MonitorSize = [ 0, 0, 800, 800];
            set(gcf, 'Position', MonitorSize);
            a1 = subplot( 3,1,1 );
            plot(0.01:0.01:60,optiData(1:6000,6),'k');
            %A = std((optiData(1:6000,3)+optiData(1:6000,6)+optiData(1:6000,9)+optiData(1:6000,12))/4);
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('RhandC-x');
            a2 = subplot( 3,1,2 );
            plot(0.01:0.01:60,optiData(1:6000,7),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('RhandC-y');
            a3 = subplot( 3,1,3 );
            plot(0.01:0.01:60,optiData(1:6000,8),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('RhandC-z');
            
            linkaxes([a1 a2 a3],'x');
            obj.saveGraphWithName(strcat('マーカー位置Hand',optifilename));
            
            
%              Exl = zeros(3000,1);
%              
%               for i =1:6000
%                 if(rem(i,2) == 0)
%                     Exl(i/2,1)=(optiData(i,3)+optiData(i,6)+optiData(i,9)+optiData(i,12))/4;
%                 end
%                 
%               end
%             
%             filename = strcat('体の向き',optifilename);
%             A = Exl;
%             sheet = 1;
%             xlRange = 'A1';
%             xlswrite(filename,A,sheet,xlRange)
            

                end
                
%                 PrePulPhase = zeros(60000,1);
%                 Pulse = zeros(1,1);
%                 PrePulPhase(1,1) = xlsread(dataname,1,'A1');
%                 RawPulPhase = xlsread(dataname,1,'B3:B60002');
%                 for j=1:59999
%                     PrePulPhase(j+1,1) = PrePulPhase(j,1) + RawPulPhase(j+1,1);
%                     if rem((j+1),20) == 0
%                         Pulse = vertcat(Pulse,PrePulPhase(j+1,1));
%                     end  
%                 end
%                 Pulse(1,:)=[];


        function runForPair(obj,user1 ,user2)
%             obj.runForAlone(user1);
%             obj.runForAlone(user2);
%             
            
        end
end
        
end