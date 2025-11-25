

; plc=place(場所)
[eval exp="tf.plc='f101_34_01_pic'" ]


; ◆◆左エリア(X1-13,Y1-24)＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

        ; 封鎖
        [AutoPut pct="cross.gif" x="0" y="7" c="t" layer="0"]
        [AutoPut pct="cross.gif" x="0" y="8" c="t" layer="0"]

        [AutoPut pct="cross.gif" x="11" y="19" c="t" layer="0"]



; ◆作業レーン1周辺(X1-2,Y10-15)
    ; 人物配置
    [AutoNPC dic="l" name="Seal-F" x="2" y="11"]
    ; [AutoPut pct="container1_OR.png" x="1.2" y="9" t="r" c="t" layer="0"]
    [AutoPut pct="obj_rail1.png" x="1" y="10" t="r" layer="0"]
    [AutoPut pct="obj_rail1_DN.png" x="1" y="10" t="r" layer="0"]

; ◆作業レーン2周辺(X4-7,Y5-17)
    ; 人物配置
    [AutoNPC dic="l" name="mob2" x="7" y="7"]
    [AutoNPC dic="r" name="mob1" x="4" y="8"]
    [AutoZPut pct="obj_railL" x="4" y="4.5" t="d"]
    [AutoPut pct="obj_railLT_DN.png" x="4" y="4.5" t="r" layer="1"]

; ◆作業レーン3周辺(X8-11,Y5-17)
    ; 人物配置
    [AutoNPC dic="r" name="mob5" x="8" y="10"]
    [AutoNPC dic="l" name="mob3" x="11" y="15"]
    [AutoZPut pct="obj_railL" x="8" y="4.5" t="d"]
    [AutoPut pct="obj_railLT_DN.png" x="8" y="4.5" t="r" layer="1"]


; ◆作業レーン4周辺(X12-14,Y5-17)
    [AutoPut pct="obj_rail1.png" x="13" y="4" t="r"]
    [AutoPut pct="obj_rail1.png" x="13" y="8" t="r"]
    ; 人物配置
    [AutoNPC dic="r" name="mob4" x="12" y="12"]
    [AutoPut pct="obj_rail1.png" x="13" y="12" t="r" layer="0"]

    [AutoPut pct="obj_rail1_DN.png" x="13" y="4" t="r" layer="1"]

    ; 柱
    [AutoPut pct="pillar12y.png" c="t" t="l" x="14" y="7.5" layer="1"]


    [AutoPut pct="obj_rail1_DN.png" x="13" y="10" t="r" layer="1"]



; ◆冷凍庫1周辺(X0-13,Y19-25)
[AutoPut pct="room_reizokoDo.png" x="0" y="19.5" t="r"]


; ◆◆右上エリア(X15-29,Y1-11)＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝


    ; ◆次のマップ周り(X28-29,Y4-7)
    ; マップ移動
    [AutoPut layer="0" pct="ex_floor_conc11.png" x="29" y="5" c="t" t="u" name="exroad"]
    [AutoPut layer="0" pct="ex_floor_conc11.png" x="29" y="6" c="t" t="u" name="exroad2"]
    ; アニメーション
    [AutoPut pct="arrow_anim_R.gif" x="29" y="5.5"  c="t" t="u" layer="0"]

; ◆出荷待ち冷蔵庫(X17-29,Y1-4)
    [AutoZPut pct="room_reizokoUp" t="d" x="16.5" y="-0.5"]
    ; 封鎖
    [AutoPut pct="cross.gif" x="16" y="2" c="t" layer="0"]
    [AutoPut pct="cross.gif" x="16" y="3" c="t" layer="0"]

; ◆作業レーン5周辺(X17-23,Y6-8)
    [AutoPut pct="machine_L0.png" c="t" t="" x="17" y="7" layer="0"]
    [AutoPut pct="machine_L0.png" c="t" t="" x="21" y="7" layer="0"]
    ; 段ボール
    [AutoCont n="1" color="DN" x="20" y="6.5" t=""]
    [AutoCont n="1" color="DN" x="21" y="6.5" t=""]
    [AutoCont n="1" color="DN" x="23" y="6.5" t=""]

    ; 人物配置
    [AutoNPC dic="t" name="Sort-F" x="22" y="8"]


; ◆◆右下エリア(X15-29,Y12-25)＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

; ◆作業レーン6周辺(X17-25,Y12-17)
    [AutoZPut pct="obj_railLB1" x="17" y="11"]
    [AutoPut pct="obj_railLB1_DN.png" x="17" y="10.5" layer="1"]

    ; 人物配置
    [AutoNPC dic="t" name="mob6" x="19" y="16"]

; ◆作業レーン7周辺(X17-25,Y18-21)
    [AutoZPut pct="obj_railLB2" x="17" y="18"]
    [AutoPut pct="obj_railLB2_DN.png" x="17" y="18" layer="1"]

    ; 人物配置
    [AutoNPC dic="t" name="mob7" x="23" y="21"]

