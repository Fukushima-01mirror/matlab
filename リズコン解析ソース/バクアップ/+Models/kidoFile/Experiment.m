classdef Experiment < Models.DataGroupAbstruct
    %Device このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
        master
        slave
    end

    methods
        function obj = Experiment()
            propertyNames = { ...
                'master' ...
                'slave' ...
                };
            obj = obj@Models.DataGroupAbstruct(propertyNames);
            
        end

    end
end
