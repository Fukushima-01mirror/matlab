classdef NormalGraph < Analyze.Base
    %PRECURSOR このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = NormalGraph(config,data)
            obj = obj@Analyze.Base(config,data);

        end


        function runForAlone(obj,user)
 opti = user.opti;
            subplot(3,1,1);
            plot(    opti.body.time, opti.body.position.x, ...
                opti.head.time, opti.head.position.x, ...
                opti.rightHand.time, opti.rightHand.position.x  );
            legend('Body','Head','RightHand',-1);
            title('x');


            subplot(3,1,2);
            plot(    opti.body.time, opti.body.position.y, ...
                opti.head.time, opti.head.position.y, ...
                opti.rightHand.time, opti.rightHand.position.y  );
            legend('Body','Head','RightHand',-1);
            title('y');


            subplot(3,1,3);
            plot(    opti.body.time, opti.body.position.z, ...
                opti.head.time, opti.head.position.z, ...
                opti.rightHand.time, opti.rightHand.position.z  );
            legend('Body','Head','RightHand',-1);
            title('z');

            obj.saveGraph();
        end

    end
end
