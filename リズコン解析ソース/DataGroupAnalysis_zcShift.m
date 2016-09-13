%% config�t�@�C���̃f�[�^���܂Ƃ߂ĉ��

clf;
% clearvars *;
clc;
clear all;

addpath('C:\Users\cell\Desktop\���Y�R����̓\�[�X');
cd('C:\Users\cell\Desktop\���Y�R����̓\�[�X');
% 
% saveDataDir = 'C:\Users\cell\Desktop\���Y�R����̓f�[�^';

% addpath('C:\Users\taketo\Desktop\���Y�R����̓\�[�X');
% cd('C:\Users\taketo\Desktop\���Y�R����̓\�[�X');

%% settings  
configFileName = [cd() , '\_configData\config_20131031_ZC-50�Y��(����).xlsx'];   % config.xlsx(�ݒ�t�@�C���C��������)��ǂݍ���
alwaysLoadRawData = 1;          % ���f�[�^����荞�ނ��̐ݒ�


% saveDataDir = 'T:\��̓f�[�^\���Y�R����̓f�[�^\results(zc100)';
% saveDataDir = 'T:\��̓f�[�^\���Y�R����̓f�[�^\results(zc50)'; 
saveDataDir = 'C:\Users\cell\Desktop\�{�����Y�R����̓f�[�^'; 
if ~exist(saveDataDir,'dir' )
    mkdir(saveDataDir );
end

%% source
configs = Models.ConfigGroup(configFileName,saveDataDir);
configFileInfo = dir(configFileName);
% figure(1);      %�@�H
% maximize;       %�@
package = what('Analyze');      % ��͂̊֐��̃��X�g���擾

%% �ݒ�t�@�C���̎��������̍��ږ��ɏ���
n_st = 1;

for i = [n_st:length(configs.configs)]

% for i = [1,7]  % �O��E�ǂ����܂��\�f�[�^
% for i = [1:7, 10:15, 22:26]  % �O��ǂ����܂�
% for i = [54]      %�@LF������\�f�[�^
% for i = [1,2, 5,6, 29:32, 53:56]  % LF�������ꏊ�f�[�^
% for i = [10:15 22:26]  % �O��ǂ����܂��\ �ؑ�
% for i = [1:42 44:length(configs.configs)]   %���Ǐ]
% for i = [5]      %

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
        data = Loader.Loader_cpShift_taskData(config);    %�[���N���X�ɃY��
        save(varFilename,'data');
        disp(char(strcat('start(Row',num2str(i),'):',config.fileName,'(load from raw)')))
    end
    
    
    % ��̓��X�g�̍��ږ��ɏ���
    for j = 1:length(package.m)
        [pathstr,name] = fileparts(char(strcat(package.path, '\',package.m(j))));
        disp(char(strcat(config.fileName,':',name)))
        % ��̓X�^�[�g
        figure(1);      %�@�H
        analyze = eval(char(strcat('Analyze.',name,'(config,data)')));
        analyze.start();
    end
    
end
close all


