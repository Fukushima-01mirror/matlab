classdef OptiGroup < Models.DataGroupAbstruct
    %Device このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
        rightHand
        body
        head
    end

    methods
        function obj = OptiGroup(dirname, suffix)
            propertyNames = { ...
                'rightHand' ...
                'body' ...
                'head' ...
                };
            obj = obj@Models.DataGroupAbstruct(propertyNames);
            
            fileName = char(strcat(dirname,'\RightHand',suffix,'.csv'));
            obj.rightHand = Models.Opti(fileName);
            
            fileName = char(strcat(dirname,'\Head',suffix,'.csv'));
            obj.head = Models.Opti(fileName);
            
            fileName = char(strcat(dirname,'\Body',suffix,'.csv'));
            obj.body = Models.Opti(fileName);            
        end

        function transformFor20120910(obj)
            for i = 1:obj.length()
                obj.getData(i).transformFor20120910();
            end
        end
        
    end
end
