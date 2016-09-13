classdef comfirmLogPara < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = comfirmLogPara(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
            
            plot( abs( user.zeroCrossData.nonlogAvtVelocity(10:end) ), abs( user.zeroCrossData.avtVelocity(10:end) ) , '*');
            xlim([0 50000]);  ylim([0 0.5]);
            obj.saveGraph();            
        end

    end
end