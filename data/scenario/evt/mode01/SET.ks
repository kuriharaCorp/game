; 7番目部屋

; 入室時オートイベント
[if exp="!f.autoEvt[tf.scName]"]

    [iadv]
        [announcement n="5"]
    [endadv]
    @eval exp="f.autoEvt[tf.scName]=true"

[endif]

; 退室時ONイベント
[checkstudy next="生産管理室" c="&f.score.set" cond="tf.contact.id == '採点セット室'"]

; 話しかけたときの会話内容
[QuesAndAnswer category="set" item="Setup" name="mbm" cond="tf.push.id == '方向転換'+'Setup-F'"]

[QuesAndAnswer category="set" item="Pack" name="mbw" cond="tf.push.id == '方向転換'+'Pack-F'"]

[SoloAnswer category="set" item="Mob1" name="mob" cond="tf.push.id == '方向転換'+'mob1'"]
[SoloAnswer category="set" item="Mob2" name="mob" cond="tf.push.id == '方向転換'+'mob2'"]

; ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

; イベントを初期化
[eval exp="tf.contact='done'"]

; イベント終了変数処理
[wait time="100"]
[eval exp="f.isEventRunning=false"]
[jump storage="test_cameraworld.ks" target="*end_load"]
[s ]
