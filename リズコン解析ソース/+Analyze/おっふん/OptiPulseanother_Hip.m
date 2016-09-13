classdef OptiPulseanother_Hip < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = OptiPulseanother_Hip(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
          %%ファイル名設定
           optifilename = '⑲.csv';
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
            
            
            disp('zeroEnd');
            
            
            MonitorSize = [ 0, 0, 800, 800];
            set(gcf, 'Position', MonitorSize);
            a1 = subplot( 3,1,1 );
            plot(0.01:0.01:60,(optiData(1:6000,3)+optiData(1:6000,6)+optiData(1:6000,9)+optiData(1:6000,12))/4,'k');
            %A = std((optiData(1:6000,3)+optiData(1:6000,6)+optiData(1:6000,9)+optiData(1:6000,12))/4);
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            %ylim([-0.15 0.15]);
            title('HipC-x');
            a2 = subplot( 3,1,2 );
            plot(0.01:0.01:60,(optiData(1:6000,4)+optiData(1:6000,7)+optiData(1:6000,10)+optiData(1:6000,13))/4,'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('HipC-y');
            a3 = subplot( 3,1,3 );
            plot(0.01:0.01:60,(optiData(1:6000,5)+optiData(1:6000,8)+optiData(1:6000,11)+optiData(1:6000,14))/4,'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('HipC-z');
            
            linkaxes([a1 a2 a3],'x');
            obj.saveGraphWithName(strcat('マーカー位置Hip',optifilename));
            %saveas(strcat('マーカー位置Hip',optifilename));
            
             %Exl = zeros(3000,1);
             Exl = zeros(3000,3);
             %Exl = zeros(6000,3);
             
              for i =1:6000
               if rem(i,2) == 0
                    Exl(i/2,1)=(optiData(i,3)+optiData(i,6)+optiData(i,9)+optiData(i,12))/4;
                    Exl(i/2,2)=(optiData(i,4)+optiData(i,7)+optiData(i,10)+optiData(i,13))/4;
                    Exl(i/2,3)=(optiData(i,5)+optiData(i,8)+optiData(i,11)+optiData(i,14))/4;
               end
                
              end
              
              disp('X');disp(var(Exl(:,1)));
              disp('Y');disp(var(Exl(:,2)));
              disp('Z');disp(var(Exl(:,3)));
              
              disp('XYZ');disp(var(Exl));
              
            
            filename = strcat('腰の向き',optifilename);
            A = Exl;
            sheet = 1;
            xlRange = 'A1';
            xlswrite(filename,A,sheet,xlRange)
            %%
%             set(gcf, 'Position', [ 0, 0, 500, 500]);
%             hold on
%                 %plot(dT_nzc, dA_nzc , Y_nzc ,'Color' , 'b' ,'Marker','o', 'LineStyle','none' );
% %                 plot(Exl(1:3000,1),Exl(1:3000,3),'k-');
% %                 plot(Exl(1:225,1),Exl(1:225,3),'k-');
%                 plot(Exl(251:850,1),Exl(251:850,3),'k-');
%                 plot(Exl(851:1500,1),Exl(851:1500,3),'m-');
%                 plot(Exl(1501:1625,1),Exl(1501:1625,3),'c-');
%                 plot(Exl(1626:2175,1),Exl(1626:2175,3),'g-');
%                 plot(Exl(2176:2800,1),Exl(2176:2800,3),'k-');
%              
%                  xlim([0.9 1.2]);
%                  ylim([-0.5 -0.1]);
% %             view(-30,25);
% %             set(gcf, 'Position', [0 0 500 500]);
%             obj.saveGraphWithName(strcat('上から見た軌跡',optifilename));
%             %%
%             startIndex1 = 1;
%             endIndex1 = 2002;
%             Num = 1;
%             
%              for spotTimeMax = 2501 : 1:2998
% 
%                 %ここから上の200はすべてもともと500
%                 endIndex1 = endIndex1 + 1;  
%                 
%              set(gcf, 'Position', [ 0, 0, 500, 500]);
%              if spotTimeMax <5
%                    plot(Exl(startIndex1:endIndex1,1),Exl(startIndex1:endIndex1,3),'k*');
%              else
%                  disp(endIndex1);
%                    plot(Exl((endIndex1 - 5):endIndex1,1),Exl((endIndex1 - 5):endIndex1,3),'k*');
%              end
%             
%             xlim([0.9 1.2]);
%                  ylim([-0.5 -0.1]);
%              drawnow             % drawnowを入れるとアニメーションになる
%                     movmov(Num) = getframe(gcf,MonitorSize); 
%                     Num = Num +1;
%               end   
%             if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
%                 saveMovieName = obj.saveFilePath(['_' num2str( obj.data.splitTimeInfo.index ) '.avi']);
%             else
%                 saveMovieName = obj.saveFilePath('.avi');
%             end
%             movie2avi(movmov, saveMovieName,  'compression', 'None', 'fps', 2);

%ここまで
%            if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
%                 obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_主成分回帰分析']);
%             else

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