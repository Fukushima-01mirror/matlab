classdef OperatePulsesCorrelation < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = OperatePulsesCorrelation(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)

        end

        function runForPair(obj,user1,user2)
            
            filterdPul1 = Rhythm.BPfilter( user1.operatePulse.lowSampled);
            filterdPul2 = Rhythm.BPfilter( user2.operatePulse.lowSampled);
            
            [timeCorr, AB_Series0, AB_Series_Max] = Rhythm.AllCorr__func(filterdPul1, filterdPul2, user2.time.lowSampled, 100);
            
            for i = 1:6
                subplot(6,1,i,'align')
                [haxes,hline1,hline2] = plotyy( user1.time.lowSampled, filterdPul1,  timeCorr, AB_Series_Max(:,2));
                set(hline1,'Color','b');
                set(hline2,'Color','r');
                set(haxes(1),'YColor','k');
                set(haxes(2),'YColor','r');
                
                hold( haxes(1),'on') % 重ね書きモードオン
                plot(   haxes(1), user2.time.lowSampled,  filterdPul2 ,'Color', [0 .498 0] );   
                
                plot(   haxes(1), user1.time.highSampled,  user1.operatePulse.highSampled ,'b:');
                plot(   haxes(1), user2.time.highSampled,  user2.operatePulse.highSampled ,'LineStyle',':','Color', [0 .498 0]);

                hold( haxes(2),'on') % 重ね書きモードオン
                plot( haxes(2),[0 60000], [0.8 0.8],'k:');
                hold off
                
                axes(haxes(1))
                xlabel('時間t ms'); ylabel('コントローラ操作');
                xlim([10000*(i-1) 10000*i]);    ylim([-400 400]);
                set(gca,'YTick',[-400:200:400]);

                axes(haxes(2))
                xlabel('時間t ms'); ylabel('最大相互相関');
                xlim([10000*(i-1) 10000*i]);    ylim([0 1]);
                set(gca,'YTick',[0:0.2:1]);
            end
            MonitorSize = [ 0, 0, 1200, 1000];
            set(gcf, 'Position', MonitorSize);
            obj.saveGraphWithName([ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state ]);
        end

    end
end
