classdef FlucAnalysis < Analyze.Base
    %STANDARDDEVIATION ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q

    properties
    end

    methods
        function obj = FlucAnalysis(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
            [period_zx, peak_zx] = Rhythm.setZeroCrossPeriodData(user.zeroCrossData);
            
%             Period = interp1(user.zeroCrossData.zeroCrossTime , abs(period_zx), user.time.highSampled );
%             Peak = interp1(user.zeroCrossData.zeroCrossTime , abs(peak_zx), user.time.highSampled );
            
            yuragi_data(:,1) = user.operatePulse.highSampled(obj.config.analyzeTime(1):end );      %�R���g���[������
%             yuragi_data(:,2)=wave_1kdata(:,2);      %�����̍�
%             yuragi_data(:,3)=wave_1kdata(:,3);      %�U���̍�

            %�g�`��炬���
            [D1,Alpha1,n,F_n]=Rhythm.DFAouts_main( yuragi_data,1);
            [avar,tau]=Rhythm.avar_func(yuragi_data,1,0.001);
            
            loglog(tau,avar(:,1));
            xlabel('�T���v�����O�Ԋu �� s'); ylabel('�A�������U ��');
            xlim([10^-3,10^2]);    ylim([10^-1 10^3]);
            title([' DFA-alpha :',num2str(Alpha1(1,1))]);


            MonitorSize = [ 0, 0, 500, 400];
            set(gcf, 'Position', MonitorSize);
            if ~isempty(strfind( char(obj.config.examType) , '�����ΐ�'))
                obj.saveGraphWithName( [ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state ]);
            else
                obj.saveGraph();
            end
            
            %%      �ߎ������@�W���@�G�N�Z���f�[�^�o��  

            outputTitle = {'�R���g���[�������炬'};
            output = num2cell([Alpha1] );
            if ~isempty(strfind( char(obj.config.examType) , '�����ΐ�'))
                obj.outputAllToXlsWithName([ num2str( obj.data.splitTimeInfo.index ) '_' obj.data.splitTimeInfo.state ] , output , outputTitle)
            else
                obj.outputAllToXls(output , outputTitle);
            end

            
        end

    end
end
