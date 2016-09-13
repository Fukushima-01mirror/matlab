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
        meanDelayTime
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
                'meanDelayTime'...
                };
            obj = obj@Models.DataAbstruct(propertyNames);
            
            if suffix == '1'                            %1P
                avt_list = dir([filename,'avt_*.csv']);
            elseif suffix == '2'                        %2P（同場所）
                avt_list = dir([filename,'avt_*.csv']);
            elseif suffix == '3'                        %3P（遠隔）
                avt_list = dir([filename,'avt2P_*.csv']);
            end
            
            data0 = csvread([filename,avt_list.name],1,0);
            while data0(1,1) ~= 20
                data0(1,:)=[];
            end
            
            %% OpenFrameWorks用　UDP通信欠損補填
            if length(data0) ~= 3000
                a = 1;
                while (data0(a,2) ~= 200 || data0(a,4) ~= 800)          %初期データの修復
                    data0(a,2) = 200;
                    data0(a,4) = 800;
                    a = a+1;
                end

                if data0(end,1) ~= 60000
                    data0 = vertcat(data0,zeros(1,6));
                    data0(end,:) = data0(end-1,:);
                    data0(end,1) = 60000;
                end

                data0_fixed = zeros(3000,6);
                data0_fixed(1,:) = data0(1,:);
                a = 2;
                b = 2;
                while(1)
                    if data0(a,1) ~= data0(a-1,1)+20
                        n_lost = (data0(a,1) - data0(a-1,1)) /20 - 1;   %損失しているデータ数
                        data0_fixed(b+n_lost,:) = data0(a,:);           %正しい位置に代入
                        fix_data_1 = zeros(1,6);                        %1欠損あたりの数値
                        fix_data_1(1,:) = round((data0(a,:) - data0(a-1,:)) / (n_lost + 1));
                        for fix = 1 : n_lost
                            data0_fixed(b-1+fix,:) = data0_fixed(b-1+fix-1,:) + fix_data_1;
                        end
                        b = b+n_lost+1;
                    else
                        data0_fixed(b,:) = data0(a,:);
                        b = b+1;
                    end
                    a = a+1;

                    if data0_fixed(end,1) == 60000
                        break
                    end
                end
            else
                data0_fixed = data0;
            end

            %% データ読込（avt_data.csv，DATA1.csv，DATA2.csv）　1P，2Pに分離
            if suffix == '1'
                avt0 = horzcat(data0_fixed(:,1),data0_fixed(:,2));
                data_list = dir([filename,'DATA1_*']);
                data = csvread([filename,data_list.name],2,0);
            else
                avt0 = horzcat(data0_fixed(:,1),data0_fixed(:,4));
                data_list = dir([filename,'DATA2_*']);
                data = csvread([filename,data_list.name],2,0);
            end
            
            %% 仮コントローラ波形
            if length(data)~=60000
                disp('操作データ取得ミス');
                pause on;
                pause;
            end
                
            tempPul = zeros(60000,1);
            for i = 2:60000
                tempPul(i) = data(i,2) + tempPul(i-1);
            end
            
            %% アバタ速度再計算
            if suffix =='1'
                [Pul, avt_data, cycle_data, Err] ...
                    = Rhythm.rhythmAvt_splitData_func(tempPul, avt0, -200, 7500, match_data, suffix); %操作波形，アバタ座標，試合データ
            else
                [Pul, avt_data, cycle_data, Err] ...
                    = Rhythm.rhythmAvt_splitData_func(tempPul, avt0, -200, 7500, match_data, suffix);
            end

            obj.splitTime = match_data;

            obj.time.highSampled = data(:, 1) + 1  ;
            obj.time.lowSampled = avt0(:,1);
            
            obj.operatePulse.highSampled = Pul;
            obj.operatePulse.lowSampled = Pul(avt0(:,1));
            
            obj.avatarPosition.highSampled = avt_data(:,2);
            obj.avatarPosition.lowSampled = avt0(:,2);
            
            if suffix =='1'
                obj.avatarSword = data0_fixed(:,3);
            else
                obj.avatarSword = data0_fixed(:,5);
            end
            
            obj.avatarPosition.error = Err;
            
            obj.avatarVelocity.highSampled = avt_data(:,1);
            
            obj.zeroCrossData.zeroCrossTime         = cycle_data(:,1);
            obj.zeroCrossData.area                  = cycle_data(:,2);
            obj.zeroCrossData.nonlogAvtVelocity     = cycle_data(:,3);
            obj.zeroCrossData.avtVelocity           = cycle_data(:,4);
            
%             if ~isempty(data0_fixed(1,6))
%                 obj.meanDelayTime = mean(data0_fixed(:,6));
%             end
            
            % ゼロクロス点間ピーク値情報
%             zeroCrossData.peak.value，zeroCrossData.peak.time
%             t_zx =1:cycle_data(1,1);            %初めのゼロクロスまでの時間
%             t_zx = t_zx';
            
%             初めのゼロクロスはエラーが多いため，ピーク算出なし

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
