classdef AvatarFollowPerformance_verLS < Analyze.Base
    %STANDARDDEVIATION ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q

    properties
    end

    methods
        function obj = AvatarFollowPerformance_verLS(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForPair(obj,user1,user2)
            
            
            %1P���t�H�����[�̎�
            reverseIndex = find( user1.avatarVelocity.highSampled .* user2.avatarVelocity.highSampled < 0 );    %�A�o�^���t�s���̃C���f�b�N�X
            reverseLowSampleIndex = find( diff( user1.avatarPosition.lowSampled ) .*  diff(user2.avatarPosition.lowSampled) < 0 );    %�A�o�^���t�s���̃C���f�b�N�X

            reverseTimeGroupe(1,1) = user1.time.lowSampled( reverseLowSampleIndex(1) );  % timeGroupStart
            k=1;    %Group index
            for i=2 :length(reverseLowSampleIndex)
                if reverseLowSampleIndex(i) - reverseLowSampleIndex(i-1) > 20 %�t�s�̏I���𔻒�@+�Z������̂͌���
                    reverseTimeGroupe(k,2) = user1.time.lowSampled( reverseLowSampleIndex(i-1) );  % timeGroupEnd
                    reverseTimeGroupe(k,3) =  reverseTimeGroupe(k,2) - reverseTimeGroupe(k,1);  %�t�s����
                    k=k+1;  %
                    reverseTimeGroupe(k,1) = user1.time.lowSampled( reverseLowSampleIndex(i) );
                elseif i == length(reverseLowSampleIndex)
                    reverseTimeGroupe(k,2) = user1.time.lowSampled( reverseLowSampleIndex(i) );
                    reverseTimeGroupe(k,3) =  reverseTimeGroupe(k,2) - reverseTimeGroupe(k,1);  %�t�s����
                end
            end
            
            %�t�H�����[�̔����܂ł̎��Ԃ�F����
            hold on;
            for i=1 :length(reverseTimeGroupe)
                x = [reverseTimeGroupe(i,1) reverseTimeGroupe(i,1) reverseTimeGroupe(i,2) reverseTimeGroupe(i,2)];
                y = [0 1000 1000 0];
                if reverseTimeGroupe(i,1)>5000 && reverseTimeGroupe(i,3)>20 ...  %���߂ƒZ������̂͏��O
%                         && user1.avatarVelocity.highSampled(reverseTimeGroupe(i,2)) ...       %���C�t�s�̏I��肪�t�H�����[�̕����]�����̂�
%                            * user1.avatarVelocity.highSampled(reverseTimeGroupe(i,2)+1) <0    %����������
                       
                    fill(x,y,[0.85 0.85 0.85],'LineStyle','none');
                    reverseTimeGroupe(i,4) = 1;   %����������
                elseif reverseTimeGroupe(i,1)>5000 && reverseTimeGroupe(i,3)>20 ...  %���߂ƒZ������̂͏��O
%                         && user2.avatarVelocity.highSampled(reverseTimeGroupe(i,2)) ...       %���C�t�s�̏I��肪���[�_�[�̕����]�����̂�
%                            * user2.avatarVelocity.highSampled(reverseTimeGroupe(i,2)+1) <0    %������������

                    fill(x,y,[0.95 0.85 0.95],'LineStyle','none');
                    reverseTimeGroupe(i,4) = 2;    %������������
                end
            end
            
            plot(   user1.time.highSampled,  user1.avatarPosition.highSampled,'b',...
                user2.time.highSampled,  user2.avatarPosition.highSampled,'g',...
                user2.time.highSampled(5000:end),  user2.avatarPosition.highSampled(5000:end) - user1.avatarPosition.highSampled(5000:end) ,'r:');               
            title('avatarDistance');
            xlabel('����t ms'); ylabel('�A�o�^�ԋ���');
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
%             obj.outputAllToXls(output ,{'���σA�o�^�ԋ���','�ő�t�s����','���ϋt�s����','���v�t�s����', ...
%                                         '','�ő唽������','���ϔ�������','���v��������', ...
%                                         '','�ő喢��������','���ϖ���������','���v����������'});

        end

    end
end
