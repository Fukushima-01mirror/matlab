%% configファイルのデータをまとめて解析

clf;
% clearvars *;
clc;
clear all;

addpath('C:\Users\cell\Documents\リズコンシステム\リズコン解析ソース');
cd('C:\Users\cell\Documents\リズコンシステム\リズコン解析ソース');
saveDataDir = 'C:\Users\cell\Documents\リズコンシステム\須藤リズコン解析データ\results';

%% settings  
configFileName = [cd() , '\_configData\config_20140717間合い協力.xlsx'];   % config.xlsx(設定ファイル，実験条件)を読み込む
alwaysLoadRawData = 1;          % 生データを取り込むかの設定
%% source
configs = Models.ConfigGroup(configFileName,saveDataDir);
configFileInfo = dir(configFileName);
package = what('Analyze');      % 解析の関数のリストを取得

%% 設定ファイルの実験条件の項目毎に処理
n_st = 8;
% for i = n_st:length(configs.configs)
% for i = [n_st:24 , 26:length(configs.configs)]
% for i = [25]  % 剣道　代表データ
% for i = [5]  % 剣道　代表データ
for i= [1]
    config = configs.configs(i);
    varFilename = char(strcat(cd(), '\vars\',config.fileName,'.mat'));
    varFileInfo = dir(varFilename);

    %% データの読み込み

        % matファイルから読み込み
    if alwaysLoadRawData ~= 1 && exist(varFilename,'file') && configFileInfo.datenum < varFileInfo.datenum 
        load(varFilename,'data');
        disp(char(strcat('start(Row',num2str(i),'):',config.fileName,'(load from .mat)')))

        % 生データから読み込み
    else
        data = Loader.Loader_Kendo(config);                        %剣道対戦　読込
        save(varFilename,'data');
        disp(char(strcat('start(Row',num2str(i),'):',config.fileName,'(load from raw)')))
    end
    
    %% 
    %データセットを抜き出す
    data_timeSplit =  Models.timeSplitData(data);
    for k =  1: length( data_timeSplit)
%     k=1;
            % 解析リストの項目毎に処理
            for j = 1:length(package.m)
                [pathstr,name] = fileparts(char(strcat(package.path, '\',package.m(j))));
                disp(char(strcat(config.fileName,':',name)))

                % 解析スタート
                figure(1);      
                analyze = eval(char(['Analyze.',name,'( config , data_timeSplit(', num2str(k) ,') )']));
                analyze.start();
            end
    end
    
end
close all



