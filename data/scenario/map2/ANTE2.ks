; 第二前室



; plc=place(場所)
[eval exp="tf.plc='f201_39_13_ant'" ]

; c="nanika"でcommon呼び出しに変更
; t="u,r,d,l"でその方向1マスを進入可能にする

[AutoPut pct="pillar12y.png" x="1" y="0" c="t"]
[AutoPut pct="add_sig_room_triming.png" x="1" y="1"]
[AutoPut pct="wall44_b.png" x="3" y="0" c="t"]
[AutoPut pct="wall24_bER.png" x="9" y="0" c="t"]



[AutoPut pct="shelf22_d.png" x="3" y="2" c="t"]
; ここに縦排水溝
[AutoPut pct="shelf03_l.png" x="4" y="3" c="t"]
[AutoPut pct="steps_r.png" x="5" y="3" c="t"]
[AutoPut pct="wal_shoes_l.png" x="8" y="3" t="l"]
[AutoPut pct="pillar12y.png" x="3" y="5" c="t"]
[AutoPut pct="shelf12_l.png" x="5" y="5" c="t"]
[AutoPut pct="wal_sink_d.png" x="3" y="5.5"]
[AutoPut pct="pillar11y.png" x="0" y="7" c="t"]
[AutoPut pct="add_sig_room_keiryo.png" x="0" y="8"]
[AutoPut pct="pillar11y.png" x="6" y="6.5" c="t"]
[AutoPut pct="ex_floor_conc11.png" x="0" y="9" c="t" t="u"]

[AutoPut pct="obj_clean_mcn_t.png" x="3" y="9" t="u"]
[AutoPut pct="flr_drain.png" x="7" y="10"]

[AutoNPC dic="r" name="tutorial-F" x="1" y="9"]

[AutoPut pct="arrow_anim_T.gif" x="2" y="1" c="t" layer="0"]
[AutoPut pct="cross.gif" x="7" y="2" c="t" layer="0"]
[AutoPut pct="cross.gif" x="8" y="2" c="t" layer="0"]


; ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
; イベントを登録

; moveの時に発火。
; x,yで範囲を指定、w,hで左上を基準にした範囲を設定。
; AutoPutで設定している設定を上書きする。
; 動いた先で発火するか、その場でボタンを押すと発火の2種類。
; .someを使って移動先のx(tf.st.x),y(tf.st.y)がそれに含まれているかでT/Fをして判断する。

[SetEvent EventType="3" x="1" y="9" w="1" h="1" name="hoge" type="triggerPush" id="方向転換"]

; typeで発火内容(動作)をフォルダリング
; idでtypeの中の変数に標準
[SetEvent EventType="2" x="3" y="9" w="1" h="1" name="hoge" type="contact" id="とるミングチェック"]

; トリミング機械を調べると動画が流れる
[SetEvent EventType="3" x="3" y="10" w="2" h="1" type="search" id="とるミング"]

; マップ移動
[SetEvent EventType="2" x="2" y="1" w="1" h="1" type="mapMove" id="マップ移動前室toトリミング室"]


[return]
