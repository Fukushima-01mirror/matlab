classdef dist_r < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = dist_r(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
            
            figure
%                time_break = user.zeroCrossData.zeroCrossTime(index_break);
%                time_else =  user.zeroCrossData.zeroCrossTime(index_else);
% %                 time_nonBreak = user.zeroCrossData.zeroCrossTime(index_nonBreak);
               plot(   user.time.highSampled,  user.avatarPosition.highSampled);         
               hold on
                    % 実験条件の描画
                    if ~isempty( strfind( char(obj.config.examType), '追い込まれ') ) ...
                            || ~isempty( strfind( char(obj.config.examType), '追い込む実験') )
                        plot(   obj.data.com.time,  obj.data.com.avatarPosition , 'k:');               
                        if ~isempty(strfind( char(obj.config.examType), '両側') )  
                            plot(   obj.data.com2.time,  obj.data.com2.avatarPosition , 'k:');     
                        end
                    elseif ~isempty(  findstr( char( obj.config.examType ) , '追従'))
                        if ~isempty(  findstr( char( obj.config.examType ) , '目標追従'))
                            plot(   obj.data.task.time,  obj.data.task.avatarPosition , 'color' ,[.8 .8 .8]);   
                            plot(   obj.data.task.time,  obj.data.task.avatarPosition-75 , 'color' ,[.8 .8 .8]);   
                        else
                            plot(   obj.data.task.time,  obj.data.task.avatarPosition , 'k:');   
                        end
                    elseif obj.config.isExistPlayer1 && obj.config.isExistPlayer2
                        if obj.currentRunType == obj.runTypePlayer1
                            plot( obj.data.player2.time.highSampled , obj.data.player2.avatarPosition.highSampled , 'k');
                            dist = abs(user.avatarPosition.highSampled -obj.data.player2.avatarPosition.highSampled);
                            plot( obj.data.player1.time.highSampled , dist,':r');
                        elseif obj.currentRunType == obj.runTypePlayer2
                            dist = abs(user.avatarPosition.highSampled -obj.data.player1.avatarPosition.highSampled);
                            plot( obj.data.player1.time.highSampled , dist,':r');
                            plot( obj.data.player1.time.highSampled , obj.data.player1.avatarPosition.highSampled , 'k');
                            
                        end
                    end
%                     for i= 1:length(time_break)
%                         plot([time_nonBreak(i) time_nonBreak(i)], [0 1000], 'm');
%                         plot([time_break(i) time_break(i)], [0 1000], 'm');
%                     end
                hold off
           if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state ]);
            else
                obj.saveGraph();
            end

%             %%      近似面　係数　エクセルデータ出力  
%             outputTitle = { '定数項', '周期差', '(標準化)',...
%                                     '振幅差', '(標準化)', '重相関R', '重決定R2' ,'標準誤差(残差の標準偏差)' };
%             output = num2cell( [fitParam3(1) fitParam3(2) zfitParam(2) fitParam3(3) zfitParam(3) fitR fitR2 SER ] );
%             
%             if ~isempty(strfind( char(obj.config.examType) , '剣道対戦'))
%                 obj.outputAllToXlsWithName([ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state ] , output , outputTitle)
%             else
%                 obj.outputAllToXls(output , outputTitle);
%             end
% 
        end

        function runForPair(obj,user1 ,user2)
%             obj.runForAlone(user1);
%             obj.runForAlone(user2);
%             
            
        end

        
    end
end
