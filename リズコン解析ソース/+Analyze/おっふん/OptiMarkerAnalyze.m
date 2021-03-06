%% configファイルのデータをまとめて解析

clf;
% clearvars *;
clc;
clear all;

addpath('C:\Users\fksm\Documents\リズコン解析ソース');
cd('C:\Users\fksm\Documents\リズコン解析ソース');

% saveDataDir = 'T:\解析データ\リズコン解析データ\results';
% saveDataDir = 'T:\解析データ\リズコン解析データ(角柱レバー)\results';
% saveDataDir = 'T:\解析データ\リズコン解析データ(円柱レバー)\results';
% saveDataDir = 'T:\解析データ\リズコン解析データ(軸中心レバー)\results';

saveDataDir = 'C:\Users\fksm\Documents\福島リズコン解析データ\results';

          %%ファイル名設定
           optifilename = 'Take 2014-11-20 11.13.37 PM.csv';
           dataname = 'DATA1_04.csv';
%%          Optiでのマーカーの変位
            optiData = xlsread(optifilename,1,'B46:C6045'); disp(0);
            optiData(1:6000,3:5) = xlsread(optifilename,1,'F46:H6045');disp('Marker1');
            optiData(1:6000,6:8) = xlsread(optifilename,1,'K46:M6045');disp('Marker2');
            optiData(1:6000,9:11) = xlsread(optifilename,1,'P46:R6045');disp('Marker3');
            optiData(1:6000,12:14) = xlsread(optifilename,1,'U46:W6045');disp('Marker4');
            optiData(1:6000,15:17) = xlsread(optifilename,1,'Z46:AB6045');disp('Marker5');
            optiData(1:6000,18:20) = xlsread(optifilename,1,'AE46:AG6045');disp('Marker6');
            optiData(1:6000,21:23) = xlsread(optifilename,1,'AJ46:AL6045');disp('Marker7');
            optiData(1:6000,24:26) = xlsread(optifilename,1,'AO46:AQ6045');disp('Marker8');
            optiData(1:6000,27:29) = xlsread(optifilename,1,'AT46:AV6045');disp('Marker9');
            optiData(1:6000,30:32) = xlsread(optifilename,1,'AY46:BA6045');disp('Marker10');
            optiData(1:6000,33:35) = xlsread(optifilename,1,'BD46:BF6045');disp('Marker11');
            optiData(1:6000,36:38) = xlsread(optifilename,1,'BI46:BK6045');disp('Marker12');
            optiData(1:6000,39:41) = xlsread(optifilename,1,'BN46:BP6045');disp('Marker13');
            optiData(1:6000,42:44) = xlsread(optifilename,1,'BS46:BU6045');disp('Marker14');
            optiData(1:6000,45:47) = xlsread(optifilename,1,'BX46:BZ6045');disp('Marker15');
            optiData(1:6000,48:50) = xlsread(optifilename,1,'CC46:CE6045');disp('Marker16');
            optiData(1:6000,51:53) = xlsread(optifilename,1,'CH46:CJ6045');disp('Marker17');
            optiData(1:6000,54:56) = xlsread(optifilename,1,'CM46:CO6045');disp('Marker18');
            optiData(1:6000,57:59) = xlsread(optifilename,1,'CR46:CT6045');disp('Marker19');
            optiData(1:6000,60:62) = xlsread(optifilename,1,'CW46:CY6045');disp('Marker20');
            optiData(1:6000,63:65) = xlsread(optifilename,1,'DB46:DD6045');disp('Marker21');
            optiData(1:6000,66:68) = xlsread(optifilename,1,'DG46:DI6045');disp('Marker22');
            optiData(1:6000,69:71) = xlsread(optifilename,1,'DL46:DN6045');disp('Marker23');
            optiData(1:6000,72:74) = xlsread(optifilename,1,'DQ46:DS6045');disp('Marker24');
            optiData(1:6000,75:77) = xlsread(optifilename,1,'DV46:DX6045');disp('Marker25');
            optiData(1:6000,78:80) = xlsread(optifilename,1,'EA46:EC6045');disp('Marker26');
            optiData(1:6000,81:83) = xlsread(optifilename,1,'EF46:EH6045');disp('Marker27');
            optiData(1:6000,84:86) = xlsread(optifilename,1,'EK46:EM6045');disp('Marker28');
            optiData(1:6000,87:89) = xlsread(optifilename,1,'EP46:ER6045');disp('Marker29');
            optiData(1:6000,90:92) = xlsread(optifilename,1,'EU46:EW6045');disp('Marker30');
            optiData(1:6000,93:95) = xlsread(optifilename,1,'EZ46:FB6045');disp('Marker31');
            optiData(1:6000,96:98) = xlsread(optifilename,1,'FE46:FG6045');disp('Marker32');
            optiData(1:6000,99:101) = xlsread(optifilename,1,'FJ46:FL6045');disp('Marker33');
            optiData(1:6000,102:104) = xlsread(optifilename,1,'FO46:FQ6045');disp('Marker34');
            optiData(1:6000,105:107) = xlsread(optifilename,1,'FT46:FV6045');disp('Marker35');
            optiData(1:6000,108:110) = xlsread(optifilename,1,'FY46:GA6045');disp('Marker36');
            opti0(1,1:2) = xlsread(optifilename,1,'B45:C45');
            opti0(1,3:5) = xlsread(optifilename,1,'F45:H45');
            opti0(1,6:8) = xlsread(optifilename,1,'K45:M45');
            opti0(1,9:11) = xlsread(optifilename,1,'P45:R45');
            opti0(1,12:14) = xlsread(optifilename,1,'U45:W45');
            opti0(1,15:17) = xlsread(optifilename,1,'Z45:AB45');
            opti0(1,18:20) = xlsread(optifilename,1,'AE45:AG45');
            opti0(1,21:23) = xlsread(optifilename,1,'AJ45:AL45');
            opti0(1,24:26) = xlsread(optifilename,1,'AO45:AQ45');
            opti0(1,27:29) = xlsread(optifilename,1,'AT45:AV45');
            opti0(1,30:32) = xlsread(optifilename,1,'AY45:BA45');
            opti0(1,33:35) = xlsread(optifilename,1,'BD45:BF45');
            opti0(1,36:38) = xlsread(optifilename,1,'BI45:BK45');
            opti0(1,39:41) = xlsread(optifilename,1,'BN45:BP45');
            opti0(1,42:44) = xlsread(optifilename,1,'BS45:BU45');
            opti0(1,45:47) = xlsread(optifilename,1,'BX45:BZ45');
            opti0(1,48:50) = xlsread(optifilename,1,'CC45:CE45');
            opti0(1,51:53) = xlsread(optifilename,1,'CH45:CJ45');
            opti0(1,54:56) = xlsread(optifilename,1,'CM45:CO45');
            opti0(1,57:59) = xlsread(optifilename,1,'CR45:CT45');
            opti0(1,60:62) = xlsread(optifilename,1,'CW45:CY45');
            opti0(1,63:65) = xlsread(optifilename,1,'DB45:DD45');
            opti0(1,66:68) = xlsread(optifilename,1,'DG45:DI45');
            opti0(1,69:71) = xlsread(optifilename,1,'DL45:DN45');
            opti0(1,72:74) = xlsread(optifilename,1,'DQ45:DS45');
            opti0(1,75:77) = xlsread(optifilename,1,'DV45:DX45');
            opti0(1,78:80) = xlsread(optifilename,1,'EA45:EC45');
            opti0(1,81:83) = xlsread(optifilename,1,'EF45:EH45');
            opti0(1,84:86) = xlsread(optifilename,1,'EK45:EM45');
            opti0(1,87:89) = xlsread(optifilename,1,'EP45:ER45');
            opti0(1,90:92) = xlsread(optifilename,1,'EU45:EW45');
            opti0(1,93:95) = xlsread(optifilename,1,'EZ45:FB45');
            opti0(1,96:98) = xlsread(optifilename,1,'FE45:FG45');
            opti0(1,99:101) = xlsread(optifilename,1,'FJ45:FL45');
            opti0(1,102:104) = xlsread(optifilename,1,'FO45:FQ45');
            opti0(1,105:107) = xlsread(optifilename,1,'FT45:FV45');
            opti0(1,108:110) = xlsread(optifilename,1,'FY45:GA45');
            disp('zeroEnd');
                Vector1 = zeros(3000,109);
                for i = 1:length(optiData)
                    if i==1
                    Vector1(1,1) = 0.02;
                    Vector1(1,2:109) = optiData(1,3:110) - opti0(1,3:110);
                    end
                   if i>2 && rem(i,2)==0
                       Vector1(i/2,1) = optiData(i,2);
                       Vector1(i/2,2:109) = optiData(i,3:110) - optiData(i-2,3:110);
                   end  
                end
                Vector2 = zeros(3000,37);
                for i = 1:3000
                       Vector2(i,1) = Vector1(i,1);
                       Vector2(i,2) = sqrt((Vector1(i,2))^2+(Vector1(i,3))^2+(Vector1(i,4))^2);
                       Vector2(i,3) = sqrt((Vector1(i,5))^2+(Vector1(i,6))^2+(Vector1(i,7))^2);
                       Vector2(i,4) = sqrt((Vector1(i,8))^2+(Vector1(i,9))^2+(Vector1(i,10))^2);
                       Vector2(i,5) = sqrt((Vector1(i,11))^2+(Vector1(i,12))^2+(Vector1(i,13))^2);
                       Vector2(i,6) = sqrt((Vector1(i,14))^2+(Vector1(i,15))^2+(Vector1(i,16))^2);
                       Vector2(i,7) = sqrt((Vector1(i,17))^2+(Vector1(i,18))^2+(Vector1(i,19))^2);
                       Vector2(i,8) = sqrt((Vector1(i,20))^2+(Vector1(i,21))^2+(Vector1(i,22))^2);
                       Vector2(i,9) = sqrt((Vector1(i,23))^2+(Vector1(i,24))^2+(Vector1(i,25))^2);
                       Vector2(i,10) = sqrt((Vector1(i,26))^2+(Vector1(i,27))^2+(Vector1(i,28))^2);
                       Vector2(i,11) = sqrt((Vector1(i,29))^2+(Vector1(i,30))^2+(Vector1(i,31))^2);
                       Vector2(i,12) = sqrt((Vector1(i,32))^2+(Vector1(i,33))^2+(Vector1(i,34))^2);
                       Vector2(i,13) = sqrt((Vector1(i,35))^2+(Vector1(i,36))^2+(Vector1(i,37))^2);
                       Vector2(i,14) = sqrt((Vector1(i,38))^2+(Vector1(i,39))^2+(Vector1(i,40))^2);
                       Vector2(i,15) = sqrt((Vector1(i,41))^2+(Vector1(i,42))^2+(Vector1(i,43))^2);
                       Vector2(i,16) = sqrt((Vector1(i,44))^2+(Vector1(i,45))^2+(Vector1(i,46))^2);
                       Vector2(i,17) = sqrt((Vector1(i,47))^2+(Vector1(i,48))^2+(Vector1(i,49))^2);
                       Vector2(i,18) = sqrt((Vector1(i,50))^2+(Vector1(i,51))^2+(Vector1(i,52))^2);
                       Vector2(i,19) = sqrt((Vector1(i,53))^2+(Vector1(i,54))^2+(Vector1(i,55))^2);
                       Vector2(i,20) = sqrt((Vector1(i,56))^2+(Vector1(i,57))^2+(Vector1(i,58))^2);
                       Vector2(i,21) = sqrt((Vector1(i,59))^2+(Vector1(i,60))^2+(Vector1(i,61))^2);
                       Vector2(i,22) = sqrt((Vector1(i,62))^2+(Vector1(i,63))^2+(Vector1(i,64))^2);
                       Vector2(i,23) = sqrt((Vector1(i,65))^2+(Vector1(i,66))^2+(Vector1(i,67))^2);
                       Vector2(i,24) = sqrt((Vector1(i,68))^2+(Vector1(i,69))^2+(Vector1(i,70))^2);
                       Vector2(i,25) = sqrt((Vector1(i,71))^2+(Vector1(i,72))^2+(Vector1(i,73))^2);
                       Vector2(i,26) = sqrt((Vector1(i,74))^2+(Vector1(i,75))^2+(Vector1(i,76))^2);
                       Vector2(i,27) = sqrt((Vector1(i,77))^2+(Vector1(i,78))^2+(Vector1(i,79))^2);
                       Vector2(i,28) = sqrt((Vector1(i,80))^2+(Vector1(i,81))^2+(Vector1(i,82))^2);
                       Vector2(i,29) = sqrt((Vector1(i,83))^2+(Vector1(i,84))^2+(Vector1(i,85))^2);
                       Vector2(i,30) = sqrt((Vector1(i,86))^2+(Vector1(i,87))^2+(Vector1(i,88))^2);
                       Vector2(i,31) = sqrt((Vector1(i,89))^2+(Vector1(i,90))^2+(Vector1(i,91))^2);
                       Vector2(i,32) = sqrt((Vector1(i,92))^2+(Vector1(i,93))^2+(Vector1(i,94))^2);
                       Vector2(i,33) = sqrt((Vector1(i,95))^2+(Vector1(i,96))^2+(Vector1(i,97))^2);
                       Vector2(i,34) = sqrt((Vector1(i,98))^2+(Vector1(i,99))^2+(Vector1(i,100))^2);
                       Vector2(i,35) = sqrt((Vector1(i,101))^2+(Vector1(i,102))^2+(Vector1(i,103))^2);
                       Vector2(i,36) = sqrt((Vector1(i,104))^2+(Vector1(i,105))^2+(Vector1(i,106))^2);
                       Vector2(i,37) = sqrt((Vector1(i,107))^2+(Vector1(i,108))^2+(Vector1(i,109))^2);  
                end
                
                PrePulPhase = zeros(60000,1);
                Pulse = zeros(1,1);
                PrePulPhase(1,1) = xlsread(dataname,1,'A1');
                RawPulPhase = xlsread(dataname,1,'B3:B60002');
                for j=1:59999
                    PrePulPhase(j+1,1) = PrePulPhase(j,1) + RawPulPhase(j+1,1);
                    if rem((j+1),20) == 0
                        Pulse = vertcat(Pulse,PrePulPhase(j+1,1));
                    end  
                end
                Pulse(1,:)=[];

