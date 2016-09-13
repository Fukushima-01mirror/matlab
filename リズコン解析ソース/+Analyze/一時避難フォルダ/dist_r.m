classdef dist_r < Analyze.Base
    %STANDARDDEVIATION ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q

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
                    % ���������̕`��
                    if ~isempty( strfind( char(obj.config.examType), '�ǂ����܂�') ) ...
                            || ~isempty( strfind( char(obj.config.examType), '�ǂ����ގ���') )
                        plot(   obj.data.com.time,  obj.data.com.avatarPosition , 'k:');               
                        if ~isempty(strfind( char(obj.config.examType), '����') )  
                            plot(   obj.data.com2.time,  obj.data.com2.avatarPosition , 'k:');     
                        end
                    elseif ~isempty(  findstr( char( obj.config.examType ) , '�Ǐ]'))
                        if ~isempty(  findstr( char( obj.config.examType ) , '�ڕW�Ǐ]'))
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
           if ~isempty(strfind( char(obj.config.examType) , '�����ΐ�'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state ]);
            else
                obj.saveGraph();
            end

%             %%      �ߎ��ʁ@�W���@�G�N�Z���f�[�^�o��  
%             outputTitle = { '�萔��', '������', '(�W����)',...
%                                     '�U����', '(�W����)', '�d����R', '�d����R2' ,'�W���덷(�c���̕W���΍�)' };
%             output = num2cell( [fitParam3(1) fitParam3(2) zfitParam(2) fitParam3(3) zfitParam(3) fitR fitR2 SER ] );
%             
%             if ~isempty(strfind( char(obj.config.examType) , '�����ΐ�'))
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
