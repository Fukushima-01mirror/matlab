classdef CSVreader2 < Analyze.Base
    %STANDARDDEVIATION ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q
    
    %60000�s�̃f�[�^��3000�s�ɒ���(CSV�t�@�C���̂�)

    properties
    end

    methods
        function obj = CSVreader2(config,data)
            obj = obj@Analyze.Base(config,data);
        end

        function runForAlone(obj,user)
          %%�t�@�C�����ݒ�
           optifilename = 'horse.csv';
           %Take 2014-11-20 11.13.37 PM.csv
           %dataname = 'DATA1_04.csv';
%%          Opti�ł̃}�[�J�[�̕ψ�
            optiData(1:1790,1) = xlsread(optifilename,1,'D1:D1790');disp('RhythPulse');
            vel = zeros(200,1);
            for i=1:1790
                if rem(i,10) == 0
                    vel(i/10,1) = optiData(i,1);
                end
            end
            %vel(200,1) = xlsread(optifilename,1,'B1');
            filename = strcat('�ʒu�g�`200',optifilename);
            A = vel;
            sheet = 1;
            xlRange = 'A1';
            xlswrite(filename,A,sheet,xlRange)

                end
                
%                 PrePulPhase = zeros(60000,1);
%                 Pulse = zeros(1,1);
%                 PrePulPhase(1,1) = xlsread(dataname,1,'A1');
%                 RawPulPhase = xlsread(dataname,1,'B3:B60002');
%                 for j=1:59999
%                     PrePulPhase(j+1,1) = PrePulPhase(j,1) + RawPulPhase(j+1,1);
%                     if rem((j+1),20) == 0
%                         Pulse = vertcat(Pulse,PrePulPhase(j+1,1));
%                     end  
%                 end
%                 Pulse(1,:)=[];


        function runForPair(obj,user1 ,user2)
%             obj.runForAlone(user1);
%             obj.runForAlone(user2);
%             
            
        end
end
        
end