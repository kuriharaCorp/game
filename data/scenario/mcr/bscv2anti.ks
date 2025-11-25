; v2の追加マクロを打ち消すマクロ

[macro name="anti_iadv"]

    ; ボタンを表示
        ; [初期に表示させるボタンを表示するマクロを入れる]
    [crbtn]
    ; [glink text="MENU" target="*gotitle2" x="&1280-300" y="0" color="btn_01_white" cond="f.dbg"] 
    ; [glink text="リスポーン" target="*reset" x="&1280-200" y="0" color="btn_01_red"]
    
    ; 部屋初めのイベントのみ対応(xy=0なので)=falseのとき起動しないなのでこれで正解。
    [ignore exp="f.autoEvt[tf.scName]"]
        ; 部屋の名前を表示+横へ   
        [ptext name="roomname" layer="2" align="center" x="&1280/2-500/2" y="&720/2-100" text="&f.roomtitle" size="72" width="500" overwrite="true" time="200" bold="true" edge="4px 0x000000, 2px 0xFFFFFF"]
        [anim name="roomname" time="500" width="100" left="&1280-100" top="0" opacity="100" effect="easeInSine"]
        [wa]

        ; カメラを初期化
        [camera x=0 y=0 zoom=1.05 layer="0"  time="500" wait="false" ease_type="ease-in-out"]
        [camera x=0 y=0 zoom=1.05 layer="1"  time="500" wait="true" ease_type="ease-in-out"]
        ; [wait time="500"]
        [camera x=0 y=0 zoom=1 layer="0"  time="1000" wait="false" ease_type="ease"]
        [camera x=0 y=0 zoom=1 layer="1"  time="1000" wait="true" ease_type="ease"]
        [wait time="50"]

        ; [reset_camera time="50"]
    [endignore]
    
    ; 会話強調を初期化
    [chara_config talk_focus="none"]

[endmacro]

[macro name="arbtn" ]
    [button name="%name" graphic="%gra" x="%x" y="%y" width="&f.btnsz" height="&f.btnsz" fix="true"   ]
[endmacro ]
[macro name="crbtn" ]
    [eval exp="f.btnTx = 100 ,f.btnTy = 400" cond="f.Placebtn === 'Left' || f.Placebtn === undefined"]  
    [eval exp="f.btnTx = 1000 ,f.btnTy = 400" cond="f.Placebtn === 'Right'"]  
    [arbtn name="arT,ar" gra="arTa.png" x="&f.btnTx+0    "   y="&f.btnTy+0    "]
    [arbtn name="arR,ar" gra="arRa.png" x="&f.btnTx+90   "   y="&f.btnTy+90   "]
    [arbtn name="arB,ar" gra="arBa.png" x="&f.btnTx+0    "   y="&f.btnTy+90+90"]
    [arbtn name="arL,ar" gra="arLa.png" x="&f.btnTx-90   "   y="&f.btnTy+90   "]
    ; Enter
    [arbtn name="ent,ar" gra="c_seta.png" x="&f.btnTx+0   "  y="&f.btnTy+90   "]
    ; ボタン位置左右変更ボタン
    [arbtn name="movR,ar" cond="f.Placebtn === 'Left' || f.Placebtn === undefined" gra="config/arrow_next.png" x="&f.btnTx+90" y="&f.btnTy+90+90"]
    [arbtn name="movL,ar" cond="f.Placebtn === 'Right'"  gra="config/arrow_prev.png" x="&f.btnTx-90" y="&f.btnTy+90+90"]

    ; 画像ボタンに矢印キーの役割を毎回与える(画像表示後有効)
    [eval exp="ImgBtnTrance()"]
[endmacro ]

[macro name="endadv"]
;メッセージウィンドウ削除&ボタン再表示
    [layopt layer="message0" visible="false" ]
    [layopt layer="message1" visible="false" ]

; キャラクターが出ていたらしまう
    [chara_hide_all layer="2" time="200"]

    [anti_iadv]

    ; 処理中というブロック処理を解除
    ; [eval exp="f.isProcessing = false"]
    ; この後にBGM再生が挟まるので無効


    ;十字ボタン有効化(規格が変わったので後で変更)
    ; [KA]
    ; [fadeoutbgm ]
[endmacro ]

; ＝＝＝＝＝＝＝＝＝＝＝＝＝＝

[macro name="anti_noenter"]



[endmacro]

[return ]

[s ]

/*
テキストメモ

イベントの分析

1. イベントが始まる
2. ADVモードに変更
3. Showでキャラの立ち位置を調整
4. キャラが話す->選択肢あり
5. 選択肢の時キャラは消したりできる
6. 選択肢のあと、変数のみ変化、
7. ADVモード解除
8. 元の位置に戻る

変更

A ポイントに来ると停止
B 条件を言い渡される
B-1 その方向にキャラが向く
1 条件を満たす
条件を満たす場合、AがCに変化
2 条件を満たさない -> Aループ
C 停止を解除

*/