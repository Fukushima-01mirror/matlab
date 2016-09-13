classdef ZeroCrossDataCorrelationGraph2_ex < Analyze.Base
    %STANDARDDEVIATION ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q

    properties
    end

    methods
        function obj = ZeroCrossDataCorrelationGraph2_ex(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
            [period_zx, peak_zx] = Rhythm.setZeroCrossPeriodData(user.zeroCrossData);
            
           %�@�[���N���X�Ԃł̃s�[�N�񐔎擾
           [zeroCrossTimes] = Rhythm.setZeroCrossCount(user.zeroCrossData);
            
            Y = abs( user.zeroCrossData.nonlogAvtVelocity );
            X1 = abs( period_zx );
            X2 = abs( peak_zx );

            if obj.currentRunType == obj.runTypePlayer1 ...
                    || ( obj.currentRunType == obj.runTypeArchive && obj.config.isExistPlayer1 )
                IndexZeroCross = find(zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2 ...
                    & obj.data.player1.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) + obj.data.player1.time.highSampled(1) );
                IndexNonZeroCross = find( zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1 ...
                    & obj.data.player1.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) + obj.data.player1.time.highSampled(1) );
            elseif obj.currentRunType == obj.runTypePlayer2 ...
                    || ( obj.currentRunType == obj.runTypeArchive && obj.config.isExistPlayer2 )
                IndexZeroCross = find(zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2 ...
                    & obj.data.player2.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) + obj.data.player2.time.highSampled(1) );
                IndexNonZeroCross = find( zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1 ...
                    & obj.data.player2.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) + obj.data.player2.time.highSampled(1) );
            end

            Y_zc  = Y(IndexZeroCross);        Y_nzc  = Y(IndexNonZeroCross);
            X1_zc = X1(IndexZeroCross,:);     X1_nzc = X1(IndexNonZeroCross,:);
            X2_zc = X2(IndexZeroCross,:);     X2_nzc = X2(IndexNonZeroCross,:);
            
            r_fig = 3;      c_fig = 3;      
            %�@�������ƃA�o�^�����̑���
            subplot(3,1,1);
            [ fitParam1, fitLineR1, lineEdgePoint] = Rhythm.approxiLine2d(X1_zc(:,3), Y_zc );
            plot( X1_zc(:,3)  ,Y_zc,  'Marker','*', 'LineStyle','none' );
            hold on
                plot( X1_nzc(:,3)  ,Y_nzc,'Marker','o', 'LineStyle','none' );
                plot(lineEdgePoint(:,1), lineEdgePoint(:,2), 'k')
            hold off
            grid on
            xlabel('����g�` �����̍�'); ylabel('�ΐ����Z�O�A�o�^����');
            xlim([0,600]);         ylim([0 50000]);
            title({['V =  (' num2str( fitParam1(1) ) ') * dPeriod  + (' num2str(fitParam1(2)) ')']; ...
                    ['���֌W���F' num2str( fitLineR1(1))]} );

            %�@�U�����ƃA�o�^�����̑���
            subplot(3,1,2);
            [ fitParam2, fitLineR2, lineEdgePoint] = Rhythm.approxiLine2d(X2_zc(:,3), Y_zc );
            plot( X2_zc(:,3)  ,Y_zc ,  'Marker','*', 'LineStyle','none' );
            hold on
                plot( X2_nzc(:,3)  ,Y_nzc,'Marker','o', 'LineStyle','none' );
                plot(lineEdgePoint(:,1), lineEdgePoint(:,2), 'k')
            hold off
            grid on
            xlabel('����g�`�@�U���̍�'); ylabel('�ΐ����Z�O�A�o�^����');
            xlim([0,600]);            ylim([0 50000]);
            title({['V =  (' num2str( fitParam2(1) ) ') * dPeak  + (' num2str(fitParam2(2)) ')']; ...
                    ['���֌W���F' num2str( fitLineR2(1))]});

            %�@�������ƐU�����̑���
            subplot(3,1,3);
            [ fitParam3, fitLineR3, lineEdgePoint] = Rhythm.approxiLine2d(X1_zc(:,3)  ,X2_zc(:,3) );
            plot( X1_zc(:,3)  ,X2_zc(:,3) , 'Marker','*', 'LineStyle','none' );
            hold on
                plot( X1_nzc(:,3)  ,X2_nzc(:,3),'Marker','o', 'LineStyle','none' );
                plot(lineEdgePoint(:,1), lineEdgePoint(:,2), 'k')
            hold off
            grid on
            xlabel('����g�` �����̍�');    ylabel('����g�`�@�U���̍�'); 
            xlim([0,600]);            ylim([0,600]);
            title({['V =  (' num2str( fitParam3(1) ) ') * dPeak  + (' num2str(fitParam3(2)) ')']; ...
                    ['���֌W���F' num2str( fitLineR3(1))]});

            MonitorSize = [ 0, 0, 400, 1000];
            set(gcf, 'Position', MonitorSize);
            if ~isempty(strfind( char(obj.config.examType) , '�����ΐ�'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state ]);
            else
                obj.saveGraph();
            end
            
            %%      �ߎ������@�W���@�G�N�Z���f�[�^�o��  

            outputTitle = {'��T��V�̉�A�W��','��T��V�̑��֌W��','��A��V�̉�A�W��','��A��V�̑��֌W��', ...
                                        '��T�ƃ�A�̉�A�W��','��T�ƃ�A�̑��֌W��'};
            output = num2cell([fitParam1(1) , fitLineR1(1), fitParam2(1) , fitLineR2(1), ...
                                        fitParam3(1), fitLineR3(1)] );
            if ~isempty(strfind( char(obj.config.examType) , '�����ΐ�'))
                obj.outputAllToXlsWithName([ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state ] , output , outputTitle)
            else
                obj.outputAllToXls(output , outputTitle);
            end

            
        end

    end
end
