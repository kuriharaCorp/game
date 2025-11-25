; [dialog text="カメラで移動するテスト"]

/*
マップを表示

キャラを表示

キャラを移動させるとキャラにカメラが付いていく。

キャラが画面中央位置に移動するまでカメラは移動しない仕組み

移動強化
画面中央にキャラが移動するようにする。
背景画像が-1以上行かないようにする。

~~


オブジェクトを設置。
オブジェクトの位置を絶対値に置く。
*/

; ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
; 基本的なjs
    [loadjs storage="../scenario/js/bsc.js"]

; マクロ読込
    [call storage="mcr/bscv2.ks" ]
    [call storage="mcr/bscv2anti.ks" ]
    [call storage="mcr/trigger_mcr.ks"]

; modeごとに基本.ks
    [call storage="evt/mode01/mode01BSC.ks"]

    [call storage="mcr/mode/01_camera.ks"]


; ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

[clearstack stack="macro" ]

; 確認用
[body bgimage="bg_title0.jpg" ]

; 最初の恰好
[eval exp="f.Issuit = true"]

; マクロ呼出
[call storage="mcr/cameraworldmcr.ks"]
; キャラ移動に関するJS呼び出し
[loadjs storage="../scenario/js/characterCameraControl.js" ]
; イベント登録用
[loadjs storage="../scenario/js/event.js" ]
; キャラクター登録用
[loadjs storage="../scenario/js/characterSetList.js"]


; カメラを使う前の準備運動
[camera x=0 y=0 time="50" wait="true" ]
[layopt layer="message0" visible="false"  ]

; イベント既読処理用
@eval exp="f.autoEvt=[]"

; 最初のマップ名
[eval exp="f.NEXTMAP = 'ENTER2'"]
[map_loading roomname="&f.NEXTMAP"]

*MAPLOAD
[clearstack stack="macro" ]
[map_loading roomname="&f.NEXTMAP[tf.move.id]" cond="tf.isFirstcheck"]


; 入室時カメラ動作
[entrance roomname="&f.NEXTMAP[tf.move.id]"]



; ==========================================

; マップに入った時に発火するイベント
; ==========================================

; 必ず入れる

; イベント中処理を入れる
            ; ジャンプ前にイベント中に変更(矢印キー処理を停止)
    [eval exp="f.isEventRunning=true"]


; 各マップごとに必ずシナリオがあるなら成立
[eval exp="tf.scName = tf.move !== undefined ? f.NEXTMAP[tf.move.id] : f.NEXTMAP"]
; モードが増えるならここのアドレスを分解する
[call storage="&'evt/mode01/'+tf.scName+'.ks'" cond="!f.autoEvt[tf.scName]"]
    ; 解除
    ; [eval exp="f.isEventRunning=false"]


; ==========================================

; 矢印キーでマクロ「move」が起動する
[loadjs storage="../scenario/js/arrowKeyHandler.js"]

; [eval exp="console.log(`ロード中3:${tf.loading}`)"]
; [dialog text="ロードが終わりました！"]

*end_load
    [eval exp="f.isEventRunning=false"]

[clearstack stack="macro" ]

; [eval exp="console.log(`イベント呼び出しテスト:${events['triggerPush']['方向転換']['from']}`)"]


[bgm nm="bsc"]
[wa]

; 処理終了
[eval exp="f.isProcessing = false"]








[s ]


; PUSH(自分からボタンを押して調べる)イベントはここ(全部の部屋共通)
; event.js > const eventHandlers = { より
*zkey
[clearstack stack="macro" ]
; イベント発動中宣言
[stop_keyconfig]
; 連続行動対策
[wait time="200"]
[eval exp="f.isEventRunning=true"]
[start_keyconfig]

; イベント種を並べて何を発火させるのか一覧を作る

; [eval exp="console.log(`発火したID:${tf.push.name}`)" ]



; tf.push.dicがundefined
[eval exp="console.log('events:=' + JSON.stringify(events['triggerPush'], null, 2))"]

; 話しかけたら振り向くマクロ
[changeDirection name="&tf.push.name" dic="&tf.push.dic" cond="tf.nowID.startsWith('方向転換')"]
; 方向転換マクロの起動の時部屋ごとの会話イベントの呼び出し
; モードが増えるならここのアドレスを分解する
[jump storage="&'evt/mode01/'+tf.scName+'.ks'" cond="tf.nowID.startsWith('方向転換')"]


; トリみんぐのイベントマクロ
[serach_truming cond="tf.nowID.startsWith('とるミング')"]


*end_Event
; 誤入力防止
[wait time="100"]
[fadeinbgm storage="music.m4a"]
[wa]
[crbtn]
[eval exp="f.isEventRunning=false"]
; イベント終了後は強制鎮火する
[eval exp="removeKeyListener()"]
    ; 処理中というブロック処理を解除
    [eval exp="f.isProcessing = false"]

[s]

; まとめ
; Destory+renewだったがこれをする必要性がなくなった。
; KnockBackは必要。別解釈の同効果を作る。
; sleepgameでなんとかしたい
; callでやると制限があるので
; 2辺の端で入ってきた方向と別方向へ行くとカメラが移動しない不具合あり


; Trigger
; Moveマクロで対象座標に入ると発火準備。
; ZかEnterを押すと*Zkeyに移動してイベント発火。

; OnEvent
; Moveマクロで対象座標に入っていると自動発火。

; それぞれ発火前に[clearstack stack="macro" ]でマクロのつながりを切っておく。

; 現在は1イベントしかできないので、共通化を行い今後に備える形にする。


/*
前室のイベントV1を移行する。
1. 階段から降りる　あとで追加
~~2. ADV,会話
~~3. ADV,システム説明
~~4. ポイントまで移動
~~    行けない部分にNoenterを付ける
~~5. 通せんぼイベント
~~6. 動画を見る
~~7. 通せんぼイベント解除
8. 次の部屋へ
*/

; AutoPut改造。
; 追加で、部分的に透過させる箇所を作る。

; isWithinBounds　で　tf.obstacles の有無で進行できるかをチェックしている。

; tf.obstacles　の　x,y,w,h,type で全てが一致した場合trueで通れるようになる

; 重すぎオーバーフロー。
; moveの処理が増えたので待ち時間が間に合ってない

; OnEvent


; checkAndTriggerEventsWithBounds
; で
; checkAndTriggerEvent
; を呼び出す。
; これがTrueで成立すると、onTrigger: の中身を発火する。


; checkAndTriggerEvent
; は
; 座標調整を行い、その座標に指定したイベント名(type)
; がある場合発火(triggerEvent)
; または、指定したボタンを押したら発火する準備を
; 行う

; triggerEvent
; は
; イベントが存在するかを確認し、eventHandlers
; を呼び出す。

; eventHandlers
; は
; 呼び出したparamsを
; それぞれ呼び出したイベント名に適した
; 変数に代入していく。(tf.contact)など

; イベントはonEvent.ksを呼び出して、tf.contact.idで
; 発火するイベントを決める

