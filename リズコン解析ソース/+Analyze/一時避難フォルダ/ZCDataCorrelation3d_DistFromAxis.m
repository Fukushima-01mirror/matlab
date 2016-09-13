classdef ZCDataCorrelation3d_DistFromAxis < Analyze.Base
    %STANDARDDEVIATION ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q

    properties
    end

    methods
        function obj = ZCDataCorrelation3d_DistFromAxis(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
           [period_zx, peak_zx] = Rhythm.setZeroCrossPeriodData(user.zeroCrossData);
           %�@�[���N���X�Ԃł̃s�[�N�񐔎擾
           [zeroCrossTimes] = Rhythm.setZeroCrossCount(user.zeroCrossData);
            
            Y = abs( user.zeroCrossData.nonlogAvtVelocity );
            dT = abs( period_zx(:,3) );
            dA = abs( peak_zx(:,3) );
            Time = user.zeroCrossData.zeroCrossTime;
            
            
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
            Time_zc = Time(IndexZeroCross);
            
            %�O��l�����O���邽�߁C�ő�f�[�^�Q���J�b�g
            [dT_max,dT_imax] = max(dT_zc);     dT_zc(dT_imax)= [];	 dA_zc(dT_imax)= [];     Y_zc(dT_imax)= [];     Time_zc(dT_imax)= [];
            [dT_max,dT_imax] = max(dT_zc);     dT_zc(dT_imax)= [];	 dA_zc(dT_imax)= [];     Y_zc(dT_imax)= [];     Time_zc(dT_imax)= [];
            [dA_max,dA_imax] = max(dA_zc);     dT_zc(dA_imax)= [];	 dA_zc(dA_imax)= [];     Y_zc(dA_imax)= [];     Time_zc(dA_imax)= [];
            [dA_max,dA_imax] = max(dA_zc);     dT_zc(dA_imax)= [];	 dA_zc(dA_imax)= [];     Y_zc(dA_imax)= [];     Time_zc(dA_imax)= [];
%             [Y_max,Y_imax] = max(Y_zc);     dT_zc(Y_imax)= [];	 dA_zc(Y_imax)= [];     Y_zc(Y_imax)= [];
%             [Y_max,Y_imax] = max(Y_zc);     dT_zc(Y_imax)= [];	 dA_zc(Y_imax)= [];     Y_zc(Y_imax)= [];
            while max(Y_zc./dT_zc) > 500
                [Y_dT_max,Y_dT_imax] = max(Y_zc./dT_zc);     dT_zc(Y_dT_imax)= [];	 dA_zc(Y_dT_imax)= [];     Y_zc(Y_dT_imax)= [];     Time_zc(Y_dT_imax)= [];
                [Y_dT_max,Y_dT_imax] = max(Y_zc./dT_zc);     dT_zc(Y_dT_imax)= [];	 dA_zc(Y_dT_imax)= [];     Y_zc(Y_dT_imax)= [];     Time_zc(Y_dT_imax)= [];
            end
            while max(Y_zc./dA_zc) > 500
                [Y_dA_max,Y_dA_imax] = max(Y_zc./dA_zc);     dT_zc(Y_dA_imax)= [];	 dA_zc(Y_dA_imax)= [];     Y_zc(Y_dA_imax)= [];     Time_zc(Y_dA_imax)= [];
                [Y_dA_max,Y_dA_imax] = max(Y_zc./dA_zc);     dT_zc(Y_dA_imax)= [];	 dA_zc(Y_dA_imax)= [];     Y_zc(Y_dA_imax)= [];     Time_zc(Y_dA_imax)= [];
            end
 
            Nzc = length(Y_zc) ;
            Nnzc = length(Y_nzc) ;
            
%%        ��A�ƃ�T�̎听������ �� �听����A����
            [coeff,score,latent,tsquare] = princomp( [dT_zc dA_zc] );
%             [coeff,score,latent,tsquare] = pca( [dT_zc dA_zc] );
            k1 = abs(coeff(1,1));            k2 = abs(coeff(2,1));
            dT0_zc = dT_zc - mean(dT_zc);
            dA0_zc = dA_zc - mean(dA_zc);
            X1 = k1 * dT0_zc + k2 * dA0_zc;
            [ fitParam_X1Y, fitLineR_X1Y, lineEdgePoint_X1Y, yhat] = Rhythm.approxiLine2d(X1, Y_zc );

            alpha = fitParam_X1Y(1); 
            direction = [k1, k2, alpha]; 
            direct = direction / norm(direction);
            Point = [dT0_zc dA0_zc Y_zc];
            Point0 = [ lineEdgePoint_X1Y(1,1)*k1 , lineEdgePoint_X1Y(1,1)*k2 , lineEdgePoint_X1Y(1,2) ];
            for i = 1 : Nzc
                vector_P0P = Point(i,:) - Point0;
                vector_P0H(i,:) = dot( vector_P0P , direct) * direct;
                H_Point(i,:) =  Point0 + vector_P0H(i,:);
                vector_HP(i,:) = Point(i,:) - H_Point(i,:);
                distError(i,:) = norm( vector_HP(i,:) );     %�听����A�����ƃf�[�^�̋���
            end
            distMean = sqrt( sum( distError.^2 ) / (Nzc-3) );
            
%%          ��A�����ƃf�[�^�̋����̎��n��ω�
            figure(1)
            MonitorSize = [ 0, 0, 1000, 800];
            set(gcf, 'Position', MonitorSize);
            
            subplot(3,1,1);
            Leng = norm( [lineEdgePoint_X1Y(:,1) , lineEdgePoint_X1Y(:,2)] );
            leng = norm( 400 * direction );
            plot3([0 Leng],[0 0],[0 0],'r' ,'LineWidth',3 );
            XYmax = ceil(distMean/50)*50;
            hold on
                plot3([0 leng],[0 0],[0 0],'r');
                plot3([0 0],[0 0],[-XYmax XYmax] ,'k');
                plot3([0 0],[-XYmax XYmax],[0 0] ,'k');
                for i = 1 : Nzc
                    plot3( [0 vector_HP(i,3)]+ norm( vector_P0H(i,:) )   ,[0 vector_HP(i,1)] ,[0 vector_HP(i,2)]  ,'k' );
                    plot3( vector_HP(i,3) + norm( vector_P0H(i,:) ) , vector_HP(i,1) , vector_HP(i,2)  , '*' );
                end
            hold off
            view(5,30);            grid on
            xlabel('');  ylabel('');  zlabel('��A����');
            title({ ['�e�f�[�^�̉�A�����Ƃ̋���'] });
            ylim([-XYmax XYmax]);            zlim([-XYmax XYmax]);
           
            
            subplot(3,1,2);
            plot(  Time_zc , distError );
            xlabel('�[���N���X����');  ylabel('��A�����ƃf�[�^�̋���');
            xlim([0 60000]);            ylim([0 400]);

            subplot(3,1,3);
            plot3(  Time_zc , vector_HP(:,1) , vector_HP(:,2) );
            xlabel('�[���N���X����');  zlabel('��A��������̃f�[�^�x�N�g��');
            view(5,30);            grid on
%             xlim([0 60000]);            ylim([0 400]);
            
%             title({ ['X�F(' num2str(coeff(1,1)) ', '  num2str(coeff(2,1)) ')�@\theta =(' num2str( atan(k2/k1) *180 / pi ) ')[deg]'] ;...
%                 ['X-V�̌X���F' num2str( alpha ) '�C���֌W��R�F' num2str( fitLineR_X1Y(1)) '�C����W��R^2�F' num2str( fitLineR_X1Y(1)^2)];...
%                 [ '��A��������̋����̓�敽�ϕ������F' num2str( distMean ) ]});

%%
            if ~isempty(strfind( char(obj.config.examType) , '�����ΐ�'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_�d��A���́iV-X1�j']);
            else
                obj.saveGraphWithName('_�d��A���́iV-X1�j');
            end


            %%   �@�G�N�Z���f�[�^�o��  
%             outputTitle = { 'k1' , 'k2' , '�p�x','latent(X1)','latent(X2)',...
%                                     'X1�̌W��','�d����R','�d����R2' };
%             output = num2cell( [k1 k2 (atan(k2/k1)*180/pi) latent' alpha  fitLineR_X1Y(1) fitLineR_X1Y(1)^2] );
%             if ~isempty(strfind( char(obj.config.examType) , '�����ΐ�'))
%                 obj.outputAllToXlsWithName([ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state ] , output , outputTitle)
%             else
%                 obj.outputAllToXls(output , outputTitle);
%             end
           
            
        end

        function runForPair(obj,user1 ,user2)
%             obj.runForAlone(user1);
%             obj.runForAlone(user2);
%             
            
        end

        
    end
end
