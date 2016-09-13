classdef AvatarPositionCorrelation < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = AvatarPositionCorrelation(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)

        end

        function runForPair(obj,user1,user2)
            
                    
            for i = 1:6
                subplot(3,2,i,'align')
                [timeCorr, AB_Series0, AB_Series_Max] = ...
                   Rhythm.AllCorr_option_func( user1.avatarPosition.lowSampled , user2.avatarPosition.lowSampled , user2.time.lowSampled, 50*i, 'coef');
                [haxes,hline1,hline2] = plotyy( user1.time.lowSampled, user1.avatarPosition.lowSampled,  timeCorr, AB_Series_Max(:,2));
                set(hline1,'Color','b');
                set(hline2,'Color','r');
                set(haxes(1),'YColor','k');
                set(haxes(2),'YColor','r');
                
                hold( haxes(1),'on') % 重ね書きモードオン
                plot(   haxes(1), user2.time.lowSampled,  user2.avatarPosition.lowSampled  ,'Color', [0 .498 0] );   
                

                hold( haxes(2),'on') % 重ね書きモードオン
%                 plot( haxes(2),[0 60000], [0.8 0.8],'k:');
                hold off
                
                axes(haxes(1))
                xlabel('時間t ms'); ylabel('アバタ間距離');
                xlim([0,60000]);    ylim([0 1000]);

                axes(haxes(2))
                xlabel('時間t ms'); ylabel('最大相互相関');
                xlim([0,60000]);
                ylim([0 1]);
                set(gca,'YTick',[0:0.2:1]);
            end
            MonitorSize = [ 0, 0, 1200, 1000];
            set(gcf, 'Position', MonitorSize);
            obj.saveGraph();
        end

    end
end