%%        回帰直線からの距離の時間変化
             %　時間スケールの設定            
  
                   Num = 1;

             for spotTimeMax = 1000 : 1 : 1500 

            MonitorSize = [ 0, 0, 1200, 800];
                    set(gcf, 'Position', MonitorSize);
                         figure(1);
            
              hold off
             x=1:1:36;
                 y = [abs(Vector2(spotTimeMax,2)),abs(Vector2(spotTimeMax,3)),abs(Vector2(spotTimeMax,4)),abs(Vector2(spotTimeMax,5)),abs(Vector2(spotTimeMax,6)),...
                     abs(Vector2(spotTimeMax,7)),abs(Vector2(spotTimeMax,8)),abs(Vector2(spotTimeMax,9)),abs(Vector2(spotTimeMax,10)),abs(Vector2(spotTimeMax,11)),...
                     abs(Vector2(spotTimeMax,12)),abs(Vector2(spotTimeMax,13)),abs(Vector2(spotTimeMax,14)),abs(Vector2(spotTimeMax,15)),abs(Vector2(spotTimeMax,16)),...
                     abs(Vector2(spotTimeMax,17)),abs(Vector2(spotTimeMax,18)),abs(Vector2(spotTimeMax,19)),abs(Vector2(spotTimeMax,20)),abs(Vector2(spotTimeMax,21)),...
                     abs(Vector2(spotTimeMax,22)),abs(Vector2(spotTimeMax,23)),abs(Vector2(spotTimeMax,24)),abs(Vector2(spotTimeMax,25)),abs(Vector2(spotTimeMax,26)),...
                     abs(Vector2(spotTimeMax,27)),abs(Vector2(spotTimeMax,28)),abs(Vector2(spotTimeMax,29)),abs(Vector2(spotTimeMax,30)),abs(Vector2(spotTimeMax,31)),...
                     abs(Vector2(spotTimeMax,32)),abs(Vector2(spotTimeMax,33)),abs(Vector2(spotTimeMax,34)),abs(Vector2(spotTimeMax,35)),abs(Vector2(spotTimeMax,36)),...
                     abs(Vector2(spotTimeMax,37))];
             bar(x,y,0.4);
             disp('Now operating');
            
             
             xlabel({['マーカー番号    時刻:' num2str(0.02 * spotTimeMax)]});    ylabel('変位');
               xlim([0 37]);    ylim([0 0.002]);
                hold on
 
            drawnow             % drawnowを入れるとアニメーションになる
                    movmov(Num) = getframe(gcf,MonitorSize);           % アニメーションのフレームをゲットする

            Num = Num +1;
             end
            
                saveMovieName ='OptiMarker.avi';
            movie2avi(movmov, saveMovieName,  'compression', 'None', 'fps', 2);
         %%
