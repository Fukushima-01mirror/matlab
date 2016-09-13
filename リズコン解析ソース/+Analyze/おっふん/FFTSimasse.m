classdef FFTSimasse < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = FFTSimasse(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
          %%ファイル名設定
           filename ='0919ΔT②.xlsx';
           sheet = 1;
           %Take 2014-11-20 11.13.37 PM.csv
           %dataname = 'DATA1_04.csv';
%%          Optiでのマーカーの変位
            
            

            fs = 50;
%             timeData = data.Frame / fs;
            
            y = xlsread(filename,sheet,'A121:A3001');disp('xlsreading...');
            nfft = pow2( nextpow2(length(y)));disp(length(y));
            Y = fft(y,length(y));    
            Pyy = Y.*conj(Y)/length(y);
            f = fs/length(y)*(0:nfft/2 - 1);
            
            x0621x=f(10:nfft/2);
            y0621y=transpose(Pyy(10:nfft/2));
    
    
            subplot(1,1,1);
    %この下省略されていた
%     
             %loglog(x0621x,y0621y,'Marker','*', 'LineStyle','none','MarkerSize',2);
             loglog(x0621x,y0621y);
%              fitParam = polyfit( x0621x , y0621y ,1);
%              yfit= polyval(fitParam,x0621x);
%              yresid = y0621y - yfit;
%              SSresid = sum(yresid.^2);
%              SStotal = (length(y0621y)-1) * var(y0621y);
%              rsq = 1 - SSresid/SStotal;
%             
%              disp('rsq');
%              disp(rsq);
            
            hold on    
            [aaa,bbb] = max(Pyy(10:nfft/2));    
            
            title(num2str(f(bbb + 9)));
           
            
            MonitorSize = [ 0, 0, 800, 800];
            set(gcf, 'Position', MonitorSize);
            %plot(f([bbb+9 bbb+9]),ylim,'r');
%             loglog(x0621x,yfit,'r');
            hold off
            xlabel('Frequency Hz'); ylabel('Amplitude');
            xlim([10^(-1),10^2]);
            ylim([10^(-6),10^8]);
            title(strcat('FFT',num2str(f(bbb + 9))));
            obj.saveGraphWithName(strcat('X_FFT',filename));
            %saveas(gcf,strcat('Y_FFT',filename,'.jpg'));
           
            

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