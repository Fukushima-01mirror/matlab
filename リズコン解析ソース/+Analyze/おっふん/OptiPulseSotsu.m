classdef OptiPulseSotsu < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = OptiPulseSotsu(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
          %%ファイル名設定
           optifilename = '3d12.csv';
           %Take 2014-11-20 11.13.37 PM.csv
           %dataname = 'DATA1_04.csv';
%%          Optiでのマーカーの変位
            optiData = xlsread(optifilename,1,'A252:A3001'); disp(0);
            optiData(1:2750,2) = xlsread(optifilename,1,'B252:B3001');disp('AvatarPositionReading');
            optiData(1:2750,3) = xlsread(optifilename,1,'E252:E3001');disp('HipPositionReading');
%             optiData(1:6000,5) = xlsread(optifilename,1,'H46:H6045');disp('Hip1z');
%             
%             optiData(1:6000,6) = xlsread(optifilename,1,'K46:K6045');disp('Hip2x');
%             optiData(1:6000,7) = xlsread(optifilename,1,'L46:L6045');disp('Hip2y');
%             optiData(1:6000,8) = xlsread(optifilename,1,'M46:M6045');disp('Hip2z');
%             
%             optiData(1:6000,9) = xlsread(optifilename,1,'P46:P6045');disp('Hip3x');
%             optiData(1:6000,10) = xlsread(optifilename,1,'Q46:Q6045');disp('Hip3y');
%             optiData(1:6000,11) = xlsread(optifilename,1,'R46:R6045');disp('Hip3z');
%             
%             optiData(1:6000,12) = xlsread(optifilename,1,'U46:U6045');disp('Hip4x');
%             optiData(1:6000,13) = xlsread(optifilename,1,'V46:V6045');disp('Hip4y');
%             optiData(1:6000,14) = xlsread(optifilename,1,'W46:W6045');disp('Hip4z');
%             
            
            disp('EndReading');
            
            
            MonitorSize = [ 0, 0, 800, 800];
            set(gcf, 'Position', MonitorSize);
%             plot(0.01:0.01:60,(optiData(1:6000,3)+optiData(1:6000,6)+optiData(1:6000,9)+optiData(1:6000,12))/4,'k');
            %A = std((optiData(1:6000,3)+optiData(1:6000,6)+optiData(1:6000,9)+optiData(1:6000,12))/4);
%             xlabel('時間t ms'); ylabel('マーカー位置');
%             xlim([0 60000]);
            %ylim([-0.15 0.15]);
%             title('HipC-x');
            
            x = 5020:20:60000;
                y1 = optiData(:,2);
                y2 = optiData(:,3);
                a1=subplot(3,1,1);
                %set(get(gcf,'Title'),'Color','k')
%                 set(get(gcf,'XLabel'),'Color','k')
%                 set(get(gcf,'YLabel'),'Color','k')
                [a1,hLine1,hLine2] = plotyy(x,y1,x,y2);
                 set(hLine1,'Color','k');
                 set(hLine2,'Color','r');
                 set(a1,'YColor','k');
                 set(a1,'YColor','k');
                 set(a1(1),'XLim',[5000 60000]);
                 set(a1(2),'XLim',[5000 60000]);
                 xlabel('時間t ms'); 
                
            saveas(gcf,strcat('卒論に使う図',optifilename,'.jpg'));
 
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