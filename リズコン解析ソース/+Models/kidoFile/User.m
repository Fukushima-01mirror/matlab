classdef User < Models.DataGroupAbstruct
    %Device ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q

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
