

; plc=place(場所)
[eval exp="tf.plc='f101_12_25_wap'" ]



; ◆◆左上エリア(X1-12,Y1-10)＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

    ; ◆通行止め(X5-10,Y4-8)
        ; ; 道をふさぐ段ボール群
        ; [AutoCont n="5" color="DN" x="5" y="5" t="u" c="t"]
        ; [AutoCont n="5" color="DN" x="7" y="4.5" t="u" c="t"]
        ; [AutoCont n="5" color="DN" x="9" y="5" t="d" c="t"]
        ; [AutoCont n="5" color="DN" x="10" y="8" t="u" c="t"]
        ; 封鎖
        [AutoPut pct="cross.gif" x="0" y="7" c="t" layer="0"]
        [AutoPut pct="cross.gif" x="0" y="8" c="t" layer="0"]

    ; ◆仕切り(X1-8,Y8-9)
        [AutoPut pct="obj_cartain_D.png" x="1" y="8.5" layer="0"]

    ; ◆真空パックマシン(X5-6,Y9-10)
        [AutoPut pct="machineB.png" c="t" x="5" y="9" layer="0"]


; ◆◆右上エリア(X13-31,Y1-10)＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝


    ; ◆パッキングマシン1周辺(X16-20,Y2-4)
        ; 作業台周辺
        [AutoZPut pct="table22" c="t" t="u" x="16" y="2"]
        [AutoCont n="1" color="DN" x="16" y="2" t="u"]
        ; マシン
        ; [AutoPut pct="obj_machineS_T.png" t="u" x="18" y="2" layer="0"]
        [AutoZPut pct="obj_machineS_" t="u" x="18" y="2"]

    ; ◆冷凍庫1(X24-31,Y3-7)
        ; 封鎖
        [AutoPut pct="cross.gif" x="24" y="6" c="t" layer="0"]
        [AutoZPut pct="room_freeze1_" t="d" x="24.5" y="2.5"]

    ; ◆通行止め周辺(X21-25,Y7-9)
        ; 道をふさぐコンテナ群
        [AutoCont n="3" color="OR" x="22" y="8" t="u" c="t"]
        [AutoCont n="2" color="OR" x="21.5" y="9" t="u" c="t"]
        [AutoCont n="2" color="OR" x="22" y="9.5" t="d" c="t"]
        [AutoCont n="3" color="OR" x="23" y="9" t="u" c="t"]
        [AutoCont n="2" color="OR" x="24" y="9" t="d" c="t"]
        ; 封鎖
        [AutoPut pct="cross.gif" x="25" y="8" c="t" layer="0"]
        [AutoPut pct="cross.gif" x="25" y="9" c="t" layer="0"]
        [AutoPut pct="cross.gif" x="25" y="10" c="t" layer="0"]
        ; 人物配置
        [AutoNPC dic="r" name="mob1" x="21" y="9"]

    ; ◆次のマップ周り(X20-21,Y1)
        ; マップ移動
        [AutoPut layer="0" pct="ex_floor_conc11.png" x="20" y="0" c="t" t="u" name="exroad"]
        [AutoPut layer="0" pct="ex_floor_conc11.png" x="21" y="0" c="t" t="u" name="exroad2"]
        ; アニメーション
        [AutoPut pct="arrow_anim_T.gif" x="20.5" y="0"  c="t" t="u" layer="0"]
        [AutoPut pct="arrow_anim_T.gif" x="20.5" y="1"  c="t" t="u" layer="0"]


