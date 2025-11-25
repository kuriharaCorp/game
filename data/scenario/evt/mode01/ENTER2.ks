; イベントのコンスタンスのテスト
/*
        [chara_new name="pl" jname="&f.playername" storage="chara/hara1.png"]
        [chara_face name="pl" face="suit" storage="chara/hara0.png"]
        [chara_new name="kuri" jname="マロン" storage="chara/kuri1.png"]
        [chara_face name="kuri" face="suit" storage="chara/kuri0.png"]

*/

; 例えば置物のポイントを指定するとそこにカメラが向くようになるとか

; ポイント1に注目(次に向かう目標)
; [camera x="&0-80*4" zoom="1"]
; [wait time="500"]

; ; それらが現在位置からどのくらいのところにあるのか、自身まで持ってくる。
; [camera x="0"]
; [wait time="500"]

; ; ステージ開始は必ず0.0から。

; ; ADV会話演出用にカメラを引く
; [camera zoom="0.8" x="0" y="0"]



[if exp="!f.autoEvt[tf.scName]"]

            [iadv]
            [bgm nm="talk"]
            [chara_config pos_mode="false" ]
            [show name="kuri" face="suit"]
            #マロン
            こんにちは！[<mid]工場見学隊のマロン[>]です！[l][r]
            今日はクリハラの工場内を探検しましょう。頑張りましょうね！[p]
            /*
                ここで名前入力
            */

            [edit left="600" top="200" name="f.playername" initial="あなた" maxchars="6"]
            [show name="pl" face="suit" side="R"]

            [glink color="btn_01_red" text="あなたの名前を決定→" target=next x=600 y=300 cm=false clickse="btn4.mp3"]
            [s]

            *next
            [commit name="f.playername"]
            [cm]
            ; //PLの名前を反映させるにはここで新規登録が必要
            [chara_new name="pl" jname="&f.playername" storage="chara/hara1.png"]



            [show name="pl" face="suit" side="R"]
            #pl
            はーい！[p]
            ;[l]同じく[<mid][emb exp="f.playername"][>]です！[p]
            #案内人
            それではみなさん、2Fの更衣室で白衣に着替えてください[p]
            ; [se nm="imp"]
            ; [image name="keyboard" layer="1" folder="image/tutorial" storage="keyboard.png" width="400" left="&1280/2-200" top="0" ]
            ; #◇操作説明◇
            ; 画面左下の十字ボタンをクリック、あるいはキーボードの十字キーで[<mid][emb exp="f.playername"][>]を動かすことができます。[p]
            ; [<imp]Shiftキーを押しながら十字キーを長押し[>]で少し早く動けます。[p]
            ; [free name="keyboard" layer="1" time="2000"]
            さっそく階段へ移動しましょう![p]

            [se nm="imp"]
            #pl
            [<imp]階段を上って更衣室で着替える[>]だったね。[l ]よし、行こう![p]
            @eval exp="f.isevt_fst=true"
            /*
            [mask time="1000" ]
            [fadeoutbgm]
            [wait time="1000" ]
            */

        [endadv]
    ;@eval exp="f.fstAnt=true"
    @eval exp="f.autoEvt[tf.scName]=true"
[endif]

; ADVカメラ演出終了時に元に戻して操作させる
; [camera zoom="1" x="0" y="0" ]

; 別イベントを入れる場合は消す
[return]


; 別のイベントを入れる場合は必要。入れない場合は不必要＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
; ; イベントを初期化
; [eval exp="tf.contact='done'"]

; ; イベント終了変数処理
; [wait time="100"]
; [eval exp="f.isEventRunning=false"]
; [eval exp="f.isProcessing=false"]
; ; [jump storage="test_cameraworld.ks" target="*end_load"]
; ; [s ]
