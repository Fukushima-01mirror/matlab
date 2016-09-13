classdef CSVreader0201_2 < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述
    
    %60000行のデータを3000行に直す(CSVファイルのみ)

    properties
    end

    methods
        function obj = CSVreader0201_2(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
          %%ファイル名設定
           optifilename = '0203_baske_my_2_fR_1P(footpressure_calibend).csv';
           %Take 2014-11-20 11.13.37 PM.csv
           %dataname = 'DATA1_04.csv';
%%          Optiでのマーカーの変位
            targetData = xlsread(optifilename,1,'A1:F929');disp('Target');
            disp('read');
%             disp(targetData);
            vel = zeros(929,1);
            VE = zeros(929,1);
            
            filename = strcat('ピーク検出',optifilename);
            A = vel;
            [pks,locs] = findpeaks(targetData(:,2));
            [pks2,locs2] = findpeaks(targetData(:,3));
            [pks3,locs3] = findpeaks(targetData(:,4));
            [pks4,locs4] = findpeaks(targetData(:,5));
            [pks5,locs5] = findpeaks(targetData(:,6));
            sheet = 1;
            xlRange = 'A1';
            
            disp(size(targetData));
            LO = transpose(locs);
            LO2 = transpose(locs2);
            LO3 = transpose(locs3);
            LO4 = transpose(locs4);
            LO5 = transpose(locs5);
            LLO = zeros(length(LO),10);
            
            for i=1:1:length(LO);
               LLO(i,1) = targetData((LO(i)),1) ;
               LLO(i,2) = targetData((LO(i)),2) ; 
            end
             for i=1:1:length(LO2);
               LLO(i,3) = targetData((LO2(i)),1) ;
               LLO(i,4) = targetData((LO2(i)),3) ;
              
             end
             for i=1:1:length(LO3);
             
               LLO(i,5) = targetData((LO3(i)),1) ;
               LLO(i,6) = targetData((LO3(i)),4) ;
              
             end
             for i=1:1:length(LO4);
              
               LLO(i,7) = targetData((LO4(i)),1) ;
               LLO(i,8) = targetData((LO4(i)),5) ; 
             
             end
            for i=1:1:length(LO5);
              
               LLO(i,9) = targetData((LO5(i)),1) ;
               LLO(i,10) = targetData((LO5(i)),6) ; 
             
            end
%             disp(size(LLO));
%             
%             figure
%             
%             plot(LLO(1711:1811,1),LLO(1711:1811,3),'Color','b','LineStyle','-','Marker','s','MarkerEdgeColor','k');
%             
%             xlim([7540 7640]);
%             ylim([0.5 1.5]);
%             set(gca, 'XTick', [7540:10:7640]);
%             set(gca, 'YTick', [0.5:0.1:1.5]);
%             set(gca, 'XTickLabel', {'7540' '' '' '' '' '' '' '' '' '' '7640'});
%             set(gca, 'YTickLabel', {'0.5' '' '' '' '' '1.0' '' '' ''  '' '1.5'});
%             hold on
            xlswrite(filename,LLO,sheet,xlRange);
            
%             [pks,locs] = findpeaks(vel);
%             disp([pks,locs]);

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