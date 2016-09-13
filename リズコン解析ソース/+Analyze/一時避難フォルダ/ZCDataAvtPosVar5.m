classdef ZCDataAvtPosVar5 < Analyze.Base
    %STANDARDDEVIATION ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q

    properties
    end

    methods
        function obj = ZCDataAvtPosVar5(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
           [period_zx, peak_zx] = Rhythm.setZeroCrossPeriodData(user.zeroCrossData);
           %�@�[���N���X�Ԃł̃s�[�N�񐔎擾
           [zeroCrossTimes] = Rhythm.setZeroCrossCount(user.zeroCrossData);
            
            Y = abs( user.zeroCrossData.nonlogAvtVelocity );
            dT = abs( period_zx(:,3) );
            dA = abs(peak_zx(:,3) );
            Time = abs( user.zeroCrossData.zeroCrossTime );
            
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
            Time_zc = Time(IndexZeroCross,:);        Time_nzc  = Time(IndexNonZeroCross,:);
            
            %�O��l�����O���邽�߁C�ő�f�[�^�Q���J�b�g
%             [dT_max,dT_imax] = max(dT_zc);     dT_zc(dT_imax)= [];	 dA_zc(dT_imax)= [];     Y_zc(dT_imax)= [];     Time_zc(dT_imax)= [];
%             [dT_max,dT_imax] = max(dT_zc);     dT_zc(dT_imax)= [];	 dA_zc(dT_imax)= [];     Y_zc(dT_imax)= [];     Time_zc(dT_imax)= [];
%             [dA_max,dA_imax] = max(dA_zc);     dT_zc(dA_imax)= [];	 dA_zc(dA_imax)= [];     Y_zc(dA_imax)= [];     Time_zc(dA_imax)= [];
%             [dA_max,dA_imax] = max(dA_zc);     dT_zc(dA_imax)= [];	 dA_zc(dA_imax)= [];     Y_zc(dA_imax)= [];     Time_zc(dA_imax)= [];
%             [Y_max,Y_imax] = max(Y_zc);     dT_zc(Y_imax)= [];	 dA_zc(Y_imax)= [];     Y_zc(Y_imax)= [];
%             [Y_max,Y_imax] = max(Y_zc);     dT_zc(Y_imax)= [];	 dA_zc(Y_imax)= [];     Y_zc(Y_imax)= [];
%             while max(Y_zc./dT_zc) > 500
%                 [Y_dT_max,Y_dT_imax] = max(Y_zc./dT_zc);     dT_zc(Y_dT_imax)= [];	 dA_zc(Y_dT_imax)= [];     Y_zc(Y_dT_imax)= [];
%                 [Y_dT_max,Y_dT_imax] = max(Y_zc./dT_zc);     dT_zc(Y_dT_imax)= [];	 dA_zc(Y_dT_imax)= [];     Y_zc(Y_dT_imax)= [];
%             end
%             while max(Y_zc./dA_zc) > 500
%                 [Y_dA_max,Y_dA_imax] = max(Y_zc./dA_zc);     dT_zc(Y_dA_imax)= [];	 dA_zc(Y_dA_imax)= [];     Y_zc(Y_dA_imax)= [];
%                 [Y_dA_max,Y_dA_imax] = max(Y_zc./dA_zc);     dT_zc(Y_dA_imax)= [];	 dA_zc(Y_dA_imax)= [];     Y_zc(Y_dA_imax)= [];
%             end
 
            Nzc = length(Y_zc) ;
            Nnzc = length(Y_nzc) ;
            
 
            
%%        �听����A����
            bFig =1 ;
            [k1 , k2, X1, fitParam_X1Y, fitLineR_X1Y] = Rhythm.PCA_regress(dT_zc , dA_zc , Y_zc , bFig) ;
           % hold on
            %    plot3(dT_nzc, dA_nzc , Y_nzc ,'Color' , 'b' ,'Marker','o', 'LineStyle','none' );
            %hold off
%             view(-30,25);
%             set(gcf, 'Position', [0 0 500 500]);
            

%%           �e�f�[�^�̉�A�����Ƃ̋���
            dTdAmean = mean( [dT_zc , dA_zc] );
             [vector_HP , distError , distMean] = Rhythm.PCA_regDist(dT_zc , dA_zc , Y_zc , k1, k2 , X1, dTdAmean, fitParam_X1Y , bFig );
%         function [vector_HP , distError , distMean] = PCA_regDist(dT_zc , dA_zc , Y_zc , k1, k2 , X1, dTdAmean, fitParam_X1Y, bFig )


%%        ��A��������̋����̎��ԕω�
            
            MonitorSize = [ 0, 0, 1200, 800];
            set(gcf, 'Position', MonitorSize);
             a1 = subplot( 3,1,1 );
           %%���p�x���o
            D=dir(char(strcat(cd(),'\data\',obj.config.fileName,'\avt*.csv')));
            SA = csvread(char(strcat(cd(),'\data\',obj.config.fileName,'\',D(1).name)),1,2,[1,2,3000,2]);
            plot(  user.time.lowSampled , SA ,'-k');
            hold on
            IA = zeros(1);
            for j= 2:length(SA)
                SupTime = user.time.lowSampled(j);
                
                if SA(j-1) == 0 && SA(j) ~= SA(j-1)
                     IB = zeros(1);
                     IB(1) = user.time.lowSampled(j);
                     if(length(IA) <= 1)
                     IA = vertcat(IA,IB);
                     else
                     IA = vertcat(IA,IB);
                     end
%                      disp(IA(:));
                     plot([SupTime SupTime],[0 2],...
                         'Color' , 'b' , 'LineStyle', '-');
                end
            end
                        set(gca,'XTick',IA(:));
            

            for j= 1:length(user.time.lowSampled)
                if rem(user.time.lowSampled(j),3000) == 0
                     plot([user.time.lowSampled(j) user.time.lowSampled(j)],[-1 2],...
                         'Color' , 'k' , 'LineStyle', '--');
                end
            end
             xlabel('����t ms'); ylabel('���p�x');
              xlim([0 40000]);  ylim([0 2]);
              hold off

              a2 = subplot( 3,1,2);
              plot(   Time, dA ,'-r.','MarkerEdgeColor','k','MarkerSize',3);
              hold on
              for j= 2:length(SA)
                SupTime = user.time.lowSampled(j);
                if SA(j-1) == 0 && SA(j) ~= SA(j-1)
                     plot([SupTime SupTime],[0 300],...
                         'Color' , 'b' , 'LineStyle', '-');
                     disp(SupTime);
                end
              end
              
            xlabel('�[���N���X����t ms'); ylabel('�U������A');
            xlim([0 40000]); 
            hold off
             a3 = subplot( 3,1,3);
              plot(   Time, dT,'-r.','MarkerEdgeColor','k','MarkerSize',3);
              hold on
               for j= 2:length(SA)
                SupTime = user.time.lowSampled(j);
                if SA(j-1) == 0 && SA(j) ~= SA(j-1)
                     plot([SupTime SupTime],[0 200],...
                         'Color' , 'b' , 'LineStyle', '-');
                end
              end
            xlabel('�[���N���X����t ms'); ylabel('��������T');
            xlim([0 40000]);  
            hold off
            
            linkaxes([a1 a2 a3],'x');
%%
            if ~isempty(strfind( char(obj.config.examType) , '�����ΐ�'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_��A��������̋����ƃA�o�^�ʒu']);
            else
                obj.saveGraphWithName('_���U�莞�����̑�');
            end

            %%   �@�G�N�Z���f�[�^�o��
            %  �@�G�N�Z���f�[�^�o��  
            outputTitle = { 'k1' , 'k2' , '�p�x',...
                                    'X1�̌W��','�d����R','�d����R2' , '��A�����ƃf�[�^�̋����̓�敽�ϕ�����'};
            output = num2cell( [k1 k2 (atan(k2/k1)*180/pi) fitParam_X1Y(1) fitLineR_X1Y(1) fitLineR_X1Y(1)^2 distMean] );
            
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
