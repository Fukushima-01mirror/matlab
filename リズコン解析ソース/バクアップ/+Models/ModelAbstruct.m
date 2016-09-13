classdef ModelAbstruct < handle

    properties
        propertyNames
    end

    methods
        function obj = ModelAbstruct(propertyNames)
            obj.propertyNames = propertyNames;
        end

        function data = getData(obj,index)      %objのindexの値を読み込む
            exp = char(strcat('data = obj.',obj.propertyNames(index),';' ));
            eval(exp);
        end
        
        function setData(obj,index,data)        %objのindexにdataの値を書き込む
            exp = char(strcat('obj.',obj.propertyNames(index),' = data;' ));
            eval(exp);
        end
        
        
        function max = length(obj)              %objのサイズを取得する
            max = length(obj.propertyNames);
        end
        
    end
end
