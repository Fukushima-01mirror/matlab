classdef OptiPulsethird < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = OptiPulsethird(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
          %%ファイル名設定
           optifilename = 'hukushima3-3.csv';
           %Take 2014-11-20 11.13.37 PM.csv
           %dataname = 'DATA1_04.csv';
%%          Optiでのマーカーの変位
            optiData = xlsread(optifilename,1,'A2:A6001'); disp(0);
            
            optiData(1:6000,2) = xlsread(optifilename,1,'K2:K6001');disp('Ruarm_x');
            optiData(1:6000,3) = xlsread(optifilename,1,'L2:L6001');disp('Ruarm_y');
            optiData(1:6000,4) = xlsread(optifilename,1,'M2:M6001');disp('Ruarm_z');
            
            optiData(1:6000,5) = xlsread(optifilename,1,'E2:E6001');disp('Rthigh_x');
            optiData(1:6000,6) = xlsread(optifilename,1,'F2:F6001');disp('Rthigh_y');
            optiData(1:6000,7) = xlsread(optifilename,1,'G2:G6001');disp('Rthigh_z');
            
            optiData(1:6000,8) = xlsread(optifilename,1,'B2:B6001');disp('Lthigh_x');
            optiData(1:6000,9) = xlsread(optifilename,1,'C2:C6001');disp('Lthigh_y');
            optiData(1:6000,10) = xlsread(optifilename,1,'D2:D6001');disp('Lthigh_z');
            
            Vect1=zeros(6000,3);
            Vect2=zeros(6000,3);
            VectX=zeros(6000,3);
            
            Nice1=zeros(6000,1);
            Nice2=zeros(6000,1);
            Nice3=zeros(6000,1);
            
            DirecX=[1 0 0];
            DirecZ=[0 0 1];
            DirecY=[0 1 1];
            
            Exl = zeros(3000,3);
            
            for i = 1:length(VectX)
                Vect1(i,1) = optiData(i,5) - optiData(i,2);
                Vect1(i,2) = optiData(i,6) - optiData(i,3);
                Vect1(i,3) = optiData(i,7) - optiData(i,4);
                
                Vect2(i,1) = optiData(i,8) - optiData(i,2);
                Vect2(i,2) = optiData(i,9) - optiData(i,3);
                Vect2(i,3) = optiData(i,10) - optiData(i,4);
                
                VectX(i,:) = cross(Vect1(i,:),Vect2(i,:));
                
                VectX(i,:) = VectX(i,:)/norm(VectX(i,:));
                
                Nice1(i,:) = dot(VectX(i,:),DirecX);
                Nice2(i,:) = dot(VectX(i,:),DirecZ);
                
                Nice3(i,:) = dot(VectX(i,:),DirecY);
            end
            disp(norm(VectX(12,:)));
            
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
%             
%             optiData(1:6000,21) = xlsread(optifilename,1,'CW46:CW6045');disp('Rshol2x');
%             optiData(1:6000,22) = xlsread(optifilename,1,'CX46:CX6045');disp('Rshol2y');
%             optiData(1:6000,23) = xlsread(optifilename,1,'CY46:CY6045');disp('Rshol2z');
%             
%             
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
            
            disp('zeroEnd');
            
            
            MonitorSize = [ 0, 0, 800, 800];
            set(gcf, 'Position', MonitorSize);
            a1 = subplot( 3,1,1 );
            plot(0.01:0.01:60,Nice1(:,1),'k');
%             A = std((optiData(1:6000,3)+optiData(1:6000,6)+optiData(1:6000,9)+optiData(1:6000,12))/4);
            xlabel('時間t s'); ylabel('内積');
            xlim([0 60]);ylim([-1 1]);
            title('X軸の内積');
            a2 = subplot( 3,1,2 );
            plot(0.01:0.01:60,Nice2(:,1),'k');
%             B = std(optiData(1:6000,15));
            xlabel('時間t s'); ylabel('内積');
            xlim([0 60]);ylim([-1 1]);
            title('Z軸との内積');
            
             a3 = subplot( 3,1,3 );
            plot(0.01:0.01:60,Nice3(:,1),'k');
%             B = std(optiData(1:6000,15));
            xlabel('時間t s'); ylabel('内積');
            xlim([0 60]);ylim([-1 1]);
            title('Y軸との内積');
            
            linkaxes([a1 a2 a3],'x');
            obj.saveGraphWithName(strcat('内積',optifilename));
            
            for i =1:6000
                if(rem(i,2) == 0)
                    Exl(i/2,1)=Nice1(i,1);
                    Exl(i/2,2)=Nice3(i,1);
                    Exl(i/2,3)=Nice2(i,1);
                end
                
            end
            
            filename = strcat('体の向き',optifilename);
            A = Exl;
            sheet = 1;
            xlRange = 'A1';
            xlswrite(filename,A,sheet,xlRange)
            
% %             
%             MonitorSize = [ 0, 0, 800, 800];
%             set(gcf, 'Position', MonitorSize);
%             a1 = subplot( 4,1,1 );
%             plot(0.01:0.01:60,(optiData(1:6000,4)+optiData(1:6000,7)+optiData(1:6000,10)+optiData(1:6000,13))/4,'k');
%             D = std((optiData(1:6000,4)+optiData(1:6000,7)+optiData(1:6000,10)+optiData(1:6000,13))/4);
%             xlabel('時間t s'); ylabel('マーカー位置');
%             xlim([0 60]);  
%             title(strcat('HipC-y',num2str(D)));
%             a2 = subplot( 4,1,2 );
%             plot(0.01:0.01:60,optiData(1:6000,16),'k');
%             E = std(optiData(1:6000,16));
%             xlabel('時間t s'); ylabel('マーカー位置');
%             xlim([0 60]);
%             title(strcat('Ches-y',num2str(E)));
%             a3 = subplot( 4,1,3 );
%             plot(0.01:0.01:60,(optiData(1:6000,19)+optiData(1:6000,22))/2,'k');
%             F = std((optiData(1:6000,19)+optiData(1:6000,22))/2);
%             xlabel('時間t s'); ylabel('マーカー位置');
%             xlim([0 60]);
%             title(strcat('sholC-y',num2str(F)));
% 
%             
%             linkaxes([a1 a2 a3 ],'x');
%             obj.saveGraphWithName(strcat('マーカー位置y',optifilename));
%             
%             MonitorSize = [ 0, 0, 800, 800];
%             set(gcf, 'Position', MonitorSize);
%             a1 = subplot( 4,1,1 );
%             plot(0.01:0.01:60,(optiData(1:6000,5)+optiData(1:6000,8)+optiData(1:6000,11)+optiData(1:6000,14))/4,'k');
%             G = std((optiData(1:6000,5)+optiData(1:6000,8)+optiData(1:6000,11)+optiData(1:6000,14))/4);
%             xlabel('時間t s'); ylabel('マーカー位置');
%             xlim([0 60]);  
%             title(strcat('HipC-z',num2str(G)));
%             a2 = subplot( 4,1,2 );
%             plot(0.01:0.01:60,optiData(1:6000,17),'k');
%             H = std(optiData(1:6000,17));
%             xlabel('時間t s'); ylabel('マーカー位置');
%             xlim([0 60]);
%             title(strcat('Ches-z',num2str(H)));
%             a3 = subplot( 4,1,3 );
%             plot(0.01:0.01:60,(optiData(1:6000,20)+optiData(1:6000,23))/2,'k');
%             I = std((optiData(1:6000,20)+optiData(1:6000,23))/2);
%             xlabel('時間t s'); ylabel('マーカー位置');
%             xlim([0 60]);
%             title(strcat('sholC-z',num2str(I)));
% 
%             linkaxes([a1 a2 a3],'x');
%             obj.saveGraphWithName(strcat('マーカー位置z',optifilename));
%             
                end



        function runForPair(obj,user1 ,user2)
%             obj.runForAlone(user1);
%             obj.runForAlone(user2);
%             
            
        end
end
        
end