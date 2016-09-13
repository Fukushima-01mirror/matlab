%% configファイルのデータをまとめて解析

clf;
% clearvars *;
clc;
clear all;

addpath('C:\Users\cell\Documents\リズコンシステム\リズコン解析ソース');
cd('C:\Users\cell\Documents\リズコンシステム\リズコン解析ソース');
saveDataDir = 'C:\Users\cell\Documents\リズコンシステム\須藤リズコン解析データ\results';

%% settings  
configFileName = [cd() , '\_configData\config_20140802協調W遠隔自分の音のみ.xlsx'];   % config.xlsx(設定ファイル，実験条件)を読み込む
alwaysLoadRawData = 1;          % 生データを取り込むかの設定
%% source
configs = Models.ConfigGroup(configFileName,saveDataDir);
configFileInfo = dir(configFileName);
package = what('Analyze');      % 解析の関数のリストを取得

%% 設定ファイルの実験条件の項目毎に処理
n_st = 1;
% for i = n_st:length(configs.configs)
% for i = [n_st:24 , 26:length(configs.configs)]
% for i = [25]  % 剣道　代表データ
% for i = [5]  % 剣道　代表データ
for i= [2]
    config = configs.configs(i);
    varFilename = char(strcat(cd(), '\vars\',config.fileName,'.mat'));
    varFileInfo = dir(varFilename);

    foldername = char(strcat(cd(),'\data\',config.fileName,'\'));

    cont_data1_list = dir([foldername,'DATA1_*']);
    cont_data2_list = dir([foldername,'DATA2_*']);
    cont_data1 = csvread([foldername,cont_data1_list.name],2,0);
    cont_data2 = csvread([foldername,cont_data2_list.name],2,0);

    %% 操作波形，ゼロクロス時間
    cont_data1(1,3) = 0;
    cont_data2(1,3) = 0;

    zerocrossTimes1 = 1;
    zerocrossTimes2 = 1;
    
    for j=2:60000
        cont_data1(j,3) = cont_data1(j-1,3) + cont_data1(j,2);  %操作波形
        cont_data2(j,3) = cont_data2(j-1,3) + cont_data2(j,2);
        
        if cont_data1(j-1,3)>0 && cont_data1(j,3)<=0            %1Pゼロクロス時間
            time_zc1(zerocrossTimes1,1) = cont_data1(j,1);
%             time_zc1(zerocrossTimes1,2) = zerocrossTimes1;
            zerocrossTimes1 = zerocrossTimes1 + 1;
        elseif cont_data1(j-1,3)<0 && cont_data1(j,3)>=0
            time_zc1(zerocrossTimes1,1) = cont_data1(j,1);
%             time_zc1(zerocrossTimes1,2) = zerocrossTimes1;
            zerocrossTimes1 = zerocrossTimes1 + 1;
        end
        
        if cont_data2(j-1,3)>0 && cont_data2(j,3)<=0            %2Pゼロクロス時間
            time_zc2(zerocrossTimes2,1) = cont_data2(j,1);
            zerocrossTimes2 = zerocrossTimes2 + 1;
        elseif cont_data2(j-1,3)<0 && cont_data2(j,3)>=0
            time_zc2(zerocrossTimes2,1) = cont_data2(j,1);
            zerocrossTimes2 = zerocrossTimes2 + 1;
        end    
    end
    zerocrossTimes1 = zerocrossTimes1 - 1;
    zerocrossTimes2 = zerocrossTimes2 - 1;
    
    %% 振幅，周期計算
    %1P period
    for l = 2:zerocrossTimes1
        period1(l,1) = time_zc1(l,1) - time_zc1(l-1,1);
    end
    period1(1,1) = 0;
    for l = 3:zerocrossTimes1 %周期差
        period1(l,2) = abs(period1(l,1)-period1(l-1,1));
    end
    
    % 1P peak
    Index_Zerocross = 0;
    Index_nonZerocross = 0;
    for l = 2:zerocrossTimes1
        if mean(cont_data1(time_zc1(l-1):time_zc1(l),3)) > 0
            peak1(l,1) = max(cont_data1(time_zc1(l-1):time_zc1(l),3));
            [pks,locs] = Rhythm.findpeaksPulse( time_zc1(l-1):time_zc1(l), abs( cont_data1( time_zc1(l-1):time_zc1(l) ) ) );
            if length(pks) ~= 1
                Index_nonZerocross = horzcat(Index_nonZerocross , l);
            else
                Index_Zerocross = horzcat(Index_nonZerocross , l);
            end
        elseif mean(cont_data1(time_zc1(l-1):time_zc1(l),3)) < 0
            peak1(l,1) = min(cont_data1(time_zc1(l-1):time_zc1(l),3));
        end
        
%         if mean( Pul(cycle_data(l-1,1) :cycle_data(l,1) ) ) > 0
%             [pks,locs] = Rhythm.findpeaksPulse(t_zx, abs( Pul(cycle_data(l-1,1) :cycle_data(l,1) ) )  );
%             obj.zeroCrossData.peak(l,1).time = locs;
%             obj.zeroCrossData.peak(l,1).value = pks;
%         else
%             [pks,locs] = Rhythm.findpeaksPulse(t_zx, abs( Pul(cycle_data(l-1,1) :cycle_data(l,1) ) )  );
%             obj.zeroCrossData.peak(l,1).time = locs;
%             obj.zeroCrossData.peak(l,1).value = -pks;
%         end
    end
    
    for l = 3:zerocrossTimes1 %振幅差
        if sign(peak1(l,1)) == sign(peak1(l-1,1))
            peak1(l,2) = abs(peak1(l,1));
        elseif sign(peak1(l,1)) ~= sign(peak1(l-1,1))
            peak1(l,2) = abs(peak1(l,1) + peak1(l-1,1));
        end
    end


    %2p period
    for l = 2:zerocrossTimes2
        period2(l,1) = time_zc2(l,1) - time_zc2(l-1,1);
    end
    period2(1,1) = 0;
    for l = 3:zerocrossTimes2 %周期差
        period2(l,2) = abs(period2(l,1)-period2(l-1,1));
    end
    
    % 2p peak
    for l = 2:zerocrossTimes2
        if mean(cont_data2(time_zc2(l-1):time_zc2(l),3)) > 0
            peak2(l,1) = max(cont_data2(time_zc2(l-1):time_zc2(l),3));
        elseif mean(cont_data2(time_zc2(l-1):time_zc2(l),3)) < 0
            peak2(l,1) = min(cont_data2(time_zc2(l-1):time_zc2(l),3));
        end
    end
    
    for l = 3:zerocrossTimes2 %振幅差
        if sign(peak2(l,1)) == sign(peak2(l-1,1))
            peak2(l,2) = abs(peak2(l,1));
        elseif sign(peak2(l,1)) ~= sign(peak2(l-1,1))
            peak2(l,2) = abs(peak2(l,1) + peak2(l-1,1));
        end
    end
    
    
    %% アバタ速度計算 
    %1p
    s_pul1 = zeros(zerocrossTimes1,1);
    for l = 2:zerocrossTimes1
        for m = time_zc1(l-1):time_zc1(l)
            s_pul1(l,1) = s_pul1(l,1) + cont_data1(m,3);
        end
        if l ~= 2
            v_avt1(l,1) = abs(s_pul1(l,1) + s_pul1(l-1,1));
        end
    end
    
    %2p
    s_pul2 = zeros(zerocrossTimes2,1);
    for l = 2:zerocrossTimes2
        for m = time_zc2(l-1):time_zc2(l)
            s_pul2(l,1) = s_pul2(l,1) + cont_data2(m,3);
        end
        if l ~= 2
            v_avt2(l,1) = abs(s_pul2(l,1) + s_pul2(l-1,1));
        end
    end

    
    %% 3D散布図描画 1p
    figure(1)
    set(gcf, 'Position', [ 0, 0, 500, 500]);
    
    plot3( [0 0],[0 0],[0 0],'k' );
    hold on
        plot3(period1(:,2), peak1(:,2) , v_avt1(:,1) ,'Marker','.','MarkerEdgeColor' , 'b' , 'LineStyle','none' );
    
    hold off
    
    
    view(-30,25);
    grid on
    axis square
    xlabel('操作波形 周期の差dT');  ylabel('操作波形 振幅の差dA');  zlabel('対数演算前アバタ速さV');
    xlim([0 600]);            ylim([0 600]);          zlim([0 50000]);
    
    
    
    %% 3D散布図描画 2p
    figure(2)
    set(gcf, 'Position', [ 0, 0, 500, 500]);
    
    plot3( [0 0],[0 0],[0 0],'k' );
    hold on
        plot3(period2(:,2), peak2(:,2) , v_avt2(:,1) ,'Marker','.','MarkerEdgeColor' , 'b' , 'LineStyle','none' );
    
    hold off
    
    
    view(-30,25);
    grid on
    axis square
    xlabel('操作波形 周期の差dT');  ylabel('操作波形 振幅の差dA');  zlabel('対数演算前アバタ速さV');
    xlim([0 600]);            ylim([0 600]);          zlim([0 50000]);
end

%%


% 
%     %% データの読み込み
% 
%         % matファイルから読み込み
%     if alwaysLoadRawData ~= 1 && exist(varFilename,'file') && configFileInfo.datenum < varFileInfo.datenum 
%         load(varFilename,'data');
%         disp(char(strcat('start(Row',num2str(i),'):',config.fileName,'(load from .mat)')))
% 
%         % 生データから読み込み
%     else
%         data = Loader.Loader_Kendo(config);                        %剣道対戦　読込
%         save(varFilename,'data');
%         disp(char(strcat('start(Row',num2str(i),'):',config.fileName,'(load from raw)')))
%     end
%     
%     %% 
%     %データセットを抜き出す
%     data_timeSplit =  Models.timeSplitData(data);
%     for k =  1: length( data_timeSplit)
% %     k=1;
%             % 解析リストの項目毎に処理
%             for j = 1:length(package.m)
%                 [pathstr,name] = fileparts(char(strcat(package.path, '\',package.m(j))));
%                 disp(char(strcat(config.fileName,':',name)))
% 
%                 % 解析スタート
%                 figure(1);      
%                 analyze = eval(char(['Analyze.',name,'( config , data_timeSplit(', num2str(k) ,') )']));
%                 analyze.start();
%             end
%     end
%     
% end
close all



