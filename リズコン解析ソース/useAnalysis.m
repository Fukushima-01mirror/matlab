%% config�t�@�C���̃f�[�^���܂Ƃ߂ĉ��

clf;
% clearvars *;
clc;
clear all;

%%

addpath('C:\Users\cell\Desktop\���Y�R����̓\�[�X');
cd('C:\Users\cell\Desktop\���Y�R����̓\�[�X');
% 
% saveDataDir = 'C:\Users\cell\Desktop\���Y�R����̓f�[�^';

% addpath('C:\Users\taketo\Desktop\���Y�R����̓\�[�X');
% cd('C:\Users\taketo\Desktop\���Y�R����̓\�[�X');

% saveDataDir = 'C:\Users\taketo\Desktop\���Y�R����̓f�[�^';

% saveDataDir = 'T:\��̓f�[�^\���Y�R����̓f�[�^\results';
% saveDataDir = 'T:\��̓f�[�^\���Y�R����̓f�[�^(�p�����o�[)\results';
saveDataDir = 'T:\��̓f�[�^\���Y�R����̓f�[�^(�~�����o�[)\results';
% saveDataDir = 'T:\��̓f�[�^\���Y�R����̓f�[�^(�����S���o�[)\results';

%% settings  
% configFileName = [cd() , '\_configData\config_20130918_�O��ǂ����܂�.xlsx'];   % config.xlsx(�ݒ�t�@�C���C��������)��ǂݍ���
% configFileName = [cd() , '\_configData\config_20130918_LF����.xlsx'];   % config.xlsx(�ݒ�t�@�C���C��������)��ǂݍ���
% configFileName = [cd() , '\_configData\config_20130827_���Ǐ].xlsx'];   % config.xlsx(�ݒ�t�@�C���C��������)��ǂݍ���
% configFileName = [cd() , '\_configData\config_20130515_�O��ǂ����܂�i�ː�j.xlsx'];   % config.xlsx(�ݒ�t�@�C���C��������)��ǂݍ���
% configFileName = [cd() , '\_configData\config_20131023_�Î~����.xlsx'];   % config.xlsx(�ݒ�t�@�C���C��������)��ǂݍ���
% configFileName = [cd() , '\_configData\config_20131031_ZC�ʏ�(����).xlsx'];   % config.xlsx(�ݒ�t�@�C���C��������)��ǂݍ���
% configFileName = [cd() , '\_configData\config_20131104_ZC�ʏ�(�ؑ�).xlsx'];   % config.xlsx(�ݒ�t�@�C���C��������)��ǂݍ���

% configFileName = [cd() , '\_configData\config_20131031_�{���f�[�^.xlsx'];   % config.xlsx(�ݒ�t�@�C���C��������)��ǂݍ���

% configFileName = [cd() , '\_configData\config_20131120_�O��ǂ����܂�_cont.xlsx'];   % config.xlsx(�ݒ�t�@�C���C��������)��ǂݍ���
% configFileName = [cd() , '\_configData\config_20131120_�ڕW�Ǐ]_cont.xlsx'];   % config.xlsx(�ݒ�t�@�C���C��������)��ǂݍ���
% configFileName = [cd() , '\_configData\config_20131120_�O��ǂ����܂�__force.xlsx'];   % config.xlsx(�ݒ�t�@�C���C��������)��ǂݍ���
% configFileName = [cd() , '\_configData\config_20131120_Kd�ω�����.xlsx'];   % config.xlsx(�ݒ�t�@�C���C��������)��ǂݍ���
% configFileName = [cd() , '\_configData\config_20131219_Kp�ω�����(�~�����o�[).xlsx'];   % config.xlsx(�ݒ�t�@�C���C��������)��ǂݍ���
configFileName = [cd() , '\_configData\config_20131217_KpKd-dTdA(�~�����o�[).xlsx'];   % config.xlsx(�ݒ�t�@�C���C��������)��ǂݍ���
% configFileName = [cd() , '\_configData\config_20131221_Km�ω�����(�~�����o�[).xlsx'];   % config.xlsx(�ݒ�t�@�C���C��������)��ǂݍ���
% configFileName = [cd() , '\_configData\config_20131223_Kduf����(�~�����o�[).xlsx'];   % config.xlsx(�ݒ�t�@�C���C��������)��ǂݍ���


% configFileName = [cd() , '\_configData\config_20131216_�O�と�����ǂ����܂�.xlsx'];   % config.xlsx(�ݒ�t�@�C���C��������)��ǂݍ���

% configFileName = [cd() , '\_configData\config_20131213_���d�S���o�[.xlsx'];   % config.xlsx(�ݒ�t�@�C���C��������)��ǂݍ���
% configFileName = [cd() , '\_configData\config_20131213_�p�����o�[.xlsx'];   % config.xlsx(�ݒ�t�@�C���C��������)��ǂݍ���


alwaysLoadRawData = 0;          % ���f�[�^����荞�ނ��̐ݒ�
bAnalize = 1;

%% source
% configs = Models.ConfigGroup(configFileName,saveDataDir);
configs = Models.ConfigGroup_Km(configFileName,saveDataDir);
% configs = Models.ConfigGroup_KmKduf(configFileName,saveDataDir);
configFileInfo = dir(configFileName);
% figure(1);      %�@�H
% maximize;       %�@
package = what('Analyze');      % ��͂̊֐��̃��X�g���擾

%% �ݒ�t�@�C���̎��������̍��ږ��ɏ���
% n_st = 76;
n_st = 1;

% for i = [33:36]

for i = [n_st:length(configs.configs)]
% for i = [6]
% for i = [1,7]  % �O��E�ǂ����܂��\�f�[�^
% for i = [1:7, 10:15, 22:26]  % �O��ǂ����܂�
% for i = [54]      %�@LF������\�f�[�^
% for i = [1,2, 5,6, 29:32, 53:56]  % LF�������ꏊ�f�[�^
% for i = [9:18, 37:40, 45, 47:48]  % LF�����ʏꏊ�f�[�^
% for i = [10:15 22:26]  % �O��ǂ����܂��\ �ؑ�
% for i = [1:42 44:length(configs.configs)]   %���Ǐ]
% for i = [9 10 11]      %
% for i = [1:8]
% for i = [1:6 9:length(configs.configs)]

    if i ~= 0   %%�@��O�f�[�^

        config = configs.configs(i);
        varFilename = char(strcat(cd(), '\vars\',config.fileName,'.mat'));
        varFileInfo = dir(varFilename);

        % �f�[�^�̓ǂݍ���
    %         mat�t�@�C������ǂݍ���
        if alwaysLoadRawData ~= 1 && exist(varFilename,'file') && configFileInfo.datenum < varFileInfo.datenum 
            load(varFilename,'data');
            disp(char(strcat('start(Row',num2str(i),'):',config.fileName,'(load from .mat)')))

    %         ���f�[�^����v�Z
        else
    %         data = Loader.Loader_FreeOrPress_oldPara(config);
    %         data = Loader.Loader_taskData(config);        %
            disp(char(strcat('start(Row',num2str(i),'):',config.fileName,'(load from raw)')))
            data = Loader.Loader_cpShift_taskData(config);    %�[���N���X�ɃY��
            save(varFilename,'data');
        end


        % ��̓��X�g�̍��ږ��ɏ���
        if bAnalize ==1
            for j = 1:length(package.m)
                [pathstr,name] = fileparts(char(strcat(package.path, '\',package.m(j))));
                disp(char(strcat(config.fileName,':',name)))
                % ��̓X�^�[�g
                figure(1);      %�@�H
                analyze = eval(char(strcat('Analyze.',name,'(config,data)')));
                analyze.start();
            end
        end

    end
    
end
close all



