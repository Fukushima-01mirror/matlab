classdef CorrelationSlopeCalc2500_ex < Analyze.Base
    %STANDARDDEVIATION ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q
% �A�o�^���x�Ƃ̉�A����

    properties
    end

    methods
        function obj = CorrelationSlopeCalc2500_ex(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
            bDispR =1;
            titleName = [ char(obj.config.examType) ,'��A�W�� ���n��ω�'];
%%      ���ԃX�P�[���̐ݒ�            
            spotTime = 2500;
            startTime = 5000;
            spotTimeSeries = spotTime+startTime : user.time.highSampled(end);
            spotTimeSeries = spotTimeSeries.';

                
%%      �f�[�^�Ǎ�
            if obj.currentRunType == obj.runTypePlayer1
                loadFileName = ...
                    char( strcat( cd(),'\results\',obj.folderName(),'\',obj.config.filenameForPlayer1(),'.mat' ) );
            elseif obj.currentRunType == obj.runTypePlayer2
                loadFileName = ...
                    char( strcat( cd(),'\results\',obj.folderName(),'\',obj.config.filenameForPlayer2(),'.mat' ) );
            end
            

            if exist( loadFileName, 'file' )
                load( loadFileName );

            else
%%      �X���v�Z

                [period_zx1, peak_zx1] = Rhythm.setZeroCrossPeriodData(user.zeroCrossData);

                startIndex1 = find( user.zeroCrossData.zeroCrossTime >= startTime ,1 ,'first');
                endIndex1 = find( user.zeroCrossData.zeroCrossTime < spotTime+startTime ,1 ,'last');   
                fitLineFunc_peak(1,:) = [0,0];            fitLineFunc_period(1,:) = [0,0];
                fitLineR_peak(1,:) = [0,0];            fitLineR_period(1,:) = [0,0];
                i = 2;

                bNonPlot =1;
                r_fig = 3;  c_fig = 1;

                for spotTimeMax = spotTime+startTime+1 : user.time.highSampled(end)
                    %�@1P�̃[���N���X���Ԃ̃C���f�N�X���i�񂾂�C���֕���
                    if  startIndex1 ~= find( user.zeroCrossData.zeroCrossTime >= ( spotTimeMax - spotTime ) ,1 ,'first') ...
                              || endIndex1 ~= find( user.zeroCrossData.zeroCrossTime < spotTimeMax ,1 ,'last')

                       startIndex1 = find( user.zeroCrossData.zeroCrossTime >= ( spotTimeMax - spotTime ) ,1 ,'first');
                       endIndex1 = find( user.zeroCrossData.zeroCrossTime < spotTimeMax ,1 ,'last');  

                       k=2;
                       zeroCrossTimes1 = zeros(1,2);
                       % �[���N���X�Ԃ̃s�[�N�񐔁@C1:�g�`�̑O�����̃s�[�N�񐔁@C2:�㔼���̃s�[�N��
                       zeroCrossTimes1(1,1) = length( user.zeroCrossData.peak(startIndex1).time );
                       for IndexSeries = startIndex1+1 :endIndex1
                           zeroCrossTimes1(k,1) = length( user.zeroCrossData.peak(IndexSeries).time );
                           zeroCrossTimes1(k,2) = length( user.zeroCrossData.peak(IndexSeries-1).time );
                           k = k+1;
                       end

                       sizeZeroCross1 = find(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2);
                       %�@�s�[�N��2�񖢖��̂Ƃ��̃C���f�b�N�X
                       if length( sizeZeroCross1 ) < 2  %�@�s�[�N��2�񖢖��̃f�[�^����2�����̎������O
                            fitLineFunc_peak(i,:) = [0,0];
                            fitLineFunc_period(i,:) = [0,0];
                            fitLineR_peak(i,:) = [0,0];
                            fitLineR_period(i,:) = [0,0];
                       else

                            Y = abs( user.zeroCrossData.nonlogAvtVelocity( startIndex1:endIndex1 ) );
                            if bNonPlot == 0
                                subplot(r_fig,c_fig,1);
                                X = period_zx1( startIndex1:endIndex1 ,2 );
                                plot( X(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ,Y(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ,'ob');
                                hold on
                                    plot( X(zeroCrossTimes1(:,1)>1|zeroCrossTimes1(:,2)>1) ,Y(zeroCrossTimes1(:,1)>1|zeroCrossTimes1(:,2)>1) ,'sb');
                                hold off
                                xlabel('�[���N���X�_�Ԋu(1����)'); ylabel('�ΐ����Z�O�A�o�^����');
                                xlim([0,800]);         ylim([0 50000]);
                                title( titleName1 );
                            end

                            X = abs( period_zx1( startIndex1:endIndex1 ,3 ) );
                            fitLineFunc_period(i,:) = polyfit(X(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ...
                                                         ,Y(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ,1);
                            [R,P] = corrcoef(X(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2),Y(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2));
                            fitLineR_period(i,:) = [R(1,2), P(1,2)]; 

                            if bNonPlot == 0
                                subplot(r_fig,c_fig,3);
                                fitDataY = polyval( fitLineFunc_period(i,:) , X );
                                plot( X(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ,Y(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ,'ob');
                                hold on
                                    plot( X(zeroCrossTimes1(:,1)>1|zeroCrossTimes1(:,2)>1) ,Y(zeroCrossTimes1(:,1)>1|zeroCrossTimes1(:,2)>1) ,'sb');
                                    plot( X, fitDataY ,'k');
                                hold off
                                xlabel('�[���N���X�_�Ԋu�̍��i�������j'); ylabel('�ΐ����Z�O�A�o�^����');
                                xlim([0,800]);         ylim([0 50000]);            
                            end

                            X = abs(peak_zx1( startIndex1:endIndex1 ,3) );
                            fitLineFunc_peak(i,:) = polyfit(X(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ...
                                                         ,Y(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ,1);
                            [R,P] = corrcoef(X(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2),Y(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2));
                            fitLineR_peak(i,:) = [R(1,2), P(1,2)]; 
                            if bNonPlot == 0
                                subplot(r_fig,c_fig,5);
                                fitDataY = polyval( fitLineFunc_peak(i,:) , X );
                                plot( X(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ,Y(zeroCrossTimes1(:,1)<2&zeroCrossTimes1(:,2)<2) ,'ob');
                                hold on
                                    plot( X(zeroCrossTimes1(:,1)>1|zeroCrossTimes1(:,2)>1) ,Y(zeroCrossTimes1(:,1)>1|zeroCrossTimes1(:,2)>1) ,'sb');
                                    plot( X, fitDataY ,'k');
                                hold off
                                xlabel('�s�[�N�l�̍�'); ylabel('�ΐ����Z�O�A�o�^����');
                                xlim([0,400]);            ylim([0 50000]);
                            end
                       end

                    else
                        fitLineFunc_peak(i,:) = fitLineFunc_peak(i-1,:);
                        fitLineFunc_period(i,:) = fitLineFunc_period(i-1,:);
                        fitLineR_peak(i,:) = fitLineR_peak(i-1,:);
                        fitLineR_period(i,:) = fitLineR_period(i-1,:);
                    end

                    i = i+1;

                    if mod(i, 1000) == 0
                    end
                    if i==50000

                    end

                end
                
    %%         �f�[�^�ۑ�
                name =  obj.saveFilePath('.mat');
                save( name, 'fitLineFunc_peak' ,'fitLineR_peak' ,'fitLineFunc_period','fitLineR_period');


            end

            
%%          �O���t�`��
            MonitorSize = [ 0, 0, 1200, 1000];
            set(gcf, 'Position', MonitorSize);
            
            subplot(2,1,1,'align')
            [haxes,hline1,hlineR1] = ...
                plotyy(spotTimeSeries, fitLineFunc_peak(:,1), spotTimeSeries, fitLineR_peak(:,1));
            set(hline1,'Color','b');            set(hlineR1,'Color','c');
            set(haxes(1),'YColor','k');            set(haxes(2),'YColor','k');
            
            axes(haxes(1))
                 xlabel('����'); ylabel('�s�[�N�l�̍��ƃA�o�^���x�̉�A�����̌X��');
                 ylim([-100 300]);
                 set(haxes(1),'YTick',[-100:100:300]);
            axes(haxes(2))
            if bDispR == 0
                axis off;
                axes(haxes(1))
            else
                 ylabel('���֌W��R');    ylim([-1,1]);
                 set(haxes(2),'YTick',[-1:0.5:1]);
            end
            title(titleName,'Interpreter','none');
                
            subplot(2,1,2,'align')
            [haxes,hline1,hlineR1] = ...
                plotyy(spotTimeSeries, fitLineFunc_period(:,1), spotTimeSeries, fitLineR_period(:,1));
            set(hline1,'Color','b');            set(hlineR1,'Color','c');
            set(haxes(1),'YColor','k');            set(haxes(2),'YColor','k');
            
            axes(haxes(1))
                xlabel('����'); ylabel('��������̍��ƃA�o�^���x�̉�A�����̌X��');
                ylim([-100,300]);
                set(haxes(1),'YTick',[-100:100:300]);
            axes(haxes(2))
            if bDispR == 0
                axis off;
                axes(haxes(1))
            else
                 ylabel('���֌W��R');    ylim([-1,1]);
                 set(haxes(2),'YTick',[-1:0.5:1]);
            end
            title(titleName,'Interpreter','none');

            
            obj.saveGraph();
            
        end
        
        function runForPair(obj,user1,user2)
            bDispR =1;
            
            if obj.config.isExistPlayer1
                titleName1 = [ char(obj.config.examType) ,'��A�W�� ���n��ω�'];
                loadFileName1 = ...
                    char( strcat( cd(),'\results\',obj.folderName(),'\',obj.config.filenameForPlayer1(),'.mat' ) );
            elseif obj.config.filenameForArchive
                titleName1 = [ char(obj.config.examType) ,'(',char(obj.config.archiveDataFileName ),') ��A�W�� ���n��ω�'];
                loatFileData = dir( strcat( cd(),'\results\',obj.folderName(),'\', char(obj.config.archiveDataFileName) , '*(L)*.mat') );
                loadFileName1 = char( strcat( cd(),'\results\',obj.folderName(),'\', loatFileData.name) );
            end

            if obj.config.isExistPlayer2
                titleName2 = [ char(obj.config.examType) ,'��A�W�� ���n��ω�'];
                loadFileName2 = ...
                    char( strcat( cd(),'\results\',obj.folderName(),'\',obj.config.filenameForPlayer2(),'.mat' ) );
            elseif obj.config.filenameForArchive
                titleName2 = [ char(obj.config.examType) ,'(',char(obj.config.archiveDataFileName ),') ��A�W�� ���n��ω�'];
                loatFileData = dir( strcat( cd(),'\results\',obj.folderName(),'\', char(obj.config.archiveDataFileName) , '*(L)*.mat') );
                loadFileName2 = char( strcat( cd(),'\results\',obj.folderName(),'\',loatFileData.name) );
            end

            if obj.config.isExistArchiveData
                titleName = [ char(obj.config.examType) ,'(',char(obj.config.archiveDataFileName ),') ��A�W�� ���n��ω�'];
            else
                titleName = [ char(obj.config.examType) ,'��A�W�� ���n��ω�'];
            end
            
%%      ���ԃX�P�[���̐ݒ�            
            spotTime = 2500;
            startTime = 5000;
            spotTimeSeries = spotTime+startTime : user1.time.highSampled(end);
            spotTimeSeries = spotTimeSeries.';

                
%%      �f�[�^�Ǎ�
%             if exist(loadFileName1, 'file' ) && exist(loadFileName2 'file' )

            data1 = load( loadFileName1 );
            data2 = load( loadFileName2 );

            fitLineFunc_peak1 = data1.fitLineFunc_peak;
            fitLineFunc_period1 = data1.fitLineFunc_period;
            fitLineR_peak1 = data1.fitLineR_peak;
            fitLineR_period1 = data1.fitLineR_period;

            fitLineFunc_peak2 = data2.fitLineFunc_peak;
            fitLineFunc_period2 = data2.fitLineFunc_period;
            fitLineR_peak2 = data2.fitLineR_peak;
            fitLineR_period2 = data2.fitLineR_period;


%%          �O���t�`��
            MonitorSize = [ 0, 0, 1200, 1000];
            set(gcf, 'Position', MonitorSize);
            
            
            subplot(2,1,1,'align')
            [haxes,hline1,hlineR1] = ...
                plotyy(spotTimeSeries, fitLineFunc_peak1(:,1), spotTimeSeries, fitLineR_peak1(:,1));
            set(hline1,'Color','b');            set(hlineR1,'Color','c');
            set(haxes(1),'YColor','k');            set(haxes(2),'YColor','k');
            
            hold( haxes(1),'on') % �X���@�d�ˏ������[�h�I��
                hline2 = plot(  haxes(1), spotTimeSeries, fitLineFunc_peak2(:,1),'Color', [0 0.5 0] );
            hold( haxes(2),'on') % ���֌W���@�d�ˏ������[�h�I��
                hlineR2 = plot(  haxes(2), spotTimeSeries, fitLineR_peak2(:,1),'g' );
            hold off
            
            axes(haxes(1))
                 xlabel('����'); ylabel('�s�[�N�l�̍��ƃA�o�^���x�̉�A�����̌X��');
                 ylim([-100 300]);
                 set(haxes(1),'YTick',[-100:100:300]);
            axes(haxes(2))
            if bDispR == 0
                axis off;
                axes(haxes(1))
            else
                 ylabel('���֌W��R');    ylim([-1,1]);
                 set(haxes(2),'YTick',[-1:0.5:1]);
            end
            
            if obj.config.isExistPlayer1
                legName1 = char(obj.config.player1UserName);
            elseif obj.config.filenameForArchive
                legName1 = '�A�[�J�C�u';
            end
            if obj.config.isExistPlayer2
                legName2 = char(obj.config.player2UserName);
            elseif obj.config.filenameForArchive
                legName2 = '�A�[�J�C�u';
            end
            legend( [hline1,hline2], legName1, legName2 ,'Location','NorthEastOutside');
            title(titleName,'Interpreter','none');
                
            subplot(2,1,2,'align')
            [haxes,hline1,hlineR1] = ...
                plotyy(spotTimeSeries, fitLineFunc_period1(:,1), spotTimeSeries, fitLineR_period1(:,1));
            set(hline1,'Color','b');            set(hlineR1,'Color','c');
            set(haxes(1),'YColor','k');            set(haxes(2),'YColor','k');
            
            hold( haxes(1),'on') % �X���@�d�ˏ������[�h�I��
                hline2 = plot(  haxes(1), spotTimeSeries, fitLineFunc_period2(:,1),'Color',[0 0.5 0] );
            hold( haxes(2),'on') % ���֌W���@�d�ˏ������[�h�I��
                hlineR2 = plot(  haxes(2), spotTimeSeries, fitLineR_period2(:,1),'g' );
            hold off
                
            axes(haxes(1))
                xlabel('����'); ylabel('��������̍��ƃA�o�^���x�̉�A�����̌X��');
                ylim([-100,300]);
                set(haxes(1),'YTick',[-100:100:300]);
            axes(haxes(2))
            if bDispR == 0
                axis off;
                axes(haxes(1))
            else
                 ylabel('���֌W��R');    ylim([-1,1]);
                 set(haxes(2),'YTick',[-1:0.5:1]);
            end
            legend( [hline1,hline2], legName1, legName2 ,'Location','NorthEastOutside');
            title(titleName,'Interpreter','none');
                
            obj.saveGraph();


%%      �G�N�Z���f�[�^�o��
            outputTitle = {'�s�[�N�l�̍��Ƃ̉�A�W�����ϒl(1P)','�W���΍�(1P)',...
                            '�s�[�N�l�̍��Ƃ̉�A�W�����ϒl(2P)','�W���΍�(2P)', ...
                            '�s�[�N�l�̍��Ƃ̉�A�W�� �ގ�����(�덷10%)','�ގ�����(�덷20%)','�ގ�����(�덷30%)',...
                            '��������̍��Ƃ̉�A�W�����ϒl(1P)','�W���΍�(1P)',...
                            '��������̍��Ƃ̉�A�W�����ϒl(2P)','�W���΍�(2P)', ...
                            '��������̍��Ƃ̉�A�W�� �ގ�����(�덷10%)','�ގ�����(�덷20%)','�ގ�����(�덷30%)'...
                            };
            slopePeakOutput = { mean( fitLineFunc_peak1(:,1) ), std( fitLineFunc_peak1(:,1) ) , ...
                                mean( fitLineFunc_peak2(:,1) ), std( fitLineFunc_peak2(:,1) ) };
            peakSlopeMean = ( mean( fitLineFunc_peak1(:,1) ) + mean( fitLineFunc_peak2(:,1) ))/2;
            distSlopePeak = abs( fitLineFunc_peak1(:,1) - fitLineFunc_peak2(:,1));
            sameSlopePeakOutput = { length( find( distSlopePeak < peakSlopeMean*0.1 ) )/60000 , ...
                                    length( find( distSlopePeak < peakSlopeMean*0.2 ) )/60000 , ...
                                    length( find( distSlopePeak < peakSlopeMean*0.3 ) )/60000 , ...
                                    };
            
            slopePeriodOutput = { mean( fitLineFunc_period1(:,1) ), std( fitLineFunc_period1(:,1) ) , ...
                                mean( fitLineFunc_period2(:,1) ), std( fitLineFunc_period2(:,1) ) };
            periodSlopeMean = ( mean( fitLineFunc_period1(:,1) ) + mean( fitLineFunc_period2(:,1) ))/2;
            distSlopePeriod = abs( fitLineFunc_period1(:,1) - fitLineFunc_period2(:,1));
            sameSlopePeriodOutput = { length( find( distSlopePeriod < periodSlopeMean*0.1 ) )/60000 ...
                                      length( find( distSlopePeriod < periodSlopeMean*0.2 ) )/60000 ...          
                                      length( find( distSlopePeriod < periodSlopeMean*0.3 ) )/60000 ...          
                                      };
            
            output = horzcat( slopePeakOutput , sameSlopePeakOutput , slopePeriodOutput , sameSlopePeriodOutput );
            obj.outputAllToXls(output , outputTitle);

        end

    end
end
