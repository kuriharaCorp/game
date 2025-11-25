; 9番目部屋
[if exp="!f.autoEvt['ENTER1']"]

    ; [iadv]
        ;ボタン非表示
        [clearfix ]

                    [layopt layer="0"  visible="false" ]
                    [layopt layer="1"  visible="false" ]
                    ; ここに受け渡しの動画
                    [bgmovie storage="受け渡し.mp4" ]

                    ; トラック詰込みについてのうんちくが入れられる[p]

                    [wait_bgmovie]
                    [stop_bgmovie]
                    [layopt layer="0"  visible="true" ]
                    [layopt layer="1"  visible="true" ]
    [endadv]
    
    ; 矢印キーは削除したまま
    [clearfix ]
    [cm]

    ; トラックが出発するムービー
    [image name="track" storage="gotrack.gif" layer="0" left="&80*255/100" top="&-80*5"]
    ; 4000sでエンジンかかる
    [wait time="4000"]
    [playse storage="engine1.mp3" buf="0"]
    [wait time="2000"]
    [fadeinse storage="engine2.mp3" buf="1" time="4000"]
    [fadeoutse time="4000" buf="0"]
    [wait time="4000"]
    ; 6000sで走り出す
    ; 10000sでクロスフィード
    [fadeoutse time="4000" buf="1"]
    ; [wait time="10000"]
    [free layer="0" name="track"]


    [iadv]
        [show name="kuri" face="suit"]
        #kuri
        クリハラで加工した野菜が行っちゃったね。[p]

        ; 着替え＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
            ; なぜか消えてるので再登録
            [chara_face name="pl" face="suit" storage="chara/hara0.png"]

            [show name="pl" side="R" time="50"]
            [wa]
            [wait time="500"]
            [anim name="pl" top="+=720" time="400" effect="easeInQuint" ]
            [wa]

            [eval exp="f.Issuit = true;"]
            [chara_part name="player" move="suitstop_r"]


            [chara_mod name="pl" face="suit"]
            [wa]
            
            [wait time="500"]
            [anim name="pl" top="-=720" time="1000" effect="easeInOutBounce" ]
            [wa]
        ; /着替え＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

        #&f.playername
        ええと、確か[<imp]『惣菜キット』[>]が出来て出荷されたんだよね？[p]
        #kuri
        そうそう。[<imp]お弁当は作ってなくて、惣菜の元を作っている[>]んだ。[p]
        #アナウンス
        本日の会社見学会の終了時刻がやってきました。[r]
        お忘れ物がないようにご帰宅の準備をお願いします。(英語で同じ内容を繰り返す)
        [wait time="2000"]
        [p]
        #kuri
        そろそろ終わりみたいだ。[r]
        帰りたくなったらボクに話しかけてね[p]
        [chara_hide name="kuri" layer="1"]

    [endadv]



    @eval exp="f.autoEvt['ENTER1']=true"

[endif]


; 話しかけたときの会話内容
[if exp="tf.push.id == '方向転換'+'Ending'"]
    ; クリアの証
    [eval exp="f.end01=true"]
    [iadv]
        [show name="kuri" face="suit"]
            #マロン
            おつかれさま！回ってこられた？[p ]
        [show name="pl" side="R" face="suit"]
            #pl
            うん！一通り見てきたよ！[p ]
            社員さんに話を聞けたよ。[p ]
            #マロン
            それは良かった！[p ]
            クリハラでは野菜のカットを含めた「惣菜キット」を作っていることがわかったね。[p ]
            #pl
            そうだね！スーパーでどんなお惣菜になるのか、ワクワクするね！[p ]
            #社員さん
            本日はお越しいただきありがとうございました。[r]
            会社説明会にもぜひお越しください！[p]
            #pl
            わかりましたー[p]
            #kuri
            最新情報はホームページをチェック！[p]
            ; #マロン
            ; それでは今日の工場見学は終わりだよ。[p ]
            ; もっとクリハラのことを知りたい！と思ったら、ぜひリアルの工場見学もしてみてね。[p ]
    [endadv]
    ; 矢印キーは削除したまま
    [clearfix ]
    [cm]

        ; [movie storage="gotrack.mp4"]
        [layopt layer="0" visible="true"]

        [mask time="2000" ]
            ; 完了支度
            [fadeoutbgm]
            [wa]
            [reset_camera]
            [destroy ]
        [mask_off time="50" ]
        ; [image storage="gotrack.gif" layer="0" height="720" ]
        ; トラックの音ここ
        ; [image storage="gotrack.gif" layer="0" width="150" x="240"  ]
        ; [wait time="12000"]

        [jump storage="credit01.ks"]


        ; [mask time="2000" ]
        ; [wait time="2000" ]
        ; [dialog text="タイトル画面に戻ります" ]
        ; [destroy ]
        ; [mask_off time="50" ]
        ; [jump storage="titlever2.ks" ]
        [s ]

[endif]


; ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

; イベントを初期化
[eval exp="tf.contact='done'"]

; イベント終了変数処理
[wait time="100"]
[eval exp="f.isEventRunning=false"]
[jump storage="test_cameraworld.ks" target="*end_load"]
[s ]
