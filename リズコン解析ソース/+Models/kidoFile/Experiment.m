classdef Experiment < Models.DataGroupAbstruct
    %Device ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q

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
