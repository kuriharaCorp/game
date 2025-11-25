

; plc=place(場所)
[eval exp="tf.plc='f201_06_15_wgh'" ]



; ◆◆左エリア(X1-9,Y1-13)＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝


    ; ◆上柱
        [AutoPut pct="pillar12y.png" x="5"  y="-1" c="t" layer="0"]

    ; ◆左通路封鎖(X7-8,Y2-4)
        [AutoPut pct="container1_OR.png" x="8" y="3" c="t" layer="0"]
        [AutoPut pct="container1_OR.png" x="8" y="2" c="t" layer="0"]

        [AutoPut pct="cross.gif" x="0" y="2" c="t" layer="0"]
        [AutoPut pct="cross.gif" x="0" y="3" c="t" layer="0"]


    ; ◆計量マシーン1周辺(X1-8,Y4-8)

        ; 人物配置
            [AutoNPC dic="t" name="Gpepper-F" x="8" y="6"]
        ; 計量マシーン1
            [AutoPut pct="container1_OR.png" x="7" y="5" c="" layer="0"]
            [AutoPut pct="container1_OR.png" x="1" y="6" c="t" t=""]
            [AutoPut pct="container1_OR.png" x="8" y="4.5" c="t" t=""]
        ; マシン本体
            [AutoPut pct="machine_L0.png" x="4" y="5" c="t" t="" layer="0"]
            [AutoZPut pct="machine_S_" c="t" x="2" y="4" t="u"]
            [AutoZPut pct="machine_S_" c="t" x="5" y="4" t="u"]
        ; コンテナ
            [AutoCont n="1" color="OR" x="7" y="6" t="r"]


    ; ◆作業台周り(X2-8,Y11-13)
        [AutoZPut pct="table32B" c="t" t="u" x="2" y="11"]
        [AutoZPut pct="table32B" c="t" t="u" x="6" y="11"]


    ; ◆下柱
        [AutoPut pct="pillar12y.png" x="5"  y="11" c="t"  t="u" layer="1"]


; ◆◆中央エリア(X10-24,Y1-13)＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝


    ; ◆上柱
        [AutoPut pct="pillar12y.png" x="14" y="-1"  c="t" layer="0"]

    ; ◆掃除道具(X10-16,Y0-1)
        [AutoPut pct="obj_clean_tools.png" x="10" y="0" t="d" layer="0"]


    ; ◆計量マシーン2周辺(X12-22,Y4-8)

    ; 人物配置
        [AutoNPC dic="b" name="Cabbage-F" x="15" y="5"]
    ; コンテナ奥・横
        [AutoPut pct="container1_OR.png" x="20" y="4.5" c="t" layer="0"]
        [AutoPut pct="container1_OR.png" x="21" y="5" c="t" t="u" layer="1"]
    ; マシン本体
        [AutoPut pct="machine_L0.png" x="14" y="5" c="t" t="" layer="0" zindex="6" ]
        [AutoPut pct="machine_L0.png" x="17" y="5" c="t" t="" layer="0" zindex="6" ]
        [AutoZPut pct="machine_S_" c="t" x="12.5" y="4" t="u"]
        [AutoZPut pct="machine_S_" c="t" x="17.5" y="4" t="u"]
    ; コンテナ手前
        [AutoCont n="1" color="OR" x="20" y="5.5" t="r"]

    ; 人物配置
        [AutoNPC dic="l" name="mob3" x="21" y="6"]
        [AutoNPC dic="t" name="mob2" x="16" y="6"]


    ; ◆計量マシーン3周辺(X11-17,Y10-13)
        [AutoPut pct="container1_OR.png" x="16"   y="11" c="t" layer="0"]
    ; マシン本体
        [AutoPut pct="machine_L0.png"    x="13"   y="11.5" c="t" t="u" layer="0"]        
        [AutoZPut pct="machine_S_" c="t" x="11.5" y="10.5" t="u"]

    ; コンテナ手前・横
        [AutoPut pct="container1_OR.png" x="17"   y="11.5" c="t" layer="0"]
        [AutoCont n="1" color="OR"       x="16"   y="12" t="r" layer="0"]


    ; 人物配置
        [AutoNPC dic="t" name="mob4" x="15" y="13"]



    ; ◆作業台(X21-24,Y11-13)
        [AutoZPut pct="table32B" c="t" t="u" x="21" y="11.5"]

    ; ◆下柱
        [AutoPut pct="pillar12y.png" x="14" y="11"  c="t" t="u"  layer="1"]



; ◆◆右エリア(X25-33,Y1-13)＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝


    ; ◆上柱
        [AutoPut pct="pillar12y.png" x="24" y="-1"  c="t" layer="0"]

    ; ◆真空パックマシン(X28-31,Y0-2)
        [AutoPut pct="machineB.png" x="28.5" y="0"  c="t"]
    ; 人物配置
        [AutoNPC dic="t" name="mob1" x="29" y="2"]

    ; ◆作業台(X28-31,Y4-6)
        [AutoZPut pct="table42" c="t" t="u" x="28" y="3"]

    ; ◆前室通行止め

        [AutoPut pct="ex_floor_conc11.png" x="34" y="7" c="t" t="u" layer="0"]
        [AutoPut pct="cross.gif" x="34" y="7" c="t" layer="0"]

    ; ◆次のマップ周り
        ; 冷蔵庫3建物
        [AutoPut pct="room_reizou3.png" x="27" y="9" t="d" layer="1"]
        ; 矢印アニメ
        ; [AutoPut pct="arrow_anim_R.gif" x="28" y="18.5" c="t" layer="1"]
        [AutoPut pct="arrow_anim_R.gif" x="26" y="10.5"  c="t" t="u" layer="0"]

    ; ◆下柱
        [AutoPut pct="pillar12y.png" x="24" y="11"  c="t" t="u"  layer="1"]




; 意味なかった
; [preload storage="data/bgimage/map2/f201_06_15_wgh/room_reizou3.png"]





; マップ移動
; [AutoPut layer="0" pct="ex_floor_conc11.png" x="30" y="10" c="t" t="u" name="exroad"]
; [AutoPut layer="0" pct="ex_floor_conc11.png" x="30" y="10" c="t" t="u" name="exroad2"]
; アニメーション
; [AutoPut pct="arrow_anim_R.gif" x="29" y="10.5"  c="t" t="u" layer="0"]

; [SetEvent EventType="2" x="30" y="10" w="1" h="2" type="mapMove" id="カット室to計量室"]

; 一時的処置

; 退室時ONイベント
[SetEvent EventType="2" x="26" y="10" w="1" h="2" type="contact" id="採点計量室"]

[SetEvent EventType="2" x="27" y="10" w="1" h="2" type="mapMove" id="計量室toセット準備室"]



; [AutoNPC dic="t" name="1-F"   x="19.5" y="7.5"]


; ; マップ移動
; [SetEvent EventType="2" x="10" y="2" w="1" h="2" type="mapMove" id="マップ移動玄関2to前室"]

; SetEventを入れないと.someでエラー
; [SetEvent EventType="3" x="1" y="9" w="1" h="1" name="hoge" type="triggerPush" id="方向転換"]

[return]