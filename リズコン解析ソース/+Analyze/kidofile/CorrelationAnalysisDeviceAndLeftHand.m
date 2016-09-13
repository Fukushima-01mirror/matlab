classdef CorrelationAnalysisDeviceAndLeftHand < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = CorrelationAnalysisDeviceAndLeftHand(config,data)
            obj = obj@Analyze.Base(config,data);
        end


        function runForAlone(obj,user)

            
            weight = user.adBoard.leftHand.weight();
            pos = user.device.getOptiPosition();
            time = user.adBoard.time;                   
            
            subplot(2,1,1);
            [timeCorr, AB_Series0, AB_Series_Max] = Tw.TW_AllCorr(weight, pos.x, time, 5);
            
            plot(timeCorr, AB_Series0, timeCorr, AB_Series_Max(:,2));
            legend('series','max',4);
            title('x');
            ylim([-1 1]);
            
            
            subplot(2,1,2);
            [timeCorr, AB_Series0, AB_Series_Max] = Tw.TW_AllCorr(weight, pos.z, time, 5);
            
            plot(timeCorr, AB_Series0, timeCorr, AB_Series_Max(:,2));
            legend('series','max',4);
            title('z');
            ylim([-1 1]);
                        
            obj.saveGraph();
            
            %右手　体　頭　xyz
            titles(1,1) = cellstr('x');
            correlationValues(1,1) =  obj.xcorrAtZero( weight, pos.x);
            titles(1,2) = cellstr('z');
            correlationValues(1,2) =  obj.xcorrAtZero( weight, pos.z);


            obj.outputAllToXls(correlationValues,titles);
        end


        function num =  xcorrAtZero(obj,A,B)
            tmpSougo = xcorr( A-mean(A) , B-mean(B), 'coeff');
            num = tmpSougo(length(A));
        end
        

    end
end
