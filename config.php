<?php

// settings/gr_channel.phpが作成された場合、
// config.php内の$GR_CHANNEL_MAPは無視されます

// 首都圏用地上デジタルチャンネルマップ
// 識別子 => チャンネル番号
$GR_CHANNEL_MAP = array(
        "GR27" => "27",         // NHK
        "GR26" => "26",         // 教育
        "GR25" => "25",         // 日テレ
        "GR22" => "22",         // TBS
        "GR23" => "23",         // 東京
        "GR21" => "21",         // フジ
        "GR24" => "24",         // テレ朝
        "GR20" => "20",         // MX TV
        "GR18" => "18",         // tvk
//        "GR18" => "18",         // テレ神
//        "GR30" => "30",         // 千葉
//        "GR32" => "32",         // テレ玉
//        "GR28" => "28",         // 大学
);

/*
// 大阪地区デジタルチャンネルマップ（参考）
$GR_CHANNEL_MAP = array(
	"GR24" => "24",		// NHK
	"GR13" => "13",		// 教育
	"GR16" => "16",		// 毎日
	"GR15" => "15",		// 朝日
	"GR17" => "17",		// 関西
	"GR14" => "14",		// 読売
	"GR18" => "18",		// テレビ大阪
);
*/


// 録画モード（option）

$RECORD_MODE = array(
	// ※ 0は必須で、変更不可です。
	0 => array(
		'name' => 'Full TS',	// モードの表示名
		'suffix' => '.ts',	// ファイル名のサフィックス
	),
	
	1 => array(
		'name' => 'Minimum TS',	// 最小のTS
		'suffix' => '_tss.ts',	// do-record.shのカスタマイズが必要
	),
	
	2 => array(
		'name' => 'mp4',
		'suffix' => '.mp4',
	),
	
  3 => array(
		'name' => 'mp4_subtitles',
		'suffix' => '.mp4',
	),

);


// BSチューナーとして黒Friioを用いているのなら下のfalseをtrueに変えてください。

define( "USE_KUROBON", false );



//////////////////////////////////////////////////////////////////////////////
// 以降の変数・定数はほとんどの場合、変更する必要はありません


define( "INSTALL_PATH", dirname(__FILE__) );		// インストールパス

// 以降は必要に応じて変更する

define( "PADDING_TIME", 180 );						// 詰め物時間
define( "DO_RECORD", INSTALL_PATH . "/do-record.sh" );		// レコードスクリプト
define( "COMPLETE_CMD", INSTALL_PATH . "/recomplete.php" );	// 録画終了コマンド
define( "GEN_THUMBNAIL", INSTALL_PATH . "/gen-thumbnail.sh" );	// サムネール生成スクリプト
define( "RECORDER_CMD", INSTALL_PATH . "/recorder.php" );

// BS/CSでEPGを取得するチャンネル
// 通常は変える必要はありません
// BSでepgdumpが頻繁に落ちる場合は、受信状態のいいチャンネルに変えることで
// 改善するかもしれません

define( "BS_EPG_CHANNEL",  "211"  );	// BS
#define( "CS1_EPG_CHANNEL", "CS10"  );	// CS1
define( "CS1_EPG_CHANNEL", "CS6"  );	// CS1
define( "CS2_EPG_CHANNEL", "CS12" );	// CS2

// 全国用BSデジタルチャンネルマップ
$BS_CHANNEL_MAP = array(
	"4101.epgdata.ontvjapan" => "101",
	"4103.epgdata.ontvjapan" => "103",
	"4141.epgdata.ontvjapan" => "141",
	"4151.epgdata.ontvjapan" => "151",
	"4161.epgdata.ontvjapan" => "161",
	"4171.epgdata.ontvjapan" => "171",
	"4181.epgdata.ontvjapan" => "181",
	"4191.epgdata.ontvjapan" => "191",
	"4192.epgdata.ontvjapan" => "192",
	"4193.epgdata.ontvjapan" => "193",
	"4200.epgdata.ontvjapan" => "200",
	"4201.epgdata.ontvjapan" => "201",
	"4202.epgdata.ontvjapan" => "202",
	"4211.epgdata.ontvjapan" => "211",
	"4222.epgdata.ontvjapan" => "222",
	"4231.epgdata.ontvjapan" => "231",
	"4232.epgdata.ontvjapan" => "232",
	"4233.epgdata.ontvjapan" => "233",
	"4234.epgdata.ontvjapan" => "234",
	"4236.epgdata.ontvjapan" => "236",
	"4238.epgdata.ontvjapan" => "238",
	"4241.epgdata.ontvjapan" => "241",
	"4242.epgdata.ontvjapan" => "242",
	"4243.epgdata.ontvjapan" => "243",
	"4244.epgdata.ontvjapan" => "244",
	"4245.epgdata.ontvjapan" => "245",
	"4251.epgdata.ontvjapan" => "251",
	"4252.epgdata.ontvjapan" => "252",
	"4255.epgdata.ontvjapan" => "255",
	"4256.epgdata.ontvjapan" => "256",
	"4258.epgdata.ontvjapan" => "258",
	"4291.epgdata.ontvjapan" => "291",
	"4292.epgdata.ontvjapan" => "292",
	"4294.epgdata.ontvjapan" => "294",
	"4295.epgdata.ontvjapan" => "295",
	"4296.epgdata.ontvjapan" => "296",
	"4297.epgdata.ontvjapan" => "297",
	"4298.epgdata.ontvjapan" => "298",
	"4531.epgdata.ontvjapan" => "531",
//	"4910.epgdata.ontvjapan" => "910",
);

