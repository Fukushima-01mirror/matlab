classdef RawGraph < Analyze.Base
    %PRECURSOR このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = RawGraph(config,data)
            obj = obj@Analyze.Base(config,data);

        end


        function runForAlone(obj,user)
            opti = user.opti;
            subplot(3,1,1);
            plot(    opti.body.raw.time, opti.body.raw.position.x, 'o',...
                opti.head.raw.time, opti.head.raw.position.x, 'o',...
                opti.rightHand.raw.time, opti.rightHand.raw.position.x, 'o' );
            legend('Body','Head','RightHand',-1);
            title('x');


            subplot(3,1,2);
            plot(    opti.body.raw.time, opti.body.raw.position.y, 'o', ...
                opti.head.raw.time, opti.head.raw.position.y, 'o', ...
                opti.rightHand.raw.time, opti.rightHand.raw.position.y, 'o'  );
            legend('Body','Head','RightHand',-1);
            title('y');


            subplot(3,1,3);
            plot(    opti.body.raw.time, opti.body.raw.position.z, 'o', ...
                opti.head.raw.time, opti.head.raw.position.z, 'o', ...
                opti.rightHand.raw.time, opti.rightHand.raw.position.z, 'o'  );
            legend('Body','Head','RightHand',-1);
            title('z');

            obj.saveGraph();
            
            
            
        end

    end
end
