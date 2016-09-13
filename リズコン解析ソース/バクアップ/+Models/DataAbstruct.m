classdef DataAbstruct  < Models.ModelAbstruct
    %DATA このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
        time    %時間データ
        raw     %元データ
    end


    methods
        function obj = DataAbstruct(propertyNames)
             obj = obj@Models.ModelAbstruct(propertyNames);
        end
        
        function data = matrix(obj)     %各オブジェクトのデータを行列化
            data = zeros(length(obj.time),obj.length());
            for i = 1:obj.length()
                data(:,i) = obj.getData(i);
            end        
        end

        function backupToRaw(obj)      %処理前のデータをバックアップ？
            propertyNames = properties(obj);
            for i = 1:length(propertyNames)
                if strcmp(propertyNames(i),'propertyNames') || strcmp(propertyNames(i),'raw')
                    continue;
                end
                exp = char(strcat('obj.raw.',propertyNames(i),' = obj.',propertyNames(i),';' ));
                eval(exp);
            end
        end
        
        function trim(obj, startTime, endTime)  %データのトリミング
            removeFlags = obj.time < startTime | obj.time > endTime;
            for i=1:obj.length()
                data = obj.getData(i);
                data(removeFlags) = [];
                obj.setData( i,  data);
            end
        end

        function splineTrim(obj, startTime, endTime)    %データトリミングしてスプライン補間
            newTime = startTime:0.5:endTime;
            for i=2:obj.length()
                obj.setData( i,  spline(obj.time, obj.getData(i), newTime) );
            end
            obj.time = newTime;
        
        end

        function spline(obj)        %スプライン補間
            newTime = min(obj.time):0.01: max(obj.time);
            for i=2:obj.length()
                obj.setData( i, spline(obj.time, obj.getData(i), newTime));
            end
            obj.time = newTime;
        end
        
        function offset(obj, startTime)         %時間オフセット
            obj.time = obj.time - startTime;
        end

        function yOffsetAvg(obj)            %平均値でオフセット
            for i=2:obj.length()
                obj.setData( i, obj.getData(i) - mean(obj.getData(i)));
            end
        end

        function useLowpassFilter(obj, samplingTime, tc)    %ローパスフィルタ
            N=1;%フィルタの次数
            Fs=1/samplingTime; %サンプリング周波数
            t=tc;
            Fc=1/(2*pi*t);
            Wn = Fc/(Fs/2); %カットオフ周波数
            [b,a]= butter(N, Wn);
            for i = 2:obj.length()
                obj.setData(i, filtfilt(b,a,obj.getData(i)));
            end
        end
        
        function useBandpassFilter(obj) %バンドパスフィルタ（3-7Hz）　FIRデジタルフィルタ
            k = csvread('BPFkeisuu_20130509.txt');    %フィルタ係数
            t_delay = length(k);                        %遅れ時間
            for i = 2:obj.length()  
                y = filter( k(:,1), 1, obj.getData(i) );    %フィルタリング
                xf = vertcat( zeros(t_delay,1) , y(1:length(y)-t_delay));   %遅れ時間補正
                obj.setData(i, xf);
            end
            
        end

%%
        function removeDoubleData(obj)      %
            errors = (diff(obj.time) == 0);
            
            for i=1:obj.length()
                data = obj.getData(i) ;
                data(errors,:) = [];
                obj.setData( i, data);
            end
        
        end

        function removeErrors(obj, errorRange)
            len = length(obj.time);
            tmp = obj.getData(2);
            if(length(tmp(1,:) ) >length(tmp(:,1) )  )
                errors = zeros(1,len);
            else
                errors = zeros(len,1);                
            end
            for i=2:obj.length()
                if(errorRange ~= 0)
                    data = obj.getData(i) ;
                    data = data - mean(data);
                    errors = errors |  abs( data ) > errorRange * std(data);
                end
            end
            deleteNum = 3;
            space = 0.1;
            for k = 1:length(obj.time) - 1
                if obj.time(k) + space < obj.time(k + 1) 
                    errors( max(1,k-deleteNum) : min(k+deleteNum+1,len) ) = 1;
                end

            end
    
            for i=1:obj.length()
                data = obj.getData(i) ;
                data(errors,:) = [];
                obj.setData( i, data);
            end
        end

    end


end