; ◆◆左下エリア(X1-12,Y11-20)＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝


        ; 封鎖
        [AutoPut pct="cross.gif" x="0" y="12" c="t" layer="0"]
        [AutoPut pct="cross.gif" x="0" y="13" c="t" layer="0"]
        [AutoPut pct="cross.gif" x="0" y="14" c="t" layer="0"]
        [AutoPut pct="cross.gif" x="0" y="15" c="t" layer="0"]

    ; ◆仕切り縦(X8-9,Y12-20)
        [AutoPut pct="obj_cartain_R.png" t="u" x="8" y="12"]

    ; ◆なんとか室作業台1周辺(X6-7,Y15-17)
        ; 人物配置
        [AutoNPC dic="b" name="Pack-F" x="6" y="15"]
        [AutoZPut pct="table22" c="t" t="d" x="6" y="15"]
        [AutoCont n="1" color="DN" x="6.5" y="15.5" t0="d"]

    ; ◆なんとか室パッキングマシン(X2-4,Y15-19)
        [AutoPut pct="obj_machineM_L.png" t="u" x="2.5" y="15.5"]

    ; ◆掃除道具(X1,Y18-20)
        [AutoPut pct="obj_clean_R.png" x="1" y="18"]

    ; ◆なんとか室作業台2周辺(4-7,Y18-20)
        [AutoZPut pct="table32" c="t" t="d" x="5" y="17.5"]
        [AutoCont n="5" color="OR" x="7" y="20.5" t="u" layer="1"]


; ◆◆右下エリア(X13-31,Y12-14)＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝


    ; ◆パッキングマシン2周辺(X16-19,Y11-17)
        ; 人物配置
        [AutoNPC dic="b" name="mob2" x="17" y="12"]
        [AutoCont n="1" color="OR" x="18.5" y="11.5" t=""]
        [AutoNPC dic="l" name="Setup-F" x="19" y="13"]
        ; マシン
        [AutoPut pct="machine_L0H.png" c="t" t="d" x="17.8" y="11.5"]
        [AutoZPut pct="table23" c="t" t="u" x="16" y="12"]
        [AutoCont n="1" color="DN" x="16" y="12" t0="l"]

        ; これをzputに変える
        ; [AutoPut pct="obj_machineL_L.png" x="16" y="13"]
        [AutoZPut pct="obj_machineL_L_" t="d" x="16" y="13"]

        

    ; ◆冷凍庫2
        ; 封鎖
        [AutoPut pct="cross.gif" x="24" y="12" c="t" layer="0"]
        [AutoPut pct="cross.gif" x="24" y="17" c="t" layer="0"]
        [AutoZPut pct="room_freeze2_" t="u" x="24.5" y="10"]

    ; ◆コンテナの集団(X13-20,Y16-20)
        [AutoCont n="5" color="OR" x="13" y="18" t="l" layer="0"]
        [AutoCont n="5" color="OR" x="15" y="18" t="l"]
        [AutoCont n="5" color="OR" x="17" y="18" t="l"]
        [AutoCont n="5" color="OR" x="19" y="18" t="l"]
        [AutoCont n="5" color="OR" x="14" y="20" t="l" layer="1"]
        [AutoCont n="5" color="OR" x="16" y="20" t="l" layer="1"]
        [AutoCont n="5" color="OR" x="18" y="20" t="l" layer="1"]

    ; ◆冷凍庫3


; ; テーブル
; ; [AutoPut pct="table32T.png" c="t" t="d" x="16" y="2"]
; ; [AutoZPut pct="table23" c="t" t="r" x="7" y="17"]

; [AutoPut pct="container1_DN.png" x="16" y="2" c="t" t="u"]
; 他の画像を消すと出る



; [AutoPut pct="ex_floor_conc11.png" x="20" y="0" c="t" t="u" layer="0"]
; [AutoPut pct="ex_floor_conc11.png" x="21" y="0" c="t" t="u" layer="0"]
; ; アニメーション
; [AutoPut pct="arrow_anim_T.gif" x="20.5" y="0"  c="t" t="u" layer="0"]





; 退室時ONイベント
[SetEvent EventType="2" x="20" y="1" w="2" h="1" type="contact" id="採点セット室"]

[SetEvent EventType="2" x="20" y="0" w="2" h="1" type="mapMove" id="セット室to生産管理室"]

[return]