classdef NonZeroCrossSituation < Analyze.Base
    %STANDARDDEVIATION ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q
    %   �[���N���X���Ȃ����̑O��2.5�b���O���t�`��@
    %       �A�o�^�ʒu�C�A�o�^���x�C�R���g���[������C�U���C�����C�i���ւ̌X���j

    properties
    end

    methods
        function obj = NonZeroCrossSituation(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
           %�@�[���N���X���Ȃ����̃f�[�^������O��̎��� 
           period_bf = 2500;
           %�@�[���N���X�Ԃł̃s�[�N�񐔎擾
           [zeroCrossTimes] = Rhythm.setZeroCrossCount(user.zeroCrossData);

           %�@�[���N���X���Ă��鎞�̃C���f�b�N�X
           IndexZeroCross = find(zeroCrossTimes(:,2)<2);
           %�@�[���N���X���Ȃ����̃C���f�b�N�X()
           IndexNonZeroCross = find( zeroCrossTimes(:,2)>1 );
           %�@�����E�U���f�[�^
           [period_zx, peak_zx] = Rhythm.setZeroCrossPeriodData(user.zeroCrossData);

           MonitorSize = [ 0, 0, 1200, 1000];
            set(gcf, 'Position', MonitorSize);
           r_fig =5;
           
           i_over = find(user.zeroCrossData.zeroCrossTime> period_bf  , 1, 'first');
           i_st = find(IndexNonZeroCross > i_over, 1,'first');
           
           for i = i_st: length(IndexNonZeroCross)
               t_zx = user.zeroCrossData.zeroCrossTime(IndexNonZeroCross(i));
               t_series = t_zx- period_bf : t_zx+ period_bf ;
               
%%           �A�o�^�ʒu�`��
               subplot(r_fig, 1, 1)     
               plot(   user.time.lowSampled,  user.avatarPosition.lowSampled);         
                % �����A�o�^�̈ʒu�`��
                if strcmp( obj.config.examType, '�ǂ����܂����')...
                        || strcmp( obj.config.examType, '�ǂ����ގ���')
                    hold on
                        plot(   obj.data.com.time,  obj.data.com.avatarPosition , 'k:');               
                    hold off
                end
                hold on %�@�[���N���X���Ȃ��^�C�~���O��`��
                    for j= 1: length(IndexNonZeroCross)
                        zeroCrossTime = user.zeroCrossData.zeroCrossTime(IndexNonZeroCross(j) );
                        plot([zeroCrossTime zeroCrossTime],[0 1000],...
                            'Color' , [.7 .7 .7] , 'LineStyle', ':');
                    end
                    plot([t_zx t_zx],[0 1000],'Color' , 'm');
                hold off
                xlabel('����t ms'); ylabel('�A�o�^�ʒu');
                xlim([t_zx- period_bf  t_zx+ period_bf ]);    ylim([0 1000]);

%%            �R���g���[������`��    
                subplot(r_fig,1,2)
                plot(   user.time.highSampled,  user.operatePulse.highSampled );               
                hold on %�@�[���N���X���Ȃ��^�C�~���O��`��
                    for j= 1: length(IndexNonZeroCross)
                        zeroCrossTime = user.zeroCrossData.zeroCrossTime(IndexNonZeroCross(j) );
                        plot([zeroCrossTime zeroCrossTime],[-400 400],...
                            'Color' , [.7 .7 .7] , 'LineStyle', ':');
                    end
                    plot([t_zx t_zx],[-400 400],'Color' , 'm');
                    plot([0 60000], [0 0] ,'k')
                hold off
                xlabel('����t ms'); ylabel('�R���g���[������');
                xlim([t_zx- period_bf  t_zx+ period_bf]);    ylim([-400 400]);
%                 grid on;
                set(gca,'YTick',[-400:100:400]);

%%            �A�o�^���x     
                subplot(r_fig,1,3)
                plot(   user.time.highSampled,  user.avatarVelocity.highSampled );               
                hold on %�@�[���N���X���Ȃ��^�C�~���O��`��
                    for j= 1: length(IndexNonZeroCross)
                        zeroCrossTime = user.zeroCrossData.zeroCrossTime(IndexNonZeroCross(j) );
                        plot([zeroCrossTime zeroCrossTime],[-0.5 0.5],...
                            'Color' , [.7 .7 .7] , 'LineStyle', ':');
                    end
                    plot([t_zx t_zx],[-0.5 0.5],'Color' , 'm');
                    plot([0 60000], [0 0] ,'k')
                hold off
                xlabel('����t ms'); ylabel('�A�o�^���x');
                xlim([t_zx- period_bf  t_zx+ period_bf ]);    ylim([-0.5 0.5]);
%                 grid on;
                set(gca,'YTick',[-0.5:0.1:0.5]);

%%            �[���N���X�����̍�,�[���N���X�U���̍�
                subplot(r_fig,1,4)
                [AX,H1,H2] = plotyy(   user.zeroCrossData.zeroCrossTime, abs(period_zx(:,3)),...
                                        user.zeroCrossData.zeroCrossTime, abs(peak_zx(:,3)));
                set(AX(1), 'YColor', 'k',...
                    'XLim', [t_zx- period_bf  t_zx+ period_bf ], 'YLim', [0 600]);
                set(AX(2), 'YColor', 'k',...
                    'XLim', [t_zx- period_bf  t_zx+ period_bf ], 'YLim', [0 600]);

                set(H1, 'Color', 'b');  set(H2, 'Color', 'c');
                hold( AX(1) ,'on') %�@�[���N���X���Ȃ��^�C�~���O��`��
                    for j= 1: length(IndexNonZeroCross)
                        zeroCrossTime = user.zeroCrossData.zeroCrossTime(IndexNonZeroCross(j) );
                        plot([zeroCrossTime zeroCrossTime],[0 600], 'Color' , [.7 .7 .7] , 'LineStyle', ':');
                    end
                    plot([t_zx t_zx],[0 600],'Color' , 'm');
                hold off
                legend( [H1, H2], '�����̍�', '�U���̍�' );                
                xlabel('����');
                ylabel(AX(1) , '��������̍�');     ylabel(AX(2) , '����U���̍�');

%%          �@�[���N���X�����E�U��
                subplot(r_fig,1,5)
                [AX,H1,H2] = plotyy(   user.zeroCrossData.zeroCrossTime, period_zx(:,2),...
                                        user.zeroCrossData.zeroCrossTime, peak_zx(:,2));
                set(AX(1), 'YColor', 'k',...
                    'XLim', [t_zx- period_bf  t_zx+ period_bf ], 'YLim', [0 600]);
                set(AX(2), 'YColor', 'k',...
                    'XLim', [t_zx- period_bf  t_zx+ period_bf ], 'YLim', [0 600]);

                set(H1, 'Color', 'b');  set(H2, 'Color', 'c');
                hold( AX(1) ,'on') %�@�[���N���X���Ȃ��^�C�~���O��`��
                    for j= 1: length(IndexNonZeroCross)
                        zeroCrossTime = user.zeroCrossData.zeroCrossTime(IndexNonZeroCross(j) );
                        plot([zeroCrossTime zeroCrossTime],[0 600], 'Color' , [.7 .7 .7] , 'LineStyle', ':');
                    end
                    plot([t_zx t_zx],[0 600],'Color' , 'm');
                hold off
                legend( [H1, H2], '����', '�U��' );                
                xlabel('����');
                ylabel(AX(1) , '�������');     ylabel(AX(2) , '����U��');
               
                obj.saveGraphWithName(num2str(i));
                
           end
            
           

        end
        
        function runForPair(obj,user1,user2)
           period_bf = 2500;

           %�@�[���N���X�Ԃł̃s�[�N�񐔎擾
           [zeroCrossTimes1] = Rhythm.setZeroCrossCount(user1.zeroCrossData);
           [zeroCrossTimes2] = Rhythm.setZeroCrossCount(user2.zeroCrossData);

           %�@�[���N���X���Ă��鎞�̃C���f�b�N�X
           IndexZeroCross1 = find(zeroCrossTimes1(:,2)<2);
           IndexZeroCross2 = find(zeroCrossTimes2(:,2)<2);
           %�@�[���N���X���Ȃ����̃C���f�b�N�X()
           IndexNonZeroCross1 = find( zeroCrossTimes1(:,2)>1 );
           IndexNonZeroCross2 = find( zeroCrossTimes2(:,2)>1 );

           [period_zx1, peak_zx1] = Rhythm.setZeroCrossPeriodData(user1.zeroCrossData);
            [period_zx2, peak_zx2] = Rhythm.setZeroCrossPeriodData(user2.zeroCrossData);
            filterdPul1 = Rhythm.BPfilter( user1.operatePulse.lowSampled);
            filterdPul2 = Rhythm.BPfilter( user2.operatePulse.lowSampled);
            [timeCorr, AB_Series0, AB_Series_Max] = Rhythm.AllCorr__func(filterdPul1, filterdPul2, user2.time.lowSampled, 100);

            MonitorSize = [ 0, 0, 1400, 1000];
            set(gcf, 'Position', MonitorSize);


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
            
            
            r_fig = 5;
            
%%          1P�[���N���X���Ȃ���       
           i_over1 = find(user1.zeroCrossData.zeroCrossTime> period_bf  , 1, 'first');
           i_st = find(IndexNonZeroCross1 > i_over1, 1,'first');
           for i = i_st: length(IndexNonZeroCross1)
                t_zx1 = user1.zeroCrossData.zeroCrossTime(IndexNonZeroCross1(i) );

%%              �A�o�^�ʒu                
                subplot(r_fig,1,1);
                plot(   user1.time.lowSampled,  user1.avatarPosition.lowSampled,'b');               
                hold on
                    plot(   user2.time.lowSampled,  user2.avatarPosition.lowSampled,...
                                    'Color', [0 .498 0] , 'LineStyle', ':');               
                %�@1P�̃[���N���X���Ȃ��^�C�~���O��`��
                    for j= 1: length(IndexNonZeroCross1)
                        zeroCrossTime1 = user1.zeroCrossData.zeroCrossTime(IndexNonZeroCross1(j) );
                        plot([zeroCrossTime1 zeroCrossTime1],[0 1000],...
                            'Color' , [.7 .7 .7] , 'LineStyle', '-');
                    end
                    plot([t_zx1 t_zx1],[0 1000],'Color' , 'm');
                 %�@2P�̃[���N���X���Ȃ��^�C�~���O��`��(�_��)
                   for j= 1: length(IndexNonZeroCross2)
                        zeroCrossTime2 = user2.zeroCrossData.zeroCrossTime(IndexNonZeroCross2(j) );
                        plot([zeroCrossTime2 zeroCrossTime2],[0 1000],...
                            'Color' , [.7 .7 .7] , 'LineStyle', ':');
                    end
                hold off
                legend(legName1, legName2 ,'Location','NorthEastOutside');
                xlabel('����t ms'); ylabel('�A�o�^�ʒu');
                xlim([t_zx1- period_bf  t_zx1+ period_bf ]);    ylim([0 1000]);
                
%%              �R���g���[������
                subplot(r_fig,1,2)
                [haxes,hline1,hlineC] = plotyy( user1.time.highSampled , user1.operatePulse.highSampled ,  timeCorr, AB_Series_Max(:,2));
 
                set(haxes(1), 'YColor', 'k',...
                    'XLim', [t_zx1- period_bf  t_zx1+ period_bf ], 'YLim', [-400 400] , ...
                    'YTick',[-400:200:400]);
                set(haxes(2), 'YColor', 'r',...
                    'XLim', [t_zx1- period_bf  t_zx1+ period_bf ], 'YLim', [0 1] ,...
                    'YTick',[0:0.2:1] );

                set(hline1,'Color','b');            set(hlineC,'Color','r');
                
                hold( haxes(1),'on') % �d�ˏ������[�h�I��
                hline2 = plot(   haxes(1), user2.time.highSampled ,  user2.operatePulse.highSampled  ,...
                                'Color', [0 .498 0] ,'LineStyle' , ':' );   
                plot( haxes(1),[0 60000], [0 0],'k');

                hold( haxes(2),'on') % �d�ˏ������[�h�I��
                    plot( haxes(2),[0 60000], [0.8 0.8],'k:');
                %�@1P�̃[���N���X���Ȃ��^�C�~���O��`��
                    for j= 1: length(IndexNonZeroCross1)
                        zeroCrossTime1 = user1.zeroCrossData.zeroCrossTime(IndexNonZeroCross1(j) );
                        plot([zeroCrossTime1 zeroCrossTime1],[-400 400],...
                            'Color' , [.7 .7 .7] , 'LineStyle', '-');
                    end
                    plot([t_zx1 t_zx1],[-400 400],'Color' , 'm');
                 %�@2P�̃[���N���X���Ȃ��^�C�~���O��`��(�_��)
                   for j= 1: length(IndexNonZeroCross2)
                        zeroCrossTime2 = user2.zeroCrossData.zeroCrossTime(IndexNonZeroCross2(j) );
                        plot([zeroCrossTime2 zeroCrossTime2],[-400 400],...
                            'Color' , [.7 .7 .7] , 'LineStyle', ':');
                    end
                 hold off

                legend( [hline1,hline2], legName1, legName2 ,'Location','NorthEastOutside');
                
                xlabel('����t ms');
                ylabel(haxes(1) , '�R���g���[������');     ylabel(haxes(2) , '�ő告�ݑ���');
                
                
%%              �A�o�^���x
                subplot(r_fig,1,3)
                plot(   user1.time.highSampled,  user1.avatarVelocity.highSampled ,'b' );               
                hold on
                    plot(   user2.time.highSampled,  user2.avatarVelocity.highSampled, ...
                    'Color', [0 .498 0] , 'LineStyle' , ':');               
                    for j= 1: length(IndexNonZeroCross1)
                        zeroCrossTime1 = user1.zeroCrossData.zeroCrossTime(IndexNonZeroCross1(j) );
                        plot([zeroCrossTime1 zeroCrossTime1],[-400 400],...
                            'Color' , [.7 .7 .7] , 'LineStyle', '-');
                    end
                    plot([t_zx1 t_zx1],[-400 400],'Color' , 'm');
                    for j= 1: length(IndexNonZeroCross2)
                        zeroCrossTime2 = user2.zeroCrossData.zeroCrossTime(IndexNonZeroCross2(j) );
                        plot([zeroCrossTime2 zeroCrossTime2],[-400 400],...
                            'Color' , [.7 .7 .7] , 'LineStyle', ':');
                    end
                     plot( [0 60000], [0 0],'k');
                hold off
                legend(legName1, legName2 ,'Location','NorthEastOutside');
                xlabel('����t ms'); ylabel('�A�o�^���x');
                xlim([t_zx1- period_bf  t_zx1+ period_bf ]);    ylim([-0.5 0.5]);
%                 grid on;
                set(gca,'YTick',[-0.5:0.1:0.5]);

%%              �[���N���X�����̍�,�[���N���X�U���̍�
                subplot(r_fig,1,4)
                [AX, Hpd1, Hpk1] = plotyy( user1.zeroCrossData.zeroCrossTime, abs(period_zx1(:,3)), ...
                                user1.zeroCrossData.zeroCrossTime, abs(peak_zx1(:,3)));
                set(AX(1), 'YColor', 'k',...
                    'XLim', [t_zx1- period_bf  t_zx1+ period_bf ], 'YLim', [0 600]);
                set(AX(2), 'YColor', 'k',...
                    'XLim', [t_zx1- period_bf  t_zx1+ period_bf ], 'YLim', [0 600]);

                set(Hpd1,'Color','b');          set(Hpk1,'Color','c');
                hold( AX(1),'on')
                    Hpd2 = plot(   user2.zeroCrossData.zeroCrossTime, abs(period_zx2(:,3)), 'Color', [0 .5 0], 'LineStyle' , ':');          
                hold( AX(2),'on')
                    Hpk2 = plot(   user2.zeroCrossData.zeroCrossTime, abs(peak_zx2(:,3)), 'Color', 'g', 'LineStyle' , ':');          
                %�@1P�̃[���N���X���Ȃ��^�C�~���O��`��
                    for j= 1: length(IndexNonZeroCross1)
                        zeroCrossTime1 = user1.zeroCrossData.zeroCrossTime(IndexNonZeroCross1(j) );
                        plot([zeroCrossTime1 zeroCrossTime1],[0 1000],...
                            'Color' , [.7 .7 .7] , 'LineStyle', '-');
                    end
                    plot([t_zx1 t_zx1],[0 1000],'Color' , 'm');
                 %�@2P�̃[���N���X���Ȃ��^�C�~���O��`��(�_��)
                   for j= 1: length(IndexNonZeroCross2)
                        zeroCrossTime2 = user2.zeroCrossData.zeroCrossTime(IndexNonZeroCross2(j) );
                        plot([zeroCrossTime2 zeroCrossTime2],[0 1000],...
                            'Color' , [.7 .7 .7] , 'LineStyle', ':');
                    end
                hold off
                
                legend([Hpd1,Hpk1,Hpd2,Hpk2], ...
                    '������','�U����','������','�U����','Location','NorthEastOutside');
%                     strcat(legName1,' �����̍�'), strcat(legName1,' �U���̍�'), ...
%                     strcat(legName2,' �����̍�'), strcat(legName2,' �U���̍�'),'Location','NorthEastOutside');
                xlabel('����');
                ylabel(AX(1) , '��������̍�');     ylabel(AX(2) , '����U���̍�');
                
%%              �[���N���X�U��,�����@�i1�����j
                subplot(r_fig,1,5)
                [AX, Hpd1, Hpk1] = plotyy( user1.zeroCrossData.zeroCrossTime, period_zx1(:,2), ...
                                user1.zeroCrossData.zeroCrossTime, peak_zx1(:,2));
                set(AX(1), 'YColor', 'k',...
                    'XLim', [t_zx1- period_bf  t_zx1+ period_bf ], 'YLim', [0 600]);
                set(AX(2), 'YColor', 'k',...
                    'XLim', [t_zx1- period_bf  t_zx1+ period_bf ], 'YLim', [0 600]);

                set(Hpd1,'Color','b');          set(Hpk1,'Color','c');
                hold( AX(1),'on')
                    Hpd2 = plot(   user2.zeroCrossData.zeroCrossTime, period_zx2(:,2),'Color', [0 .5 0], 'LineStyle' , ':');          
                hold( AX(2),'on')
                    Hpk2 = plot(   user2.zeroCrossData.zeroCrossTime, peak_zx2(:,2),'Color', 'g', 'LineStyle' , ':');          
                %�@1P�̃[���N���X���Ȃ��^�C�~���O��`��
                    for j= 1: length(IndexNonZeroCross1)
                        zeroCrossTime1 = user1.zeroCrossData.zeroCrossTime(IndexNonZeroCross1(j) );
                        plot([zeroCrossTime1 zeroCrossTime1],[0 1000],...
                            'Color' , [.7 .7 .7] , 'LineStyle', '-');
                    end
                    plot([t_zx1 t_zx1],[0 1000],'Color' , 'm');
                 %�@2P�̃[���N���X���Ȃ��^�C�~���O��`��(�_��)
                   for j= 1: length(IndexNonZeroCross2)
                        zeroCrossTime2 = user2.zeroCrossData.zeroCrossTime(IndexNonZeroCross2(j) );
                        plot([zeroCrossTime2 zeroCrossTime2],[0 1000],...
                            'Color' , [.7 .7 .7] , 'LineStyle', ':');
                    end
                hold off
                legend([Hpd1,Hpk1,Hpd2,Hpk2], ...
                    '�����Q','�U���Q','�����Q','�U���Q','Location','NorthEastOutside');
%                     strcat(legName1,' �����̍�'), strcat(legName1,' �U���̍�'), ...
%                     strcat(legName2,' �����̍�'), strcat(legName2,' �U���̍�'),'Location','NorthEastOutside');
                xlabel('����');
                ylabel(AX(1) , '�������');     ylabel(AX(2) , '����U��');
                
                obj.saveGraphWithName(num2str(i));
           end
           
%%          2P�[���N���X���Ȃ���       
           i_over2 = find(user2.zeroCrossData.zeroCrossTime> period_bf  , 1, 'first');
           i_st = find(IndexNonZeroCross2 > i_over2, 1,'first');
           for i = i_st: length(IndexNonZeroCross2)
                t_zx2 = user2.zeroCrossData.zeroCrossTime(IndexNonZeroCross2(i) );

%%              �A�o�^�ʒu                
                subplot(r_fig,1,1);
                plot(   user1.time.lowSampled,  user1.avatarPosition.lowSampled,'b:');
                hold on
                    plot(   user2.time.lowSampled,  user2.avatarPosition.lowSampled, 'Color', [0 .498 0] );               
                %�@1P�̃[���N���X���Ȃ��^�C�~���O��`��i�_���j
                    for j= 1: length(IndexNonZeroCross1)
                        zeroCrossTime1 = user1.zeroCrossData.zeroCrossTime(IndexNonZeroCross1(j) );
                        plot([zeroCrossTime1 zeroCrossTime1],[0 1000],...
                            'Color' , [.7 .7 .7]  , 'LineStyle', ':');
                    end
                 %�@2P�̃[���N���X���Ȃ��^�C�~���O��`��
                   for j= 1: length(IndexNonZeroCross2)
                        zeroCrossTime2 = user2.zeroCrossData.zeroCrossTime(IndexNonZeroCross2(j) );
                        plot([zeroCrossTime2 zeroCrossTime2],[0 1000],...
                            'Color' , [.7 .7 .7]  , 'LineStyle', '-');
                    end
                    plot([t_zx2 t_zx2],[0 1000],'Color' , 'm');
                hold off
                legend(legName1, legName2 ,'Location','NorthEastOutside');
                xlabel('����t ms'); ylabel('�A�o�^�ʒu');
                xlim([t_zx2- period_bf  t_zx2+ period_bf ]);    ylim([0 1000]);
                
%%              �R���g���[������
                subplot(r_fig,1,2)
                [haxes,hline1,hlineC] = plotyy( user1.time.highSampled, user1.operatePulse.highSampled , ...
                                                    timeCorr, AB_Series_Max(:,2));
                set(haxes(1), 'YColor', 'k',...
                    'XLim', [t_zx2- period_bf  t_zx2+ period_bf ], 'YLim', [-400 400] , ...
                    'YTick',[-400:200:400]);
                set(haxes(2), 'YColor', 'r',...
                    'XLim', [t_zx2- period_bf  t_zx2+ period_bf ], 'YLim', [0 1] ,...
                    'YTick',[0:0.2:1] );

                set(hline1,'Color','b');            set(hlineC,'Color','r');
                
                hold( haxes(1),'on') % �d�ˏ������[�h�I��
                hline2 = plot(   haxes(1), user2.time.highSampled, user2.operatePulse.highSampled ,'Color', [0 .498 0] );   

                hold( haxes(2),'on') % �d�ˏ������[�h�I��
                    plot( haxes(2),[0 60000], [0.8 0.8],'k:');
                %�@1P�̃[���N���X���Ȃ��^�C�~���O��`��i�_���j
                    for j= 1: length(IndexNonZeroCross1)
                        zeroCrossTime1 = user1.zeroCrossData.zeroCrossTime(IndexNonZeroCross1(j) );
                        plot([zeroCrossTime1 zeroCrossTime1],[-400 400],...
                            'Color' , [.7 .7 .7]  , 'LineStyle', ':');
                    end
                 %�@2P�̃[���N���X���Ȃ��^�C�~���O��`��
                   for j= 1: length(IndexNonZeroCross2)
                        zeroCrossTime2 = user2.zeroCrossData.zeroCrossTime(IndexNonZeroCross2(j) );
                        plot([zeroCrossTime2 zeroCrossTime2],[-400 400],...
                            'Color' , [.7 .7 .7]  , 'LineStyle', '-');
                    end
                    plot([t_zx2 t_zx2],[-400 400],'Color' , 'm');
                  hold off

                legend( [hline1,hline2], legName1, legName2 ,'Location','NorthEastOutside');
                
                xlabel('����t ms');
                ylabel(haxes(1) , '�R���g���[������');     ylabel(haxes(2) , '�ő告�ݑ���');
                
%%              �A�o�^���x
                subplot(r_fig,1,3)
                plot(   user1.time.highSampled,  user1.avatarVelocity.highSampled ,'b' );               
                hold on
                    plot(   user2.time.highSampled,  user2.avatarVelocity.highSampled,'Color', [0 .498 0] );               
                %�@1P�̃[���N���X���Ȃ��^�C�~���O��`��i�_���j
                    for j= 1: length(IndexNonZeroCross1)
                        zeroCrossTime1 = user1.zeroCrossData.zeroCrossTime(IndexNonZeroCross1(j) );
                        plot([zeroCrossTime1 zeroCrossTime1],[-400 400],...
                            'Color' , [.7 .7 .7]  , 'LineStyle', ':');
                    end
                 %�@2P�̃[���N���X���Ȃ��^�C�~���O��`��
                   for j= 1: length(IndexNonZeroCross2)
                        zeroCrossTime2 = user2.zeroCrossData.zeroCrossTime(IndexNonZeroCross2(j) );
                        plot([zeroCrossTime2 zeroCrossTime2],[-400 400],...
                            'Color' , [.7 .7 .7]  , 'LineStyle', '-');
                    end
                    plot([t_zx2 t_zx2],[-400 400],'Color' , 'm');
                hold off
                legend(legName1, legName2 ,'Location','NorthEastOutside');
                xlabel('����t ms'); ylabel('�A�o�^���x');
                xlim([t_zx2- period_bf  t_zx2+ period_bf ]);    ylim([-0.5 0.5]);
%                 grid on;
                set(gca,'YTick',[-0.5:0.1:0.5]);

%%              �[���N���X�����̍�,�[���N���X�U���̍�
                subplot(r_fig,1,4)
                [AX, Hpd1, Hpk1] = plotyy( user1.zeroCrossData.zeroCrossTime, period_zx1(:,3), ...
                                user1.zeroCrossData.zeroCrossTime, peak_zx1(:,3));
                set(AX(1), 'YColor', 'k',...
                    'XLim', [t_zx2- period_bf  t_zx2+ period_bf ], 'YLim', [0 600]);
                set(AX(2), 'YColor', 'k',...
                    'XLim', [t_zx2- period_bf  t_zx2+ period_bf ], 'YLim', [0 600]);

                set(Hpd1,'Color','g', 'LineStyle' , ':');          
                set(Hpk1,'Color',[0 .5 0], 'LineStyle' , ':');
                hold( AX(1),'on')
                    Hpd2 = plot(   user2.zeroCrossData.zeroCrossTime, period_zx2(:,3),'Color', 'c');          
                hold( AX(2),'on')
                    Hpk2 = plot(   user2.zeroCrossData.zeroCrossTime, peak_zx2(:,3),'Color', 'b');          
                %�@1P�̃[���N���X���Ȃ��^�C�~���O��`��i�_���j
                    for j= 1: length(IndexNonZeroCross1)
                        zeroCrossTime1 = user1.zeroCrossData.zeroCrossTime(IndexNonZeroCross1(j) );
                        plot([zeroCrossTime1 zeroCrossTime1],[0 1000],...
                            'Color' , [.7 .7 .7]  , 'LineStyle', ':');
                    end
                 %�@2P�̃[���N���X���Ȃ��^�C�~���O��`��
                   for j= 1: length(IndexNonZeroCross2)
                        zeroCrossTime2 = user2.zeroCrossData.zeroCrossTime(IndexNonZeroCross2(j) );
                        plot([zeroCrossTime2 zeroCrossTime2],[0 1000],...
                            'Color' , [.7 .7 .7]  , 'LineStyle', '-');
                    end
                    plot([t_zx2 t_zx2],[0 1000],'Color' , 'm');
                hold off
                legend([Hpd1,Hpk1,Hpd2,Hpk2], ...
                    '������','�U����','������','�U����','Location','NorthEastOutside');
                xlabel('����');
                ylabel(AX(1) , '��������̍�');     ylabel(AX(2) , '����U���̍�');
                
%%              �[���N���X�����E�U���i1�����j
                subplot(r_fig,1,5)
                [AX, Hpd1, Hpk1] = plotyy( user1.zeroCrossData.zeroCrossTime, period_zx1(:,2), ...
                                user1.zeroCrossData.zeroCrossTime, peak_zx1(:,2));
                set(AX(1), 'YColor', 'k',...
                    'XLim', [t_zx2- period_bf  t_zx2+ period_bf ], 'YLim', [0 600]);
                set(AX(2), 'YColor', 'k',...
                    'XLim', [t_zx2- period_bf  t_zx2+ period_bf ], 'YLim', [0 600]);

                set(Hpd1,'Color','g', 'LineStyle' , ':');          
                set(Hpk1,'Color',[0 .5 0], 'LineStyle' , ':');
                hold( AX(1),'on')
                    Hpd2  = plot(   user2.zeroCrossData.zeroCrossTime, period_zx2(:,2),'Color', 'c');          
                hold( AX(2),'on')
                    Hpk2 = plot(   user2.zeroCrossData.zeroCrossTime, peak_zx2(:,2),'Color', 'b');          
                %�@1P�̃[���N���X���Ȃ��^�C�~���O��`��i�_���j
                    for j= 1: length(IndexNonZeroCross1)
                        zeroCrossTime1 = user1.zeroCrossData.zeroCrossTime(IndexNonZeroCross1(j) );
                        plot([zeroCrossTime1 zeroCrossTime1],[0 1000],...
                            'Color' , [.7 .7 .7]  , 'LineStyle', ':');
                    end
                 %�@2P�̃[���N���X���Ȃ��^�C�~���O��`��
                   for j= 1: length(IndexNonZeroCross2)
                        zeroCrossTime2 = user2.zeroCrossData.zeroCrossTime(IndexNonZeroCross2(j) );
                        plot([zeroCrossTime2 zeroCrossTime2],[0 1000],...
                            'Color' , [.7 .7 .7]  , 'LineStyle', '-');
                    end
                    plot([t_zx2 t_zx2],[0 1000],'Color' , 'm');
                hold off
                legend([Hpd1,Hpk1,Hpd2,Hpk2], ...
                    '�����Q','�U���Q','�����Q','�U���Q','Location','NorthEastOutside');
                xlabel('����');
                ylabel(AX(1) , '�������');     ylabel(AX(2) , '����U��');
                
                obj.saveGraphWithName(num2str(i));
           end
           
            end

    end
end
