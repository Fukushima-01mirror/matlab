classdef AdBoardCheck < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = AdBoardCheck(config,data)
            obj = obj@Analyze.Base(config,data);
        end


       function runForAlone(obj,user)
            titles = { ...
                '左手_右上' '左手_右下' '左手_左上' '左手_左下' ...
                '座面_右上' '座面_右下' '座面_左上' '座面_左下' ...
                '足面_右上' '足面_右下' '足面_左上' '足面_左下' ...
                };
           
             
            weightValue = zeros(1,12);
            for i = 1:3
                for j= 1:4
                    weightValue(1,(i-1)*4 + j) = sum(user.adBoard.getData(i).getData(j+1));
                end
            end
            
            obj.outputAllToXls(weightValue,titles);
           
       end
       
       %{
        function run(obj)
            titles = {'master','master std','slave','slave std'};
            weight = obj.data.adBoard.weight();
             
            weightValue = zeros(1,4);
            weightTmp = weight.master.leftHand + weight.master.seat + weight.master.foot;
            weightValue(1,1) = mean(weightTmp);
            weightValue(1,2) = std(weightTmp);
            
            
            weightTmp = weight.slave.leftHand + weight.slave.seat + weight.slave.foot;
            weightValue(1,3) = mean(weightTmp);
            weightValue(1,4) = std(weightTmp);
            

            obj.outputAllToXls(weightValue,titles);
        end

%}
        

    end
end
