classdef ModelAbstruct < handle

    properties
        propertyNames
    end

    methods
        function obj = ModelAbstruct(propertyNames)
            obj.propertyNames = propertyNames;
        end

        function data = getData(obj,index)      %obj��index�̒l��ǂݍ���
            exp = char(strcat('data = obj.',obj.propertyNames(index),';' ));
            eval(exp);
        end
        
        function setData(obj,index,data)        %obj��index��data�̒l����������
            exp = char(strcat('obj.',obj.propertyNames(index),' = data;' ));
            eval(exp);
        end
        
        
        function max = length(obj)              %obj�̃T�C�Y���擾����
            max = length(obj.propertyNames);
        end
        
    end
end
