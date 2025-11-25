; v2用にv1から移植

    ;ADVモードの時の共通コード
    [macro name="iadv"]
    ;名前欄を空欄にしておく
    #
    ;ボタン非表示
        [clearfix ]
    ; モード選択
        [eval exp="tf.mode = mp.mode == 1 ? 1:0; "]

        [adv mode="&tf.mode"]
        [cm]
        ;十字ボタンを無効化
        ; ※KA自体は必要ないが、ボタンの無効化位置として残している
        ; [KA s="OFF"]
        [chara_config talk_focus="brightness"]
    [endmacro ]

    [macro name="adv"]
        ; 移動処理をキャンセル
        [eval exp="f.isProcessing = true"]
        
        ;ADV表示の準備------------------------------

        ;メッセージウィンドウの表示
        ; @layopt layer=message0 visible=true
        [ChangeWindow mode="&mp.mode"]

        ;---------------------------------------------------

    [endmacro]

    ;文字色変更
    [macro name="<imp"]
    ;重要な内容
    [font size="32" color="yellow" bold="true" edge="4px black" edge_method="filter"]
    [endmacro ]

    [macro name="<mid"]
    ;ちょっと重要
    [font size="28" color="blue" bold="true" edge="2px white" edge_method="filter"]
    [endmacro]

    [macro name=">""]
    ;変更したフォントを基に戻す
        [resetfont ]
    [endmacro]

    ; ＝＝＝＝＝＝＝＝＝＝＝＝＝＝
    ; ここまで旧BSC


    ;キャラ立ち位置
    [macro name="show"]
        @eval exp="(mp.side=='R')?mp.left=eval(1280-500):mp.left=0;"
        [chara_show name="&mp.name" layer="2" zindex="99" face="%face|default"  left="&mp.left" top="&720-700" time="%time|500"]
    [endmacro]


    [macro name="destroy"]
        [cm  ]
        [clearfix]

        [freeimage layer="base"]
        [freeimage layer="0"]
        [freeimage layer="1"]
        [freeimage layer="2"]
        [layopt layer=message0 visible=false]
        [chara_hide_all time="50"]
        ;shiftキーを強制的に外す
        ; Shiftを押しながら部屋移動すると押し続ける動作になる不具合解消用
        [eval exp="isFunctionEnabled = false;"]

    [endmacro ]

    [macro name="noenter"]

        [iadv]

            #
            不思議な力で押し戻される…！[p]

        [endadv]

        [mask time="50" color="white"  ]

            ; // 直前に入力された方向と逆方向を入れる(Right,Left,Top,Down)
            [iscript ]
                const oppositeMap = {
                Right: "Left",
                Left: "Right",
                Up: "Down",
                Down: "Up"
                };

                tf.oppositeDirection = oppositeMap[tf.lastDirection];

            [endscript ]
            [move dir="&tf.oppositeDirection"]

        [mask_off time="50"]

    [endmacro]


    ; dialog表示後0.5秒後に1ボタンを押したことにしてカーソルを合わせる
    ; setupFlow => bsc.js
    [macro name="dialogS"]

        [eval exp="setupFlow(mp.text);"]
        [p]

    [endmacro]

    ; [dialogS text="自動化テスト"]


    ; 通常のウィンドウ(message0設定)
        ;メッセージウィンドウの設定
        [position layer="message0" left=160 top=500 width=1000 height=200 page=fore visible=false]
        [current layer="message0" ]

        ;文字が表示される領域を調整
        [position layer="message0" page=fore margint="45" marginl="50" marginr="70" marginb="60"]

        ;キャラクターの名前が表示される文字領域
        [ptext name="chara_name_area" layer="message0" color="white" size=28 bold=true x=180 y=510]

        ;上記で定義した領域がキャラクターの名前表示であることを宣言（これがないと#の部分でエラーになります）
        [chara_config ptext="chara_name_area"]

        ; ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝


    ; メッセージウィンドウの切り替え用マクロ
    [macro name="ChangeWindow"]
        
        [if exp="mp.mode == 1"]
            ; 切り替え(0->1)
                    [trace exp="'現在のモード：1'"]

                ; モブ用などのウィンドウ(message1設定)
                    ;mob専用メッセージレイヤーの設定
                    [position layer="message1" left=160 top=500 width=1000 height=200 marginl="50" page=fore visible=false]
                    ;※marginはpositionを設定する度リセットされるのでそのたび入れなおす
                    ;文字が表示される領域を調整（message1）
                    [position layer="message1" page=fore margint="15" marginl="20" marginr="20" marginb="20"]

                    [fuki_chara name="others" left="&tf.l" top="&tf.t" sippo="top" max_width=500 fix_width=500 radius=100 color="0xccc"]

                    ; 枠大きさが変化するので再定義
                    [position layer="message1" page=fore margint="15" marginl="20" marginr="20" marginb="20"]
                    [font shadow="0x000000"]
            
                [current layer="message1"]
                @layopt layer=message1 visible=true
                @layopt layer=message0 visible=false
            [else]
            ; 切り替え(1->0)
                    [trace exp="'現在のモード：0'"]
                ; 通常のウィンドウ(message0設定)
                    ;メッセージウィンドウの設定
                    [position layer="message0" left=160 top=500 width=1000 height=200 page=fore visible=false]

                    ;文字が表示される領域を調整
                    [position layer="message0" page=fore margint="45" marginl="50" marginr="70" marginb="60"]

                [current layer="message0"]
                @layopt layer=message0 visible=true
                @layopt layer=message1 visible=false

        [endif]

    [endmacro]



[return]

[s ]

; イベントから戻るとき、
; [destroy]して
; [renew name="&f.mpnm"]
; で再構成してる。