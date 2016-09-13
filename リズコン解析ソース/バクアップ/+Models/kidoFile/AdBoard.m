classdef AdBoard < Models.DataAbstruct
    %Device このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
        rightTop
        rightBottom
        leftTop
        leftBottom
        width
        height
    end

    methods
        function obj = AdBoard()
            
            propertyNames = { ...
                'time' ...
                'rightTop' ...
                'rightBottom' ...
                'leftTop' ...
                'leftBottom' ...
            };
            obj = obj@Models.DataAbstruct(propertyNames);
            
        end

        
        
        function g = weight(obj)
            g = obj.rightTop + obj.rightBottom + obj.leftTop + obj.leftBottom; 
        end
        
        function g = gravityCenter(obj)
            % leftHandBoradWidth = 139;
            % leftHandBoradHeight = 228;
            % wiiBoadWidth = 430;
            % wiiBoadHeight = 240;
            
            weight = obj.weight();
            
            g.x = ((obj.rightTop + obj.rightBottom) - (obj.leftTop + obj.leftBottom)) ./ weight * (obj.width/2);
            g.z = ((obj.rightTop + obj.leftTop) - (obj.rightBottom + obj.leftBottom)) ./ weight * (obj.height/2);
            
        end
        
        function supplement(obj, index)
            posData = [ 1 1 1;
                        5 3 4; ...
                        4 2 5; ...
                        3 2 5; ...
                        2 3 4];
            obj.setData(index, obj.getData(posData(index,2)) .* obj.getData(posData(index,3)) ./ obj.getData(posData(index,1)) );
        end
        
        function convertFromSlaveToGlobal(obj)
            tmpLT = obj.leftTop;
            tmpLB = obj.leftBottom;
            tmpRT = obj.rightTop;
            tmpRB = obj.rightBottom;
            
            obj.leftTop = tmpRB;
            obj.leftBottom = tmpRT;
            obj.rightTop = tmpLB;
            obj.rightBottom = tmpLT;
            
        end
    end
end
