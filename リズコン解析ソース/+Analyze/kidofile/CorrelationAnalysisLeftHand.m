classdef CorrelationAnalysisLeftHand < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = CorrelationAnalysisLeftHand(config,data)
            obj = obj@Analyze.Base(config,data);
        end


        function run(obj)
            
            dirs = {'','x','z'};
            
            master = obj.data.master.adBoard.leftHand.weight();
            slave = obj.data.slave.adBoard.leftHand.weight();
            time = obj.data.master.adBoard.time;                   
            
            subplot(1,1,1);
            [timeCorr, AB_Series0, AB_Series_Max] = Tw.TW_AllCorr(master, slave, time, 5);
            
            plot(timeCorr, AB_Series0, timeCorr, AB_Series_Max(:,2));
            legend('series','max',4);
            title('weight');
            ylim([-1 1]);
                        
            obj.saveGraph();
            
            %右手　体　頭　xyz
            titles(1,1) = cellstr('weight');
            correlationValues(1,1) =  obj.xcorrAtZero( master, slave);


            obj.outputAllToXls(correlationValues,titles);
        end


        function num =  xcorrAtZero(obj,A,B)
            tmpSougo = xcorr( A-mean(A) , B-mean(B), 'coeff');
            num = tmpSougo(length(A));
        end
        

    end
end
