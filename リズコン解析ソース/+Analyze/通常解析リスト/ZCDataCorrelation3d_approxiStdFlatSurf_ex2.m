classdef ZCDataCorrelation3d_approxiStdFlatSurf_ex2 < Analyze.Base
    %STANDARDDEVIATION ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q

    properties
    end

    methods
        function obj = ZCDataCorrelation3d_approxiStdFlatSurf_ex2(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
           [period_zx, peak_zx] = Rhythm.setZeroCrossPeriodData(user.zeroCrossData);
           %�@�[���N���X�Ԃł̃s�[�N�񐔎擾
           [zeroCrossTimes] = Rhythm.setZeroCrossCount(user.zeroCrossData);
            
            Y = abs( user.zeroCrossData.nonlogAvtVelocity );
            X1 = abs( period_zx(:,3)  );
            X2 = abs( peak_zx(:,3) );
            
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

            [Y_zc , m_Y , s_Y]  = zscore( Y_zc);
            [X1_zc , m_X1 , s_X1] = zscore( X1_zc);
            [X2_zc , m_X2 , s_X2] = zscore( X2_zc);

            Y_nzc  =( Y(IndexNonZeroCross) - repmat(m_Y ,length( Y(IndexNonZeroCross)),1 ) )./ s_Y;
            X1_nzc =( X1(IndexNonZeroCross,:) - repmat(m_X1 ,length( X1(IndexNonZeroCross)),1 ) )./ s_X1;
            X2_nzc =( X2(IndexNonZeroCross,:)- repmat(m_X2 ,length( X2(IndexNonZeroCross)),1 ) )./ s_X2;
 

            figure(3);
            [fitParam3, X1FIT, X2FIT, YFIT , fitR, yhat, fitR2 ]  = Rhythm.approxiSurface_flat(X1_zc , X2_zc , Y_zc );
            plot3( X1_zc  , X2_zc , Y_zc,   'Marker','*', 'LineStyle','none');
            hold on
                plot3( X1_nzc  , X2_nzc , Y_nzc, 'Marker','o', 'LineStyle','none');
                mesh(X1FIT,X2FIT,YFIT, 'faceAlpha',0.5);
            hold off
            grid on
            xlabel('����g�` �����̍�');  ylabel('����g�` �U���̍�');  zlabel('�ΐ����Z�O�A�o�^����');
            xlim([-5,5]);      ylim([-5,5]);         zlim([-5 5]);
            title({['V = (' num2str(fitParam3(1)) ') + (' num2str( fitParam3(2) ) ') * dPeriod + (' num2str( fitParam3(3)) ') * dPeak']; ...
                    ['�f�[�^��:' num2str( length(user.time.highSampled)  - obj.config.analyzeTime(1) ) '[ms],(' num2str( length(Y_zc) ) ')' ] });
            axis square
            MonitorSize = [ 0, 0, 800, 800];
            set(gcf, 'Position', MonitorSize);
            if ~isempty(strfind( char(obj.config.examType) , '�����ΐ�'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state ]);
            else
                obj.saveGraph();
            end

            %%      �ߎ��ʁ@�W���@�G�N�Z���f�[�^�o��  
%             VIF = Rhythm.getVIF([X1_zc , X2_zc ]);
            VIF = [ NaN ,NaN ];
            outputTitle = { '�萔��' , '������' , '�U����',...
                                    'VIF(������)', 'VIF�i�U�����j','�d����R','�d����R2' };
            output = num2cell( [fitParam3' VIF fitR fitR2] );
            if ~isempty(strfind( char(obj.config.examType) , '�����ΐ�'))
                obj.outputAllToXlsWithName([ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state ] , output , outputTitle)
            else
                obj.outputAllToXls(output , outputTitle);
            end

        end

        function runForPair(obj,user1 ,user2)
%             obj.runForAlone(user1);
%             obj.runForAlone(user2);
%             
            
        end

        
    end
end
