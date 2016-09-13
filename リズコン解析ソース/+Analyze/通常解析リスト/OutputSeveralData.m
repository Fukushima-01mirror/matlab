classdef OutputSeveralData < Analyze.Base
    %STANDARDDEVIATION ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q

    properties
    end

    methods
        function obj = OutputSeveralData(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
            
            %�@�[���N���X�Ԃł̃s�[�N�񐔎擾
            [zeroCrossTimes] = Rhythm.setZeroCrossCount(user.zeroCrossData);

            %�@�[���N���X���Ă��鎞�̃C���f�b�N�X
            IndexZeroCross = find(zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2);
            %�@�[���N���X���Ȃ����̃C���f�b�N�X
            IndexNonZeroCross = find( zeroCrossTimes(:,1)>1 | zeroCrossTimes(:,2)>1);
            
%             if obj.currentRunType == obj.runTypePlayer1
%                 IndexZeroCross = find(zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2 ...
%                     & obj.data.player1.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) );
%                 IndexNonZeroCross = find( zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1 ...
%                     & obj.data.player1.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) );
%             elseif obj.currentRunType == obj.runTypePlayer2
%                 IndexZeroCross = find(zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2 ...
%                     & obj.data.player2.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) );
%                 IndexNonZeroCross = find( zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1 ...
%                     & obj.data.player2.zeroCrossData.zeroCrossTime > obj.config.analyzeTime(1) );
%             end

            %             %%      �[���N���X����̋N����p�x�@�G�N�Z���f�[�^�o��
%             NonZC_Percent = length( find( zeroCrossTimes(:,1)>1) ) / length(user.zeroCrossData.peak ) *100;
%             outputTitle = { '�[���N���X���p�x[%]' };
%             output = num2cell( NonZC_Percent );
%             obj.outputAllToXls(output , outputTitle);
            %%
           
            if ~isempty(  findstr( char( obj.config.examType ) , '���Ǐ]'))
                bDirect(1,1) = mean( obj.data.task.avatarPosition(1:10) ) - obj.data.task.avatarPosition(1) >0;     
                % true�̎��@���x�F���@�@false�̎��@���x:��
                swTiming(1,1) = 0;
                j=1; 
                for i = 1:length(obj.data.task.time)
                    if bDirect(j,1) && obj.data.task.avatarPosition(i) >= obj.data.task.otherData(i,2)
                        j=j+1;
                        swTiming(j,1) = obj.data.task.time(i);
                        bDirect(j,1) = false;
                    end
                    if ~bDirect(j,1) && obj.data.task.avatarPosition(i) <= obj.data.task.otherData(i,1)
                        j=j+1;
                        swTiming(j,1) = obj.data.task.time(i);
                        bDirect(j,1) = true;
                    end
                end
            end

            
            [period_zx, peak_zx] = Rhythm.setZeroCrossPeriodData(user.zeroCrossData);
             Y = abs( user.zeroCrossData.nonlogAvtVelocity );
            X1 = abs( period_zx );
            X2 = abs( peak_zx );
            
           
                 
                %% ���n��f�[�^�o��
            
                saveName_timeSeries =[  '���n��f�[�^(' ,char(obj.config.examType) , ')'];
                if ~isempty( strfind( obj.config.examType, 'LF����'))
                    if obj.currentRunType == obj.runTypePlayer1
                        saveName_timeSeries =[  '���n��f�[�^(' ,char(obj.config.examType), '_'  , char(obj.config.player1UserName ) , ')'];
                    elseif obj.currentRunType == obj.runTypePlayer2
                        saveName_timeSeries =[  '���n��f�[�^(' ,char(obj.config.examType) ,'_'  , char(obj.config.player2UserName ) ,')'];
                    end
                end
                output_time = user.time.highSampled ;
                output_cont = user.operatePulse.highSampled;
                output_xavt = user.avatarPosition.highSampled;
                output_vavt = user.avatarVelocity.highSampled;
                outputdata_timeSeries = [ output_time , output_cont , output_vavt , output_xavt];
                output_title = { '����' , '�R���g���[������' , '�A�o�^���x' , '�A�o�^�ʒu'};
                output_timeSeries = vertcat( output_title, num2cell(outputdata_timeSeries) ); 
                
                if ~isempty(strfind( char(obj.config.examType) , '�����ΐ�'))
                    xlswrite( [saveName_timeSeries num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '.xlsx' ]  ,output_timeSeries);
                else
                    xlswrite( [ saveName_timeSeries '.xlsx' ]  ,output_timeSeries);
                end
                
                if ~isempty( strfind( obj.config.examType, '�ǂ����܂�') ) ...
                            || ~isempty( strfind( obj.config.examType, '�ǂ����ގ���') )
                    saveName_ts20 = [  '�����A�o�^�ʒu�f�[�^' ,char(obj.config.examType) , ').xlsx'];
                    outputts20_title = { '����' , '�����A�o�^�ʒu'};
                    output_t20 = obj.data.com.time;
                    output_xavt20 = obj.data.com.avatarPosition; 
                    outputdata_ts20 = [output_t20 , output_xavt20 ];
                    oupput_ts20 =  vertcat( outputts20_title, num2cell(outputdata_ts20) ); 
                    if ~isempty(obj.data.com2)  
                        
                        output2_xavt20 = obj.data.com2.avatarPosition;
                        oupput_ts20 = horzcat(  oupput_ts20 ,  vertcat( {'�����A�o�^2��f�[�^'}, num2cell(output2_xavt20) ));
                        xlswrite( saveName_ts20  ,oupput_ts20);
                    else
                        xlswrite( saveName_ts20  ,oupput_ts20);
                    end
                    
                
                end
                
                %% �[���N���X�f�[�^
                saveName_ZC =[  '�[���N���X�f�[�^(' ,char(obj.config.examType) , ')'];
                if  ~isempty( strfind( obj.config.examType, 'LF����'))
                    if obj.currentRunType == obj.runTypePlayer1
                        saveName_ZC =[  '�[���N���X�f�[�^(' ,char(obj.config.examType) , '_'  , char(obj.config.player1UserName ) ,')'];
                    elseif obj.currentRunType == obj.runTypePlayer2
                        saveName_ZC =[  '�[���N���X�f�[�^(' ,char(obj.config.examType) , '_'  , char(obj.config.player2UserName ) ,')'];
                    end
                end
                outputZC_title = { '�[���N���X����' , '�ΐ����Z�O�A�o�^����', '�����̍�' , '�U���̍�' , '����' , '�U��'};
                output_ZCtime = user.zeroCrossData.zeroCrossTime(IndexZeroCross) ;
                output_avtVnonlog = Y(IndexZeroCross) ;
                output_dPeriod = X1(IndexZeroCross,3) ;
                output_dPeak = X2(IndexZeroCross,3) ;
                output_Period = X1(IndexZeroCross,2) ;
                output_Peak =  X2(IndexZeroCross,2) ;
                
                outputdata_ZC = [ output_ZCtime , output_avtVnonlog , output_dPeriod , output_dPeak , output_Period ,  output_Peak];
                output_ZC = vertcat( outputZC_title, num2cell(outputdata_ZC) ); 
                
                if ~isempty(strfind( char(obj.config.examType) , '�����ΐ�'))
                    xlswrite( [saveName_ZC num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state '.xlsx' ]  ,output_timeSeries);
                else
                    xlswrite( [saveName_ZC '.xlsx' ]  ,output_ZC);
                end
                
                
                
                


        end

        function runForPair(obj,user1,user2)

            
        end

    end
end
