; 4番目部屋

; 入室時オートイベント
[if exp="!f.autoEvt[tf.scName]"]

    [iadv]
        [announcement n="2"]
    [endadv]
    @eval exp="f.autoEvt[tf.scName]=true"

[endif]

; 退室時ONイベント
[checkstudy next="計量室" c="&f.score.cut" cond="tf.contact.id == '採点カット室'"]

; 話しかけたときの会話内容
[QuesAndAnswer category="cut" item="Slicer" name="mbm" cond="tf.push.id == '方向転換'+'Slicer-F'"]

[QuesAndAnswer category="cut" item="Cutter" name="mbw" cond="tf.push.id == '方向転換'+'Cutter-F'"]

[SoloAnswer category="cut" item="Mob1" name="mob" cond="tf.push.id == '方向転換'+'mob1'"]
[SoloAnswer category="cut" item="Mob2" name="mob" cond="tf.push.id == '方向転換'+'mob2'"]

; ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

; イベントを初期化
[eval exp="tf.contact='done'"]

; イベント終了変数処理
[wait time="100"]
[eval exp="f.isEventRunning=false"]
[jump storage="test_cameraworld.ks" target="*end_load"]
[s ]
