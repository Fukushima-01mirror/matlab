%% configファイルのデータをまとめて解析

clf;
% clearvars *;
clc;
clear all;

%%

addpath('C:\Users\cell\Desktop\リズコン解析ソース');
cd('C:\Users\cell\Desktop\リズコン解析ソース');
% 
% saveDataDir = 'C:\Users\cell\Desktop\リズコン解析データ';

% addpath('C:\Users\taketo\Desktop\リズコン解析ソース');
% cd('C:\Users\taketo\Desktop\リズコン解析ソース');

% saveDataDir = 'C:\Users\taketo\Desktop\リズコン解析データ';

% saveDataDir = 'T:\解析データ\リズコン解析データ\results';
% saveDataDir = 'T:\解析データ\リズコン解析データ(角柱レバー)\results';
saveDataDir = 'T:\解析データ\リズコン解析データ(円柱レバー)\results';
% saveDataDir = 'T:\解析データ\リズコン解析データ(軸中心レバー)\results';

%% settings  
% configFileName = [cd() , '\_configData\config_20130918_前後追い込まれ.xlsx'];   % config.xlsx(設定ファイル，実験条件)を読み込む
% configFileName = [cd() , '\_configData\config_20130918_LF実験.xlsx'];   % config.xlsx(設定ファイル，実験条件)を読み込む
% configFileName = [cd() , '\_configData\config_20130827_線追従.xlsx'];   % config.xlsx(設定ファイル，実験条件)を読み込む
% configFileName = [cd() , '\_configData\config_20130515_前後追い込まれ（戸川）.xlsx'];   % config.xlsx(設定ファイル，実験条件)を読み込む
% configFileName = [cd() , '\_configData\config_20131023_静止実験.xlsx'];   % config.xlsx(設定ファイル，実験条件)を読み込む
% configFileName = [cd() , '\_configData\config_20131031_ZC通常(安井).xlsx'];   % config.xlsx(設定ファイル，実験条件)を読み込む
% configFileName = [cd() , '\_configData\config_20131104_ZC通常(木村).xlsx'];   % config.xlsx(設定ファイル，実験条件)を読み込む

% configFileName = [cd() , '\_configData\config_20131031_須藤データ.xlsx'];   % config.xlsx(設定ファイル，実験条件)を読み込む

% configFileName = [cd() , '\_configData\config_20131120_前後追い込まれ_cont.xlsx'];   % config.xlsx(設定ファイル，実験条件)を読み込む
% configFileName = [cd() , '\_configData\config_20131120_目標追従_cont.xlsx'];   % config.xlsx(設定ファイル，実験条件)を読み込む
% configFileName = [cd() , '\_configData\config_20131120_前後追い込まれ__force.xlsx'];   % config.xlsx(設定ファイル，実験条件)を読み込む
% configFileName = [cd() , '\_configData\config_20131120_Kd変化実験.xlsx'];   % config.xlsx(設定ファイル，実験条件)を読み込む
% configFileName = [cd() , '\_configData\config_20131219_Kp変化実験(円柱レバー).xlsx'];   % config.xlsx(設定ファイル，実験条件)を読み込む
configFileName = [cd() , '\_configData\config_20131217_KpKd-dTdA(円柱レバー).xlsx'];   % config.xlsx(設定ファイル，実験条件)を読み込む
% configFileName = [cd() , '\_configData\config_20131221_Km変化実験(円柱レバー).xlsx'];   % config.xlsx(設定ファイル，実験条件)を読み込む
% configFileName = [cd() , '\_configData\config_20131223_Kduf実験(円柱レバー).xlsx'];   % config.xlsx(設定ファイル，実験条件)を読み込む


% configFileName = [cd() , '\_configData\config_20131216_前後→両側追い込まれ.xlsx'];   % config.xlsx(設定ファイル，実験条件)を読み込む

% configFileName = [cd() , '\_configData\config_20131213_軸重心レバー.xlsx'];   % config.xlsx(設定ファイル，実験条件)を読み込む
% configFileName = [cd() , '\_configData\config_20131213_角柱レバー.xlsx'];   % config.xlsx(設定ファイル，実験条件)を読み込む


alwaysLoadRawData = 0;          % 生データを取り込むかの設定
bAnalize = 1;

%% source
% configs = Models.ConfigGroup(configFileName,saveDataDir);
configs = Models.ConfigGroup_Km(configFileName,saveDataDir);
% configs = Models.ConfigGroup_KmKduf(configFileName,saveDataDir);
configFileInfo = dir(configFileName);
% figure(1);      %　？
% maximize;       %　
package = what('Analyze');      % 解析の関数のリストを取得

%% 設定ファイルの実験条件の項目毎に処理
% n_st = 76;
n_st = 1;

% for i = [33:36]

for i = [n_st:length(configs.configs)]
% for i = [6]
% for i = [1,7]  % 前後・追い込まれ代表データ
% for i = [1:7, 10:15, 22:26]  % 前後追い込まれ
% for i = [54]      %　LF実験代表データ
% for i = [1,2, 5,6, 29:32, 53:56]  % LF実験同場所データ
% for i = [9:18, 37:40, 45, 47:48]  % LF実験別場所データ
% for i = [10:15 22:26]  % 前後追い込まれ代表 木村
% for i = [1:42 44:length(configs.configs)]   %線追従
% for i = [9 10 11]      %
% for i = [1:8]
% for i = [1:6 9:length(configs.configs)]

    if i ~= 0   %%　例外データ

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
    %         data = Loader.Loader_FreeOrPress_oldPara(config);
    %         data = Loader.Loader_taskData(config);        %
            disp(char(strcat('start(Row',num2str(i),'):',config.fileName,'(load from raw)')))
            data = Loader.Loader_cpShift_taskData(config);    %ゼロクロスにズレ
            save(varFilename,'data');
        end


        % 解析リストの項目毎に処理
        if bAnalize ==1
            for j = 1:length(package.m)
                [pathstr,name] = fileparts(char(strcat(package.path, '\',package.m(j))));
                disp(char(strcat(config.fileName,':',name)))
                % 解析スタート
                figure(1);      %　？
                analyze = eval(char(strcat('Analyze.',name,'(config,data)')));
                analyze.start();
            end
        end

    end
    
end
close all



