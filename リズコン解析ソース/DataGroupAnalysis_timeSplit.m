%% configファイルのデータをまとめて解析

clf;
% clearvars *;
clc;
clear all;

addpath('C:\Users\Fukushima\Documents\リズコンシステム\リズコン解析ソース');
cd('C:\Users\Fukushima\Documents\リズコンシステム\リズコン解析ソース');
% 
% saveDataDir = 'C:\Users\Fukushima\Desktop\リズコン解析データ';
% saveDataDir = 'T:\解析データ\リズコン解析データ\results';
saveDataDir = 'C:\Users\Fukushima\Documents\リズコンシステム\須藤リズコン解析データ\results';

% addpath('C:\Users\taketo\Desktop\リズコン解析ソース');
% cd('C:\Users\taketo\Desktop\リズコン解析ソース');
% 
% saveDataDir = 'C:\Users\taketo\Desktop\リズコン解析データ\results';


%% settings  
% configFileName = [cd() , '\_configData\config_20131003_剣道対戦(K-Y)1.xlsx'];   % config.xlsx(設定ファイル，実験条件)を読み込む
% configFileName = [cd() , '\_configData\config_201407協調移動実験まとめ.xlsx'];   % config.xlsx(設定ファイル，実験条件)を読み込む
% configFileName = [cd() , '\_configData\config_2014HIまとめ.xlsx'];   % config.xlsx(設定ファイル，実験条件)を読み込むconfig_20140711test
configFileName = [cd() , '\_configData\config_Life追加0831urgent.xlsx'];   % config.xlsx(設定ファイル，実験条件)を読み込む
% configFileName = [cd() , '\_configData\config_201406-07LF実験まとめ.xlsx'];   % config.xlsx(設定ファイル，実験条件)を読み込む
% configFileName = [cd() , '\_configData\config_20140612-28対戦まとめ福島ー須藤.xlsx'];   % config.xlsx(設定ファイル，実験条件)を読み込む
% configFileName = [cd() , '\_configData\config_2014HI協調移動実験やるきなし.xlsx'];   % config.xlsx(設定ファイル，実験条件)を読み込む
alwaysLoadRawData = 1;          % 生データを取り込むかの設定
%% source
configs = Models.ConfigGroup(configFileName,saveDataDir);
configFileInfo = dir(configFileName);
% figure(1);      %　？
% maximize;       %　
package = what('Analyze');      % 解析の関数のリストを取得

%% 設定ファイルの実験条件の項目毎に処理
n_st = 63;

% i=1;
% for i = n_st:length(configs.configs)
% for i = [n_st:24 , 26:length(configs.configs)]

% for i = [1,4,5,6]  % 剣道　代表データ
% for i = [8,10,11]  % 剣道　代表データ
for i = [10:21]
% for i= [1,4:7]   
   

    config = configs.configs(i);
    varFilename = char(strcat(cd(), '\vars\',config.fileName,'.mat'));
    varFileInfo = dir(varFilename);

    %% データの読み込み
%         matファイルから読み込み
    if alwaysLoadRawData ~= 1 && exist(varFilename,'file') && configFileInfo.datenum < varFileInfo.datenum 
        load(varFilename,'data');
        disp(char(strcat('start(Row',num2str(i),'):',config.fileName,'(load from .mat)')))

%         生データから読み込み
    else

        data = Loader.Loader_Kendo(config);                        %剣道対戦　読込
%         data = Loader.Loader_splitInHalf(config);                        %剣道対戦　読込

        save(varFilename,'data');
        disp(char(strcat('start(Row',num2str(i),'):',config.fileName,'(load from raw)')))
    end
    
    %% 
    %データセットを抜き出す
    disp('PointA');
    data_timeSplit =  Models.timeSplitData(data);
    save('data_timeSplit');
%     data_timeSplit =  Models.timeSplit_inHalf(data);
    for k =  1: length( data_timeSplit)
%     k=1;

         if data_timeSplit(k).splitTimeInfo.examTime > 1000

            % 解析リストの項目毎に処理
            for j = 1:length(package(1,1).m)
                disp('K');
                disp(k);
                disp('J');
                disp(j);
                [pathstr,name] = fileparts(char(strcat(package(1,1).path, '\',package(1,1).m(j))));
                disp(char(strcat(config.fileName,':',name)))
                % 解析スタート
                figure(1);      
                analyze = eval(char(['Analyze.',name,'( config , data_timeSplit(', num2str(k) ,') )']));
                analyze.start();
               
            end
                        
%             h=figure(1);
%             figurename = char(strcat(config.fileName, '_', num2str(k)));
%             saveas(h,figurename,'png');
            
        end
    end
%     % 解析リストの項目毎に処理
%     for j = 1:length(package.m)
%         [pathstr,name] = fileparts(char(strcat(package.path, '\',package.m(j))));
%         disp(char(strcat(config.fileName,':',name)))
%         % 解析スタート
%         figure(1);      %　？
%         analyze = eval(char(strcat('Analyze.',name,'(config,data)')));
%         analyze.start();
%     end
    
end
close all