if( USE_KUROBON ) {
	$BS_CHANNEL_MAP = array(
		"4101.epgdata.ontvjapan" => "B18",
		"4103.epgdata.ontvjapan" => "B19",
		"4141.epgdata.ontvjapan" => "B16",
		"4151.epgdata.ontvjapan" => "B1",
		"4161.epgdata.ontvjapan" => "B2",
		"4171.epgdata.ontvjapan" => "B3",
		"4181.epgdata.ontvjapan" => "B17",
		"4191.epgdata.ontvjapan" => "B4",
		"4192.epgdata.ontvjapan" => "B5",
		"4193.epgdata.ontvjapan" => "B6",
		"4200.epgdata.ontvjapan" => "B11",
		"4201.epgdata.ontvjapan" => "B7",
		"4202.epgdata.ontvjapan" => "B7",
		"4211.epgdata.ontvjapan" => "B10",
		"4222.epgdata.ontvjapan" => "B12",
		"4231.epgdata.ontvjapan" => "B15",
		"4232.epgdata.ontvjapan" => "B15",
		"4233.epgdata.ontvjapan" => "B15",
//		"4234.epgdata.ontvjapan" => "234",
		"4236.epgdata.ontvjapan" => "B8",
		"4238.epgdata.ontvjapan" => "B13",
		"4241.epgdata.ontvjapan" => "B22",
		"4242.epgdata.ontvjapan" => "B23",
		"4243.epgdata.ontvjapan" => "B23",
		"4244.epgdata.ontvjapan" => "B25",
		"4245.epgdata.ontvjapan" => "B26",
		"4251.epgdata.ontvjapan" => "B27",
		"4252.epgdata.ontvjapan" => "B24",
		"4255.epgdata.ontvjapan" => "B28",
		"4256.epgdata.ontvjapan" => "B9",
		"4258.epgdata.ontvjapan" => "B29",
		"4291.epgdata.ontvjapan" => "B20",
		"4292.epgdata.ontvjapan" => "B20",
		"4294.epgdata.ontvjapan" => "B21",
		"4295.epgdata.ontvjapan" => "B21",
		"4296.epgdata.ontvjapan" => "B21",
		"4297.epgdata.ontvjapan" => "B21",
		"4298.epgdata.ontvjapan" => "B20",
		"4531.epgdata.ontvjapan" => "B15",
		"4910.epgdata.ontvjapan" => "B19",
	);
}

