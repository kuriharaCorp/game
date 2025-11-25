; 5番目部屋

; 入室時オートイベント
[if exp="!f.autoEvt[tf.scName]"]

    [iadv]
        [announcement n="3"]
    [endadv]
    @eval exp="f.autoEvt[tf.scName]=true"

[endif]

; 退室時ONイベント
[checkstudy next="セット準備室" c="&f.score.keiryo" cond="tf.contact.id == '採点計量室'"]

; 話しかけたときの会話内容
[QuesAndAnswer category="keiryo" item="Gpepper" name="mbm" cond="tf.push.id == '方向転換'+'Gpepper-F'"]

[QuesAndAnswer category="keiryo" item="Cabbage" name="mbw" cond="tf.push.id == '方向転換'+'Cabbage-F'"]

[SoloAnswer category="keiryo" item="Mob1" name="mob" cond="tf.push.id == '方向転換'+'mob1'"]
[SoloAnswer category="keiryo" item="Mob2" name="mob" cond="tf.push.id == '方向転換'+'mob2'"]
[SoloAnswer category="keiryo" item="Mob3" name="mob" cond="tf.push.id == '方向転換'+'mob3'"]
[SoloAnswer category="keiryo" item="Mob4" name="mob" cond="tf.push.id == '方向転換'+'mob4'"]
[SoloAnswer category="keiryo" item="Mob5" name="mob" cond="tf.push.id == '方向転換'+'mob5'"]
[SoloAnswer category="keiryo" item="Mob6" name="mob" cond="tf.push.id == '方向転換'+'mob6'"]
[SoloAnswer category="keiryo" item="Mob7" name="mob" cond="tf.push.id == '方向転換'+'mob7'"]

; ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

; イベントを初期化
[eval exp="tf.contact='done'"]

; イベント終了変数処理
[wait time="100"]
[eval exp="f.isEventRunning=false"]
[jump storage="test_cameraworld.ks" target="*end_load"]
[s ]
