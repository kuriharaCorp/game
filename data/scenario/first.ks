;一番最初に呼び出されるファイル

[title name="クリハラのゲーム"]

[stop_keyconfig]


;ティラノスクリプトが標準で用意している便利なライブラリ群
;コンフィグ、CG、回想モードを使う場合は必須
@call storage="tyrano.ks"

;ゲームで必ず必要な初期化処理はこのファイルに記述するのがオススメ

;CSV読込プラグイン(https://memocho.no-tenki.me/tyrano/archives/33)
[plugin name="mc_loadcsv"]

; @jump storage="test_cameraworld.ks"

; @jump storage="mcr/test_test.ks"


;メッセージボックスは非表示
@layopt layer="message" visible=false

;最初は右下のメニューボタンを非表示にする
[hidemenubutton]


;基本動作まとめマクロ
; @call storage="mcr/bsc.ks"

;共通JSfunction読み込み
; @loadjs storage="../scenario/js/style.js"


;オリジナルタグてすと(使ってない)
[loadjs storage="orizinal.js"]




;仮テスト
;@jump storage="map/maptemplate.ks" 

;タイトル画面へ移動
;@jump storage="testalpha.ks"

; [s ]
;@jump storage="evt/mngm/mvsp.ks"
;@jump storage="marge1t.ks"
;@jump storage="title.ks"
@eval exp="tf.count=0"


;[dialog text="音が鳴ります。ご注意ください。"]
[call storage="soundtrack.ks" ]

;編集中は音が出ないようにしておく
;///////////////////////////
[bgmopt volume="100"]
[seopt volume="100"]
;///////////////////////////


; 基本マクロ呼出
[loadjs storage="../scenario/js/bsc.js"]
[call storage="mcr/bscv2.ks" ]



; @jump storage="credit01.ks"

; @jump storage="testfile.ks" 
@jump storage="titlever2.ks"
[s]


