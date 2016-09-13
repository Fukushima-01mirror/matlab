classdef xcorrCalibBoard < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = xcorrCalibBoard(config,data)
            obj = obj@Analyze.Base(config,data);
        end


        function runForAlone(obj,user)
            results = zeros(1,4);
            deltaTime = (min(user.adBoard.time) - max(user.adBoard.time))/(length(user.adBoard.time)-1);
            
            board = user.adBoard.leftHand.gravityCenter();
            optiPos =  user.opti.head.position;
            
            board.x = board.x - mean(board.x);
            board.z = board.z - mean(board.z);
            optiPos.x = optiPos.x - mean(optiPos.x);
            optiPos.z = optiPos.z - mean(optiPos.z);
            
            xcorrX = xcorr(board.x /1000 , optiPos.x ,'coeff');
            [C,I]  = max(xcorrX);
            preTimeCount = I - (length(xcorrX)-1)/2 + 1;
            preTime = preTimeCount * deltaTime;
            results(1) = preTime;
            results(2) = C;
            
            subplot(2,2,1);
            plot(user.adBoard.time, board.x / 1000, ...
                user.opti.head.time, optiPos.x);
            legend('board','opti');
            title('x');
            
            subplot(2,2,2);
            plot(user.adBoard.time + preTime, board.x / 1000, ...
                user.opti.head.time, optiPos.x);
            legend('board','opti');
            title('offsetted x');
            
            
            
            
            xcorrZ = xcorr(board.z /1000, optiPos.z ,'coeff');
            [C,I]  = max(xcorrZ);
            preTimeCount = I - (length(xcorrZ)-1)/2 + 1;
            preTime = preTimeCount * deltaTime;
            results(3) = preTime;
            results(4) = C;
            
            subplot(2,2,3);
            plot(user.adBoard.time, board.z  /1000, ...
                user.opti.head.time,optiPos.z);
            legend('board','opti');
            title('z');
            
            
            subplot(2,2,4);
            plot(user.adBoard.time + preTime, board.z  /1000, ...
                user.opti.head.time, optiPos.z);
            legend('board','opti');
            title('offsetted z');
            
            obj.saveGraph();
            
            obj.outputAllToXls(results,{'x-時間','x-値','z-時間','z-値'});
        end



    end
end
