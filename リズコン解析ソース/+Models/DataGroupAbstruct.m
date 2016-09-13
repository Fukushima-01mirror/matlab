classdef DataGroupAbstruct < Models.ModelAbstruct
    % このクラスの概要をここに記述
    % 詳細説明をここに記述

    properties
    end

    methods
        function obj = DataGroupAbstruct(propertyNames)
             obj = obj@Models.ModelAbstruct(propertyNames);
        end

        function backupToRaw(obj)
            for i=1:obj.length
                if(isempty(obj.getData(i)))
                    continue;
                end
                obj.getData(i).backupToRaw();
            end
        
        end
        
        function offset(obj,startTime)
            for i=1:obj.length
                if(isempty(obj.getData(i)))
                    continue;
                end
                obj.getData(i).offset(startTime);
            end
        end
        
        
        function trim(obj,startTime,endTime)
            for i=1:obj.length
                if(isempty(obj.getData(i)))
                    continue;
                end
                obj.getData(i).trim(startTime,endTime);
            end
        end
        
        
        function splineTrim(obj,startTime,endTime)
            for i=1:obj.length
                if(isempty(obj.getData(i)))
                    continue;
                end
                obj.getData(i).splineTrim(startTime,endTime);
            end
        end
        
        
        function yOffsetAvg(obj)
            for i=1:obj.length
                if(isempty(obj.getData(i)))
                    continue;
                end
                obj.getData(i).yOffsetAvg();
            end
        end
        
               
        function spline(obj)
            for i=1:obj.length
                if(isempty(obj.getData(i)))
                    continue;
                end
                obj.getData(i).spline();
            end
        end
        
        function useLowpassFilter(obj, samplingTime, tc)
            for i=1:obj.length
                if(isempty(obj.getData(i)))
                    continue;
                end
                obj.getData(i).useLowpassFilter( samplingTime, tc);
            end
            
        end 

        function useBandpassFilter(obj)
            for i=1:obj.length
                if(isempty(obj.getData(i)))
                    continue;
                end
                obj.getData(i).useBandpassFilter();
            end
            
        end 
        
%%        
        function removeDoubleData(obj)
            for i=1:obj.length
                if(isempty(obj.getData(i)))
                    continue;
                end
                obj.getData(i).removeDoubleData();
            end
        end
        
        function removeErrors(obj, errorRange)
            for i=1:obj.length
                if(isempty(obj.getData(i)))
                    continue;
                end
                obj.getData(i).removeErrors(errorRange);
            end
        end
        

    end
end
