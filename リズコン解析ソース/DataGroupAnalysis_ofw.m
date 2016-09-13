%% config�t�@�C���̃f�[�^���܂Ƃ߂ĉ��

clf;
% clearvars *;
clc;
clear all;

addpath('C:\Users\cell\Documents\���Y�R���V�X�e��\���Y�R����̓\�[�X');
cd('C:\Users\cell\Documents\���Y�R���V�X�e��\���Y�R����̓\�[�X');

saveDataDir = 'C:\Users\cell\Documents\���Y�R���V�X�e��\�{�����Y�R����̓f�[�^\results';


%% settings  

% configFileName = [cd() , '\_configData\config_20140516_�{��_3.xlsx'];   % config.xlsx(�ݒ�t�@�C���C��������)��ǂݍ���

% configFileName = [cd() , '\_configData\config_20141006ofw��l�e�X�g.xlsx'];   % config.xlsx(�ݒ�t�@�C���C��������)��ǂݍ���
configFileName = [cd() , '\_configData\config_20140429����.xlsx'];   % config.xlsx(�ݒ�t�@�C���C��������)��ǂݍ���

alwaysLoadRawData = 1;          % ���f�[�^����荞�ނ��̐ݒ�
bAnalize = 1;

%% source
configs = Models.ConfigGroup(configFileName,saveDataDir);
% configs = Models.ConfigGroup_Km(configFileName,saveDataDir);
% configs = Models.ConfigGroup_KmKduf(configFileName,saveDataDir);
configFileInfo = dir(configFileName);
% figure(1);      %�@�H
% maximize;       %�@
package = what('Analyze');      % ��͂̊֐��̃��X�g���擾

%% �ݒ�t�@�C���̎��������̍��ږ��ɏ���
% n_st = 76;
n_st = 1;

for i = [3]

% for i = n_st:length(configs.configs)
% for i = [2,3]
% for i = [1:6 9:length(configs.configs)]

    if ~( i == 0 || i == 0 )  %%�@��O�f�[�^

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
            disp(char(strcat('start(Row',num2str(i),'):',config.fileName,'(load from raw)')))
%             data = Loader.Loader_FreeOrPress_oldPara(config);
%             data = Loader.Loader_taskData(config);        % �����A�o�^�f�[�^�o�͂̌`�����Â�
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
fclose all
close all



