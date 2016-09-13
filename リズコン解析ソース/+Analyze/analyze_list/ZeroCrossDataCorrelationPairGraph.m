classdef ZeroCrossDataCorrelationPairGraph < Analyze.Base
    %STANDARDDEVIATION ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q

    properties
    end

    methods
        function obj = ZeroCrossDataCorrelationPairGraph(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        
        function runForPair(obj,user1,user2)
            [period_zx1, peak_zx1] = Rhythm.setZeroCrossPeriodData(user1.zeroCrossData);
            
            if obj.config.isExistPlayer1
                titleName1 = strcat(obj.config.player1UserName, ' �A�o�^���x�]����@���֐}');
            elseif obj.config.filenameForArchive
                titleName1 = [ '�A�[�J�C�u�f�[�^�@�A�o�^���x�]����@���֐}'];
            end
            
            if obj.config.isExistPlayer2
                titleName2 = strcat(obj.config.player2UserName, ' �A�o�^���x�]����@���֐}');
            elseif obj.config.filenameForArchive
                titleName2 = [ '�A�[�J�C�u�f�[�^�@�A�o�^���x�]����@���֐}'];
            end
            
            [period_zx2, peak_zx2] = Rhythm.setZeroCrossPeriodData(user2.zeroCrossData);
            r_fig = 3;  c_fig = 2;

            subplot(r_fig,c_fig,1);
            plot(  period_zx1(10:end,2)  ,abs( user1.zeroCrossData.nonlogAvtVelocity(10:end) ),'*');
            xlabel('�[���N���X�_�Ԋu(1����)'); ylabel('�ΐ����Z�O�A�o�^����');
            xlim([0,800]);         ylim([0 50000]);
            title( titleName1 );

            subplot(r_fig,c_fig,3);
            plot(  abs( period_zx1(10:end,3) ) ,abs( user1.zeroCrossData.nonlogAvtVelocity(10:end) ),'*');
            xlabel('�[���N���X�_�Ԋu�̍��i�������j'); ylabel('�ΐ����Z�O�A�o�^����');
            xlim([0,800]);         ylim([0 50000]);            
            
            subplot(r_fig,c_fig,5);
            plot(  abs(peak_zx1(10:end,3) )  ,abs( user1.zeroCrossData.nonlogAvtVelocity(10:end) ),'*');
            xlabel('�s�[�N�l�̍�'); ylabel('�ΐ����Z�O�A�o�^����');
            xlim([0,400]);            ylim([0 50000]);
 
            
            subplot(r_fig,c_fig,2);
            plot( abs( period_zx2(10:end,2) )  ,abs( user2.zeroCrossData.nonlogAvtVelocity(10:end) ),'*');
            xlabel('�[���N���X�_�Ԋu(1����)'); ylabel('�ΐ����Z�O�A�o�^����');
            xlim([0,800]);         ylim([0 50000]);
            title( titleName2 );
 
            subplot(r_fig,c_fig,4);
            plot(  abs( period_zx2(10:end,3) )  ,abs( user2.zeroCrossData.nonlogAvtVelocity(10:end) ),'*');
            xlabel('�[���N���X�_�Ԋu�̍��i�������j'); ylabel('�ΐ����Z�O�A�o�^����');
            xlim([0,800]);         ylim([0 50000]);            
            
            subplot(r_fig,c_fig,6);
            plot(  abs(peak_zx2(10:end,3))  ,abs( user2.zeroCrossData.nonlogAvtVelocity(10:end) ),'*');
            xlabel('�s�[�N�l�̍�'); ylabel('�ΐ����Z�O�A�o�^����');
            xlim([0,400]);            ylim([0 50000]);
            MonitorSize = [ 0, 0, 900, 1200];
            set(gcf, 'Position', MonitorSize);
            obj.saveGraph();
        end

    end
end
