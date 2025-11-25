; // 第一工場玄関(ゴール)

; plc=place(場所)
[eval exp="tf.plc='f101_62_01_ent'" ]

; ゴール矢印
[AutoPut pct="goal.png" x="3" y="11" t="u" layer="0" zindex="5"]


[AutoNPC dic="b" name="Ending" x="3" y="13"]


; 行っても何もないので早めに封鎖サイン
[AutoPut pct="cross.gif" x="1" y="7" c="t" layer="0"]
[AutoPut pct="cross.gif" x="2" y="7" c="t" layer="0"]
[AutoPut pct="cross.gif" x="3" y="7" c="t" layer="0"]
[AutoPut pct="cross.gif" x="4" y="7" c="t" layer="0"]
[AutoPut pct="cross.gif" x="5" y="7" c="t" layer="0"]
[AutoPut pct="cross.gif" x="6" y="7" c="t" layer="0"]
[AutoPut pct="cross.gif" x="7" y="7" c="t" layer="0"]
[AutoPut pct="cross.gif" x="8" y="7" c="t" layer="0"]

[AutoPut pct="cross.gif" x="1" y="17" c="t" layer="0"]
[AutoPut pct="cross.gif" x="2" y="17" c="t" layer="0"]
[AutoPut pct="cross.gif" x="3" y="17" c="t" layer="0"]
[AutoPut pct="cross.gif" x="4" y="17" c="t" layer="0"]
[AutoPut pct="cross.gif" x="5" y="17" c="t" layer="0"]
[AutoPut pct="cross.gif" x="6" y="17" c="t" layer="0"]
[AutoPut pct="cross.gif" x="7" y="17" c="t" layer="0"]
[AutoPut pct="cross.gif" x="8" y="17" c="t" layer="0"]

; 石橋から落ちないための透明壁7~17
[AutoPut pct="invisible_wall11.png" x="4" y="7" c="t"]
[AutoPut pct="invisible_wall11.png" x="4" y="8" c="t"]
[AutoPut pct="invisible_wall11.png" x="4" y="9" c="t"]
[AutoPut pct="invisible_wall11.png" x="4" y="10" c="t"]
[AutoPut pct="invisible_wall11.png" x="4" y="11" c="t"]
[AutoPut pct="invisible_wall11.png" x="4" y="12" c="t"]
[AutoPut pct="invisible_wall11.png" x="4" y="13" c="t"]
[AutoPut pct="invisible_wall11.png" x="4" y="14" c="t"]
[AutoPut pct="invisible_wall11.png" x="4" y="15" c="t"]
[AutoPut pct="invisible_wall11.png" x="4" y="16" c="t"]
[AutoPut pct="invisible_wall11.png" x="4" y="17" c="t"]



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




; ; マップ移動
; [AutoPut layer="0" pct="ex_floor_conc11.png" x="31" y="8" c="t" t="u" name="exroad"]
; [AutoPut layer="0" pct="ex_floor_conc11.png" x="31" y="9" c="t" t="u" name="exroad2"]
; ; アニメーション
; [AutoPut pct="arrow_anim_T.gif" x="20.5" y="0"  c="t" t="u" layer="0"]

; [SetEvent EventType="2" x="31" y="8" w="1" h="2" type="mapMove" id="生産管理室to玄関2"]

[return]