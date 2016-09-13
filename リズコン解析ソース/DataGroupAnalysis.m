%% configファイルのデータをまとめて解析

clf;
% clearvars *;
clc;
clear all;

addpath('C:\Users\Fukushima\Documents\リズコンシステム\リズコン解析ソース');
cd('C:\Users\Fukushima\Documents\リズコンシステム\リズコン解析ソース');

% saveDataDir = 'T:\解析データ\リズコン解析データ\results';
% saveDataDir = 'T:\解析データ\リズコン解析データ(角柱レバー)\results';
% saveDataDir = 'T:\解析データ\リズコン解析データ(円柱レバー)\results';
% saveDataDir = 'T:\解析データ\リズコン解析データ(軸中心レバー)\results';

saveDataDir = 'C:\Users\Fukushima\Documents\リズコンシステム\須藤リズコン解析データ\results';


%% settings  

configFileName = [cd() , '\_configData\blank普段.xlsx'];   % config.xlsx(設定ファイル，実験条件)を読み込む

% configFileName = [cd() , '\_configData\config_0202.xlsx'];   % config.xlsx(設定ファイル，実験条件)を読み込む
% configFileName = [cd() , '\_configData\config_toka.xlsx'];   
bAnalize = 1;% config.xlsx(設定ファイル，実験条件)を読み込む
% configFileName = [cd() , '\_configData\config_20131213_角柱レバー.xlsx'];   % config.xlsx(設定ファイル，実験条件)を読み込む

alwaysLoadRawData = 1;          % 生データを取り込むかの設定

%% source
configs = Models.ConfigGroup(configFileName,saveDataDir);
% configs = Models.ConfigGroup_Km(configFileName,saveDataDir);
% configs = Models.ConfigGroup_KmKduf(configFileName,saveDataDir);
configFileInfo = dir(configFileName);
% figure(1);      %　？
% maximize;       %　
package = what('Analyze');      % 解析の関数のリストを取得

%% 設定ファイルの実験条件の項目毎に処理
% n_st = 76;
n_st = 1;

% for i = [33:36]

% for i = n_st:length(configs.configs)
for i = [2:6]
% for i = [1,7]  % 前後・追い込まれ代表データ
% for i = [1:7, 10:15, 22:26]  % 前後追い込まれ
% for i = [17 28]      %　LF実験代表データ
% for i = [27:30]      %　LF実験代表データ
% for i = [1,2, 5,6, 29:32, 53:56]  % LF実験同場所データ
% for i = [9:18, 37:40, 45, 47:48]  % LF実験別場所データ
% for i = [10:15 22:26]  % 前後追い込まれ代表 木村
% for i = [1:42 44:length(configs.configs)]   %線追従
% for i = [9 10 11]      %
% for i = [1:10]
% for i = [1:6 9:length(configs.configs)]

    if ~( i == 0 || i == 0 )  %%　例外データ

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
            disp(char(strcat('start(Row',num2str(i),'):',config.fileName,'(load from raw)')))
%             data = Loader.Loader_FreeOrPress_oldPara(config);
%             data = Loader.Loader_taskData(config);        % 自動アバタデータ出力の形式が古い
             data = Loader.Loader_cpShift_taskData(config);
             %ゼロクロスにズレ
            save(varFilename,'data');
%             ZCcsvfilename = char( strcat( num2str(i) , '.csv' ));
%             csvwrite(ZCcsvfilename , data.player1.zeroCrossData.zeroCrossTime)
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
fclose all
close all



