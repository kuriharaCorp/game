; 第二工場前室のイベント内容


; もしautoを処理していない状態で以下のマクロが発火するとこれが発火するので注意
[if exp="!f.autoEvt[tf.scName]"]
    [iadv]

        ; 1回画面外に出て着替えるモーションを加える

        ; なぜか消えてるので再登録
        [chara_face name="pl" face="suit" storage="chara/hara0.png"]

        [show name="pl" face="suit" side="R" time="50"]
        [wa]
        [wait time="500"]
        [anim name="pl" top="+=720" time="400" effect="easeInQuint" ]
        [wa]

        ; くるくるして立ち絵が変わるみたいなのやりたい

        [eval exp="f.Issuit = false;"]
        [chara_part name="player" move="stop_r"]

        [chara_mod name="pl" face="default"]
        [wa]

        [se nm="eye"]
        [bgm nm="talk"]
        
        [wait time="500"]
        [anim name="pl" top="-=720" time="1000" effect="easeInOutBounce" ]
        [wa]


        ; [show name="pl" side="R"]
                ; [show name="pl" face="suit" side="R"]

        ; @eval exp="(mp.side=='R')?mp.left=eval(1280-500):mp.left=0;"

        ; [chara_show name="pl" layer="2" zindex="99" face="suit"  left="&mp.left" top="&720-700" time="500"]


        #pl
        さっそく工場の白衣に着替えてきたよ。楽しみだね！[p]
        [show name="kuri"]
        #マロン
        そうだね。[p ]
        [se nm="imp"]
        今日の工場見学は、[<imp]社員さんに話を聞いてきてもらう[>]よ。[p ]
        [se nm="imp"]
        [<imp]緑の帽子をかぶった人[>]が社員さんなんだって。[p ]
        各部屋に社員さんがいるから、話しかけてみてね。[p ]
        [se nm="imp"]
        #◇ゲームの目的◇
        各部屋にいる緑色の帽子の人から話を聞いていきましょう。[r]
        話しかけるには、その人の近くでその方向でボタン(Enter)を押します。[p]
        #pl
        はーい！わかりました。[l][r]
        どんな工程があるのか聞けるといいな！[p]
        #マロン
        それじゃあいったん解散！また会おう！[p]
        [chara_hide_all layer="1"]
        [bgm nm="evt"]
        #案内人
        それでは「惣菜キット」を作る工程を一緒に見ていきましょう[p]
        [image layer="1" name="photo"  storage="../image/process/p1cab.jpg" pos="c" time="500" ]
        これからめぐるお部屋でこのキャベツがどのように加工されていくのかよく覚えておいてくださいね[p]
        [free layer="1" name="photo"  time="500" ]
        #
    [endadv]
; @eval exp="f.fstAnt=true"

@eval exp="f.autoEvt[tf.scName]=true";

[endif]
; [return ]
; [s ]

[if exp="tf.contact.id == 'とるミングチェック'"]

    ; [dialog text="とるミングイベントが発火しました。"]

    [chara_new name="mbg" jname="社員さん" storage="chara/mon0.png"]

    ; すでにトリミングを見ている場合は発火しない
    [ignore exp="f.istoruming" ]
        [iadv ]

            [show name="mbg"]
            #社員さん
            ちょっと待って！[p]
            ここから先は衣服の埃や髪の毛を取ってから進んでください。[r]
            そこにある『取るミング』を使ってね[p]

            ; 選択肢表示準備
            #
            動画を見て『取るミング』をしよう。[p]
            [chara_hide name="mbg" wait="true" left="0" top="&720-700"]

            #社員さん
            使わないならここは通せないな。[p]

        [endadv ]

        @eval exp="tf.nxjump=''"
        ; 1マス戻る
        [noenter]

    [endignore ]

[endif]

; 退室時ONイベント
; [checkstudy next="カット室" c="&f.score.trm" cond="tf.contact.id == '採点トリミング室'"]

; 話しかけたときの会話内容
[if exp="tf.push.id == '方向転換'+'tutorial-F'"]
    [iadv ]

        [show name="mbg"]

        #mbg
        そうそう、私みたいな人が「緑の帽子の人」ですよ。[p]
        [se nm="imp"]
        今から選択肢が出るからね。[r]文字クリックかキーの1or2を押してエンターだよ。[p]

        [QuesAndAnswer category="ante2" item="tutorial" name="mbg"]
    ; [endif ]

[endif]

; [QuesAndAnswer category="trm" item="Cabbage" name="mbw" cond="tf.push.id == '方向転換'+'Cabbage-F'"]

; ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝



; イベントを初期化
[eval exp="tf.contact='done'"]

; イベント終了変数処理
[wait time="100"]
[eval exp="f.isEventRunning=false"]
[jump storage="test_cameraworld.ks" target="*end_load"]
[s ]
