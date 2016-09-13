classdef AvatarFollowPerformance_verLS < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = AvatarFollowPerformance_verLS(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForPair(obj,user1,user2)
            
            
            %1Pがフォロワーの時
            reverseIndex = find( user1.avatarVelocity.highSampled .* user2.avatarVelocity.highSampled < 0 );    %アバタが逆行時のインデックス
            reverseLowSampleIndex = find( diff( user1.avatarPosition.lowSampled ) .*  diff(user2.avatarPosition.lowSampled) < 0 );    %アバタが逆行時のインデックス

            reverseTimeGroupe(1,1) = user1.time.lowSampled( reverseLowSampleIndex(1) );  % timeGroupStart
            k=1;    %Group index
            for i=2 :length(reverseLowSampleIndex)
                if reverseLowSampleIndex(i) - reverseLowSampleIndex(i-1) > 20 %逆行の終わりを判定　+短すぎるのは結合
                    reverseTimeGroupe(k,2) = user1.time.lowSampled( reverseLowSampleIndex(i-1) );  % timeGroupEnd
                    reverseTimeGroupe(k,3) =  reverseTimeGroupe(k,2) - reverseTimeGroupe(k,1);  %逆行時間
                    k=k+1;  %
                    reverseTimeGroupe(k,1) = user1.time.lowSampled( reverseLowSampleIndex(i) );
                elseif i == length(reverseLowSampleIndex)
                    reverseTimeGroupe(k,2) = user1.time.lowSampled( reverseLowSampleIndex(i) );
                    reverseTimeGroupe(k,3) =  reverseTimeGroupe(k,2) - reverseTimeGroupe(k,1);  %逆行時間
                end
            end
            
            %フォロワーの反応までの時間を色分け
            hold on;
            for i=1 :length(reverseTimeGroupe)
                x = [reverseTimeGroupe(i,1) reverseTimeGroupe(i,1) reverseTimeGroupe(i,2) reverseTimeGroupe(i,2)];
                y = [0 1000 1000 0];
                if reverseTimeGroupe(i,1)>5000 && reverseTimeGroupe(i,3)>20 ...  %初めと短すぎるのは除外
%                         && user1.avatarVelocity.highSampled(reverseTimeGroupe(i,2)) ...       %かつ，逆行の終わりがフォロワーの方向転換時のみ
%                            * user1.avatarVelocity.highSampled(reverseTimeGroupe(i,2)+1) <0    %→反応時間
                       
                    fill(x,y,[0.85 0.85 0.85],'LineStyle','none');
                    reverseTimeGroupe(i,4) = 1;   %→反応時間
                elseif reverseTimeGroupe(i,1)>5000 && reverseTimeGroupe(i,3)>20 ...  %初めと短すぎるのは除外
%                         && user2.avatarVelocity.highSampled(reverseTimeGroupe(i,2)) ...       %かつ，逆行の終わりがリーダーの方向転換時のみ
%                            * user2.avatarVelocity.highSampled(reverseTimeGroupe(i,2)+1) <0    %→未反応時間

                    fill(x,y,[0.95 0.85 0.95],'LineStyle','none');
                    reverseTimeGroupe(i,4) = 2;    %→未反応時間
                end
            end
            
            plot(   user1.time.highSampled,  user1.avatarPosition.highSampled,'b',...
                user2.time.highSampled,  user2.avatarPosition.highSampled,'g',...
                user2.time.highSampled(5000:end),  user2.avatarPosition.highSampled(5000:end) - user1.avatarPosition.highSampled(5000:end) ,'r:');               
            title('avatarDistance');
            xlabel('時間t ms'); ylabel('アバタ間距離');
            xlim([0,60000]);    ylim([0 1000]);
                set(gca,'XTick',[0:5000:60000]);
            meanDist = mean( user2.avatarPosition.highSampled(5000:end) - user1.avatarPosition.highSampled(5000:end) );
            plot( [5000 60000],  [meanDist meanDist] ,'r-.');               
            plot( [5000 5000],  [0 1000] ,'k:');               
            hold off
            
            MonitorSize = [ 0, 0, 1200, 400];
            set(gcf, 'Position', MonitorSize);
            obj.saveGraph();
            
            if reverseTimeGroupe(i,3) == 1
                
            elseif reverseTimeGroupe(i,3) == 2
                
            end
%             output = ;
%             obj.outputAllToXls(output ,{'平均アバタ間距離','最大逆行時間','平均逆行時間','合計逆行時間', ...
%                                         '','最大反応時間','平均反応時間','合計反応時間', ...
%                                         '','最大未反応時間','平均未反応時間','合計未反応時間'});

        end

    end
end
