classdef ZCDataCorrelation3d_seekAxis_ex_ver3 < Analyze.Base
    %STANDARDDEVIATION ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q

    properties
    end

    methods
        function obj = ZCDataCorrelation3d_seekAxis_ex_ver3(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
           [period_zx, peak_zx] = Rhythm.setZeroCrossPeriodData(user.zeroCrossData);
           %�@�[���N���X�Ԃł̃s�[�N�񐔎擾
           [zeroCrossTimes] = Rhythm.setZeroCrossCount(user.zeroCrossData);
            
            Y = abs( user.zeroCrossData.nonlogAvtVelocity );
            dT = abs( period_zx(:,3) );
            dA = abs( peak_zx(:,3) );
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
            Time_zc = Time(IndexZeroCross);        Time_nzc  = Time(IndexNonZeroCross);
            
            %�O��l�����O���邽�߁C�ő�f�[�^�Q���J�b�g
            [dT_max,dT_imax] = max(dT_zc);     dT_zc(dT_imax)= [];	 dA_zc(dT_imax)= [];     Y_zc(dT_imax)= [];     Time_zc(dT_imax)= [];
            [dT_max,dT_imax] = max(dT_zc);     dT_zc(dT_imax)= [];	 dA_zc(dT_imax)= [];     Y_zc(dT_imax)= [];     Time_zc(dT_imax)= [];
            [dA_max,dA_imax] = max(dA_zc);     dT_zc(dA_imax)= [];	 dA_zc(dA_imax)= [];     Y_zc(dA_imax)= [];     Time_zc(dA_imax)= [];
            [dA_max,dA_imax] = max(dA_zc);     dT_zc(dA_imax)= [];	 dA_zc(dA_imax)= [];     Y_zc(dA_imax)= [];     Time_zc(dA_imax)= [];
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
            
%%           �听����A����
            bFig =1 ;
            [k1 , k2, X1, fitParam_X1Y, fitLineR_X1Y] = Rhythm.PCA_regress(dT_zc , dA_zc , Y_zc , bFig) ;
            hold on
                plot3(dT_nzc, dA_nzc , Y_nzc ,'Color' , 'b' ,'Marker','o', 'LineStyle','none' );
            hold off
%             view(-30,25);
%             set(gcf, 'Position', [0 0 500 500]);
            
            %%
           if ~isempty(strfind( char(obj.config.examType) , '�����ΐ�'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_�听����A����']);
            else
                obj.saveGraphWithName('_�听����A����');
            end
            
%%           �e�f�[�^�̉�A�����Ƃ̋���
            dTdAmean = mean( [dT_zc , dA_zc] );
             [vector_HP , distError , distMean] = Rhythm.PCA_regDist(dT_zc , dA_zc , Y_zc , k1, k2 , X1, dTdAmean, fitParam_X1Y , bFig );
%         function [vector_HP , distError , distMean] = PCA_regDist(dT_zc , dA_zc , Y_zc , k1, k2 , X1, dTdAmean, fitParam_X1Y, bFig )

%%
            if ~isempty(strfind( char(obj.config.examType) , '�����ΐ�'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_��A��������̋���']);
            else
                obj.saveGraphWithName('_��A��������̋���');
            end

%%        ��A��������̋����̎��ԕω�

            MonitorSize = [ 0, 0, 1200, 800];
            set(gcf, 'Position', MonitorSize);
            a1 = subplot( 2,1,1 );
            
            plot(   user.time.highSampled,  user.avatarPosition.highSampled);      
            hold on
                if ~isempty( strfind( char(obj.config.examType), '�ǂ����܂�') ) ...
                        || ~isempty( strfind( char(obj.config.examType), '�ǂ����ގ���') )
                    plot(   obj.data.com.time, abs( obj.data.com.avatarPosition ) , 'k:');               
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
                        plot( obj.data.player2.time.highSampled , obj.data.player2.avatarPosition.highSampled , 'k:');
                    elseif obj.currentRunType == obj.runTypePlayer2
                        plot( obj.data.player1.time.highSampled , obj.data.player1.avatarPosition.highSampled , 'k:');
                    end
                end
                %�@�[���N���X���Ȃ��^�C�~���O��`��
                for j= 1: length(IndexNonZeroCross)
                    zeroCrossTime = user.zeroCrossData.zeroCrossTime(IndexNonZeroCross(j) );
                    plot([zeroCrossTime zeroCrossTime],[0 1000],...
                        'Color' , [1 0 0] , 'LineStyle', ':');
                end
                if ~isempty(  findstr( char( obj.config.examType ) , '���Ǐ]'))
                    for j=1:length(swTiming)
                        plot( [swTiming(j) swTiming(j)],[-1000 1000], 'Color' , 'k' , 'LineStyle', ':');
                    end
                end
            hold off
            xlabel('����t ms'); ylabel('�A�o�^�ʒu');
            xlim([0 60000]);    ylim([0 1000]);
            
            a2 = subplot( 2,1,2 );
            plot(Time_zc , distError);
            xlabel('����t ms'); ylabel('��A��������̋���');
            xlim([0 60000]);    ylim([0 300]);
            
            linkaxes([a1 a2],'x');

%%
            if ~isempty(strfind( char(obj.config.examType) , '�����ΐ�'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '_��A��������̋����ƃA�o�^�ʒu']);
            else
                obj.saveGraphWithName('_��A��������̋����ƃA�o�^�ʒu');
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
