

; plc=place(場所)
[eval exp="tf.plc='f101_20_01_set'" ]


; ◆◆上エリア(X1-10,Y1-9)＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝


    ; ◆柱左
        [AutoPut pct="pillar12y.png" x="1"  y="-1" c="t" layer="0"]

    ; ◆カット野菜仕分け場(X3-7,Y0-2)
        [AutoPut pct="obj_shelf_d.png" x="3" y="0"  t="" layer="0"]
        [AutoPut pct="container1_BL.png" x="3" y="1" c="t" t="d" layer="0"]
        [AutoPut pct="container1_OR.png" x="4" y="1" c="t" t="d" layer="0"]
        [AutoPut pct="container1_BL.png" x="5" y="1" c="t" t="d" layer="0"]
        [AutoPut pct="container1_OR.png" x="6" y="1" c="t" t="d" layer="0"]
        ; 人物配置
        [AutoNPC dic="t" name="mob1" x="4" y="2"]

    ; ◆柱右
        [AutoPut pct="pillar12y.png" x="11" y="-1"  c="t" layer="0"]

    ; ◆備品棚(X9-10,Y4-9)
        [AutoPut pct="obj_shelf_l.png" x="9.5" y="4"  t="u" layer="1"]

    ; ◆封鎖
        [AutoPut pct="cross.gif" x="1" y="6" c="t" layer="0"]
        [AutoPut pct="cross.gif" x="1" y="7" c="t" layer="0"]
        [AutoPut pct="cross.gif" x="1" y="8" c="t" layer="0"]



; ◆◆中央エリア(X1-10,Y10-14)＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝


    ; ◆作業台周り(X4-8,Y10-14)
        [AutoNPC dic="r" name="Fridge-F" x="5" y="11"]
        [AutoNPC dic="l" name="mob2" x="8" y="12"]
        [AutoZPut pct="table23" c="t" t="u" x="6" y="10"]
        
        [AutoPut pct="Obj_table23D.png" x="6" y="10" c="t" layer="1"]

    ; ◆生産準備室封鎖周り(X11,Y11-12)
        ; 封鎖
        [AutoPut pct="cross.gif" x="11" y="11" c="t" layer="0"]
        [AutoPut pct="cross.gif" x="11" y="12" c="t" layer="0"]


; ◆◆下エリア(X1-10,Y15-25)＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝


    ; ◆コンテナ集(X1-2,Y15-22)
        [AutoCont n="2" color="OR" x="1" y="17" t="" t0="r"]
        [AutoCont n="1" color="OR" x="1.5" y="17.0" t="" layer="0"]
        [AutoCont n="2" color="OR" x="1" y="18.5" t="" t0="r"]

        [AutoCont n="3" color="OR" x="1" y="19" t="" t0="r"]
        [AutoCont n="2" color="OR" x="1.5" y="20" t="" layer="0"]
        [AutoCont n="3" color="OR" x="1" y="20" t="" t0="r"]

        [AutoCont n="5" color="OR" x="1" y="22" t="" t0="r"]
        [AutoCont n="3" color="OR" x="1.5" y="23" t="" layer="0"]
        [AutoCont n="5" color="OR" x="1" y="24" t="" ]


    ; ◆作業台周り(X6-9,Y17-21)
        [AutoNPC dic="b" name="mob3" x="8.5" y="17"]
        [AutoNPC dic="r" name="Forage-F" x="6" y="18"]
        [AutoNPC dic="l" name="mob4" x="8.5" y="19"]
        [AutoZPut pct="table23" c="t" t="u" x="7" y="17"]
        
        [AutoPut pct="Obj_table23D.png" x="7" y="17" c="t" layer="1"]

        [AutoNPC dic="t" name="mob5" x="7" y="21  "]

    ; ◆右コンテナ集(X10,Y22-24)

    ; ◆次のマップ周り(X2-6,Y22)
        [AutoPut pct="room_set.png" x="0" y="23"  t="u" layer="1"]
        ; マップ移動
        [AutoPut layer="0" pct="ex_floor_conc11.png" x="2" y="25" c="t" t="u" name="exroad"]
        [AutoPut layer="0" pct="ex_floor_conc11.png" x="3" y="25" c="t" t="u" name="exroad2"]
        [AutoPut layer="0" pct="ex_floor_conc11.png" x="4" y="25" c="t" t="u" name="exroad3"]
        [AutoPut layer="0" pct="ex_floor_conc11.png" x="5" y="25" c="t" t="u" name="exroad4"]
        ; アニメーション
        [AutoPut pct="arrow_anim_D.gif" x="2" y="22"  c="t" t="u" layer="0"]
        [AutoPut pct="arrow_anim_D.gif" x="3" y="22"  c="t" t="u" layer="0"]
        [AutoPut pct="arrow_anim_D.gif" x="4" y="22"  c="t" t="u" layer="0"]
        [AutoPut pct="arrow_anim_D.gif" x="5" y="22"  c="t" t="u" layer="0"]
        ; 壁の裏で見えないけどある
        [AutoPut pct="arrow_anim_L.gif" x="6" y="23"  c="t" t="u" layer="0"]

    ; ◆柱
        [AutoPut pct="pillar12y.png" x="0" y="23"  t="u" layer="1"]



; ; アニメーション
; [AutoPut pct="arrow_anim_D.gif" x="3" y="25"  c="t" t="u" layer="0"]
; [AutoPut pct="arrow_anim_D.gif" x="4" y="25"  c="t" t="u" layer="0"]

; [SetEvent EventType="2" x="2" y="25" w="4" h="1" type="mapMove" id="セット準備室toセット室"]


; 退室時ONイベント

[SetEvent EventType="2" x="2" y="22" w="4" h="1" type="contact" id="採点セット準備室"]
[SetEvent EventType="2" x="6" y="23" w="1" h="1" type="contact" id="採点セット準備室2"]

[SetEvent EventType="2" x="2" y="23" w="4" h="1" type="mapMove" id="セット準備室toセット室"]



[return]


作業台の上に何か置いてほしい
カット野菜仕分け場に進入できる