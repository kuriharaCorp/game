; 起動後の一度だけ通る
[if exp="!tf.isFirstcheck"]
    [iscript ]

        f.NEXTMAP = {};  // オブジェクトとして初期化
        f.NEXTMAP['マップ移動玄関2to前室'] = 'ANTE2';
        f.NEXTMAP['マップ移動前室toトリミング室'] = 'TRIM2';
        f.NEXTMAP['トリミング室toカット室'] = 'CUT2';
        f.NEXTMAP['カット室to計量室'] = 'KEIRYO2';
        f.NEXTMAP['計量室toセット準備室'] = 'SETPre';
        f.NEXTMAP['セット準備室toセット室'] = 'SET';
        f.NEXTMAP['セット室to生産管理室'] = 'SEISAN';
        f.NEXTMAP['生産管理室to玄関1'] = 'ENTER1';

        tf.isFirstcheck = true;

    [endscript ]
[endif]

; 移動イベントの処理
[ClearVars cond="tf.nowEvent == 'mapMove'"]
[jump storage="test_cameraworld.ks" target="*MAPLOAD" cond="tf.nowEvent == 'mapMove'"]


; 以下、tf.contact.idに設定したイベント名の内容＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

; auto以外のイベント点火
[jump storage="&'evt/mode01/'+tf.scName+'.ks'"]

/*
[if exp="tf.contact.id == 'とるミングチェック'"]

    ; [dialog text="とるミングイベントが発火しました。"]

    [chara_new name="mbg" jname="社員さん" storage="chara/mon0.png"]

    ; すでにトリミングを見ている場合は発火しない
    [ignore exp="f.istoruming" ]
        [iadv ]

            [show name="mbg"]
            #社員さん
            ちょっと待って！[p]
            ここから先は衣服の埃や髪の毛を取ってから進んでください。[r]
            そこにある『取るミング』を使ってね[p]

            ; 選択肢表示準備
            #
            動画を見て『取るミング』をしよう。[p]
            [chara_hide name="mbg" wait="true" left="0" top="&720-700"]

            #社員さん
            使わないならここは通せないな。[p]

        [endadv ]

        @eval exp="tf.nxjump=''"
        ; 1マス戻る
        [noenter]

    [endignore ]

[endif]


; //以上、tf.contact.idに設定したイベント名の内容＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝


; イベントを初期化
[eval exp="tf.contact='done'"]

; イベント終了変数処理
[wait time="100"]
[eval exp="f.isEventRunning=false"]
[jump storage="test_cameraworld.ks" target="*end_load"]
*/
[s ]