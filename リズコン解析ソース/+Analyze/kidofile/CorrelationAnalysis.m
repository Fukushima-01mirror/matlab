classdef CorrelationAnalysis < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = CorrelationAnalysis(config,data)
            obj = obj@Analyze.Base(config,data);
        end


        function runForAlone(obj,user)
            opti = user.opti;
            dirs = {'','x','y','z'};
            pos  = {'','body','head'};
            for j = 2:4
                for i = 2:3
                    base = opti.rightHand.getData(j);
                    subject = opti.getData(i).getData(j);
                    time = opti.rightHand.time;                    
                    [timeCorr, AB_Series0, AB_Series_Max] = Tw.TW_AllCorr(subject, base, time, 5);
                    
                    
                    subplot(3,2,(j-2)*2+(i-1));
                    plot(timeCorr, AB_Series0, timeCorr, AB_Series_Max(:,2));
                    legend('series','max',4);
                    title(char(strcat(dirs(j),pos(i))));
                    ylim([-1 1]);
                end
            end

            obj.saveGraph();

            correlationValues = zeros(1,6);
            titles = cell(1,6);

            %右手　体　頭　xyz
            titles(1,1) = cellstr('xBody');
            correlationValues(1,1) =  obj.xcorrAtZero( opti.body.position.x, opti.rightHand.position.x);
            titles(1,2) = cellstr('yBody');
            correlationValues(1,2) =  obj.xcorrAtZero( opti.body.position.y, opti.rightHand.position.y);
            titles(1,3) = cellstr('zBody');
            correlationValues(1,3) =  obj.xcorrAtZero( opti.body.position.z, opti.rightHand.position.z);

            titles(1,4) = cellstr('xHead');
            correlationValues(1,4) =  obj.xcorrAtZero( opti.head.position.x, opti.rightHand.position.x);
            titles(1,5) = cellstr('yHead');
            correlationValues(1,5) =  obj.xcorrAtZero( opti.head.position.y, opti.rightHand.position.y);
            titles(1,6) = cellstr('zHead');
            correlationValues(1,6) =  obj.xcorrAtZero( opti.head.position.z, opti.rightHand.position.z);


            obj.outputAllToXls(correlationValues,titles);
        end


        function num =  xcorrAtZero(obj,A,B)
            tmpSougo = xcorr( A-mean(A) , B-mean(B), 'coeff');
            num = tmpSougo(length(A));
        end
        

    end
end
