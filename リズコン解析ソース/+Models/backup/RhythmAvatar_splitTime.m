classdef RhythmAvatar_splitTime < Models.DataAbstruct
    %Device このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
        operatePulse
        avatarPosition
        avatarVelocity
        avatarSword
        zeroCrossData
        bCalcError
        splitTime
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
        function obj = RhythmAvatar_splitTime(filename, match_data ,suffix)
             propertyNames = { ...
                'time.lowSampled' ...               %
                'avatarPosition.lowSampled' ...     %
                'operatePulse.lowSampled' ...       %
                'time.highSampled' ...              %
                'operatePulse.highSampled' ...      %
                'avatarVelocity.highSampled' ...    %
                'avatarPosition.highSampled' ...    %
                'avatarSword'  ...
                'zeroCrossData.zeroCrossTime' ...   %
                'zeroCrossData.peak.time' ...       %
                'zeroCrossData.peak.value' ...      %
                'zeroCrossData.area' ...            %
                'zeroCrossData.nonlogAvtVelocity' ...   %
                'zeroCrossData.avtVelocity' ...         %
                'bCalcError'...
                'splitTime'...
                };
            obj = obj@Models.DataAbstruct(propertyNames);
            
            avt_list =  dir([filename,'avt*.csv']);
            data0 = csvread([filename,avt_list.name],1,0);
            while data0(1,1) ~= 20
                data0(1,:)=[];
            end

            %データ読込（avt_data.csv，DATA1.csv，DATA2.csv）　1P，2Pに分離
            if suffix =='1'
                avt0 = horzcat(data0(:,1),data0(:,2));
                data_list = dir([filename,'DATA1_*']);
                data = csvread([filename,data_list.name],2,0);
            elseif suffix =='2'
                avt0 = horzcat(data0(:,1),data0(:,4));
                data_list = dir([filename,'DATA2_*']);
                data = csvread([filename,data_list.name],2,0);
            end
            
            %仮コントローラ波形
            if length(data)~=60000
                disp('操作データ取得ミス');
                pause on;
                pause;
            end
                
            tempPul = zeros(60000,1);
            for i = 2:60000
                tempPul(i) = data(i,2)+tempPul(i-1);
            end
            
            %アバタ速度再計算
            if suffix =='1'
                [Pul, avt_data, cycle_data, Err] ...
                    = Rhythm.rhythmAvt1_splitData_func(tempPul, avt0, -200, 7500 , match_data); %操作波形，アバタ座標，試合データ
            elseif suffix =='2'
                [Pul, avt_data, cycle_data, Err] ...
                    = Rhythm.rhythmAvt2_splitData_func(tempPul, avt0, -200, 7500, match_data);
            end

%             if mean( abs( user1.avatarPosition.error ) ) >5 || mean( abs( user2.avatarPosition.error ) ) >5
%                 obj.bCalcError = 1;
%             end

%             win = match_data(n_match,3);         %%勝者
% 
            obj.splitTime = match_data;

            obj.time.highSampled = data(:, 1) + 1  ;
            obj.time.lowSampled = avt0(:,1);
            
            obj.operatePulse.highSampled = Pul;
            obj.operatePulse.lowSampled = Pul(avt0(:,1));
            
            obj.avatarPosition.highSampled = avt_data(:,2);
            obj.avatarPosition.lowSampled = avt0(:,2);
            
            if suffix =='1'
                obj.avatarSword = data0(:,3);
            elseif suffix =='2'
                obj.avatarSword = data0(:,5);
            end
            
            obj.avatarPosition.error = Err;
            
            obj.avatarVelocity.highSampled = avt_data(:,1);
            
            obj.zeroCrossData.zeroCrossTime         = cycle_data(:,1);
            obj.zeroCrossData.area                  = cycle_data(:,2);
            obj.zeroCrossData.nonlogAvtVelocity     = cycle_data(:,3);
            obj.zeroCrossData.avtVelocity           = cycle_data(:,4);
            
            % ゼロクロス点間ピーク値情報
%             zeroCrossData.peak.value，zeroCrossData.peak.time
            t_zx =1:cycle_data(1,1);
            t_zx = t_zx';
            
%             初めのゼロクロスはエラーが多いため，ピーク算出なし
%             if mean( Pul(1:cycle_data(1,1) ) ) > 0      % ピーク値（半周期）正負あり
%                 [pks,locs] = Rhythm.findpeaksPulse(t_zx, abs( Pul(1:cycle_data(1,1) ) ) );
%                 obj.zeroCrossData.peak(1).time = locs;
%                 obj.zeroCrossData.peak(1).value = pks;
%             else
%                 [pks,locs] = Rhythm.findpeaksPulse(t_zx, abs( Pul(1:cycle_data(1,1) ) ) );
%                 obj.zeroCrossData.peak(1).time = locs;
%                 obj.zeroCrossData.peak(1).value = -pks;
%             end
            for i=2:length(cycle_data)
                if cycle_data(i,2) ~= 0
                    t_zx =cycle_data(i-1,1) : cycle_data(i,1);
                    t_zx = t_zx';
                    if mean( Pul(cycle_data(i-1,1) :cycle_data(i,1) ) ) > 0
                        [pks,locs] = Rhythm.findpeaksPulse(t_zx, abs( Pul(cycle_data(i-1,1) :cycle_data(i,1) ) )  );
                        obj.zeroCrossData.peak(i,1).time = locs;
                        obj.zeroCrossData.peak(i,1).value = pks;
                    else
                        [pks,locs] = Rhythm.findpeaksPulse(t_zx, abs( Pul(cycle_data(i-1,1) :cycle_data(i,1) ) )  );
                        obj.zeroCrossData.peak(i,1).time = locs;
                        obj.zeroCrossData.peak(i,1).value = -pks;
                    end
                end
            end

            
           
        end


    end
end
