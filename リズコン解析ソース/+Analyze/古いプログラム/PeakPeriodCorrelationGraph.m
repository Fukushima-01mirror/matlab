classdef PeakPeriodCorrelationGraph < Analyze.Base
    %STANDARDDEVIATION ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q

    properties
    end

    methods
        function obj = PeakPeriodCorrelationGraph(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
            [period_zx, peak_zx] = Rhythm.setZeroCrossPeriodData(user.zeroCrossData);
            
            k=2;
            zeroCrossTimes = zeros(1,2);
            % �[���N���X�Ԃ̃s�[�N�񐔁@C1:�g�`�̑O�����̃s�[�N�񐔁@C2:�㔼���̃s�[�N��
            zeroCrossTimes(1,1) = length( user.zeroCrossData.peak(1).time );
            for i = 2 : length(user.zeroCrossData.peak)
                zeroCrossTimes(k,1) = length( user.zeroCrossData.peak(i).time );
                zeroCrossTimes(k,2) = length( user.zeroCrossData.peak(i-1).time );
                k = k+1;
            end

            r_fig = 3;      c_fig = 3;      
            period_zx_n0 = period_zx(3:end-1,:);
            period_zx_n1 = period_zx(4:end,:);
            peak_zx_n0 = peak_zx(3:end-1,:);
            peak_zx_n1 = peak_zx(4:end,:);

            subplot(r_fig,c_fig,1);
            plot( abs( peak_zx_n0(:,1) )  , abs( period_zx_n1(:,1) ) ,'*');
            xlabel('�s�[�N�l�i�������jn-1'); ylabel('����g�` ������ n');
            xlim([0,600]);            ylim([0,600]); 
  
            subplot(r_fig,c_fig,2);
            plot( abs( period_zx_n0(:,1) )  , abs( peak_zx_n1(:,1) ) ,'*');
            xlabel('����g�` ������ n-1'); ylabel('�s�[�N�l�i�������jn');
            xlim([0,600]);            ylim([0,600]); 
 
            subplot(r_fig,c_fig,3);
            plot(  abs( peak_zx( zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2,1) )  ,abs( period_zx( zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2,1) ),'*');
            hold on
                plot( abs( peak_zx(zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1,1) )  ,abs( period_zx(zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1,1) ),'o');
            hold off
            xlabel('�s�[�N�l�i�������jn'); ylabel('����g�` ������ n');
            xlim([0,600]);            ylim([0,600]);

            
            subplot(r_fig,c_fig,4);
            plot( peak_zx_n0(:,2)  , period_zx_n1(:,2) ,'*');
            xlabel('�U��(1����) n-1'); ylabel('����g�` 1���� n');
            xlim([0,800]);             ylim([0,800]);
  
            subplot(r_fig,c_fig,5);
            plot( period_zx_n0(:,2)  , peak_zx_n1(:,2) ,'*');
            xlabel('����g�` 1���� n-1'); ylabel('�U��(1����) n');
            xlim([0,800]);             ylim([0,800]);
 
            subplot(r_fig,c_fig,6);
            plot(  abs( peak_zx( zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2,2) )  ,abs( period_zx( zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2,2) ),'*');
            hold on
                plot( abs( peak_zx(zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1,2) )  ,abs( period_zx(zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1,2) ),'o');
            hold off
            xlabel('�U��(1����) n'); ylabel('����g�` 1���� n');
            xlim([0,800]);            ylim([0,800]);
            
            
            subplot(r_fig,c_fig,7);
            plot( peak_zx_n0(:,3)  , period_zx_n1(:,3) ,'*');
            xlabel('�U���̍� n-1'); ylabel('�����̍� n');
            xlim([0,600]);             ylim([0,600]);
  
            subplot(r_fig,c_fig,8);
            plot( period_zx_n0(:,3)  , peak_zx_n1(:,3) ,'*');
            xlabel('�����̍� n-1'); ylabel('�U���̍� n');
            xlim([0,800]);             ylim([0,600]);
 
            subplot(r_fig,c_fig,9);
            plot(  abs( peak_zx( zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2,3) )  ,abs( period_zx( zeroCrossTimes(:,1)<2&zeroCrossTimes(:,2)<2,3) ),'*');
            hold on
                plot( abs( peak_zx(zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1,3) )  ,abs( period_zx(zeroCrossTimes(:,1)>1|zeroCrossTimes(:,2)>1,3) ),'o');
            hold off
            xlabel('�U���̍� n'); ylabel('�����̍� n');
            xlim([0,600]);            ylim([0,600]);

            
            MonitorSize = [ 0, 0, 1000, 1000];
            set(gcf, 'Position', MonitorSize);
            
            obj.saveGraph();
        end
        
%         function runForPair(obj.user1, obj.user2)
%             
%         end

        
    end
end
