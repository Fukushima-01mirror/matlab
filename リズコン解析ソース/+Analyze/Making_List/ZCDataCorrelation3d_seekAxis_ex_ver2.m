classdef ZCDataCorrelation3d_seekAxis_ex_ver2 < Analyze.Base
    %STANDARDDEVIATION ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q

    properties
    end

    methods
        function obj = ZCDataCorrelation3d_seekAxis_ex_ver2(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
           [period_zx, peak_zx] = Rhythm.setZeroCrossPeriodData(user.zeroCrossData);
           %�@�[���N���X�Ԃł̃s�[�N�񐔎擾
           [zeroCrossTimes] = Rhythm.setZeroCrossCount(user.zeroCrossData);
            
            Y = abs( user.zeroCrossData.nonlogAvtVelocity );
            dT = abs( period_zx(:,3) );
            dA = abs( peak_zx(:,3) );
            
            
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
            dT_zc = dT(IndexZeroCross,:);     dT_nzc = dT(IndexNonZeroCross,:);
            dA_zc = dA(IndexZeroCross,:);     dA_nzc = dA(IndexNonZeroCross,:);
            
            %�O��l�����O���邽�߁C�ő�f�[�^�Q���J�b�g
            [dT_max,dT_imax] = max(dT_zc);     dT_zc(dT_imax)= [];	 dA_zc(dT_imax)= [];     Y_zc(dT_imax)= [];
            [dT_max,dT_imax] = max(dT_zc);     dT_zc(dT_imax)= [];	 dA_zc(dT_imax)= [];     Y_zc(dT_imax)= [];
            [dA_max,dA_imax] = max(dA_zc);     dT_zc(dA_imax)= [];	 dA_zc(dA_imax)= [];     Y_zc(dA_imax)= [];
            [dA_max,dA_imax] = max(dA_zc);     dT_zc(dA_imax)= [];	 dA_zc(dA_imax)= [];     Y_zc(dA_imax)= [];
%             [Y_max,Y_imax] = max(Y_zc);     dT_zc(Y_imax)= [];	 dA_zc(Y_imax)= [];     Y_zc(Y_imax)= [];
%             [Y_max,Y_imax] = max(Y_zc);     dT_zc(Y_imax)= [];	 dA_zc(Y_imax)= [];     Y_zc(Y_imax)= [];
            while max(Y_zc./dT_zc) > 500
                [Y_dT_max,Y_dT_imax] = max(Y_zc./dT_zc);     dT_zc(Y_dT_imax)= [];	 dA_zc(Y_dT_imax)= [];     Y_zc(Y_dT_imax)= [];
                [Y_dT_max,Y_dT_imax] = max(Y_zc./dT_zc);     dT_zc(Y_dT_imax)= [];	 dA_zc(Y_dT_imax)= [];     Y_zc(Y_dT_imax)= [];
            end
            while max(Y_zc./dA_zc) > 500
                [Y_dA_max,Y_dA_imax] = max(Y_zc./dA_zc);     dT_zc(Y_dA_imax)= [];	 dA_zc(Y_dA_imax)= [];     Y_zc(Y_dA_imax)= [];
                [Y_dA_max,Y_dA_imax] = max(Y_zc./dA_zc);     dT_zc(Y_dA_imax)= [];	 dA_zc(Y_dA_imax)= [];     Y_zc(Y_dA_imax)= [];
            end
 
            Nzc = length(Y_zc) ;
            Nnzc = length(Y_nzc) ;
%%        ��A�ƃ�T�̎听������
            figure(1)
            [coeff,score] = princomp( [dT_zc dA_zc] );
%             [ fitParam_dTdA, fitLineR_dTdA, lineEdgePoint] = Rhythm.approxiLine2d(dT_zc  ,dA_zc );
%             a = fitParam_dTdA(1);   b = fitParam_dTdA(2);
            plot( dT_zc - mean(dT_zc)   ,dA_zc - mean(dA_zc) , 'Marker','*', 'LineStyle','none');
            hold on
                plot( dT_nzc   ,dA_nzc ,'Marker','o', 'LineStyle','none' );
                plot(  [ zeros(1,2) ; 50*coeff(1,:) ] , [ zeros(1,2) ; 50*coeff(2,:) ] , 'r')
            hold off
%             biplot(coeff(:,1:2),'scores',score(:,1:2));
            grid on
            xlabel('����g�` �����̍��@��T');    ylabel('����g�`�@�U���̍��@��A'); 
            xlim([-50 50]);            ylim([-50 50]);
            xlim([0,600]);            ylim([0,600]);
%             title({['��A =  (' num2str( a ) ') * ��T  + (' num2str( b ) ')']; ...
%                     ['���֌W��R�F' num2str( fitLineR_dTdA(1)) '�@�@����W��R^2' num2str( fitLineR_dTdA(1)^2)]});
%%
            MonitorSize = [ 0, 0, 400, 400];
            set(gcf, 'Position', MonitorSize);
            if ~isempty(strfind( char(obj.config.examType) , '�����ΐ�'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_��A����(��A-��T)']);
            else
                obj.saveGraphWithName('_��A����(��A-��T)');
            end
            
            
%%        �ؕЕ��v���b�g�����炷
            figure(2)
            dA_zc_shift = dA_zc  - b * ones(Nzc,1);
            plot( dT_zc   ,dA_zc_shift , 'Marker','*', 'LineStyle','none' );
            lineEdgePoint0(:,1) = lineEdgePoint(:,1);
            lineEdgePoint0(:,2) = lineEdgePoint(:,2) - b *ones(2,1);
            % 
            theta = atan( a );  % ��]�p
            Rotate = [ cos(theta) sin(theta); -sin(theta) cos(theta)];      % ��]�s��
            k1 =  Rotate(1,1);    k2 = Rotate(1,2);
            l1 =  Rotate(2,1);    l2 = Rotate(2,2);
            Rotate_inv = [ cos(-theta) sin(-theta); -sin(-theta) cos(-theta)];      % �t��]�s��
            m1 =Rotate_inv(1,1);    m2 = Rotate_inv(1,2);
            n1 =Rotate_inv(2,1);    n2 = Rotate_inv(2,2);
            hold on
                plot( dT_nzc   ,dA_nzc  - b *ones(Nnzc,1),'Marker','o', 'LineStyle','none' );
                plot(lineEdgePoint0(:,1), lineEdgePoint0(:,2), 'c')
            hold off
            grid on
            xlabel('����g�` �����̍��@��T');    ylabel('����g�`�@�U���̍��@��A�f'); 
            xlim([0,600]);            ylim([0,600]);
            title({['��A�f =  (' num2str( a ) ') * ��T' ]; ...
                    ['X = ' num2str( k1) ' * ��T +' num2str( k2 ) ' * ��A']});
%%
            MonitorSize = [ 0, 0, 400, 400];
            set(gcf, 'Position', MonitorSize);
            if ~isempty(strfind( char(obj.config.examType) , '�����ΐ�'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_��A����(��A�f-��T)']);
            else
                obj.saveGraphWithName('_��A����(��A�f-��T)');
            end
            

%%        ��]�ϊ� X1 X2
            figure(3)
            X1 = k1 * dT_zc + k2 * dA_zc_shift;
            X2 = l1 * dT_zc + l2 * dA_zc_shift;
            plot( X1   ,X2 , 'Marker','*', 'LineStyle','none' );
            grid on
            xlabel('X1');    ylabel('X2'); 
            xlim([0,600]);            ylim([-300,300]);
%             title({['��A�f =  (' num2str( a ) ') * ��T' ]; ...
%                     ['X = ' num2str( k1) ' * ��T +' num2str( k2 ) ' * ��A']});

%%
            MonitorSize = [ 0, 0, 400, 400];
            set(gcf, 'Position', MonitorSize);
            if ~isempty(strfind( char(obj.config.examType) , '�����ΐ�'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_���W�ϊ�X1X2']);
            else
                obj.saveGraphWithName('_���W�ϊ�X1X2');
            end
                        
            
%%        X1�ƃA�o�^�����̉�A����
            figure(4)
            %�@��T�ƃA�o�^�����̑���
            subplot(3,1,1);
            [ fitParam1, fitLineR1, lineEdgePoint1] = Rhythm.approxiLine2d(dT_zc, Y_zc );
            plot( dT_zc  ,Y_zc,  'Marker','*', 'LineStyle','none' );
            hold on
                plot(lineEdgePoint1(:,1), lineEdgePoint1(:,2), 'r')
            hold off
            grid on
            xlabel('����g�` �����̍��@��T'); ylabel('�ΐ����Z�O�A�o�^����');
            xlim([0,600]);         ylim([0 50000]);
            title({['V =  (' num2str( fitParam1(1) ) ') * ��T  + (' num2str(fitParam1(2)) ')']; ...
                    ['���֌W���F' num2str( fitLineR1(1))]} );

            %�@��A�ƃA�o�^�����̑���
            subplot(3,1,2);
            [ fitParam2, fitLineR2, lineEdgePoint2] = Rhythm.approxiLine2d(dA_zc_shift, Y_zc );
            plot( dA_zc_shift  ,Y_zc ,  'Marker','*', 'LineStyle','none' );
            hold on
                plot(lineEdgePoint2(:,1), lineEdgePoint2(:,2), 'r')
            hold off
            grid on
            xlabel('����g�`�@�U���̍��@��A�f'); ylabel('�ΐ����Z�O�A�o�^����');
            xlim([0,600]);            ylim([0 50000]);
            title({['V =  (' num2str( fitParam2(1) ) ') * ��A�f  + (' num2str(fitParam2(2)) ')']; ...
                    ['���֌W���F' num2str( fitLineR2(1))]});

            %�@X�ƃA�o�^�����̑���
            subplot(3,1,3);
            [ fitParam_X1Y, fitLineR_X1Y, lineEdgePoint_X1Y] = Rhythm.approxiLine2d(X1 ,Y_zc);
            alpha = fitParam_X1Y(1);   beta = fitParam_X1Y(2);
            plot( X1   ,Y_zc  , 'Marker','*', 'LineStyle','none');
            hold on
                plot(lineEdgePoint_X1Y(:,1), lineEdgePoint_X1Y(:,2), 'r')
            hold off
            grid on
            xlabel('X = k1*��T + k2*��A');    ylabel('�ΐ��ϊ��O�A�o�^���x'); 
            xlim([0,600]);            ylim([0 50000]);
            title({['V =  (' num2str( alpha ) ') * X  + (' num2str( beta ) ')']; ...
                    ['���֌W��R�F' num2str( fitLineR_X1Y(1)) '�@�@����W��R^2' num2str( fitLineR_X1Y(1)^2)]; ...
                    ['      ���@V = (' num2str( alpha * k1 ) ') * ��T + (' num2str( alpha * k2 ) ') * ��A + (' num2str( beta ) ')'] });
            fitParam_recalc = [ beta, alpha*k1, alpha*k2];

%%
            MonitorSize = [ 0, 0, 400, 1000];
            set(gcf, 'Position', MonitorSize);
            if ~isempty(strfind( char(obj.config.examType) , '�����ΐ�'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_�P��A����(V-��T,V-��A,V-X1)']);
            else
                obj.saveGraphWithName('_�P��A����(V-��T,V-��A,V-X1)');
            end
            

%%        3�������z�@�d��A�i���ݍ�p�Ȃ��j��A�V�t�g
            figure(100);
            [fitParam3d, dTFIT, dAFIT, YFIT , fitR, yhat, fitR2 ]  = Rhythm.approxiSurface_flat(dT_zc , dA_zc_shift , Y_zc );
            plot3( dT_zc  , dA_zc_shift , Y_zc,   'Marker','*', 'LineStyle','none');
            lineEdgePoint_dTdAY(:,1) = m1 * lineEdgePoint_X1Y(:,1); %dT
            lineEdgePoint_dTdAY(:,2) = n1 * lineEdgePoint_X1Y(:,1); %dA
            lineEdgePoint_dTdAY(:,3) = lineEdgePoint_X1Y(:,2);      % Y

            hold on
                plot3( dT_nzc , dA_nzc  - b * ones(Nnzc,1), Y_nzc, 'Marker','o', 'LineStyle','none');
                plot3( [0,600*k1]  , [0,600*k2] , [0,0] ,'r' );
                plot3( [lineEdgePoint_dTdAY(2,1) lineEdgePoint_dTdAY(2,1)] , [lineEdgePoint_dTdAY(2,2) lineEdgePoint_dTdAY(2,2)] ...
                    , [0 lineEdgePoint_dTdAY(2,3)] ,'--r' );
                plot3( lineEdgePoint_dTdAY(:,1)  , lineEdgePoint_dTdAY(:,2) , lineEdgePoint_dTdAY(:,3) ,'r' ,'LineWidth',3 );
                C =colormap(jet);
                mesh(dTFIT,dAFIT,YFIT, 'faceAlpha',0.5);
                
%                 YFIT_recalc = fitParam_recalc(1) + fitParam_recalc(2)*dTFIT + fitParam_recalc(3)*dAFIT ;
% %                 C =colormap(Bone);
%                 mesh(dTFIT,dAFIT,YFIT_recalc, 'faceAlpha',0.5);     
                
%                 %�@�f�[�^�O���[�v������
%                 dTgrid = 0:50:600;            dAgrid = 0:50:600;
%                 Zsep = 2* mean(Y_zc) * ones(length(dTgrid), length(dAgrid));
%                 mesh(dTgrid, dAgrid, Zsep, 'faceAlpha',0.8);
            hold off
            grid on
%             view(45,30);
            xlabel('����g�` �����̍�');  ylabel('����g�` �U���̍�');  zlabel('�ΐ����Z�O�A�o�^����');
            xlim([0,600]);      ylim([0,600]);         zlim([0 50000]);
            title({ ['V = (' num2str(fitParam3d(1)) ') + (' num2str( fitParam3d(2) ) ') * ��T + (' num2str( fitParam3d(3)) ') * ��A�f '] ;...
                []});
            axis square
%%
            MonitorSize = [ 0, 0, 800, 800];
            set(gcf, 'Position', MonitorSize);
            if ~isempty(strfind( char(obj.config.examType) , '�����ΐ�'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_�d��A���́iV-��T,��A�j']);
            else
                obj.saveGraphWithName('_�d��A���́iV-��T,��A�j');
            end

%%        3�������z�@�d��A�i���ݍ�p�Ȃ��j��A�V�t�g�����W�ϊ�
            figure(110);
            [fitParam3d, X1FIT, X2FIT, YFIT , fitR, yhat, fitR2 ]  = Rhythm.approxiSurface_flat(X1 , X2 , Y_zc );
            plot3( X1  , X2 , Y_zc,   'Marker','*', 'LineStyle','none');

            hold on
                mesh(X1FIT,X2FIT,YFIT, 'faceAlpha',0.5);
                plot3(lineEdgePoint_X1Y(:,1), [0,0], lineEdgePoint_X1Y(:,2), 'r','LineWidth',3)
                plot3([lineEdgePoint_X1Y(2,1) lineEdgePoint_X1Y(2,1)], [0,0], [0 lineEdgePoint_X1Y(2,2)], '--r' );
                plot3([0 600], [0 0],[0 0],'r');
%                 %�@�f�[�^�O���[�v������
%                 dTgrid = 0:50:600;            dAgrid = 0:50:600;
%                 Zsep = 2* mean(Y_zc) * ones(length(dTgrid), length(dAgrid));
%                 mesh(dTgrid, dAgrid, Zsep, 'faceAlpha',0.8);
            hold off
            grid on
            xlabel('X1 = k1*��T + k2*��A');  ylabel('X2 = l1*��T + l2*��A');  zlabel('�ΐ����Z�O�A�o�^����V');
            xlim([0,600]);      ylim([-300,300]);         zlim([0 50000]);
            title({ ['V = (' num2str(fitParam3d(1)) ') + (' num2str( fitParam3d(2) ) ') * X1 + (' num2str( fitParam3d(3)) ') * X2�f '] });
            axis square
%%
            MonitorSize = [ 0, 0, 800, 800];
            set(gcf, 'Position', MonitorSize);
            if ~isempty(strfind( char(obj.config.examType) , '�����ΐ�'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_�d��A����(V-X1,X2)']);
            else
                obj.saveGraphWithName('_�d��A����(V-X1,X2)');
            end

            %%      �ߎ��ʁ@�W���@�G�N�Z���f�[�^�o��  
%             VIF = Rhythm.getVIF([dT_zc , dA_zc , dT_zc .*dA_zc ]);
%             outputTitle = { '�萔��' , '������' , '�U����','�U������������',...
%                                     'VIF(������)', 'VIF�i�U�����j', 'VIF�i���ݍ�p�j','�d����R','�d����R2' };
%             output = num2cell( [fitParam3' VIF fitR fitR2] );
%             obj.outputAllToXls(output , outputTitle);
            
        end

        function runForPair(obj,user1 ,user2)
%             obj.runForAlone(user1);
%             obj.runForAlone(user2);
%             
            
        end

        
    end
end
