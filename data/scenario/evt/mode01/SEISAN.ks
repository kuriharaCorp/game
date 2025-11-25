; 8番目部屋

; 入室時オートイベント
[if exp="!f.autoEvt[tf.scName]"]

    [iadv]
        [announcement n="6"]

        #pl
        ここが最後の部屋だな![p]

    [endadv]
    @eval exp="f.autoEvt[tf.scName]=true"

[endif]

; 退室時ONイベント
[checkstudy next="エンディング" c="&f.score.seisan" cond="tf.contact.id == '採点生産室'"]

; 話しかけたときの会話内容
[QuesAndAnswer category="seisan" item="Seal" name="mbm" cond="tf.push.id == '方向転換'+'Seal-F'"]

[QuesAndAnswer category="seisan" item="Sort" name="mbw" cond="tf.push.id == '方向転換'+'Sort-F'"]

[SoloAnswer category="seisan" item="Mob1" name="mob" cond="tf.push.id == '方向転換'+'mob1'"]
[SoloAnswer category="seisan" item="Mob2" name="mob" cond="tf.push.id == '方向転換'+'mob2'"]
[SoloAnswer category="seisan" item="Mob3" name="mob" cond="tf.push.id == '方向転換'+'mob3'"]
; 以下セリフ未登録
[SoloAnswer category="seisan" item="Mob4" name="mob" cond="tf.push.id == '方向転換'+'mob4'"]
[SoloAnswer category="seisan" item="Mob5" name="mob" cond="tf.push.id == '方向転換'+'mob5'"]
[SoloAnswer category="seisan" item="Mob6" name="mob" cond="tf.push.id == '方向転換'+'mob6'"]
[SoloAnswer category="seisan" item="Mob7" name="mob" cond="tf.push.id == '方向転換'+'mob7'"]

; 調整中
; [SoloAnswer category="seisan" item="Sistem" name="mob" cond="tf.push.id == '方向転換'+'sistem'"]

; ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

; イベントを初期化
[eval exp="tf.contact='done'"]

; イベント終了変数処理
[wait time="100"]
[eval exp="f.isEventRunning=false"]
[jump storage="test_cameraworld.ks" target="*end_load"]
[s ]