// 全国用CSデジタルチャンネルマップ
$CS_CHANNEL_MAP = array(
  "2296.ontvjapan.com" => "CS2", // 296, // ＴＢＳチャンネル１
  "2298.ontvjapan.com" => "CS2", // 298, // テレ朝チャンネル１
  "2299.ontvjapan.com" => "CS2", // 299, // テレ朝チャンネル２
  "2100.ontvjapan.com" => "CS4", // 100, // スカパー！プロモ
  "2223.ontvjapan.com" => "CS4", // 223, // チャンネルＮＥＣＯ
  "2227.ontvjapan.com" => "CS4", // 227, // ザ・シネマ
  "2250.ontvjapan.com" => "CS4", // 250, // ｓｋｙ・Ａスポーツ＋
  "2342.ontvjapan.com" => "CS4", // 342, // ヒストリーチャンネル
  "2363.ontvjapan.com" => "CS4", // 363, // 囲碁・将棋チャンネル
  "2294.ontvjapan.com" => "CS6", // 294, // ホームドラマＣＨ
  "2323.ontvjapan.com" => "CS6", // 323, // ＭＴＶ　ＨＤ
  "2329.ontvjapan.com" => "CS6", // 329, // 歌謡ポップス
  "2340.ontvjapan.com" => "CS6", // 340, // ディスカバリー
  "2341.ontvjapan.com" => "CS6", // 341, // アニマルプラネット
  "2354.ontvjapan.com" => "CS6", // 354, // ＣＮＮｊ
  "255.ontvjapan.com" => "CS8", // 55, // ショップチャンネル
  "2218.ontvjapan.com" => "CS8", // 218, // 東映チャンネル
  "2219.ontvjapan.com" => "CS8", // 219, // 衛星劇場
  "2326.ontvjapan.com" => "CS8", // 326, // ミュージック・エア
  "2339.ontvjapan.com" => "CS8", // 339, // ディズニージュニア
  "2349.ontvjapan.com" => "CS8", // 349, // 日テレＮＥＷＳ２４
  "2800.ontvjapan.com" => "CS10", // 800, // スカチャン０
  "2801.ontvjapan.com" => "CS10", // 801, // スカチャン１
  "2802.ontvjapan.com" => "CS10", // 802, // スカチャン２
  "2805.ontvjapan.com" => "CS10", // 805, // スカチャン３
  "2254.ontvjapan.com" => "CS12", // 254, // ＧＡＯＲＡ
  "2325.ontvjapan.com" => "CS12", // 325, // エムオン！ＨＤ
  "2330.ontvjapan.com" => "CS12", // 330, // キッズステーション
  "2292.ontvjapan.com" => "CS14", // 292, // 時代劇専門ｃｈＨＤ
  "2293.ontvjapan.com" => "CS14", // 293, // ファミリー劇場ＨＤ
  "2310.ontvjapan.com" => "CS14", // 310, // スーパー！ドラマＨＤ
  "2290.ontvjapan.com" => "CS16", // 290, // ＳＫＹ　ＳＴＡＧＥ
  "2305.ontvjapan.com" => "CS16", // 305, // チャンネル銀河
  "2311.ontvjapan.com" => "CS16", // 311, // ＡＸＮ
  "2333.ontvjapan.com" => "CS16", // 333, // ＡＴ－Ｘ
  "2343.ontvjapan.com" => "CS16", // 343, // ナショジオチャンネル
  "2353.ontvjapan.com" => "CS16", // 353, // ＢＢＣワールド
  "2240.ontvjapan.com" => "CS18", // 240, // ムービープラスＨＤ
  "2262.ontvjapan.com" => "CS18", // 262, // ゴルフネットＨＤ
  "2314.ontvjapan.com" => "CS18", // 314, // 女性ｃｈ／ＬａＬａ
  "2307.ontvjapan.com" => "CS20", // 307, // フジテレビＯＮＥ
  "2308.ontvjapan.com" => "CS20", // 308, // フジテレビＴＷＯ
  "2309.ontvjapan.com" => "CS20", // 309, // フジテレビＮＥＸＴ
  "2161.ontvjapan.com" => "CS22", // 161, // ＱＶＣ
  "2297.ontvjapan.com" => "CS22", // 297, // ＴＢＳチャンネル２
  "2312.ontvjapan.com" => "CS22", // 312, // ＦＯＸ
  "2322.ontvjapan.com" => "CS22", // 322, // スペースシャワーＴＶ
  "2331.ontvjapan.com" => "CS22", // 331, // カートゥーン
  "2351.ontvjapan.com" => "CS22", // 351, // ＴＢＳニュースバード
  "2229.ontvjapan.com" => "CS24", // 229, // ＦＯＸムービー
  "2257.ontvjapan.com" => "CS24", // 257, // 日テレＧ＋　ＨＤ
  "2300.ontvjapan.com" => "CS24", // 300, // 日テレプラス
  "2321.ontvjapan.com" => "CS24", // 321, // スペシャプラス
  "2362.ontvjapan.com" => "CS24", // 362, // 旅チャンネル
);


// 地上デジタルチャンネルテーブルsettings/gr_channel.phpが存在するならそれを
// 優先する
if( file_exists( INSTALL_PATH."/settings/gr_channel.php" ) ) {
	unset($GR_CHANNEL_MAP);
	include_once( INSTALL_PATH."/settings/gr_channel.php" );
}

//
// settings/site_conf.phpがあればそれを優先する
//
if( file_exists( INSTALL_PATH."/settings/site_conf.php" ) ) {
	unset($GR_CHANNEL_MAP);
	unset($RECORD_MODE);
	include_once( INSTALL_PATH."/settings/site_conf.php" );
}

// Deprecated
// カスタマイズした設定をロードし、デフォルト設定をオーバライドする
// unsetはカスタム設定ファイルの責任で行う
if( file_exists( INSTALL_PATH."/settings/config_custom.php" ) ) {
	include_once( INSTALL_PATH."/settings/config_custom.php" );
}


// DBテーブル情報　以下は変更しないでください

define( "RESERVE_TBL",  "reserveTbl" );						// 予約テーブル
define( "PROGRAM_TBL",  "programTbl" );						// 番組表
define( "CHANNEL_TBL",  "channelTbl" );						// チャンネルテーブル
define( "CATEGORY_TBL", "categoryTbl" );					// カテゴリテーブル
define( "KEYWORD_TBL", "keywordTbl" );						// キーワードテーブル
// ログテーブル
define( "LOG_TBL", "logTbl" );
?>
