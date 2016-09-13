classdef CorrelationAnalysisAdBoard < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = CorrelationAnalysisAdBoard(config,data)
            obj = obj@Analyze.Base(config,data);
        end


        function runForAlone(obj,user)
            
            dirs = {'','x','z'};
            
            device = user.device.getOptiPosition();
            gravity = user.adBoard.bodyGravityCenter();
            time = user.device.time;                    
            
            subplot(2,1,1);
            [timeCorr, AB_Series0, AB_Series_Max] = Tw.TW_AllCorr(gravity.x, device.x, time, 5);
            
            plot(timeCorr, AB_Series0, timeCorr, AB_Series_Max(:,2));
            legend('series','max',4);
            title('x');
            ylim([-1 1]);
            
            
            subplot(2,1,2);
            [timeCorr, AB_Series0, AB_Series_Max] = Tw.TW_AllCorr(gravity.z, device.z, time, 5);
            
            plot(timeCorr, AB_Series0, timeCorr, AB_Series_Max(:,2));
            legend('series','max',4);
            title('z');
            ylim([-1 1]);
                        
            obj.saveGraph();

            correlationValues = zeros(1,2);
            titles = cell(1,2);

            %右手　体　頭　xyz
            titles(1,1) = cellstr('xBody');
            correlationValues(1,1) =  obj.xcorrAtZero( gravity.x, device.x);
            titles(1,2) = cellstr('zBody');
            correlationValues(1,2) =  obj.xcorrAtZero( gravity.z, device.z);


            obj.outputAllToXls(correlationValues,titles);
        end


        function num =  xcorrAtZero(obj,A,B)
            tmpSougo = xcorr( A-mean(A) , B-mean(B), 'coeff');
            num = tmpSougo(length(A));
        end
        

    end
end
