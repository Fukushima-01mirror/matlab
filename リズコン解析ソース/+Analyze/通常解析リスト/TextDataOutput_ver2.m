classdef TextDataOutput_ver2 < Analyze.Base
    %STANDARDDEVIATION このクラスの概要をここに記述
    %   詳細説明をここに記述

    properties
    end

    methods
        function obj = TextDataOutput_ver2(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
            
            if ~exist( obj.saveFilePath('') ,'dir')
                mkdir(obj.saveFilePath(''));
            end
            
            avt1DataTitle = {'Time[ms]','ControllerPulse','AvatarVelocity','AvatarPosition'};
            avt1Data =  horzcat( user.time.highSampled , user.operatePulse.highSampled, user.avatarVelocity.highSampled, user.avatarPosition.highSampled );
            avt1DataOutput = [ avt1DataTitle; num2cell(avt1Data)];
            [nrows,ncols]= size(avt1DataOutput);
            Filename = obj.saveFilePath(char(strcat('\avtData.txt')));
            fid = fopen(Filename, 'w');
            for row=1:nrows
                if row ==1
                    fprintf(fid, '%s\t%s\t%s\t%s\r\n', avt1DataOutput{row,:});
                else
                    fprintf(fid, '%d\t%d\t%f\t%f\r\n', avt1DataOutput{row,:});
                end
            end
            fclose(fid);
            
            [period_zx1, peak_zx1] = Rhythm.setZeroCrossPeriodData(user.zeroCrossData);
            [peakCount1] = Rhythm.setZeroCrossCount(user.zeroCrossData);
            ZcData1Title = {'halfPeriod[ms]','Period[ms]','difHalfPeriod[ms]',...
                'Peak','Amplitude','difPeak',...
                'ZeroCrossTime[ms]','OperatePulsesSum','AvatarVelocity(nonLog)','AvatarVelocity','peakCount'};
            
            ZcData1 =  horzcat( abs(period_zx1) , abs(peak_zx1) , ...
                user.zeroCrossData.zeroCrossTime, user.zeroCrossData.area, ...
                abs(user.zeroCrossData.nonlogAvtVelocity) , user.zeroCrossData.avtVelocity , peakCount1(:,1) );
            ZcData1Output = [ ZcData1Title; num2cell(ZcData1)];
            [nrows,ncols]= size(ZcData1Output);
            zc1Filename = obj.saveFilePath(char(strcat('\CycleData.txt')));
            fid = fopen(zc1Filename, 'w');
            for row=1:nrows
                if row ==1
                    fprintf(fid, '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\r\n', ZcData1Output{row,:});
                else
                    fprintf(fid, '%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%f\t%d\r\n', ZcData1Output{row,:});
                end
            end
            fclose(fid);

        end

        function runForPair(obj,user1,user2)
            
            if ~exist( obj.saveFilePath('') ,'dir')
                mkdir(obj.saveFilePath(''));
            end

            avt1DataTitle = {'Time[ms]','ControllerPulse','AvatarVelocity','AvatarPosition'};
            avt1Data =  horzcat( user1.time.highSampled , user1.operatePulse.highSampled, user1.avatarVelocity.highSampled, user1.avatarPosition.highSampled );
            avt1DataOutput = [ avt1DataTitle; num2cell(avt1Data)];
            [nrows,ncols]= size(avt1DataOutput);
            Filename = obj.saveFilePath(char(strcat('\avtData1.txt')));
            fid = fopen(Filename, 'w');
            for row=1:nrows
                if row ==1
                    fprintf(fid, '%s\t%s\t%s\t%s\r\n', avt1DataOutput{row,:});
                else
                    fprintf(fid, '%d\t%d\t%f\t%f\r\n', avt1DataOutput{row,:});
                end
            end
            fclose(fid);

            avt2DataTitle = {'Time[ms]','ControllerPulse','AvatarVelocity','AvatarPosition'};
            avt2Data =  horzcat( user2.time.highSampled , user2.operatePulse.highSampled, user2.avatarVelocity.highSampled, user2.avatarPosition.highSampled );
            avt2DataOutput = [ avt2DataTitle; num2cell(avt2Data)];
            [nrows,ncols]= size(avt2DataOutput);
            Filename = obj.saveFilePath(char(strcat('\avtData2.txt')));
            fid = fopen(Filename, 'w');
            for row=1:nrows
                if row ==1
                    fprintf(fid, '%s\t%s\t%s\t%s\r\n', avt2DataOutput{row,:});
                else
                    fprintf(fid, '%d\t%d\t%f\t%f\r\n', avt2DataOutput{row,:});
                end
            end
            fclose(fid);

            filterdPul1 = Rhythm.BPfilter( user1.operatePulse.lowSampled);
            filterdPul2 = Rhythm.BPfilter( user2.operatePulse.lowSampled);
            [timeCorr, AB_Series0, AB_Series_Max] = Rhythm.AllCorr__func(filterdPul1, filterdPul2, user2.time.lowSampled, 100);
            
            filterdPulDataTitle = {'Time[ms]','FilterControllerPulse(1P)','FilterControllerPulse(2P)'};
            filterdPulData =  horzcat( user1.time.lowSampled , filterdPul1, filterdPul2 );
            filterdPulDataOutput = [ filterdPulDataTitle; num2cell(filterdPulData)];
            [nrows,ncols]= size(filterdPulDataOutput);
            Filename = obj.saveFilePath(char(strcat('\filterPulData.txt')));
            fid = fopen(Filename, 'w');
            for row=1:nrows
                if row ==1
                    fprintf(fid, '%s\t%s\t%s\r\n', filterdPulDataOutput{row,:});
                else
                    fprintf(fid, '%d\t%f\t%f\r\n', filterdPulDataOutput{row,:});
                end
            end
            fclose(fid);
            
            contCorrDataTitle = {'Time[ms]','dTime','ContCorrMax','ContCorr(dTime=0)'};
            contCorrData =  horzcat( timeCorr , AB_Series_Max, AB_Series0 );
            contCorrDataOutput = [ contCorrDataTitle; num2cell(contCorrData)];
            [nrows,ncols]= size(contCorrDataOutput);
            Filename = obj.saveFilePath(char(strcat('\contCorrData.txt')));
            fid = fopen(Filename, 'w');
            for row=1:nrows
                if row ==1
                    fprintf(fid, '%s\t%s\t%s\t%s\r\n', contCorrDataOutput{row,:});
                elseif ~isnan(contCorrDataOutput{row,3})
                    fprintf(fid, '%d\t%d\t%f\t%f\r\n', contCorrDataOutput{row,:});
                end
            end
            fclose(fid);
            
            
            [period_zx1, peak_zx1] = Rhythm.setZeroCrossPeriodData(user1.zeroCrossData);
            [peakCount1] = Rhythm.setZeroCrossCount(user1.zeroCrossData);
            ZcData1Title = {'halfPeriod[ms]','Period[ms]','difHalfPeriod[ms]',...
                'Peak','Amplitude','difPeak',...
                'ZeroCrossTime[ms]','OperatePulsesSum','AvatarVelocity(nonLog)','AvatarVelocity','peakCount'};
            
            ZcData1 =  horzcat( abs(period_zx1) , abs(peak_zx1) , ...
                user1.zeroCrossData.zeroCrossTime, user1.zeroCrossData.area, ...
                abs(user1.zeroCrossData.nonlogAvtVelocity) , user1.zeroCrossData.avtVelocity , peakCount1(:,1) );
            ZcData1Output = [ ZcData1Title; num2cell(ZcData1)];
            [nrows,ncols]= size(ZcData1Output);
            zc1Filename = obj.saveFilePath(char(strcat('\CycleData1.txt')));
            fid = fopen(zc1Filename, 'w');
            for row=1:nrows
                if row ==1
                    fprintf(fid, '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\r\n', ZcData1Output{row,:});
                else
                    fprintf(fid, '%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%f\t%d\r\n', ZcData1Output{row,:});
                end
            end
            fclose(fid);
            
            [period_zx2, peak_zx2] = Rhythm.setZeroCrossPeriodData(user2.zeroCrossData);
            [peakCount2] = Rhythm.setZeroCrossCount(user2.zeroCrossData);
            ZcData2Title = {'halfPeriod[ms]','Period[ms]','difHalfPeriod[ms]',...
                'Peak','Amplitude','difPeak',...
                'ZeroCrossTime[ms]','OperatePulsesSum','AvatarVelocity(nonLog)','AvatarVelocity','peakCount'};
            ZcData2 =  horzcat( abs(period_zx2) , abs(peak_zx2) , ...
                user2.zeroCrossData.zeroCrossTime, user2.zeroCrossData.area, ...
                abs(user2.zeroCrossData.nonlogAvtVelocity) , user2.zeroCrossData.avtVelocity , peakCount2(:,1) );
            ZcData2Output = [ ZcData2Title; num2cell(ZcData2)];
            [nrows,ncols]= size(ZcData2Output);
            zc2Filename = obj.saveFilePath(char(strcat('\CycleData2.txt')));
            fid = fopen(zc2Filename, 'w');
            for row=1:nrows
                if row ==1
                    fprintf(fid, '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\r\n', ZcData2Output{row,:});
                else
                    fprintf(fid, '%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%f\t%d\r\n', ZcData2Output{row,:});
                end
            end
            fclose(fid);
            
            

        end

    end
end
