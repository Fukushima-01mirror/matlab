classdef OptiPulseanother < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = OptiPulseanother(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
          %%ファイル名設定
           optifilename = '①-1 2015-01-11 04.59.03 PM.csv';
           %Take 2014-11-20 11.13.37 PM.csv
           %dataname = 'DATA1_04.csv';
%%          Optiでのマーカーの変位
            optiData = xlsread(optifilename,1,'B46:C6045'); disp(0);
            optiData(1:6000,3) = xlsread(optifilename,1,'F46:F6045');disp('Hip1x');
            optiData(1:6000,4) = xlsread(optifilename,1,'G46:G6045');disp('Hip1y');
            optiData(1:6000,5) = xlsread(optifilename,1,'H46:H6045');disp('Hip1z');
            
            optiData(1:6000,6) = xlsread(optifilename,1,'K46:K6045');disp('Hip2x');
            optiData(1:6000,7) = xlsread(optifilename,1,'L46:L6045');disp('Hip2y');
            optiData(1:6000,8) = xlsread(optifilename,1,'M46:M6045');disp('Hip2z');
            
            optiData(1:6000,9) = xlsread(optifilename,1,'P46:P6045');disp('Hip3x');
            optiData(1:6000,10) = xlsread(optifilename,1,'Q46:Q6045');disp('Hip3y');
            optiData(1:6000,11) = xlsread(optifilename,1,'R46:R6045');disp('Hip3z');
            
            optiData(1:6000,12) = xlsread(optifilename,1,'U46:U6045');disp('Hip4x');
            optiData(1:6000,13) = xlsread(optifilename,1,'V46:V6045');disp('Hip4y');
            optiData(1:6000,14) = xlsread(optifilename,1,'W46:W6045');disp('Hip4z');
            
            optiData(1:6000,15) = xlsread(optifilename,1,'AO46:AO6045');disp('Chest4x');
            optiData(1:6000,16) = xlsread(optifilename,1,'AP46:AP6045');disp('Chest4y');
            optiData(1:6000,17) = xlsread(optifilename,1,'AQ46:AQ6045');disp('Chest4z');
            
            optiData(1:6000,18) = xlsread(optifilename,1,'BN46:BN6045');disp('Lshol2x');
            optiData(1:6000,19) = xlsread(optifilename,1,'BO46:BO6045');disp('Lshol2y');
            optiData(1:6000,20) = xlsread(optifilename,1,'BP46:BP6045');disp('Lshol2z');
            
            %optiData(1:6000,21) = xlsread(optifilename,1,'BS46:BS6045');disp('Luarm1x');
            %optiData(1:6000,22) = xlsread(optifilename,1,'BT46:BT6045');disp('Luarm1y');
            %optiData(1:6000,23) = xlsread(optifilename,1,'BU46:BU6045');disp('Luarm1z');
            
            optiData(1:6000,21) = xlsread(optifilename,1,'CW46:CW6045');disp('Rshol2x');
            optiData(1:6000,22) = xlsread(optifilename,1,'CX46:CX6045');disp('Rshol2y');
            optiData(1:6000,23) = xlsread(optifilename,1,'CY46:CY6045');disp('Rshol2z');
            
   
            
            disp('zeroEnd');
            
            
            MonitorSize = [ 0, 0, 800, 800];
            set(gcf, 'Position', MonitorSize);
            a1 = subplot( 4,1,1 );
            plot(0.01:0.01:60,(optiData(1:6000,3)+optiData(1:6000,6)+optiData(1:6000,9)+optiData(1:6000,12))/4,'k');
            %A = std((optiData(1:6000,3)+optiData(1:6000,6)+optiData(1:6000,9)+optiData(1:6000,12))/4);
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);ylim([-0.15 0.15]);
            title('HipC-x');
            a2 = subplot( 4,1,2 );
            plot(0.01:0.01:60,(optiData(1:6000,4)+optiData(1:6000,7)+optiData(1:6000,10)+optiData(1:6000,13))/4,'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('HipC-y');
            a3 = subplot( 4,1,3 );
            plot(0.01:0.01:60,(optiData(1:6000,5)+optiData(1:6000,8)+optiData(1:6000,11)+optiData(1:6000,14))/4,'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('HipC-z');
            
            linkaxes([a1 a2 a3],'x');
            obj.saveGraphWithName(strcat('マーカー位置Hip',optifilename));
            
            
             Exl = zeros(3000,1);
             
              for i =1:6000
                if(rem(i,2) == 0)
                    Exl(i/2,1)=(optiData(i,3)+optiData(i,6)+optiData(i,9)+optiData(i,12))/4;
                end
                
              end
            
            filename = strcat('体の向き',optifilename);
            A = Exl;
            sheet = 1;
            xlRange = 'A1';
            xlswrite(filename,A,sheet,xlRange)
            

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