%             MonitorSize = [ 0, 0, 1200, 800];
%             set(gcf, 'Position', MonitorSize);
%             Marker1 = Vector2(:,2);
%             Marker2 = Vector2(:,3);
%             Marker3 = Vector2(:,4);
%             Marker4 = Vector2(:,5);
%             Marker5 = Vector2(:,6);
%             Marker6 = Vector2(:,7);
%             Marker7 = Vector2(:,8);
%             Marker8 = Vector2(:,9);
%             Marker9 = Vector2(:,10);
%             Marker10 = Vector2(:,11);
%             Marker11 = Vector2(:,12);
%             Marker12 = Vector2(:,13);
%             Marker13 = Vector2(:,14);
%             Marker14 = Vector2(:,15);
%             Marker15 = Vector2(:,16);
%             Marker16 = Vector2(:,17);
%             Marker17 = Vector2(:,18);
%             Marker18 = Vector2(:,19);
%             Marker19 = Vector2(:,20);
%             Marker20 = Vector2(:,21);
%             Marker21 = Vector2(:,22);
%             Marker22 = Vector2(:,23);
%             Marker23 = Vector2(:,24);
%             Marker24 = Vector2(:,25);
%             Marker25 = Vector2(:,26);
%             Marker26 = Vector2(:,27);
%             Marker27 = Vector2(:,28);
%             Marker28 = Vector2(:,29);
%             Marker29 = Vector2(:,30);
%             Marker30 = Vector2(:,31);
%             Marker31 = Vector2(:,32);
%             Marker32 = Vector2(:,33);
%             Marker33 = Vector2(:,34);
%             Marker34 = Vector2(:,35);
%             Marker35 = Vector2(:,36);
%             Marker36 = Vector2(:,37);
%             
%             corr1 = corrcoef(Pulse,Marker1);
%             corr2 = corrcoef(Pulse,Marker2);
%             corr3 = corrcoef(Pulse,Marker3);
%             corr4 = corrcoef(Pulse,Marker4);
%             corr5 = corrcoef(Pulse,Marker5);
%             corr6 = corrcoef(Pulse,Marker6);
%             corr7 = corrcoef(Pulse,Marker7);
%             corr8 = corrcoef(Pulse,Marker8);
%             corr9 = corrcoef(Pulse,Marker9);
%             corr10 = corrcoef(Pulse,Marker10);
%             corr11 = corrcoef(Pulse,Marker11);
%             corr12 = corrcoef(Pulse,Marker12);
%             corr13 = corrcoef(Pulse,Marker13);
%             corr14 = corrcoef(Pulse,Marker14);
%             corr15 = corrcoef(Pulse,Marker15);
%             corr16 = corrcoef(Pulse,Marker16);
%             corr17 = corrcoef(Pulse,Marker17);
%             corr18 = corrcoef(Pulse,Marker18);
%             corr19 = corrcoef(Pulse,Marker19);
%             corr20 = corrcoef(Pulse,Marker20);
%             corr21 = corrcoef(Pulse,Marker21);
%             corr22 = corrcoef(Pulse,Marker22);
%             corr23 = corrcoef(Pulse,Marker23);
%             corr24 = corrcoef(Pulse,Marker24);
%             corr25 = corrcoef(Pulse,Marker25);
%             corr26 = corrcoef(Pulse,Marker26);
%             corr27 = corrcoef(Pulse,Marker27);
%             corr28 = corrcoef(Pulse,Marker28);
%             corr29 = corrcoef(Pulse,Marker29);
%             corr30 = corrcoef(Pulse,Marker30);
%             corr31 = corrcoef(Pulse,Marker31);
%             corr32 = corrcoef(Pulse,Marker32);
%             corr33 = corrcoef(Pulse,Marker33);
%             corr34 = corrcoef(Pulse,Marker34);
%             corr35 = corrcoef(Pulse,Marker35);
%             corr36 = corrcoef(Pulse,Marker36);
%             
%                  z = [corr1(1,2),corr2(1,2),corr3(1,2),corr4(1,2),corr5(1,2),...
%                      corr6(1,2),corr7(1,2),corr8(1,2),corr9(1,2),corr10(1,2),...
%                      corr11(1,2),corr12(1,2),corr13(1,2),corr14(1,2),corr15(1,2),...
%                      corr16(1,2),corr17(1,2),corr18(1,2),corr19(1,2),corr20(1,2),...
%                      corr21(1,2),corr22(1,2),corr23(1,2),corr24(1,2),corr25(1,2),...
%                      corr26(1,2),corr27(1,2),corr28(1,2),corr29(1,2),corr30(1,2),...
%                      corr31(1,2),corr32(1,2),corr33(1,2),corr34(1,2),corr35(1,2),...
%                      corr36(1,2)];
%              bar(x,z,0.9);
%             
%             xlabel('マーカー番号'); ylabel('操作波形との相関係数');
%             xlim([0 37]);    ylim([-1 1]);
%             
% 
% %%
% %             if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
% %                 obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_回帰直線からの距離とアバタ位置']);
% %             else
%                 obj.saveGraphWithName('相関係数');
% %             end
% disp(corr1);
% disp(corr25);
% %         function runForPair(obj,user1 ,user2)
% %             obj.runForAlone(user1);
% %             obj.runForAlone(user2);
% %             
% %         end

close all
