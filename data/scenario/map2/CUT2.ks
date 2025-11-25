

; plc=place(場所)
[eval exp="tf.plc='f201_01_01_mac'" ]

; ズラし
[eval exp="tf.os = 0"]


; ◆◆左上エリア(X1-15,Y1-8)＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝


    ; ◆略(制作中)

        ; 左柱
        [AutoPut pct="pillar12y.png" x="0"  y="0" c="t"]
        ; 右柱
        [AutoPut pct="pillar12y.png" x="10" y="0"  c="t"]


; ◆◆右上エリア(X16-29,Y1-8)＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

    ; 左柱
    [AutoPut pct="pillar12y.png" x="19" y="0"  c="t"]

    ; ◆包装マシーン3(X16-18,Y0-1)

        [AutoPut pct="machine_S.png" x="16.5" y="0" c="t"]

    ; ◆ベルトコンベア1周辺(X18-22,Y2-4)

        ; 人物
        [AutoNPC dic="b" name="mob1"  x="20.5" y="&tf.os+3.5"]
        ; コンテナ
        [AutoCont n="1" color="OR" x="21" y="3.5" t=""]
        ; 機械
        [AutoPut pct="machine_L0.png" x="17" y="3.5" c="t" t=""]
        [AutoPut pct="machine_L1.png" x="17" y="&tf.os+2" c="t" layer="1"]

    ; ◆作用テーブル1(X23-26,Y2-4)
        
        [AutoZPut pct="table42" c="t" x="23" y="1.5"]

    ; ◆ベルトコンベア2周辺(X18-22,Y5-7)

        ; コンテナ
        [AutoCont n="1" color="OR" x="21" y="6.5" t=""]
        ; 機械
        [AutoPut pct="machine_L0.png" x="17" y="6.5" c="t" t=""]
        [AutoPut pct="machine_L1.png" x="17" y="&tf.os+5" c="t" layer="1"]
        ; 人物
        [AutoNPC dic="t" name="Slicer-F"   x="19.5" y="&tf.os+7.5"]


    ; ◆作用テーブル2(X23-26,Y6-8)

        [AutoZPut pct="table42" c="t" x="23" y="5.5"]


; ◆◆左下エリア(X1-15,Y9-15)＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

        ; ◆省略(未実装)

        ; ◆柱

            [AutoPut pct="pillar12y.png" x="0"  y="12" c="t" t="r" layer="1"]
            [AutoPut pct="pillar12y.png" x="10" y="12"  c="t" t="r" layer="1"]

; ◆◆右下エリア(X16-29,Y9-15)＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

    ; ◆柱
        [AutoPut pct="pillar12y.png" x="19" y="12"  c="t" t="r" layer="1"]

    ; ◆通行止め

        [AutoPut pct="cross.gif" x="18" y="11" c="t" layer="0"]
        [AutoPut pct="cross.gif" x="18" y="12" c="t" layer="0"]
        [AutoPut pct="cross.gif" x="18" y="13" c="t" layer="0"]
        [AutoPut pct="cross.gif" x="18" y="14" c="t" layer="0"]

    ; ◆ベルトコンベア3周辺(X18-22,Y8-10)

        ; コンテナ
        [AutoCont n="1" color="OR" x="21" y="9.5" t=""]
        ; 機械
        [AutoPut pct="machine_L0.png" x="17" y="9.5" c="t" t=""]
        [AutoPut pct="machine_L1.png" x="17" y="&tf.os+8" c="t" layer="1"]
        ; 人物
        [AutoNPC dic="t" name="Cutter-F"   x="19.5" y="&tf.os+10.5"]


    ; ◆次のマップ周り

        ; マップ移動
        [AutoPut layer="0" pct="ex_floor_conc11.png" x="23" y="15" c="t" t="u" name="exroad"]
        [AutoPut layer="0" pct="ex_floor_conc11.png" x="24" y="15" c="t" t="u" name="exroad2"]
        ; アニメーション
        [AutoPut pct="arrow_anim_D.gif" x="23.5" y="15"  c="t" t="u" layer="0"]


; 退室時ONイベント
[SetEvent EventType="2" x="23" y="14" w="2" h="1" type="contact" id="採点カット室"]

[SetEvent EventType="2" x="23" y="15" w="2" h="1" type="mapMove" id="カット室to計量室"]

[return]


レーンが素通りできる
コンテナが素通りできる

ベルトコンベア3つのY座標を0.5ズラす。
レーンは進行不可にする。