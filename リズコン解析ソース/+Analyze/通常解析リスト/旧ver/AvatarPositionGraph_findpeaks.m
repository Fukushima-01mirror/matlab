classdef AvatarPositionGraph_findpeaks < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = AvatarPositionGraph_findpeaks(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
            MonitorSize = [ 0, 0, 700, 800];
            set(gcf, 'Position', MonitorSize);
            
            r_fig= 3;
            subplot(r_fig,1,1);
            plot(   user.time.highSampled,  user.avatarPosition.highSampled);               
            [pks_upper ,locs_upper] = findpeaks( user.avatarPosition.highSampled );
            [pks_lower,locs_lower] = findpeaks( -user.avatarPosition.highSampled );
            hold on 
            plot(   user.time.highSampled(locs_upper),  pks_upper' , 'Marker','o', 'MarkerEdgeColor' , 'r' ,'LineStyle','none'); 
            plot(   user.time.highSampled(locs_lower),  -pks_lower' , 'Marker','o', 'MarkerEdgeColor' , 'r' ,'LineStyle','none'); 
            hold off
%             pks = [pks_upper' locs_upper'; -pks_lower' locs_lower'];
%             pks = sortrows(pks,2);
%             k= 2;
%             while k <length(pks)
%                for k = 2: length(pks) 
% %                    if abs( pks(k,2) - pks(k+1,2) ) < 1000 % 時間間隔が小さい時
%                    if abs( pks(k,1) - pks(k-1,1) ) < 100 % 時間間隔が小さい時
%                        pks(k,:) = [];
%                        break
%                    end
%                end
%                hold on
%                     plot(   user.time.highSampled( pks(1:k-1,2) ),  pks(1:k-1,1) , 'Marker','o', 'MarkerEdgeColor' , 'm' ,'LineStyle','none');
%                hold off
%             end
%             
%             hold on 
%             plot(   user.time.highSampled( pks(:,2) ),  pks(:,1) , 'Marker','o', 'MarkerEdgeColor' , 'r' ,'LineStyle','none'); 
%             hold off
            xlabel('時間t ms'); ylabel('アバタ位置');
            xlim([0,60000]);    ylim([0 1000]);
            
%             t_width = 500;
%             ts_trend05 = [t_width/2 : user.time.highSampled(end)-t_width/2];
%             k=1;
%             for spotMax = t_width: user.time.highSampled(end)
%                 avtPos_trend05(k) = mean( user.avatarPosition.highSampled (spotMax-t_width+1:spotMax) );
%                 k=k+1;
%             end
%             plot( user.time.highSampled,  user.avatarPosition.highSampled , ...
%                 ts_trend05 ,avtPos_trend05 );
%             [pks_upper ,locs_upper] = findpeaks( avtPos_trend05 );
%             [pks_lower,locs_lower] = findpeaks( -avtPos_trend05 );
%             hold on 
%             plot(  ts_trend05(locs_upper),  pks_upper' , 'Marker','o', 'MarkerEdgeColor' , 'r' ,'LineStyle','none'); 
%             plot(   ts_trend05(locs_lower),  -pks_lower' , 'Marker','o', 'MarkerEdgeColor' , 'r' ,'LineStyle','none'); 
%             hold off
%             xlabel('時間t ms'); ylabel('アバタ位置');
%             xlim([0,60000]);    ylim([0 1000]);
            
            subplot(r_fig,1,2);
            t_width = 1000;
            avtPos_trend1 = smooth( user.avatarPosition.highSampled , t_width , 'moving');
            plot( user.time.highSampled,  user.avatarPosition.highSampled , ...
               user.time.highSampled ,avtPos_trend1 );
            [pks_upper ,locs_upper] = findpeaks( avtPos_trend1 );
            [pks_lower,locs_lower] = findpeaks( -avtPos_trend1 );
            hold on 
            plot(  user.time.highSampled(locs_upper),  pks_upper' , 'Marker','o', 'MarkerEdgeColor' , 'r' ,'LineStyle','none'); 
            plot(   user.time.highSampled(locs_lower),  -pks_lower' , 'Marker','o', 'MarkerEdgeColor' , 'r' ,'LineStyle','none'); 
            hold off
            xlabel('時間t ms'); ylabel('アバタ位置');
            xlim([0,60000]);    ylim([0 1000]);
            title('移動平均　1秒');

            subplot(r_fig,1,3);
            t_width = 1500;
            avtPos_trend15 = smooth( user.avatarPosition.highSampled , t_width , 'moving');
            plot( user.time.highSampled,  user.avatarPosition.highSampled , ...
                user.time.highSampled ,avtPos_trend15 );
            [pks_upper ,locs_upper] = findpeaks( avtPos_trend15 );
            [pks_lower,locs_lower] = findpeaks( -avtPos_trend15 );
            hold on 
            plot(  user.time.highSampled(locs_upper),  pks_upper' , 'Marker','o', 'MarkerEdgeColor' , 'r' ,'LineStyle','none'); 
            plot(   user.time.highSampled(locs_lower),  -pks_lower' , 'Marker','o', 'MarkerEdgeColor' , 'r' ,'LineStyle','none'); 
            hold off
            xlabel('時間t ms'); ylabel('アバタ位置');
            xlim([0,60000]);    ylim([0 1000]);
            title('移動平均　1.5秒');            
            
            
             obj.saveGraph();
           
        end

%         function runForPair(obj,user1,user2)
%             plot(   user1.time.lowSampled,  user1.avatarPosition.lowSampled...
%                 ,user2.time.lowSampled,
%                 user2.avatarPosition.lowSampled);               
%             title('avatarPosition');
%             legend('Player1', 'Player2');
%             xlabel('時間t ms'); ylabel('アバタ位置');
%             xlim([0,60000]);    ylim([0 1000]);
%             MonitorSize = [ 0, 0, 700, 250];
%             set(gcf, 'Position', MonitorSize);
%             obj.saveGraph();
%         end

    end
end
