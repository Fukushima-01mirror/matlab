classdef LibetAna0811 < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = LibetAna0811(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
           [period_zx, peak_zx] = Rhythm.setZeroCrossPeriodData(user.zeroCrossData);
           %　ゼロクロス間でのピーク回数取得
           [zeroCrossTimes] = Rhythm.setZeroCrossCount(user.zeroCrossData);
            
            Y = abs( user.zeroCrossData.nonlogAvtVelocity );
            dT = abs( period_zx(:,3) );
            dA = abs( peak_zx(:,3) );
            cT = abs( period_zx(:,1) );
            cA = abs( peak_zx(:,1));
            Time = abs( user.zeroCrossData.zeroCrossTime );
            if obj.currentRunType == obj.runTypePlayer1
                IndexZeroCross = find(zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2 ...
                    & obj.data.player1.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) );
                IndexNonZeroCross = find( zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1 ...
                    & obj.data.player1.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) );
            elseif obj.currentRunType == obj.runTypePlayer2
                IndexZeroCross = find(zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2 ...
                    & obj.data.player2.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) );
                IndexNonZeroCross = find( zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1 ...
                    & obj.data.player2.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) );
            end

            Y_zc  = Y(IndexZeroCross);        Y_nzc  = Y(IndexNonZeroCross);
            dT_zc = dT(IndexZeroCross,:);     dT_nzc = dT(IndexNonZeroCross,:);
            dA_zc = dA(IndexZeroCross,:);     dA_nzc = dA(IndexNonZeroCross,:);
            cT_zc = cT(IndexZeroCross,:);     cA_zc = cA(IndexZeroCross,:);
            Time_zc = Time(IndexZeroCross);        Time_nzc  = Time(IndexNonZeroCross);
            %外れ値を除外するため，最大データ２つをカット
            [dT_max,dT_imax] = max(dT_zc);     dT_zc(dT_imax)= [];	 dA_zc(dT_imax)= [];     Y_zc(dT_imax)= [];     Time_zc(dT_imax)= [];   cT_zc(dT_imax)= [];     cA_zc(dT_imax)= [];
            [dT_max,dT_imax] = max(dT_zc);     dT_zc(dT_imax)= [];	 dA_zc(dT_imax)= [];     Y_zc(dT_imax)= [];     Time_zc(dT_imax)= [];   cT_zc(dT_imax)= [];     cA_zc(dT_imax)= [];
            [dA_max,dA_imax] = max(dA_zc);     dT_zc(dA_imax)= [];	 dA_zc(dA_imax)= [];     Y_zc(dA_imax)= [];     Time_zc(dA_imax)= [];   cT_zc(dA_imax)= [];     cA_zc(dA_imax)= [];
            [dA_max,dA_imax] = max(dA_zc);     dT_zc(dA_imax)= [];	 dA_zc(dA_imax)= [];     Y_zc(dA_imax)= [];     Time_zc(dA_imax)= [];   cT_zc(dA_imax)= [];     cA_zc(dA_imax)= [];
%             [Y_max,Y_imax] = max(Y_zc);     dT_zc(Y_imax)= [];	 dA_zc(Y_imax)= [];     Y_zc(Y_imax)= [];
%             [Y_max,Y_imax] = max(Y_zc);     dT_zc(Y_imax)= [];
%             dA_zc(Y_imax)= [];     Y_zc(Y_imax)= [];
            Nzc = length(Y_zc) ;
            Nnzc = length(Y_nzc) ;

%%        ΔAとΔTの散布図
             set(gcf, 'Position', [ 0, 0, 1600, 1600]);
             a1 = subplot(3,1,1);
             plot(user.time.lowSampled(1:2500),user.avatarPosition.lowSampled(1:2500),'Color' , 'b' );
            grid on
            hold on
             for j= 1:length(user.time.lowSampled)
                 if rem(user.time.lowSampled(j),3000) == 0
                      plot([user.time.lowSampled(j) user.time.lowSampled(j)],[0 1000],...
                          'Color' , 'k' , 'LineStyle', '--');
                 end
             end
            xlabel('時間t ms'); ylabel('アバタ位置');
            xlim([0 40000]); 
            ylim([0 1000]);
            a2= subplot(3,1,2);
             plot(user.time.highSampled(1:50000),user.avatarVelocity.highSampled(1:50000),'Color' , 'b' );
            grid on
            hold on
             for j= 1:length(user.time.lowSampled)
                 if rem(user.time.lowSampled(j),3000) == 0
                      plot([user.time.lowSampled(j) user.time.lowSampled(j)],[-0.2 0.2],...
                          'Color' , 'k' , 'LineStyle', '--');
                 end
             end
            xlabel('時間t ms'); ylabel('アバタ速度');
            xlim([0 40000]);    
            ylim([-0.2 0.2]);
            a3= subplot(3,1,3);
            dAdT=zeros(Nzc,1);
            for i=1:Nzc
                dAdT(i,1)=dA_zc(i)/dT_zc(i);
            end
            plot(Time_zc,dAdT(:,1),'Color' , 'b');
            grid on
            hold on
             for j= 1:length(user.time.lowSampled)
                if rem(user.time.lowSampled(j),3000) == 0
                     plot([user.time.lowSampled(j) user.time.lowSampled(j)],[-6 6],...
                         'Color' , 'k' , 'LineStyle', '--');
                end
             end
            xlabel('時間t ms'); ylabel('dA/dT');
            xlim([0 40000]);   
             ylim([-6 6]);
            
           %%
            if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_回帰直線からの距離とアバタ位置']);
            else
                obj.saveGraphWithName('リベット実験波形');
            end
%                        %%        ΔAとΔTの散布図
%              set(gcf, 'Position', [ 0, 0, 800, 800]);
%              L=3000;
%               NFFT= 2^nextpow2(L);
%             Y= fft(user.operatePulse.highSampled(27001:30000),NFFT)/L;
%             f=1000/2*linspace(0,1,NFFT/2+1);
%             plot(f,2*abs(Y(1:NFFT/2+1))); 
%             xlabel('Frequency (Hz)');ylabel('|Y(f)|');
%             xlim([0 50]);
%            %%
%             if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
%                 obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_回帰直線からの距離とアバタ位置']);
%             else
%                 obj.saveGraphWithName('波形解析3');
%             end
            


        function runForPair(obj,user1 ,user2)
%             obj.runForAlone(user1);
%             obj.runForAlone(user2);
%             
            
        end
    end
        
end
end