リズコン解析ソース

●フォルダ内容

・config.txt			
・config_test.txt
　実験条件設定ファイル
	ファイル名，1PName，2PName，実験条件，実験時間，アーカイブデータファイル名，（タスクデータ）

・index.m				解析mファイル

・dataフォルダ			元データ
・varsフォルダ			matファイルの保存データ
・resultsフォルダ		解析結果保存データ

・+Modelsフォルダ		基本データ処理mファイル
・+Loaderフォルダ		元データの読込mファイル
・+Analyzeフォルダ		解析mファイル
・+Twフォルダ			渡辺さん作成解析mファイル




▼+Modelsフォルダ内容（基本データ処理mファイル）
・Config.m				設定読込の基本データ処理
・ConfigGroup.m			設定データ読込のクラス

・ModelAbstruct.m < handle
	methods : getData, setData, length

・DataAbstruct.m　< ModelAbstruct.m
	methos : matrix, backupToRaw, trim, splineTrim, spline, 
			offset, yOffsetAvg, useLowpassFilter, useBandpassFilter
・DataGroupAbstruct.m < ModelAbstruct.m
	いらない？
	

・RhythmAvatar.m < Models.DataAbstruct
	データ読込，アバタ位置・速度再計算，ゼロクロス情報


▼+Loderフォルダ内容（元データの読込mファイル）
・Loder201305115．m		リーダーフォロワ実験（人同士，アーカイブ）

◇todo
・剣道対戦のときのデータ読込


▼+Analyzeフォルダ

・Base.m	基本クラス
	start, forlderName,  saveFileName, saveFilepath, outputAllToXls,
	saveGraph, saveGraphWithName, 
・~Graph.m, ~Graph.m

◇todo
・グラフ化
	アバタ位置，アバタ間距離，アバタ速度，コントローラ操作の時系列グラフ

・ゆらぎ解析（FFT，アラン分散，DFA解析）
	エクセル化　→　統計解析（ヒストグラム）

・アバタ-操作要素相関図
	グルーピング　→　ばらつき具合，傾きの算出
	
・エントレインメント解析
		バンドパスフィルタ　→　相互相関

・
