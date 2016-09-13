%% configファイルのデータをまとめて解析

clf;
% clearvars *;
clc;
clear all;

addpath('C:\Users\cell\Desktop\リズコン解析ソース');
cd('C:\Users\cell\Desktop\リズコン解析ソース');
% 
% saveDataDir = 'C:\Users\cell\Desktop\リズコン解析データ';

% addpath('C:\Users\taketo\Desktop\リズコン解析ソース');
% cd('C:\Users\taketo\Desktop\リズコン解析ソース');

%% settings  
configFileName = [cd() , '\_configData\config_20131031_ZC-50ズレ(安井).xlsx'];   % config.xlsx(設定ファイル，実験条件)を読み込む
alwaysLoadRawData = 1;          % 生データを取り込むかの設定


% saveDataDir = 'T:\解析データ\リズコン解析データ\results(zc100)';
% saveDataDir = 'T:\解析データ\リズコン解析データ\results(zc50)'; 
saveDataDir = 'C:\Users\cell\Desktop\須藤リズコン解析データ'; 
if ~exist(saveDataDir,'dir' )
    mkdir(saveDataDir );
end

%% source
configs = Models.ConfigGroup(configFileName,saveDataDir);
configFileInfo = dir(configFileName);
% figure(1);      %　？
% maximize;       %　
package = what('Analyze');      % 解析の関数のリストを取得

%% 設定ファイルの実験条件の項目毎に処理
n_st = 1;

for i = [n_st:length(configs.configs)]

% for i = [1,7]  % 前後・追い込まれ代表データ
% for i = [1:7, 10:15, 22:26]  % 前後追い込まれ
% for i = [54]      %　LF実験代表データ
% for i = [1,2, 5,6, 29:32, 53:56]  % LF実験同場所データ
% for i = [10:15 22:26]  % 前後追い込まれ代表 木村
% for i = [1:42 44:length(configs.configs)]   %線追従
% for i = [5]      %

    config = configs.configs(i);
    varFilename = char(strcat(cd(), '\vars\',config.fileName,'.mat'));
    varFileInfo = dir(varFilename);

    % データの読み込み
%         matファイルから読み込み
    if alwaysLoadRawData ~= 1 && exist(varFilename,'file') && configFileInfo.datenum < varFileInfo.datenum 
        load(varFilename,'data');
        disp(char(strcat('start(Row',num2str(i),'):',config.fileName,'(load from .mat)')))

%         生データから計算
    else
        data = Loader.Loader_cpShift_taskData(config);    %ゼロクロスにズレ
        save(varFilename,'data');
        disp(char(strcat('start(Row',num2str(i),'):',config.fileName,'(load from raw)')))
    end
    
    
    % 解析リストの項目毎に処理
    for j = 1:length(package.m)
        [pathstr,name] = fileparts(char(strcat(package.path, '\',package.m(j))));
        disp(char(strcat(config.fileName,':',name)))
        % 解析スタート
        figure(1);      %　？
        analyze = eval(char(strcat('Analyze.',name,'(config,data)')));
        analyze.start();
    end
    
end
close all


