classdef AvatarFollowPerformance < Analyze.Base
    %STANDARDDEVIATION ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q

    properties
    end

    methods
        function obj = AvatarFollowPerformance(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForPair(obj,user1,user2)
            
            
            %1P���t�H�����[�̎�
            reverseIndex = find( user1.avatarVelocity.highSampled .* user2.avatarVelocity.highSampled < 0 );    %�A�o�^���t�s���̃C���f�b�N�X
%             reverseIndex = find( diff( user1.avatarPosition.lowSampled ) .*  diff(user2.avatarPosition.lowSampled) < 0 );    %�A�o�^���t�s���̃C���f�b�N�X

            reverseTimeGroup(1,1) = reverseIndex(1);  % timeGroupStart
            k=1;
            for i=2 :length(reverseIndex)
                if reverseIndex(i) - reverseIndex(i-1) > 1 %�t�s�̏I���𔻒�@+�Z������̂͌���
                    reverseTimeGroup(k,2) = reverseIndex(i-1);  % timeGroupEnd
                    reverseTimeGroup(k,3) = reverseTimeGroup(k,2) - reverseTimeGroup(k,1);  % �t�s����
                    k=k+1;
                    reverseTimeGroup(k,1) = reverseIndex(i);
                elseif i == length(reverseIndex)
                    reverseTimeGroup(k,2) = reverseIndex(i);
                    reverseTimeGroup(k,3) = reverseTimeGroup(k,2) - reverseTimeGroup(k,1);  % �t�s����
                end
    
                
            end
            
            %�t�H�����[�̔����܂ł̎��Ԃ�F����
            k=1;    j=1;
            hold on;
            for i=2 :length(reverseTimeGroup)
                
                if reverseTimeGroup(i,2) ~= 60000       % �G���[�΍�@���O

                    if reverseTimeGroup(i,1)>5000 && reverseTimeGroup(i,3) >1 ...  %���߂ƒZ������̂͏��O
                            && user1.avatarVelocity.highSampled(reverseTimeGroup(i,2)) ...
                               * user1.avatarVelocity.highSampled(reverseTimeGroup(i,2)+1) <0    %���C�t�s�̏I��肪�t�H�����[�̕����]�����̂�

                        x = [reverseTimeGroup(i,1) reverseTimeGroup(i,1) reverseTimeGroup(i,2) reverseTimeGroup(i,2)];
                        y = [0 1000 1000 0];
                        fill(x,y,[0.85 0.85 0.85],'LineStyle','none');
                        reactingTime(j,:) = reverseTimeGroup(i,:);   %����������
                        j=j+1;
                    elseif reverseTimeGroup(i,1)>5000 && reverseTimeGroup(i,3) >1 ...  %���߂ƒZ������̂͏��O
                            && user2.avatarVelocity.highSampled(reverseTimeGroup(i,2)) ...
                               * user2.avatarVelocity.highSampled(reverseTimeGroup(i,2)+1) <0    %���C�t�s�̏I��肪�t�H�����[�̕����]�����̂�

                        x = [reverseTimeGroup(i,1) reverseTimeGroup(i,1) reverseTimeGroup(i,2) reverseTimeGroup(i,2)];
                        y = [0 1000 1000 0];
                        fill(x,y,[0.95 0.85 0.95],'LineStyle','none');
                        unreactingTime(k,:) = reverseTimeGroup(i,:);   %����������
                        k=k+1;
                    end
                    
                end
            end
            
            distAvt = user2.avatarPosition.highSampled - user1.avatarPosition.highSampled;
            plot(   user1.time.highSampled,  user1.avatarPosition.highSampled,'b',...
                user2.time.highSampled,  user2.avatarPosition.highSampled,'g',...
                user2.time.highSampled(5000:end),  distAvt(5000:end) ,'r:');               
            title('avatarDistance');
            xlabel('����t ms'); ylabel('�A�o�^�ԋ���');
            xlim([0,60000]);    ylim([0 1000]);
                set(gca,'XTick',[0:5000:60000]);
            meanDist = mean( distAvt(5000:end) );
            stdDist = std( distAvt(5000:end) );
            plot( [5000 60000],  [meanDist meanDist] ,'r-.');               
            plot( [5000 5000],  [0 1000] ,'k:');               
            hold off
            
            MonitorSize = [ 0, 0, 1200, 400];
            set(gcf, 'Position', MonitorSize);
            obj.saveGraph();
            
            outputTitle = {'�A�o�^�ԋ�������','�A�o�^�ԋ������U',...
                            '�ő�t�s����','���ϋt�s����','���v�t�s����', ...
                            '�ő唽������','���ϔ�������','���v��������', ...
                            '�ő喢��������','���ϖ���������','���v����������'} ;
            overIndex = find( reverseTimeGroup(:,1)>5000 );
            reverseTimeOutput = { max( reverseTimeGroup(overIndex:end,3) ), mean( reverseTimeGroup(overIndex:end,3) ), sum( reverseTimeGroup(overIndex:end,3) ) };
            rectingTimeOutput = { max( reactingTime(:,3) ), mean( reactingTime(:,3) ), sum( reactingTime(:,3) ) };
            unrectingTimeOutput = { max( unreactingTime(:,3) ), mean( unreactingTime(:,3) ), sum( unreactingTime(:,3) ) };
            output = horzcat( meanDist, stdDist, reverseTimeOutput , rectingTimeOutput , unrectingTimeOutput);
            obj.outputAllToXls(output , outputTitle);

        end

    end
end


