classdef AdBoardGroup < Models.DataGroupAbstruct
    %Device このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
        leftHand
        seat
        foot
        leftHandPos
        footPos
    end

    methods
        function obj = AdBoardGroup()
            
            propertyNames = { ...
                'leftHand' ...
                'seat' ...
                'foot' ...
            };
            obj = obj@Models.DataGroupAbstruct(propertyNames);
        end

        function supplementFor20120910(obj, weight)
            leftHandWeight = obj.leftHand.rightTop + obj.leftHand.rightBottom + obj.leftHand.leftTop + obj.leftHand.leftBottom ;
            seatWeight = obj.seat.rightTop + obj.seat.rightBottom + obj.seat.leftTop + obj.seat.leftBottom ;
            footHandWeight = obj.foot.rightBottom + obj.foot.leftTop + obj.foot.leftBottom ;
            
            weightArr = leftHandWeight + seatWeight + footHandWeight;
            weightArr = weight - weightArr;
            %obj.seat.rightBottom = weightArr .* seatWeight ./ footHandWeight;
            %obj.foot.rightTop = weightArr .* footHandWeight ./ seatWeight;
            obj.foot.rightTop = weightArr;
        end

        function g = weight(obj)
            handWeight = obj.leftHand.weight();
            seatWeight = obj.seat.weight();
            footWeight = obj.foot.weight();
            
            g = handWeight + seatWeight + footWeight;
        end
        
        function pos = bodyGravityCenter(obj)
            handPos = obj.leftHand.gravityCenter();
            seatPos = obj.seat.gravityCenter();
            footPos = obj.foot.gravityCenter();
            
            handWeight = obj.leftHand.weight();
            seatWeight = obj.seat.weight();
            footWeight = obj.foot.weight();
            
            weight = obj.weight();
            
            pos.x = ((footPos.x + obj.footPos.x) .* footWeight + seatPos.x .* seatWeight + (handPos.x + obj.leftHandPos.x) .* handWeight) ./ weight;
            pos.z = ((footPos.z + obj.footPos.z) .* footWeight + seatPos.z .* seatWeight + (handPos.z + obj.leftHandPos.z) .* handWeight) ./ weight;
        end
        
        function t = time(obj)
            t = obj.leftHand.time;
        end
    end
end
