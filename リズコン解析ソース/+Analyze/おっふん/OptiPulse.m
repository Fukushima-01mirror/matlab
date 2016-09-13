classdef CSVreader < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = CSVreader(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
          %%ファイル名設定
           optifilename = 'small3 2015-01-12 11.58.27 AM.csv';
           %Take 2014-11-20 11.13.37 PM.csv
           %dataname = 'DATA1_04.csv';
%%          Optiでのマーカーの変位
            VelocData = xlsread(optifilename,1,'B46:C6045'); disp(0);

            VelocData = xlsread(optifilename,1,'B46:C6045'); disp(0);
            VelocData(1:6000,3) = xlsread(optifilename,1,'F46:F6045');disp('Hip1x');
            VelocData(1:6000,4) = xlsread(optifilename,1,'G46:G6045');disp('Hip1y');
            VelocData(1:6000,5) = xlsread(optifilename,1,'H46:H6045');disp('Hip1z');
            
            VelocData(1:6000,6) = xlsread(optifilename,1,'K46:K6045');disp('Hip2x');
            VelocData(1:6000,7) = xlsread(optifilename,1,'L46:L6045');disp('Hip2y');
            VelocData(1:6000,8) = xlsread(optifilename,1,'M46:M6045');disp('Hip2z');
            
            VelocData(1:6000,9) = xlsread(optifilename,1,'P46:P6045');disp('Hip3x');
            VelocData(1:6000,10) = xlsread(optifilename,1,'Q46:Q6045');disp('Hip3y');
            VelocData(1:6000,11) = xlsread(optifilename,1,'R46:R6045');disp('Hip3z');
            
            VelocData(1:6000,12) = xlsread(optifilename,1,'U46:U6045');disp('Hip4x');
            VelocData(1:6000,13) = xlsread(optifilename,1,'V46:V6045');disp('Hip4y');
            VelocData(1:6000,14) = xlsread(optifilename,1,'W46:W6045');disp('Hip4z');
            
            VelocData(1:6000,15) = xlsread(optifilename,1,'AO46:AO6045');disp('Chest4x');
            VelocData(1:6000,16) = xlsread(optifilename,1,'AP46:AP6045');disp('Chest4y');
            VelocData(1:6000,17) = xlsread(optifilename,1,'AQ46:AQ6045');disp('Chest4z');
            
            VelocData(1:6000,18) = xlsread(optifilename,1,'BN46:BN6045');disp('Lshol2x');
            VelocData(1:6000,19) = xlsread(optifilename,1,'BO46:BO6045');disp('Lshol2y');
            VelocData(1:6000,20) = xlsread(optifilename,1,'BP46:BP6045');disp('Lshol2z');
            
            %optiData(1:6000,21) = xlsread(optifilename,1,'BS46:BS6045');disp('Luarm1x');
            %optiData(1:6000,22) = xlsread(optifilename,1,'BT46:BT6045');disp('Luarm1y');
            %optiData(1:6000,23) = xlsread(optifilename,1,'BU46:BU6045');disp('Luarm1z');
            
            VelocData(1:6000,24) = xlsread(optifilename,1,'CW46:CW6045');disp('Rshol2x');
            VelocData(1:6000,25) = xlsread(optifilename,1,'CX46:CX6045');disp('Rshol2y');
            VelocData(1:6000,26) = xlsread(optifilename,1,'CY46:CY6045');disp('Rshol2z');
            
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
            
            
            opti0(1,1:2) = xlsread(optifilename,1,'B45:C45');
            opti0(1,3) = xlsread(optifilename,1,'F45');disp('ZEROHip1x');
            opti0(1,4) = xlsread(optifilename,1,'G45');disp('ZEROHip1y');
            opti0(1,5) = xlsread(optifilename,1,'H45');disp('ZEROHip1z');
            opti0(1,6) = xlsread(optifilename,1,'K45');disp('ZEROHip2x');
            opti0(1,7) = xlsread(optifilename,1,'L45');disp('ZEROHip2y');
            opti0(1,8) = xlsread(optifilename,1,'M45');disp('ZEROHip2z');
            opti0(1,9) = xlsread(optifilename,1,'P45');disp('ZEROHip3x');
            opti0(1,10) = xlsread(optifilename,1,'Q45');disp('ZEROHip3y');
            opti0(1,11) = xlsread(optifilename,1,'R45');disp('ZEROHip3z');
            opti0(1,12) = xlsread(optifilename,1,'U45');disp('ZEROHip4x');
            opti0(1,13) = xlsread(optifilename,1,'V45');disp('ZEROHip4y');
            opti0(1,14) = xlsread(optifilename,1,'W45');disp('ZEROHip4z');
            opti0(1,15) = xlsread(optifilename,1,'AO45');disp('ZEROChest4x');
            opti0(1,16) = xlsread(optifilename,1,'AP45');disp('ZEROChest4y');
            opti0(1,17) = xlsread(optifilename,1,'AQ45');disp('ZEROChest4z');
            opti0(1,18) = xlsread(optifilename,1,'BN45');disp('ZEROLshol2x');
            opti0(1,19) = xlsread(optifilename,1,'BO45');disp('ZEROLshol2y');
            opti0(1,20) = xlsread(optifilename,1,'BP45');disp('ZEROLshol2z');
            opti0(1,21) = xlsread(optifilename,1,'BS45');disp('ZEROLuarm1x');
            opti0(1,22) = xlsread(optifilename,1,'BT45');disp('ZEROLuarm1y');
            opti0(1,23) = xlsread(optifilename,1,'BU45');disp('ZEROLuarm1z');
            opti0(1,24) = xlsread(optifilename,1,'CW45');disp('ZERORshol2x');
            opti0(1,25) = xlsread(optifilename,1,'CX45');disp('ZERORshol2y');
            opti0(1,26) = xlsread(optifilename,1,'CY45');disp('ZERORshol2z');
            opti0(1,27) = xlsread(optifilename,1,'DB45');disp('ZERORuarm1x');
            opti0(1,28) = xlsread(optifilename,1,'DC45');disp('ZERORuarm1y');
            opti0(1,29) = xlsread(optifilename,1,'DD45');disp('ZERORuarm1z');
            opti0(1,30) = xlsread(optifilename,1,'DL45');disp('ZERORhand1x');
            opti0(1,31) = xlsread(optifilename,1,'DM45');disp('ZERORhand1y');
            opti0(1,32) = xlsread(optifilename,1,'DN45');disp('ZERORhand1z');
            opti0(1,33) = xlsread(optifilename,1,'DQ45');disp('ZERORhand2x');
            opti0(1,34) = xlsread(optifilename,1,'DR45');disp('ZERORhand2y');
            opti0(1,35) = xlsread(optifilename,1,'DS45');disp('ZERORhand2z');
            opti0(1,36) = xlsread(optifilename,1,'DV45');disp('ZERORhand3x');
            opti0(1,37) = xlsread(optifilename,1,'DW45');disp('ZERORhand3y');
            opti0(1,38) = xlsread(optifilename,1,'DX45');disp('ZERORhand3z');
            opti0(1,39) = xlsread(optifilename,1,'EF45');disp('ZEROLthi2x');
            opti0(1,40) = xlsread(optifilename,1,'EG45');disp('ZEROLthi2y');
            opti0(1,41) = xlsread(optifilename,1,'EH45');disp('ZEROLthi2z');
            opti0(1,42) = xlsread(optifilename,1,'FJ45');disp('ZERORthi2x');
            opti0(1,43) = xlsread(optifilename,1,'FK45');disp('ZERORthi2y');
            opti0(1,44) = xlsread(optifilename,1,'FL45');disp('ZERORthi2z');
           
            
            disp('zeroEnd');
            
            MonitorSize = [ 0, 0, 800, 800];
            set(gcf, 'Position', MonitorSize);
            a1 = subplot( 4,1,1 );
            plot(0.01:0.01:60,VelocData(1:6000,3),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('Hip1-x');
            a2 = subplot( 4,1,2 );
            plot(0.01:0.01:60,VelocData(1:6000,6),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('Hip2-x');
            a3 = subplot( 4,1,3 );
            plot(0.01:0.01:60,VelocData(1:6000,9),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('Hip3-x');
            a4 = subplot( 4,1,4 );
            plot(0.01:0.01:60,VelocData(1:6000,12),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('Hip4-x');
             
            linkaxes([a1 a2 a3 a4],'x');
            obj.saveGraphWithName('マーカー位置x1');
            
%             fs =1000; % Sampling FFT実施
%             n = length(optiData(1:6000,3)); % Window length length(x) % Window length
%             y = fft(optiData(1:6000,3),n); % DFT
%             f = (0:n-1)*(fs/n); % Frequency
%             power = y.*conj(y)/n; % Power
%             figure(2)
%             plot(f,power)
%             xlabel('Frequency (Hz)')
%             ylabel('Power')
%             
%             NFFT = 2^nextpow2(L); % Next power of 2 from length of y
%             Y = fft(y,NFFT)/L;
%             f = Fs/2*linspace(0,1,NFFT/2+1);
% 
%             % Plot single-sided amplitude spectrum.
%             plot(f,2*abs(Y(1:NFFT/2+1))) 
%             title('Single-Sided Amplitude Spectrum of y(t)')
%             xlabel('Frequency (Hz)')
%             ylabel('|Y(f)|')
%             
%             title('FFT')
%             obj.saveGraphWithName('FFT-Hip1-x');
%             
            MonitorSize = [ 0, 0, 800, 800];
            set(gcf, 'Position', MonitorSize);
            a1 = subplot( 4,1,1 );
            plot(0.01:0.01:60,VelocData(1:6000,4),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);  
            title('Hip1-y');
            a2 = subplot( 4,1,2 );
            plot(0.01:0.01:60,VelocData(1:6000,7),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('Hip2-y');
            a3 = subplot( 4,1,3 );
            plot(0.01:0.01:60,VelocData(1:6000,10),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('Hip3-y');
            a4 = subplot( 4,1,4 );
            plot(0.01:0.01:60,VelocData(1:6000,13),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('Hip4-y');
            
            linkaxes([a1 a2 a3 a4],'x');
            obj.saveGraphWithName('マーカー位置y1');
            
            MonitorSize = [ 0, 0, 800, 800];
            set(gcf, 'Position', MonitorSize);
            a1 = subplot( 4,1,1 );
            plot(0.01:0.01:60,VelocData(1:6000,5),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);  
            title('Hip1-z');
            a2 = subplot( 4,1,2 );
            plot(0.01:0.01:60,VelocData(1:6000,8),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('Hip2-z');
            a3 = subplot( 4,1,3 );
            plot(0.01:0.01:60,VelocData(1:6000,11),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('Hip3-z');
            a4 = subplot( 4,1,4 );
            plot(0.01:0.01:60,VelocData(1:6000,14),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('Hip4-z');
            linkaxes([a1 a2 a3 a4],'x');
            obj.saveGraphWithName('マーカー位置z1');
            
            MonitorSize = [ 0, 0, 800, 1000];
            set(gcf, 'Position', MonitorSize);
            a5 = subplot( 5,1,1 );
            plot(0.01:0.01:60,VelocData(1:6000,15),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('Chest4-x');
            a6 = subplot( 5,1,2 );
            plot(0.01:0.01:60,VelocData(1:6000,18),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('Lshol2-x');
            a7 = subplot( 5,1,3 );
            plot(0.01:0.01:60,VelocData(1:6000,21),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('Luarm1-x');
            a8 = subplot( 5,1,4 );
            plot(0.01:0.01:60,VelocData(1:6000,24),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('Rshol2-x');
            a9 = subplot( 5,1,5 );
            plot(0.01:0.01:60,VelocData(1:6000,27),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('Ruarm1-x');
            
            linkaxes([a5 a6 a7 a8 a9],'x');
            obj.saveGraphWithName('マーカー位置x2');
            
            MonitorSize = [ 0, 0, 800, 1000];
            set(gcf, 'Position', MonitorSize);
            a10 = subplot( 5,1,1 );
            plot(0.01:0.01:60,VelocData(1:6000,16),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('Chest4-y');
            a11 = subplot( 5,1,2 );
            plot(0.01:0.01:60,VelocData(1:6000,19),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('Lshol2-y');
            a12 = subplot( 5,1,3 );
            plot(0.01:0.01:60,VelocData(1:6000,22),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('Luarm1-y');
            a13 = subplot( 5,1,4 );
            plot(0.01:0.01:60,VelocData(1:6000,25),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('Rshol2-y');
            a14 = subplot( 5,1,5 );
            plot(0.01:0.01:60,VelocData(1:6000,28),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('Ruarm1-y');
            
            linkaxes([a10 a11 a12 a13 a14],'x');
            obj.saveGraphWithName('マーカー位置y2');
            
            MonitorSize = [ 0, 0, 800, 1000];
            set(gcf, 'Position', MonitorSize);
            a15 = subplot( 5,1,1 );
            plot(0.01:0.01:60,VelocData(1:6000,17),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('Chest4-z');
            a16 = subplot( 5,1,2 );
            plot(0.01:0.01:60,VelocData(1:6000,20),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('Lshol2-z');
            a17 = subplot( 5,1,3 );
            plot(0.01:0.01:60,VelocData(1:6000,21),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('Luarm1-z');
            a18 = subplot( 5,1,4 );
            plot(0.01:0.01:60,VelocData(1:6000,22),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('Rshol2-z');
            a19 = subplot( 5,1,5 );
            plot(0.01:0.01:60,VelocData(1:6000,23),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('Ruarm1-z');
            
            linkaxes([a15 a16 a17 a18 a19],'x');
            obj.saveGraphWithName('マーカー位置z2');
            
            MonitorSize = [ 0, 0, 800, 1000];
            set(gcf, 'Position', MonitorSize);
            a20 = subplot( 5,1,1 );
            plot(0.01:0.01:60,VelocData(1:6000,30),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('Rhand1-x');
            a21 = subplot( 5,1,2 );
            plot(0.01:0.01:60,VelocData(1:6000,33),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('Rhand2-x');
            a22 = subplot( 5,1,3 );
            plot(0.01:0.01:60,VelocData(1:6000,36),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('Rhand3-x');
            a23 = subplot( 5,1,4 );
            plot(0.01:0.01:60,VelocData(1:6000,39),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('Lthi2-x');
            a24 = subplot( 5,1,5 );
            plot(0.01:0.01:60,VelocData(1:6000,42),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('Rthi2-x');
            
            linkaxes([a20 a21 a22 a23 a24],'x');
            obj.saveGraphWithName('マーカー位置x3');
            
            MonitorSize = [ 0, 0, 800, 1000];
            set(gcf, 'Position', MonitorSize);
            a25 = subplot( 5,1,1 );
            plot(0.01:0.01:60,VelocData(1:6000,31),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('Rhand1-y');
            a26 = subplot( 5,1,2 );
            plot(0.01:0.01:60,VelocData(1:6000,34),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('Rhand2-y');
            a27 = subplot( 5,1,3 );
            plot(0.01:0.01:60,VelocData(1:6000,37),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
             title('Rhand3-y');
            a28 = subplot( 5,1,4 );
            plot(0.01:0.01:60,VelocData(1:6000,40),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('Lthi2-y');
            a29 = subplot( 5,1,5 );
            plot(0.01:0.01:60,VelocData(1:6000,43),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('Rthi2-y');
            
            linkaxes([a25 a26 a27 a28 a29],'x');
            obj.saveGraphWithName('マーカー位置y3');
            
            MonitorSize = [ 0, 0, 800, 1000];
            set(gcf, 'Position', MonitorSize);
            a30 = subplot( 5,1,1 );
            plot(0.01:0.01:60,VelocData(1:6000,32),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('Rhand1-z');
            a31 = subplot( 5,1,2 );
            plot(0.01:0.01:60,VelocData(1:6000,35),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('Rhand2-z');
            a32 = subplot( 5,1,3 );
            plot(0.01:0.01:60,VelocData(1:6000,38),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
             title('Rhand3-z');
            a33 = subplot( 5,1,4 );
            plot(0.01:0.01:60,VelocData(1:6000,41),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('Lthi2-z');
            a34 = subplot( 5,1,5 );
            plot(0.01:0.01:60,VelocData(1:6000,44),'k');
            xlabel('時間t s'); ylabel('マーカー位置');
            xlim([0 60]);
            title('Rthi2-z');
            
            linkaxes([a30 a31 a32 a33 a34],'x');
            obj.saveGraphWithName('マーカー位置z3');
            
%                 Vector1 = zeros(6000,112);
%                 for i = 1:length(optiData)
%                     if i==1
%                     Vector1(1,1) = 0.02;
%                     Vector1(1,2:112) = optiData(1,3:113) - opti0(1,3:113);
%                     end
%                    if i>2 && rem(i,2)==0
%                        Vector1(i/2,1) = optiData(i,2);
%                        Vector1(i/2,2:112) = optiData(i,3:113) - optiData(i-2,3:113);
%                    end  
%                 end
%                 Vector2 = zeros(6000,38);
%                 for i = 1:6000
%                        Vector2(i,1) = Vector1(i,1);
%                        Vector2(i,2) = sqrt((Vector1(i,2))^2+(Vector1(i,3))^2+(Vector1(i,4))^2);
%                        Vector2(i,3) = sqrt((Vector1(i,5))^2+(Vector1(i,6))^2+(Vector1(i,7))^2);
%                        Vector2(i,4) = sqrt((Vector1(i,8))^2+(Vector1(i,9))^2+(Vector1(i,10))^2);
%                        Vector2(i,5) = sqrt((Vector1(i,11))^2+(Vector1(i,12))^2+(Vector1(i,13))^2);
%                        Vector2(i,6) = sqrt((Vector1(i,14))^2+(Vector1(i,15))^2+(Vector1(i,16))^2);
%                        Vector2(i,7) = sqrt((Vector1(i,17))^2+(Vector1(i,18))^2+(Vector1(i,19))^2);
%                        Vector2(i,8) = sqrt((Vector1(i,20))^2+(Vector1(i,21))^2+(Vector1(i,22))^2);
%                        Vector2(i,9) = sqrt((Vector1(i,23))^2+(Vector1(i,24))^2+(Vector1(i,25))^2);
%                        Vector2(i,10) = sqrt((Vector1(i,26))^2+(Vector1(i,27))^2+(Vector1(i,28))^2);
%                        Vector2(i,11) = sqrt((Vector1(i,29))^2+(Vector1(i,30))^2+(Vector1(i,31))^2);
%                        Vector2(i,12) = sqrt((Vector1(i,32))^2+(Vector1(i,33))^2+(Vector1(i,34))^2);
%                        Vector2(i,13) = sqrt((Vector1(i,35))^2+(Vector1(i,36))^2+(Vector1(i,37))^2);
%                        Vector2(i,14) = sqrt((Vector1(i,38))^2+(Vector1(i,39))^2+(Vector1(i,40))^2);
%                        Vector2(i,15) = sqrt((Vector1(i,41))^2+(Vector1(i,42))^2+(Vector1(i,43))^2);
%                        Vector2(i,16) = sqrt((Vector1(i,44))^2+(Vector1(i,45))^2+(Vector1(i,46))^2);
%                        Vector2(i,17) = sqrt((Vector1(i,47))^2+(Vector1(i,48))^2+(Vector1(i,49))^2);
%                        Vector2(i,18) = sqrt((Vector1(i,50))^2+(Vector1(i,51))^2+(Vector1(i,52))^2);
%                        Vector2(i,19) = sqrt((Vector1(i,53))^2+(Vector1(i,54))^2+(Vector1(i,55))^2);
%                        Vector2(i,20) = sqrt((Vector1(i,56))^2+(Vector1(i,57))^2+(Vector1(i,58))^2);
%                        Vector2(i,21) = sqrt((Vector1(i,59))^2+(Vector1(i,60))^2+(Vector1(i,61))^2);
%                        Vector2(i,22) = sqrt((Vector1(i,62))^2+(Vector1(i,63))^2+(Vector1(i,64))^2);
%                        Vector2(i,23) = sqrt((Vector1(i,65))^2+(Vector1(i,66))^2+(Vector1(i,67))^2);
%                        Vector2(i,24) = sqrt((Vector1(i,68))^2+(Vector1(i,69))^2+(Vector1(i,70))^2);
%                        Vector2(i,25) = sqrt((Vector1(i,71))^2+(Vector1(i,72))^2+(Vector1(i,73))^2);
%                        Vector2(i,26) = sqrt((Vector1(i,74))^2+(Vector1(i,75))^2+(Vector1(i,76))^2);
%                        Vector2(i,27) = sqrt((Vector1(i,77))^2+(Vector1(i,78))^2+(Vector1(i,79))^2);
%                        Vector2(i,28) = sqrt((Vector1(i,80))^2+(Vector1(i,81))^2+(Vector1(i,82))^2);
%                        Vector2(i,29) = sqrt((Vector1(i,83))^2+(Vector1(i,84))^2+(Vector1(i,85))^2);
%                        Vector2(i,30) = sqrt((Vector1(i,86))^2+(Vector1(i,87))^2+(Vector1(i,88))^2);
%                        Vector2(i,31) = sqrt((Vector1(i,89))^2+(Vector1(i,90))^2+(Vector1(i,91))^2);
%                        Vector2(i,32) = sqrt((Vector1(i,92))^2+(Vector1(i,93))^2+(Vector1(i,94))^2);
%                        Vector2(i,33) = sqrt((Vector1(i,95))^2+(Vector1(i,96))^2+(Vector1(i,97))^2);
%                        Vector2(i,34) = sqrt((Vector1(i,98))^2+(Vector1(i,99))^2+(Vector1(i,100))^2);
%                        Vector2(i,35) = sqrt((Vector1(i,101))^2+(Vector1(i,102))^2+(Vector1(i,103))^2);
%                        Vector2(i,36) = sqrt((Vector1(i,104))^2+(Vector1(i,105))^2+(Vector1(i,106))^2);
%                        Vector2(i,37) = sqrt((Vector1(i,107))^2+(Vector1(i,108))^2+(Vector1(i,109))^2); 
%                        Vector2(i,38) = sqrt((Vector1(i,110))^2+(Vector1(i,111))^2+(Vector1(i,112))^2);
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