; 6番目部屋

; 入室時オートイベント
[if exp="!f.autoEvt[tf.scName]"]

    [iadv]
        [announcement n="4"]
    [endadv]
    @eval exp="f.autoEvt[tf.scName]=true"

[endif]

; 退室時ONイベント
[checkstudy next="セット室" c="&f.score.setpre" cond="tf.contact.id == '採点セット準備室'"]
[checkstudy next="セット室" c="&f.score.setpre" cond="tf.contact.id == '採点セット準備室2'"]

; 話しかけたときの会話内容
[QuesAndAnswer category="setpre" item="Fridge" name="mbm" cond="tf.push.id == '方向転換'+'Fridge-F'"]

[QuesAndAnswer category="setpre" item="Forage" name="mbw" cond="tf.push.id == '方向転換'+'Forage-F'"]

[SoloAnswer category="setpre" item="Mob1" name="mob" cond="tf.push.id == '方向転換'+'mob1'"]
[SoloAnswer category="setpre" item="Mob2" name="mob" cond="tf.push.id == '方向転換'+'mob2'"]
[SoloAnswer category="setpre" item="Mob3" name="mob" cond="tf.push.id == '方向転換'+'mob3'"]
[SoloAnswer category="setpre" item="Mob4" name="mob" cond="tf.push.id == '方向転換'+'mob4'"]
[SoloAnswer category="setpre" item="Mob5" name="mob" cond="tf.push.id == '方向転換'+'mob5'"]

; ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

; イベントを初期化
[eval exp="tf.contact='done'"]

; イベント終了変数処理
[wait time="100"]
[eval exp="f.isEventRunning=false"]
[jump storage="test_cameraworld.ks" target="*end_load"]
[s ]
