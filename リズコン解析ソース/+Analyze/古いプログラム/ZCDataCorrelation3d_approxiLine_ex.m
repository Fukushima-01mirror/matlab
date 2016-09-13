classdef ZCDataCorrelation3d_approxiLine_ex < Analyze.Base
    %STANDARDDEVIATION ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q

    properties
    end

    methods
        function obj = ZCDataCorrelation3d_approxiLine_ex(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
           [period_zx, peak_zx] = Rhythm.setZeroCrossPeriodData(user.zeroCrossData);
           %�@�[���N���X�Ԃł̃s�[�N�񐔎擾
           [zeroCrossTimes] = Rhythm.setZeroCrossCount(user.zeroCrossData);
            
            Y = abs( user.zeroCrossData.nonlogAvtVelocity );
            X1 = abs( period_zx );
            X2 = abs( peak_zx );

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
            X1_zc = X1(IndexZeroCross,:);     X1_nzc = X1(IndexNonZeroCross,:);
            X2_zc = X2(IndexZeroCross,:);     X2_nzc = X2(IndexNonZeroCross,:);
%             figure(1);
%             plot3( X1_zc(:,1) , X2_zc(:,1), Y_zc,   'Marker','*', 'LineStyle','none');
%             hold on
%                 plot3( X1_nzc(:,1) , X2_nzc(:,1), Y_nzc, 'Marker','o', 'LineStyle','none');
%             hold off
%             grid on
%             xlabel('����g�` ������'); ylabel('����g�`�@�s�[�N�l');  zlabel('�ΐ����Z�O�A�o�^����');
%             xlim([0,600]);      ylim([0,600]);         zlim([0 50000]);
% 
%             axis square
%             MonitorSize = [ 0, 0, 800, 800];
%             set(gcf, 'Position', MonitorSize);
%             obj.saveGraphWithName('_halfParam');
% 
% 
%             figure(2);
%             plot3( X1_zc(:,2) , X2_zc(:,2), Y_zc,   'Marker','*', 'LineStyle','none');
%             hold on
%                 plot3( X1_nzc(:,2) , X2_nzc(:,2), Y_nzc, 'Marker','o', 'LineStyle','none');
%             hold off
%             grid on
%             xlabel('����g�` 1����'); ylabel('����g�` �U��');  zlabel('�ΐ����Z�O�A�o�^����');
%             xlim([0,800]);     ylim([0,800]);   zlim([0 50000]);
%             axis square
%             MonitorSize = [ 0, 0, 800, 800];
%             set(gcf, 'Position', MonitorSize);            obj.saveGraphWithName('_sumParam');


            figure(3);
            [dirVect3, lineEdgePoint] = Rhythm.approxiLine3d(X1_zc(:,3),  X2_zc(:,3),  Y_zc );
            plot3( X1_zc(:,3) , X2_zc(:,3), Y_zc,   'Marker','*', 'LineStyle','none');
            hold on
                plot3( X1_nzc(:,3) , X2_nzc(:,3), Y_nzc, 'Marker','o', 'LineStyle','none');
                plot3(lineEdgePoint(:,1),lineEdgePoint(:,2),lineEdgePoint(:,3),'r-');
            hold off
            grid on
            xlabel('����g�` �����̍�');  ylabel('����g�` �U���̍�');  zlabel('�ΐ����Z�O�A�o�^����');
            xlim([0,600]);      ylim([0,600]);         zlim([0 50000]);
            title(['�����x�N�g�� ( dPeriod, dPeak, V ) = ( ' num2str(dirVect3(1)) ',  ' num2str(dirVect3(2)) ',  '  num2str(dirVect3(3)) , ')'] );
            axis square
            MonitorSize = [ 0, 0, 800, 800];
            set(gcf, 'Position', MonitorSize);            obj.saveGraphWithName('');

            %%      �ߎ������@�W���@�G�N�Z���f�[�^�o��  

            outputTitle = { '�����̍��̌W������' , '�U���̍��̌W������' , '�A�o�^�����i�吔���Z�O�j�̌W������' };
            output = num2cell( dirVect3' );
            obj.outputAllToXls(output , outputTitle);
        end

        function runForPair(obj,user1 ,user2)
%             obj.runForAlone(user1);
%             obj.runForAlone(user2);
%             
            
        end

    end
end
