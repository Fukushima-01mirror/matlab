classdef RhythmAvatar_cpShift < Models.DataAbstruct
    %Device ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q

    properties
        operatePulse
        avatarPosition
        avatarVelocity
        zeroCrossData
        bCalcError
        zeroCrossPosition
    end

%{
    properties (Constant)
        columnIndexTime      = 1
        columnIndexX         = 2
        columnIndexY         = 3
        columnIndexZ         = 4
        columnIndexQx        = 5
        columnIndexQy        = 6
        columnIndexQz        = 7
        columnIndexQw        = 8
        columnIndexYaw       = 9
        columnIndexPitch     = 10
        columnIndexRoll      = 11
    end
    %}

    methods
        function obj = RhythmAvatar_cpShift(config,suffix)
             propertyNames = { ...
                'time.lowSampled' ...               %
                'avatarPosition.lowSampled' ...     %
                'operatePulse.lowSampled' ...       %
                'time.highSampled' ...              %
                'operatePulse.highSampled' ...      %
                'avatarVelocity.highSampled' ...    %
                'avatarPosition.highSampled' ...    %
                'zeroCrossData.zeroCrossTime' ...   %
                'zeroCrossData.peak.time' ...       %
                'zeroCrossData.peak.value' ...      %
                'zeroCrossData.area' ...            %
                'zeroCrossData.nonlogAvtVelocity' ...   %
                'zeroCrossData.avtVelocity' ...         %
                'bCalcError' ...
                'zeroCrossPosition' ...
                };
            obj = obj@Models.DataAbstruct(propertyNames);

            filename = char(strcat(cd(),'\data\',config.fileName,'\'));           
            avt_list =  dir([filename,'avt*.csv']);
            data0 = csvread([filename,avt_list.name],1,0);
            

            if data0(1,1) ~= 20
                data0(1,:)=[];
            end
%             disp(data0);
            %�f�[�^�Ǎ��iavt_data.csv�CDATA1.csv�CDATA2.csv�j�@1P�C2P�ɕ���
            if suffix =='1'
                avt0 = horzcat(data0(:,1),data0(:,2));
                data_list = dir([filename,'DATA1_*']);
                data = csvread([filename,data_list.name],2,0);
                Top = xlsread([filename,data_list.name],1,'A1:B1');
            elseif suffix =='2'
                avt0 = horzcat(data0(:,1),data0(:,4));
                data_list = dir([filename,'DATA2_*']);
                data = csvread([filename,data_list.name],2,0);
                Top = xlsread([filename,data_list.name],1,'A1:B1');
            end
            
            %�R���g���[���g�`
            tempPul = zeros(60000,1);
            for i = 2:60000
%                 data(i,2) = round(data(i,2)*5000/1600);
%                 if i ==2
%                     tempPul(i) = Top(1,1) + data(i,2);
%                 else

                    tempPul(i) = data(i,2)+tempPul(i-1);
%                   tempPul(i) = round(tempPul(i)*5000/1600);
                %end
            end
%             disp(tempPul(58000:60000));
            % �[���N���X�ϓ�
            PulsesCP = config.player1ContParam(1);
            zcPos = PulsesCP * ones( 60000,1 );
            
            if suffix =='1'
                [Pul, avt_data, cycle_data, avtCalcError] = Rhythm.rhythmAvt1_cpShift_cycle_data_func(tempPul, avt0, zcPos, -200, 7500);
            elseif suffix =='2'
   %              [Pul, avt_data, cycle_data, avtCalcError] = Rhythm.rhythmAvt2_cpShift_cycle_data_func(tempPul, avt0, zcPos, -200, 7500);
                [Pul, avt_data, cycle_data, avtCalcError] = Rhythm.rhythmAvt2_cycle_data_func(tempPul, avt0, -200, 7500);
% [Pul, avt_data, cycle_data, avtCalcError] = Rhythm.rhythmAvt1_cpShift_cycle_data_func(tempPul, avt0, zcPos, -200, 7500);
            end

%             if mean( abs( user1.avatarPosition.error ) ) >5 || mean( abs( user2.avatarPosition.error ) ) >5
%                 obj.bCalcError = 1;
%             end


            obj.time.highSampled = data(:, 1) + 1  ;
            obj.time.lowSampled = avt0(:,1);
            
            obj.operatePulse.highSampled = Pul;
            obj.operatePulse.lowSampled = Pul(avt0(:,1));
            
            obj.avatarPosition.highSampled = avt_data(:,2);
            obj.avatarPosition.lowSampled = avt0(:,2);
            obj.avatarPosition.error = avtCalcError;
            
            obj.avatarVelocity.highSampled = avt_data(:,1);
            obj.zeroCrossData.zeroCrossTime         = cycle_data(:,1);
            obj.zeroCrossData.area                  = cycle_data(:,2);
            obj.zeroCrossData.nonlogAvtVelocity     = cycle_data(:,3);         
            obj.zeroCrossData.avtVelocity           = cycle_data(:,4);
            
            obj.zeroCrossPosition = zcPos;
            
            % �[���N���X�_�ԃs�[�N�l���
%             zeroCrossData.peak.value�CzeroCrossData.peak.time
            t_zx =1:cycle_data(1,1);
            t_zx = t_zx';
            
%             ���߂̃[���N���X�̓G���[���������߁C�s�[�N�Z�o�Ȃ�
%             if mean( Pul(1:cycle_data(1,1) ) ) > 0      % �s�[�N�l�i�������j��������
%                 [pks,locs] = Rhythm.findpeaksPulse(t_zx, abs( Pul(1:cycle_data(1,1) ) ) );
%                 obj.zeroCrossData.peak(1).time = locs;
%                 obj.zeroCrossData.peak(1).value = pks;
%             else
%                 [pks,locs] = Rhythm.findpeaksPulse(t_zx, abs( Pul(1:cycle_data(1,1) ) ) );
%                 obj.zeroCrossData.peak(1).time = locs;
%                 obj.zeroCrossData.peak(1).value = -pks;
%             end
            for i=2:length(cycle_data)
                t_zx =cycle_data(i-1,1) : cycle_data(i,1);
                t_zx = t_zx';
                devPul = Pul - zcPos;   
                if mean( Pul(cycle_data(i-1,1) :cycle_data(i,1) ) ) > 0    %�g�`�����̂Ƃ�
                    [pks,locs] = Rhythm.findpeaksPulse(t_zx, abs( devPul(cycle_data(i-1,1) :cycle_data(i,1) ) )  );
                    obj.zeroCrossData.peak(i,1).time = locs;
                    obj.zeroCrossData.peak(i,1).value = pks;
                else                                                       %�g�`�����̂Ƃ�
                    [pks,locs] = Rhythm.findpeaksPulse(t_zx, abs( devPul(cycle_data(i-1,1) :cycle_data(i,1) ) )  );
                    obj.zeroCrossData.peak(i,1).time = locs;
                    obj.zeroCrossData.peak(i,1).value = -pks;
                end
            end

            
           
        end

%         function moveToMean(obj)
%             for i = 2: obj.length()
%                 data = obj.getData(i);
%                 obj.setData(i, data - mean(data) );
%             end
%         end
% 
% 
%         function max = length(obj)
%             max = 9;
%         end
% 
%         function transformFor20120910(obj)
%             preX = obj.position.x;
%             preZ = obj.position.z;
%             obj.position.x = preZ;
%             obj.position.z = -preX;
%         end
        
    end
end
