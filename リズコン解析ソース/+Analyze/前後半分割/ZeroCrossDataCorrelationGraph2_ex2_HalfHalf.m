classdef ZeroCrossDataCorrelationGraph2_ex2_HalfHalf < Analyze.Base
    %STANDARDDEVIATION ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q

    properties
    end

    methods
        function obj = ZeroCrossDataCorrelationGraph2_ex2_HalfHalf(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
            [period_zx, peak_zx] = Rhythm.setZeroCrossPeriodData(user.zeroCrossData);
            
           %�@�[���N���X�Ԃł̃s�[�N�񐔎擾
           [zeroCrossTimes] = Rhythm.setZeroCrossCount(user.zeroCrossData);
            
            Y = abs( user.zeroCrossData.nonlogAvtVelocity );
            X1 = abs( period_zx(:,3)  );
            X2 = abs( peak_zx(:,3) );

%%             �O���f�[�^
            if obj.currentRunType == obj.runTypePlayer1 ...
                    || ( obj.currentRunType == obj.runTypeArchive && obj.config.isExistPlayer1 )
                IndexZeroCross1 = find(zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2 ...
                    & obj.data.player1.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) + obj.data.player1.time.highSampled(1)...
                    & obj.data.player1.zeroCrossData.zeroCrossTime < 30000 );
                IndexNonZeroCross1 = find( zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1 ...
                    & obj.data.player1.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) + obj.data.player1.time.highSampled(1)...
                    & obj.data.player1.zeroCrossData.zeroCrossTime < 30000 );
            elseif obj.currentRunType == obj.runTypePlayer2 ...
                    || ( obj.currentRunType == obj.runTypeArchive && obj.config.isExistPlayer2 )
                IndexZeroCross1 = find(zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2 ...
                    & obj.data.player2.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) + obj.data.player2.time.highSampled(1)...
                    & obj.data.player2.zeroCrossData.zeroCrossTime < 30000 );
                IndexNonZeroCross1 = find( zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1 ...
                    & obj.data.player2.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) + obj.data.player2.time.highSampled(1)...
                    & obj.data.player2.zeroCrossData.zeroCrossTime < 30000 );
            end


            Y_zc  = Y(IndexZeroCross1);        Y_nzc  = Y(IndexNonZeroCross1);
            X1_zc = X1(IndexZeroCross1,:);     X1_nzc = X1(IndexNonZeroCross1,:);
            X2_zc = X2(IndexZeroCross1,:);     X2_nzc = X2(IndexNonZeroCross1,:);
            
            %�O��l�����O���邽�߁C�ő�f�[�^�Q���J�b�g
            [X1_max,X1_imax] = max(X1_zc);     X1_zc(X1_imax)= [];	 X2_zc(X1_imax)= [];     Y_zc(X1_imax)= [];
            [X1_max,X1_imax] = max(X1_zc);     X1_zc(X1_imax)= [];	 X2_zc(X1_imax)= [];     Y_zc(X1_imax)= [];
            [X2_max,X2_imax] = max(X2_zc);     X1_zc(X2_imax)= [];	 X2_zc(X2_imax)= [];     Y_zc(X2_imax)= [];
            [X2_max,X2_imax] = max(X2_zc);     X1_zc(X2_imax)= [];	 X2_zc(X2_imax)= [];     Y_zc(X2_imax)= [];
%             [Y_max,Y_imax] = max(Y_zc);     X1_zc(Y_imax)= [];	 X2_zc(Y_imax)= [];     Y_zc(Y_imax)= [];
%             [Y_max,Y_imax] = max(Y_zc);     X1_zc(Y_imax)= [];	 X2_zc(Y_imax)= [];     Y_zc(Y_imax)= [];
%             while max(Y_zc./X1_zc) > 1000
%                 [Y_X1_max,Y_X1_imax] = max(Y_zc./X1_zc);     X1_zc(Y_X1_imax)= [];	 X2_zc(Y_X1_imax)= [];     Y_zc(Y_X1_imax)= [];
%                 [Y_X1_max,Y_X1_imax] = max(Y_zc./X1_zc);     X1_zc(Y_X1_imax)= [];	 X2_zc(Y_X1_imax)= [];     Y_zc(Y_X1_imax)= [];
%             end
%             while max(Y_zc./X2_zc) > 1000
%                 [Y_X2_max,Y_X2_imax] = max(Y_zc./X2_zc);     X1_zc(Y_X2_imax)= [];	 X2_zc(Y_X2_imax)= [];     Y_zc(Y_X2_imax)= [];
%                 [Y_X2_max,Y_X2_imax] = max(Y_zc./X2_zc);     X1_zc(Y_X2_imax)= [];	 X2_zc(Y_X2_imax)= [];     Y_zc(Y_X2_imax)= [];
%             end
            r_fig = 3;      c_fig = 3;      
            %�@�������ƃA�o�^�����̑���
            subplot(3,1,1);
            [ fitParam1, fitLineR1, lineEdgePoint] = Rhythm.approxiLine2d(X1_zc , Y_zc );
            plot( X1_zc   ,Y_zc,  'Marker','*', 'LineStyle','none' );
            hold on
                plot( X1_nzc   ,Y_nzc,'Marker','o', 'LineStyle','none' );
                plot(lineEdgePoint(:,1), lineEdgePoint(:,2), 'k')
            hold off
            grid on
            xlabel('����g�` �����̍�'); ylabel('�ΐ����Z�O�A�o�^����');
            if isempty(  findstr( char( obj.config.examType ) , '���R����'))
                xlim([0,600]);         ylim([0 50000]);
            end
            title({['V =  (' num2str( fitParam1(1) ) ') * dPeriod  + (' num2str(fitParam1(2)) ')']; ...
                    ['���֌W���F' num2str( fitLineR1(1))]} );

            %�@�U�����ƃA�o�^�����̑���
            subplot(3,1,2);
            [ fitParam2, fitLineR2, lineEdgePoint] = Rhythm.approxiLine2d(X2_zc , Y_zc );
            plot( X2_zc   ,Y_zc ,  'Marker','*', 'LineStyle','none' );
            hold on
                plot( X2_nzc   ,Y_nzc,'Marker','o', 'LineStyle','none' );
                plot(lineEdgePoint(:,1), lineEdgePoint(:,2), 'k')
            hold off
            grid on
            xlabel('����g�`�@�U���̍�'); ylabel('�ΐ����Z�O�A�o�^����');
            if isempty(  findstr( char( obj.config.examType ) , '���R����'))
                xlim([0,600]);            ylim([0 50000]);
            end
            title({['V =  (' num2str( fitParam2(1) ) ') * dPeak  + (' num2str(fitParam2(2)) ')']; ...
                    ['���֌W���F' num2str( fitLineR2(1))]});

            %�@�������ƐU�����̑���
            subplot(3,1,3);
            [ fitParam3, fitLineR3, lineEdgePoint] = Rhythm.approxiLine2d(X1_zc   ,X2_zc  );
            plot( X1_zc   ,X2_zc  , 'Marker','*', 'LineStyle','none' );
            hold on
                plot( X1_nzc   ,X2_nzc ,'Marker','o', 'LineStyle','none' );
                plot(lineEdgePoint(:,1), lineEdgePoint(:,2), 'k')
            hold off
            grid on
            xlabel('����g�` �����̍�');    ylabel('����g�`�@�U���̍�'); 
            if isempty(  findstr( char( obj.config.examType ) , '���R����'))
                xlim([0,600]);            ylim([0,600]);
            end
            title({['V =  (' num2str( fitParam3(1) ) ') * dPeak  + (' num2str(fitParam3(2)) ')']; ...
                    ['���֌W���F' num2str( fitLineR3(1))]});

            MonitorSize = [ 0, 0, 400, 1000];
            set(gcf, 'Position', MonitorSize);
            if ~isempty(strfind( char(obj.config.examType) , '�����ΐ�'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state ]);
            else
                obj.saveGraphWithName('1st-half');
            end
            
%%             �㔼�f�[�^
            if obj.currentRunType == obj.runTypePlayer1 ...
                    || ( obj.currentRunType == obj.runTypeArchive && obj.config.isExistPlayer1 )
                IndexZeroCross2 = find(zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2 ...
                    & obj.data.player1.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) + 30000 );
                IndexNonZeroCross2 = find( zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1 ...
                    & obj.data.player1.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) + 30000 );
            elseif obj.currentRunType == obj.runTypePlayer2 ...
                    || ( obj.currentRunType == obj.runTypeArchive && obj.config.isExistPlayer2 )
                IndexZeroCross2 = find(zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2 ...
                    & obj.data.player2.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) + 30000 );
                IndexNonZeroCross2 = find( zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1 ...
                    & obj.data.player2.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) + 30000 );
            end

            Y_zc  = Y(IndexZeroCross2);        Y_nzc  = Y(IndexNonZeroCross2);
            X1_zc = X1(IndexZeroCross2,:);     X1_nzc = X1(IndexNonZeroCross2,:);
            X2_zc = X2(IndexZeroCross2,:);     X2_nzc = X2(IndexNonZeroCross2,:);
            
            %�O��l�����O���邽�߁C�ő�f�[�^�Q���J�b�g
            [X1_max,X1_imax] = max(X1_zc);     X1_zc(X1_imax)= [];	 X2_zc(X1_imax)= [];     Y_zc(X1_imax)= [];
            [X1_max,X1_imax] = max(X1_zc);     X1_zc(X1_imax)= [];	 X2_zc(X1_imax)= [];     Y_zc(X1_imax)= [];
            [X2_max,X2_imax] = max(X2_zc);     X1_zc(X2_imax)= [];	 X2_zc(X2_imax)= [];     Y_zc(X2_imax)= [];
            [X2_max,X2_imax] = max(X2_zc);     X1_zc(X2_imax)= [];	 X2_zc(X2_imax)= [];     Y_zc(X2_imax)= [];
%             [Y_max,Y_imax] = max(Y_zc);     X1_zc(Y_imax)= [];	 X2_zc(Y_imax)= [];     Y_zc(Y_imax)= [];
%             [Y_max,Y_imax] = max(Y_zc);     X1_zc(Y_imax)= [];	 X2_zc(Y_imax)= [];     Y_zc(Y_imax)= [];
%             while max(Y_zc./X1_zc) > 1000
%                 [Y_X1_max,Y_X1_imax] = max(Y_zc./X1_zc);     X1_zc(Y_X1_imax)= [];	 X2_zc(Y_X1_imax)= [];     Y_zc(Y_X1_imax)= [];
%                 [Y_X1_max,Y_X1_imax] = max(Y_zc./X1_zc);     X1_zc(Y_X1_imax)= [];	 X2_zc(Y_X1_imax)= [];     Y_zc(Y_X1_imax)= [];
%             end
%             while max(Y_zc./X2_zc) > 1000
%                 [Y_X2_max,Y_X2_imax] = max(Y_zc./X2_zc);     X1_zc(Y_X2_imax)= [];	 X2_zc(Y_X2_imax)= [];     Y_zc(Y_X2_imax)= [];
%                 [Y_X2_max,Y_X2_imax] = max(Y_zc./X2_zc);     X1_zc(Y_X2_imax)= [];	 X2_zc(Y_X2_imax)= [];     Y_zc(Y_X2_imax)= [];
%             end
            r_fig = 3;      c_fig = 3;      
            %�@�������ƃA�o�^�����̑���
            subplot(3,1,1);
            [ fitParam1, fitLineR1, lineEdgePoint] = Rhythm.approxiLine2d(X1_zc , Y_zc );
            plot( X1_zc   ,Y_zc,  'Marker','*', 'LineStyle','none' );
            hold on
                plot( X1_nzc   ,Y_nzc,'Marker','o', 'LineStyle','none' );
                plot(lineEdgePoint(:,1), lineEdgePoint(:,2), 'k')
            hold off
            grid on
            xlabel('����g�` �����̍�'); ylabel('�ΐ����Z�O�A�o�^����');
            if isempty(  findstr( char( obj.config.examType ) , '���R����'))
                xlim([0,600]);         ylim([0 50000]);
            end
            title({['V =  (' num2str( fitParam1(1) ) ') * dPeriod  + (' num2str(fitParam1(2)) ')']; ...
                    ['���֌W���F' num2str( fitLineR1(1))]} );

            %�@�U�����ƃA�o�^�����̑���
            subplot(3,1,2);
            [ fitParam2, fitLineR2, lineEdgePoint] = Rhythm.approxiLine2d(X2_zc , Y_zc );
            plot( X2_zc   ,Y_zc ,  'Marker','*', 'LineStyle','none' );
            hold on
                plot( X2_nzc   ,Y_nzc,'Marker','o', 'LineStyle','none' );
                plot(lineEdgePoint(:,1), lineEdgePoint(:,2), 'k')
            hold off
            grid on
            xlabel('����g�`�@�U���̍�'); ylabel('�ΐ����Z�O�A�o�^����');
            if isempty(  findstr( char( obj.config.examType ) , '���R����'))
                xlim([0,600]);            ylim([0 50000]);
            end
            title({['V =  (' num2str( fitParam2(1) ) ') * dPeak  + (' num2str(fitParam2(2)) ')']; ...
                    ['���֌W���F' num2str( fitLineR2(1))]});

            %�@�������ƐU�����̑���
            subplot(3,1,3);
            [ fitParam3, fitLineR3, lineEdgePoint] = Rhythm.approxiLine2d(X1_zc   ,X2_zc  );
            plot( X1_zc   ,X2_zc  , 'Marker','*', 'LineStyle','none' );
            hold on
                plot( X1_nzc   ,X2_nzc ,'Marker','o', 'LineStyle','none' );
                plot(lineEdgePoint(:,1), lineEdgePoint(:,2), 'k')
            hold off
            grid on
            xlabel('����g�` �����̍�');    ylabel('����g�`�@�U���̍�'); 
            if isempty(  findstr( char( obj.config.examType ) , '���R����'))
                xlim([0,600]);            ylim([0,600]);
            end
            title({['V =  (' num2str( fitParam3(1) ) ') * dPeak  + (' num2str(fitParam3(2)) ')']; ...
                    ['���֌W���F' num2str( fitLineR3(1))]});

            MonitorSize = [ 0, 0, 400, 1000];
            set(gcf, 'Position', MonitorSize);
            if ~isempty(strfind( char(obj.config.examType) , '�����ΐ�'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state ]);
            else
                obj.saveGraphWithName('2nd-half');
            end
                        
            %%      �ߎ������@�W���@�G�N�Z���f�[�^�o��  
% 
%             outputTitle = {'��T��V�̉�A�W��','��T��V�̑��֌W��','��A��V�̉�A�W��','��A��V�̑��֌W��', ...
%                                         '��T�ƃ�A�̉�A�W��','��T�ƃ�A�̑��֌W��'};
%             output = num2cell([fitParam1(1) , fitLineR1(1), fitParam2(1) , fitLineR2(1), ...
%                                         fitParam3(1), fitLineR3(1)] );
%             if ~isempty(strfind( char(obj.config.examType) , '�����ΐ�'))
%                 obj.outputAllToXlsWithName([ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state ] , output , outputTitle)
%             else
%                 obj.outputAllToXls(output , outputTitle);
%             end

            
        end

    end
end
