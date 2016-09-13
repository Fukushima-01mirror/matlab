classdef Analize < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = Analize(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
        end

    end
end