; ◆システム室(X14-26,Y22-25)
    ; 封鎖
    [AutoPut pct="cross.gif" x="15" y="23" c="t" layer="0"]
    [AutoPut pct="room_sistem.png" x="14" y="22.5" t="d"]

; ◆従業員玄関への扉(X27,Y24-25)
    ; 封鎖
    [AutoPut pct="cross.gif" x="27" y="25" c="t" layer="1"]


; 生産管理室冷蔵庫
; システム室






; 出ない






; ; ; テーブル
; [AutoZPut pct="table32" c="t" t="d" x="16" y="2"]
; ; ; [AutoPut pct="table32T.png" c="t" t="d" x="16" y="2"]
; ; ; [AutoZPut pct="table23" c="t" t="r" x="7" y="17"]

; [AutoCont n="1" color="DN" x="16" y="2" t="t"]
; ; [AutoPut pct="container1_DN.png" x="16" y="2" c="t" t="t"]
; ; 他の画像を消すと出る
; [AutoPut pct="obj_machineS_T.png" x="18" y="2"]

; ; レイトウ庫(出ない)
; [AutoZPut pct="room_freeze1_" t="d" x="24.5" y="2.5"]

; ; 道をふさぐ段ボール群
; [AutoCont n="5" color="DN" x="5" y="5" t="t" c="t"]
; [AutoCont n="5" color="DN" x="7" y="4.5" t="t" c="t"]
; [AutoCont n="5" color="DN" x="9" y="5" t="d" c="t"]
; [AutoCont n="5" color="DN" x="10" y="8" t="t" c="t"]

; ; 道をふさぐコンテナ群
; [AutoCont n="3" color="OR" x="22" y="8" t="t" c="t"]
; [AutoCont n="2" color="OR" x="21.5" y="9" t="t" c="t"]
; [AutoCont n="2" color="OR" x="22" y="9.5" t="d" c="t"]
; [AutoCont n="3" color="OR" x="23" y="9" t="t" c="t"]
; [AutoCont n="2" color="OR" x="24" y="9" t="d" c="t"]

; ; 衝立(出ない)
; [AutoPut pct="obj_cartain_D.png" x="1" y="8.5"]
; [AutoPut pct="obj_cartain_R.png" x="8" y="12"]


; ; 何とか室の中(衝立)
; [AutoPut pct="obj_clean_R.png" x="1" y="18"]
; [AutoPut pct="obj_machineM_L.png" x="2.5" y="15.5"]

; [AutoZPut pct="table22" c="t" t="d" x="6" y="15"]
; [AutoZPut pct="table42" c="t" t="d" x="5" y="17.5"]

; [AutoCont n="1" color="DN" x="6.5" y="15.5" t0="d"]
; [AutoCont n="5" color="OR" x="7" y="20.5" t="t" layer="1"]


; ; 中央と下あたり
; [AutoZPut pct="table23" c="t" t="d" x="16" y="11.5"]
; ; 出ない
; [AutoPut pct="obj_machineL_L.png" x="16" y="13"]
; [AutoCont n="1" color="DN" x="16" y="12" t0="l"]

; [AutoCont n="5" color="OR" x="13" y="18.5" t="l"]
; [AutoCont n="5" color="OR" x="15" y="18.5" t="l"]
; [AutoCont n="5" color="OR" x="17" y="18.5" t="l"]
; [AutoCont n="5" color="OR" x="19" y="18.5" t="l"]
; [AutoCont n="5" color="OR" x="14" y="20.5" t="l" layer="1"]
; [AutoCont n="5" color="OR" x="16" y="20.5" t="l" layer="1"]
; [AutoCont n="5" color="OR" x="18" y="20.5" t="l" layer="1"]

; ; レイトウ庫(出ない)
; [AutoZPut pct="room_freeze2_" t="t" x="24.5" y="10"]


; [AutoPut pct="ex_floor_conc11.png" x="20" y="0" c="t" t="u" layer="0"]
; [AutoPut pct="ex_floor_conc11.png" x="21" y="0" c="t" t="u" layer="0"]
; ; アニメーション
; [AutoPut pct="arrow_anim_T.gif" x="20.5" y="0"  c="t" t="t" layer="0"]





; 退室時ONイベント
[SetEvent EventType="2" x="28" y="5" w="1" h="2" type="contact" id="採点生産室"]

; [SetEvent EventType="2" x="29" y="5" w="1" h="2" type="mapMove" id="生産管理室to玄関1"]

[return]

クロスを入れる
        ; 封鎖
        [AutoPut pct="cross.gif" x="0" y="7" c="t" layer="0"]
        [AutoPut pct="cross.gif" x="0" y="8" c="t" layer="0"]
