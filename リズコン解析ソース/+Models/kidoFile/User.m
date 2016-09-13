classdef User < Models.DataGroupAbstruct
    %Device このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
        opti
        device
        adBoard
    end

    methods
        function obj = User()
             propertyNames = { ...
                'opti' ...
                'device' ...
                'adBoard' ...
                };
            obj = obj@Models.DataGroupAbstruct(propertyNames);
        end

        
    end
end
