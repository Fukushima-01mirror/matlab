classdef Opti < Models.DataAbstruct
    %Device このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
        position
        quaternion
        angle
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
        function obj = Opti(filename)
             propertyNames = { ...
                'time' ...
                'position.x' ...
                'position.y' ...
                'position.z' ...
                'quaternion.x' ...
                'quaternion.y' ...
                'quaternion.z' ...
                'quaternion.w' ...
                'angle.yaw' ...
                'angle.pitch' ...
                'angle.roll' ...
                };
            obj = obj@Models.DataAbstruct(propertyNames);
            
            data = load(filename);
            obj.time = data(:, 1) / 1000 ;
            obj.position.x = data(:, 2);
            obj.position.y = data(:, 3);
            obj.position.z = data(:, 4);
            obj.quaternion.x = data(:, 5);
            obj.quaternion.y = data(:, 6);
            obj.quaternion.z = data(:, 7);
            obj.quaternion.w = data(:, 8);
            obj.angle.yaw = data(:, 9);
            obj.angle.pitch = data(:, 10);
            obj.angle.roll = data(:, 11);
            
        end

        function moveToMean(obj)
            for i = 2: obj.length()
                data = obj.getData(i);
                obj.setData(i, data - mean(data) );
            end
        end


        function max = length(obj)
            max = 9;
        end

        function transformFor20120910(obj)
            preX = obj.position.x;
            preZ = obj.position.z;
            obj.position.x = preZ;
            obj.position.z = -preX;
        end
        
        %{
        function convertFromSlaveToMaster(obj)
            tmpX = obj.position.x;
            tmpY = obj.position.y;
            tmpZ = obj.position.z;
            
            obj.position.x = -tmpX;
            obj.position.y = tmpY;
            obj.position.z = -tmpZ;
            
        end
        %}
    end
end
