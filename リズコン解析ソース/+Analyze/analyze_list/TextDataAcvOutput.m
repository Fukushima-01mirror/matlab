classdef TextDataAcvOutput < Analyze.Base
    %STANDARDDEVIATION ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q

    properties
    end

    methods
        function obj = TextDataAcvOutput(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)

        end

        function runForPair(obj,user1,user2)
            
            if ~exist( obj.saveFilePath('') ,'dir')
                mkdir(obj.saveFilePath(''));
            end
            if sum(isnan(cell2mat(obj.config.archiveDataFileName) )) == 0
                
	           pulFilename = obj.saveFilePath(char(strcat('\PulseAcvData.txt')));
            PulTitle = {'����','�R���g���[�������(�v���C���[1)','�R���g���[�������(�v���C���[2)'};
            PulData =  horzcat( user1.time.highSampled , user1.operatePulse.highSampled, user2.operatePulse.highSampled );
            PulOutput = [ PulTitle; num2cell(PulData)];
            [nrows,ncols]= size(PulOutput);
            pulFilename = obj.saveFilePath(char(strcat('\PulseData.txt')));
            if sum(isnan(cell2mat(obj.config.archiveDataFileName) )) == 0
	           pulFilename = obj.saveFilePath(char(strcat('\PulseAcvData.txt')));
            end
            fid = fopen(pulFilename, 'w');
            for row=1:nrows
                if row ==1
                    fprintf(fid, '%s\t%s\t%s\t\r\n', PulOutput{row,:});
                else
                    fprintf(fid, '%d\t%d\t%d\t\r\n', PulOutput{row,:});
                end
            end
            fclose(fid);

            AvtTitle = {'����','�A�o�^�ʒu(�v���C���[1)','�A�o�^�ʒu(�v���C���[2)'};
            AvtData =  horzcat( user1.time.lowSampled , user1.avatarPosition.lowSampled , user2.avatarPosition.lowSampled );
            AvtOutput = [ AvtTitle; num2cell(AvtData)];
            [nrows,ncols]= size(AvtOutput);
            avtFilename = obj.saveFilePath(char(strcat('\AvatarData.txt')));
            if sum(isnan(cell2mat(obj.config.archiveDataFileName) )) == 0
	           avtFilename = obj.saveFilePath(char(strcat('\AvatarAcvData.txt')));
            end
            fid = fopen(avtFilename, 'w');
            for row=1:nrows
                if row ==1
                    fprintf(fid, '%s\t%s\t%s\t\r\n', AvtOutput{row,:});
                else
                    fprintf(fid, '%d\t%d\t%d\t\r\n', AvtOutput{row,:});
                end
            end
            fclose(fid);
            
            [period_zx1, peak_zx1] = Rhythm.setZeroCrossPeriodData(user1.zeroCrossData);
            ZcData1Title = {'�[���N���X���ԊԊu','�������','�[���N���X���ԊԊu�̍�',...
                '�s�[�N�l','�U��','�s�[�N�l�̍�',...
                '�[���N���X����','����ʐώZ�l','�ΐ����Z�O�A�o�^���x','�A�o�^���x'};
            ZcData1 =  horzcat( abs(period_zx1) , abs(peak_zx1) , ...
                user1.zeroCrossData.zeroCrossTime, user1.zeroCrossData.area, ...
                abs(user1.zeroCrossData.nonlogAvtVelocity) , user1.zeroCrossData.avtVelocity );
            ZcData1Output = [ ZcData1Title; num2cell(ZcData1)];
            [nrows,ncols]= size(ZcData1Output);
            zc1Filename = obj.saveFilePath(char(strcat('\CycleData1.txt')));
            if sum(isnan(cell2mat(obj.config.archiveDataFileName) )) == 0
	           zc1Filename = obj.saveFilePath(char(strcat('\CycleAcvData1txt')));
            end
            fid = fopen(zc1Filename, 'w');
            for row=1:nrows
                if row ==1
                    fprintf(fid, '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t\r\n', ZcData1Output{row,:});
                else
                    fprintf(fid, '%g\t%g\t%g\t%g\t%g\t%g\t%g\t%g\t%g\t%g\t\r\n', ZcData1Output{row,:});
                end
            end
            fclose(fid);
            
            [period_zx2, peak_zx2] = Rhythm.setZeroCrossPeriodData(user2.zeroCrossData);
            ZcData2Title = {'�[���N���X���ԊԊu','�������','�[���N���X���ԊԊu�̍�',...
                '�s�[�N�l','�U��','�s�[�N�l�̍�',...
                '�[���N���X����','����ʐώZ�l','�ΐ����Z�O�A�o�^���x','�A�o�^���x'};
            ZcData2 =  horzcat( abs(period_zx2) , abs(peak_zx2) , ...
                user2.zeroCrossData.zeroCrossTime, user2.zeroCrossData.area, ...
                abs(user2.zeroCrossData.nonlogAvtVelocity) , user2.zeroCrossData.avtVelocity );
            ZcData2Output = [ ZcData2Title; num2cell(ZcData2)];
            [nrows,ncols]= size(ZcData2Output);
            zc2Filename = obj.saveFilePath(char(strcat('\CycleData2.txt')));
            if sum(isnan(cell2mat(obj.config.archiveDataFileName) )) == 0
	           zc2Filename = obj.saveFilePath(char(strcat('\CycleAcvData2txt')));
            end
            fid = fopen(zc2Filename, 'w');
            for row=1:nrows
                if row ==1
                    fprintf(fid, '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t\r\n', ZcData2Output{row,:});
                else
                    fprintf(fid, '%g\t%g\t%g\t%g\t%g\t%g\t%g\t%g\t%g\t%g\t\r\n', ZcData2Output{row,:});
                end
            end
            fclose(fid);

               
               
               
            end
            

        end

    end
end
