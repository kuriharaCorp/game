; 3番目部屋

; 入室時オートイベント
[if exp="!f.autoEvt[tf.scName]"]

    [iadv]
        [announcement n="1"]
    [endadv]
    @eval exp="f.autoEvt[tf.scName]=true"

[endif]


; 最適化したのでこれを全部屋の基準にする

; 退室時ONイベント
[checkstudy next="カット室" c="&f.score.trm" cond="tf.contact.id == '採点トリミング室'"]

; 話しかけたときの会話内容
[QuesAndAnswer category="trm" item="Letas" name="mbm" cond="tf.push.id == '方向転換'+'Letas-F'"]

[QuesAndAnswer category="trm" item="Cabbage" name="mbw" cond="tf.push.id == '方向転換'+'Cabbage-F'"]

[SoloAnswer category="trm" item="Mob1" name="mob" cond="tf.push.id == '方向転換'+'mob1'"]
[SoloAnswer category="trm" item="Mob2" name="mob" cond="tf.push.id == '方向転換'+'mob2'"]

; ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

; イベントを初期化
[eval exp="tf.contact='done'"]

; イベント終了変数処理
[wait time="100"]
[eval exp="f.isEventRunning=false"]
[jump storage="test_cameraworld.ks" target="*end_load"]
[s ]
