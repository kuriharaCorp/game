

; plc=place(場所)
[eval exp="tf.plc='f201_46_01_ent'" ]
[AutoPut pct="obj_wal4.png" x="4" y="0" layer="0"]
[AutoPut pct="obj_steps.png" x="8" y="-0.5" layer="0"]
[AutoPut pct="pillar12y.png" x="14" y="-1" c="t" layer="0"]
[AutoPut pct="pillar11y.png" x="14" y="2.5" c="t" t="u" layer="1"]
[AutoPut pct="invisible_wall11.png" x="6" y="5" c="t"]
[AutoPut pct="arrow_anim_L.gif" x="10" y="1.5" c="t" layer="0"]

; マップ移動
[SetEvent EventType="2" x="10" y="2" w="1" h="2" type="mapMove" id="マップ移動玄関2to前室"]
; [SetEvent EventType="2" x="10" y="2" w="1" h="2" type="mapMove" id="トリミング室toカット室"]

; SetEventを入れないと.someでエラー
; [SetEvent EventType="3" x="1" y="9" w="1" h="1" name="hoge" type="triggerPush" id="方向転換"]

[return]