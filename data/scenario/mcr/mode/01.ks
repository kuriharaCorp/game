/*
「社長でGO」のイベントマクロ
全てのモードで共通名のイベント名にする。

[crimap]マクロ(bsc.ks)からcallで呼び出す
[crimap]はmap.ksの中で1度だけ呼び出す


いままでのは
POV限定====================================(POVは現在凍結中)
mindev
objev
マクロ(evt.ks)で登録。中身は同じだが呼び出す条件が異なる。
それぞれtrgevマクロ(mov.ks)に構成登録
;前のときと後ろの時で2パターン用意
;現在地と一致するイベントが発火する。
    [mindev cond="f.ginfo===2&&!tf.istn&&!tf.istrg&&tf.hoge=='T'"]
    [mindev cond="f.binfo===2&&!tf.istn&&!tf.istrg&&tf.hoge=='B'"]
;現在地+進行予定方向+1の座標と一致するイベントがボタンを押すと発火する。
    [objev cond="f.ginfo===3&&!tf.istn&&!tf.istrg&&tf.hoge=='T'"]
    [objev cond="f.binfo===3&&!tf.istn&&!tf.istrg&&tf.hoge=='B'"]
f.ginfo…キャラ現在地で向いている方向1つ先のマスの数値
tf.istn…ボタン方向とキャラの向いている方向があっているか否か。合っている場合T。
tf.istrg…pov用。その場回転の場合はF。
tf.hoge…この時は、押したボタンの種類。TRBL。
==================================================
TPP(現在の)
mapそれぞれを呼び出し、イベントキーからジャンプして処理をする。


基本的なイベントはそのままに、変化するイベントだけ01系列に飛ばして上書きするとか


進行方向にイベントがある場合処理
f.ginfoが0-3のときそれぞれの効果を変更する。
    - 0…通過可能、何も発生しない。　処理済
    - 1…通行不可。現在値に隣接している場合そちらの方向へ動けない。 処理済
    - 2…イベント発生0。通過したときに発生する　動きは処理済
    - 3…イベント発生1。現在値に隣接している場合、そちらを向いてボタンで発生。1と合わせる
    - 4…メニューのマップワープ移動専用。

マス依存のイベントはマップごとに記載
それ以外のイベントはここに記載

イベント発火
- ゲーム開始時
- エンディング
- 特定の条件を満たした瞬間
- 特定の条件を満たした後の下記
これらはすでにマップ記載のとき、上書きして発生するようにする
- モノ(人)を調べた時
- 何かの上に載ったとき

発火させるマップ名、マス番号、イベント内容
をこちらでも検索させる

動くたびに毎回ここは読み込まれる
*/

;初回読み込み用(bsc呼び出し)
[macro name="evt_fst"]
    ; [trace exp="&`'現在'+f.mode+'モードです'`" ]
    [iadv]
    ;TODO:あとで消す
        ;[chara_new name="syatyo" storage="chara/akane/normal.png"  jname="クリ" ]
        ;[chara_new name="mob" storage="chara/yamato/normal.png"  jname="ハラ" ]
        [chara_config pos_mode="false" ]
        [show name="kuri" face="suit"]
        ;[chara_show face="suit"  layer="1" zindex="99" name="kuri" left="0"  top="&720-700" ]
        #クリ
        こんにちは！工場見学隊の[<mid]クリ[>]です！[l][r]
        今日はクリハラの工場内を探検しましょう。[p]
        [show name="hara" face="suit" side="R"]
        ;[chara_show layer="1" zindex="99" name="hara" left="&1280-500" top="&720-700"   ]
        #ハラ
        はーい！[l]同じく[<mid]ハラ[>]です！[p]
        #案内人
        それではみなさん、2Fの更衣室で白衣に着替えてください[p]

        #◇操作説明◇
        画面左下の十字ボタンをクリック、あるいはキーボードの十字キーでハラちゃんを動かすことができます。[p]
        さっそく階段へ移動しましょう![p]

        #ハラ
        [<imp]階段を上って更衣室で着替える[>]だったね。[l ]よし、行こう![p]
         @eval exp="f.isevt_fst=true"
        [mask time="1000" ]
        [wait time="1000" ]

    [endadv]

    ;エンジンの限界で、一度にfor文まで処理ができないためここで再起動させる。
    ;もっかい破壊
    [destroy]
    ;マップに登場するキャラクター・モノ宣言
    ;[call storage="&'map/'+tf.stmap+'.ks'" target="*dec" cond="!f.isnmp" ]
    ;全体創造。レイヤー1読込処理をtrueに戻す(処理後falseになる)
    [iscript ]
        tf.mpnm=tf.stmap;
        f.isnmp=false;
        f.isma=true;
    [endscript ]
    [renew name="&tf.mpnm"]
    ;マップ読み込み済みの処理(1度だけの処理を行わない)
    @eval exp="f.isnmp=true" 

    [mask_off time="50" ]

[endmacro ]

[macro name="evt_mid" ]
    ;移動する度に通る

    ;条件を満たしたら発火する(if-endif)
    ;踏んだり調べたりするイベントではない。それらは以下にラベルで直書きする。
    ;これらは初回イベント
    ;前室
    [call target="ant" cond="f.mpnm=='f201_39_13_ant'&&f.fstAnt!=true"]
    ;計量室
    [call target="wgh" cond="f.mpnm=='f201_06_15_wgh'&&f.fstWgh!=true"]
    ;カット室
    [call target="mac" cond="f.mpnm=='f201_01_01_mac'&&f.fstMac!=true"]
    ;トリミング室
    [call target="trm" cond="f.mpnm=='f201_29_01_trm'&&f.fstTrm!=true"]
    ;セット準備室
    [call target="set" cond="f.mpnm=='f101_20_01_set'&&f.fstSet!=true"]
    ;セット室
    [call target="wap" cond="f.mpnm=='f101_12_25_wap'&&f.fstWap!=true"]
    ;生産管理室
    [call target="pic" cond="f.mpnm=='f101_34_01_pic'&&f.fstPic!=true"]


    ; これを軸にしようか、下の*00000にしようか悩んでる

[endmacro ]

[macro name="evt_end"]
    ;条件を満たしたら発火する(if-endif)
    [iscript ]
        f.end01= f.flg01trm==true&&
                f.flg01mac==true&&
                f.flg01wgh==true&&
                f.flg01set==true&&
                f.flg01set==true&&
                f.flg01wap==true&&
                f.flg01pic==100;

        //f.end01=true;
    [endscript ]
    [if exp="f.end01" ]
        [iadv ]
        ;TODO:あとで消す(chara_show)
        [show name="kuri"]
                ;[chara_show layer="1" zindex="99" name="syatyo" left="0"  top="&720-700" ]

            #クリ
            おつかれさま！回ってこられた？[p ]
        [show name="hara" side="R"]
                    ;[chara_show layer="1" zindex="99" name="mob" left="&1280-500" top="&720-700"   ]

            #ハラ
            うん！一通り見てきたよ！[p ]
            社員さんに話を聞けたよ。[p ]
            #クリ
            それは良かった！[p ]
            クリハラでは野菜のカットを含めた「惣菜キット」を作っていることがわかったね。[p ]
            #ハラ
            そうだね！スーパーでどんなお惣菜になるのか、ワクワクするね！[p ]
            #クリ
            それでは今日の工場見学は終わりだよ。[p ]
            もっとクリハラのことを知りたい！と思ったら、ぜひリアルの工場見学もしてみてね。[p ]
        [mask time="2000" ]
        [wait time="2000" ]

        [endadv ]
        [dialog text="タイトル画面に戻ります" ]
        [destroy ]
        [mask_off time="50" ]
        [jump storage="titlever2.ks" ]
    [endif ]
[endmacro ]

;移動先変更マクロ
;移動先部屋名/移動先初期位置
;[mod_dest dest="" etl="" cond="適用する部屋名"]
[macro name="mod_dest" ]
    [iscript ]
        tf.mpnm=mp.dest
        f.etl=mp.etl
        f.ismdeve=true
    [endscript ]
[endmacro ]

;画像追加確認配列(map.ksで読込)
[iscript ]
    f.mod_image=[];
    f.mod_image[0]='f201_39_13_ant';
    //f.mod_image[1]='f201_46_01_ent';//これはテスト
    f.mod_image[2]='f201_29_01_trm';
    f.mod_image[3]='f201_01_01_mac';
    f.mod_image[4]='f201_06_15_wgh';
    f.mod_image[5]='f101_20_01_set';
    f.mod_image[6]='f101_12_25_wap';
    f.mod_image[7]='f101_34_01_pic';
    

[endscript ]

;キャラ登録
    [chara_config pos_mode="false" ]
    ;TODO:akaneを消す
    [macro name="reg_chara00"]
        [chara_new name="akane" jname="あかね" storage="chara/akane/normal.png" ]
        [chara_face name="akane" face="happy" storage="chara/akane/happy.png" ]
        [chara_face name="akane" face="doki" storage="chara/akane/doki.png" ]
    [endmacro ]
    [macro name="reg_chara01"]
        [chara_new name="hara" jname="ハラ" storage="chara/hara1.png"]
        [chara_face name="hara" face="suit" storage="chara/hara0.png"]
    [endmacro]
    [macro name="reg_chara02"]
        [chara_new name="kuri" jname="クリ" storage="chara/kuri1.png"]
        [chara_face name="kuri" face="suit" storage="chara/kuri0.png"]
    [endmacro]
    [macro name="reg_mob01"]
        [chara_new name="mbm" jname="社員さん" storage="chara/man0.png"]
    [endmacro]
    [macro name="reg_mob02"]
        [chara_new name="mbw" jname="社員さん" storage="chara/wom0.png"]
    [endmacro]

    [macro name="reg_mob03"]
        [chara_new name="mbg" jname="社員さん" storage="chara/mon0.png"]
    [endmacro]

;キャラ立ち位置
    [macro name="show"]
        @eval exp="(mp.side=='R')?mp.left=eval(1280-500):mp.left=0;"
        ;[dialog text="&%face" ]
        [chara_show name="&mp.name" layer="1" zindex="99" name="&mp.name" face="%face|default"  left="&mp.left" top="&720-700" time="500"]
    [endmacro]

;話しかけシステム雛形マクロ===
[iscript ]
    f.sct_def=[];
    f.sct_def[0]='◆何をしていますか？[1]';
    f.sct_def[1]='◇どんなことを気を付けていますか？[2]';
    tf.sct=['',''];
[endscript ]



[return]
[s ]

;このmodeだけ追加する要素(部屋ごとにIFで囲む)(map_bld呼び出し)
*place

    [trace exp="f.mpnm+'<-mpnm'" ]

;人物の呼出はここかなぁ。
    [iscript ]
/*
f.mpnm=='f201_46_01_ent'||
f.mpnm=='f201_39_13_ant'||
f.mpnm=='f201_29_01_trm'||
f.mpnm=='f201_01_01_mac'||
f.mpnm=='f201_06_15_wgh'||
f.mpnm=='f101_20_01_set'||
f.mpnm=='f101_12_25_wap'||
f.mpnm=='f101_34_01_pic';
  */  
        tf.reg_mob03=   f.mpnm=='f201_39_13_ant';
    [endscript ]

    [reg_chara01]
    [reg_chara02]
    [reg_mob01]
    [reg_mob02]
    [reg_mob03 cond="tf.reg_mob03"]

    [iscript ]
    //第二工場入口(f201_46_01_ent)追加新規イベント
    //削除
    
    //第二工場前室追加新規イベント
    if(f.mpnm=='f201_39_13_ant'){
        push(2,1,7,2,2);//立ち入り禁止イベント
        push(1,1,1,9,3);//立ち入り禁止イベント
        push(1,1,3,9,2);//トリミングイベント
        push(4,1,3,3);//壁
    };
    //第二工場トリミング室新規イベント
    if(f.mpnm=='f201_29_01_trm'){
        push(2,2,18,9,3);//立ち入り禁止+話しかけ(東封鎖)
        push(3,2,13,4);//壁(ゴミ室)
        push(2,2,7,5,3);//話しかけフラグ1
        push(2,2,7,13,3);//話しかけフラグ2
        push(1,2,1,10,3);//全員に話を聞くフラグ
    }
    //第二工場カット室新規イベント
    if(f.mpnm=='f201_01_01_mac'){
        push(2,2,20,7,3)//話しかけフラグ1
        push(2,2,20,10,3)//話しかけフラグ2
        push(2,1,23,14,3)//全員に話を聞くフラグ
        push(1,3,20,12,2)//部屋見渡し定点動画
        push(7,1,22,6,2)//上記同文
    }
    //第二工場計量室新規イベント
    if(f.mpnm=='f201_06_15_wgh'){
        push(1,2,15,5,3)//話しかけフラグ1
        push(1,1,8,6,3)//話しかけフラグ2
        push(1,2,30,10,3)//全員に話を聞くフラグ
        //TODO:ここ消す
        //push(1,13,7,1,2)//部屋見渡し西
        //push(1,8,23,1,2)//部屋見渡し東
        //push(1,1,33,7,3)//前室封鎖封鎖
        //push(11,1,23,8,2)//上記同文
        push(1,4,8,1)//西封鎖
        push(1,1,1,6)//隙間詰め壁
        push(1,1,33,7,3)//前室封鎖会話
    }
    //第一工場セット準備室新規イベント
    if(f.mpnm=='f101_20_01_set'){
        push(2,2,4,11,3)//話しかけフラグ1
        push(2,2,6,17,3)//話しかけフラグ2
        //TODO:壁に変更
        push(1,3,0,6)//立ち入り禁止+話しかけ(西封鎖)
        push(1,2,10,11,3)//立ち入り禁止+話しかけ(東封鎖)
        push(1,1,11,2,2)//移動先変更(計量室へ)
        push(4,1,3,25,3)//フラグチェック門
    }
    //第一工場セット室新規イベント
    if(f.mpnm=='f101_12_25_wap'){
        push(2,2,18,12,3)//話しかけフラグ央
        push(2,2,6,15,3)//話しかけフラグ西
        push(2,1,20,0,3)//フラグチェック門
        push(9,6,1,4,3)//部屋見渡し西
        //TODO:壁に変更
        //push(2,18,23,3,3)//部屋見渡し東
        push(1,1,25,6)//冷凍庫1壁
        push(1,2,24,8)//ふさぎブロック↑
        push(1,1,23,9)//ふさぎブロック2
        push(1,1,25,12)//冷凍庫2壁
        push(1,1,25,17)//冷凍庫3壁
    }
    //第一工場生産管理室新規イベント
    if(f.mpnm=='f101_34_01_pic'){
        push(1,2,2,10,3)//話しかけフラグ西
        push(2,2,21,7,3)//話しかけフラグ東
        push(1,1,15,23,3)//システム室会話
        push(1,2,1,7,3)//立ち入り禁止+話しかけ(西封鎖)
        push(1,2,17,2)//立ち入り禁止(壁)
        push(1,1,27,24,3)//立ち入り禁止+話しかけ(南封鎖)
        push(1,1,11,20)//立ち入り禁止(壁)
        push(1,4,29,4,2)//立ち入り禁止(戻し)
        push(1,1,0,17,2)//移動先変更(セット室へ)

    }

//TODO:①ここにイベントアドレスを入れる

    [endscript ]

    /*
        f.mpnm(マップ名)
        f.label(イベントID)
        の2つで上書きイベントがあるか調べて発火する

        1.モードを指定
        2.現在のマップ名を引数
        3.モード番号のシナリオに飛び、f.labelのイベントを走らせる
        4.終了時に上書きした証拠の変数を刻む


        ラベルの一覧配列を読み込む


        部屋のラベルを上書きして実行できる。
        部屋にすでに*00000がある場合、01.ksに同様のラベルがある場合これに上書きする。
    */

    [iscript ]
    //testalphaにて01.ksを読み込むかの判定処理に使用。使用する数字ラベルを全て羅列する。
        f.arlbl=[];
        //玄関(f201_46_01_ent.ks)
        f.arlbl[1]="131012"//移動先変更
        //前室(f201_39_13_ant.ks)
        f.arlbl[3]="11392"//トリミングイベント
        f.arlbl[4]="21722"//立ち入り禁止
        f.arlbl[5]="11193"//立ち入り禁止
        //f.arlbl[6]="41333"//壁
        //トリミング室(f201_29_01_trm.ks)
        //f.arlbl[7]="2115152"//移動先変更
        f.arlbl[8]="221893"//東封鎖
        //TODO:変更消す
        //f.arlbl[9]="321353"//北封鎖(ゴミ室)
        f.arlbl[9]="321353"//北封鎖(ゴミ室)
        f.arlbl[10]="22753"//上従業員フラグ
        f.arlbl[11]="227133"//下従業員フラグ
        f.arlbl[12]="121103"//全員に話を聞くまで通さない
        //カット室(f201_01_01_mac)
        f.arlbl[13]="222073"//上従業員フラグ
        f.arlbl[14]="2220103"//下従業員フラグ
        f.arlbl[15]="2123143"//全員に話を聞く門
        f.arlbl[16]="1320122"//部屋見渡し床下
        f.arlbl[17]="712262"//部屋見渡し床上
        //計量室(f201_06_15_wgh)
        f.arlbl[18]="1230103"//移動先変更+話を聞く門
        f.arlbl[19]="121553"//央従業員フラグ
        f.arlbl[20]="11863"//西従業員フラグ
        f.arlbl[21]="113373"//前室封鎖会話
        //TODO:ここ消す
        //f.arlbl[21]="113712"//見渡し西
        //f.arlbl[22]="182312"//見渡し東縦
        //f.arlbl[21]="113373"//見渡し西
        //f.arlbl[23]="1112382"//見渡し東横
        //セット準備室(f101_20_01_set.ks)
        f.arlbl[24]="224113"//央従業員フラグ
        f.arlbl[25]="226173"//下従業員フラグ
        f.arlbl[26]="413253"//全員に話を聞く門
        //f.arlbl[27]="13163"//西封鎖
        f.arlbl[28]="1210113"//東封鎖(コンテナ洗浄室)
        f.arlbl[29]="111122"//移動先変更(計量室)
        //セット室(f101_12_25_wap.ks)
        f.arlbl[30]="2218123"//央話しかけフラグ
        f.arlbl[31]="226153"//西話しかけフラグ
        f.arlbl[32]="212003"//フラグチェック門
        f.arlbl[33]="96143"//部屋見渡し西
        //f.arlbl[34]="2182333"//部屋見渡し東
        //生産管理室(f101_34_01_pic)
        f.arlbl[35]="122103"//話しかけフラグ西
        f.arlbl[36]="222173"//話しかけフラグ東
        f.arlbl[37]="1115233"//システム室会話
        f.arlbl[38]="12173"//立ち入り禁止+話しかけ(西封鎖)
        //f.arlbl[39]="121723"//立ち入り禁止(壁)
        f.arlbl[40]="1127243"//立ち入り禁止+話しかけ(南封鎖)
        //f.arlbl[41]="1111203"//立ち入り禁止(壁)
        f.arlbl[42]="142942"//立ち入り禁止(戻し)
        f.arlbl[43]="110172"//移動先変更(セット室へ)

        
//TODO:②この配列にイベントアドレスを入れる
    [endscript ]

    [jump storage="&f.pg" target="*rt_bld2" ]

    ;[return ]
[s]

;記入例
    ; *00000
    ; [if exp="f.mpnm=='マップ名'" ]
    ; ;ここに特殊イベントを入れる


    ; ;これがTの時、本来のイベントは発火しない。
    ; ;再び動いたときにFになる。
    ; @eval exp="f.ismdeve=true"
    ; [endif ]

    ; [return ]
    ; [s]
;/記入例

;部屋初回イベント---
;tf.aoiは超適当に付けた名前。何の意味もないです。
*ant
    [iadv]
    ;TODO:あとで消す(chara_show)
        [show name="hara" side="R"]
        ;[chara_show layer="1" zindex="99" name="hara" face="def"  left="&1280-400" top="&720-700"   ]
        #ハラ
        さっそく工場の白衣に着替えてきたよ。楽しみだね！[p]
        [show name="kuri"]
        ;[chara_show layer="1" zindex="99" name="kuri" face="def"  left="0"  top="&720-700" ]
        #クリ
        そうだね。[p ]
        今日の工場見学は、[<imp]社員さんに話を聞いてきてもらう[>]よ。[p ]
        [<imp]緑の帽子をかぶった人[>]が社員さんなんだって。[p ]
        各部屋に社員さんがいるから、話しかけてみてね。[p ]
        #◇ゲームの目的◇
        各部屋にいる緑色の帽子の人から話を聞いていきましょう。[r]
        話しかけるには、その人の近くでその方向にボタンを押します。[p]
        #ハラ
        はーい！わかりました。[l][r]
        どんな工程があるのか聞けるといいな！[p]
        #クリ
        それじゃあいったん解散！また会おう！[p]
        [chara_hide_all layer="1"]
        #案内人
        それでは「惣菜キット」を作る工程を一緒に見ていきましょう[p]
        [image layer="1" name="photo"  storage="../image/process/p1cab.jpg" pos="c" time="500" ]
        これからめぐるお部屋でこのキャベツがどのように加工されていくのかよく覚えておいてくださいね[p]
        [free layer="1" name="photo"  time="500" ]
        #
    [endadv]
@eval exp="f.fstAnt=true"
[return ]
[s ]

*trm
;trmトリミング室
    [iadv]
        [image layer="1" name="photo" visible="true" storage="../image/process/p2cab.jpg" pos="c" time="500" ]
        #案内人
        キャベツや白菜の芯を取ったり、プリーツレタスをばらしたりなど、[r]野菜の下処理を行います。[p]
        [free layer="1" name="photo"  time="500" ]
        #
    [endadv]
    @eval exp="f.fstTrm=true"
[return ]
[s ]

*mac
;mac(カット室(機械洗浄))
    [iadv]
        [image layer="1" name="photo" visible="true" storage="../image/process/p3cab.jpg" pos="c" time="500" ]
        #案内人
       様々な野菜を様々な規格に専用の機械で切り分けます。[r]洗浄、殺菌、脱水工程までを行います。[p]
        [free layer="1" name="photo"  time="500" ]
        #
    [endadv]
@eval exp="f.fstMac=true"
[return ]
[s ]

*wgh
;計量室
    [iadv]
        [image layer="1" name="photo" visible="true" storage="../image/process/p4cab.jpg" pos="c" time="500" ]
        #案内人
        全ての野菜を重量、枚数、本数によって計量します。[r]
        異物が入っていないか金属探知機を使って検品もしています。[p]
        [free layer="1" name="photo"  time="500" ]
        #
    [endadv]
@eval exp="f.fstWgh=true"
[return ]
[s ]


*set
;set(セット準備室)
    [iadv]
        [image layer="1" name="photo" visible="true" storage="../image/process/p5cab.jpg" pos="c" time="500" ]
        #案内人
        計量室で出来上がった食材と付属品の組み合わせとセット作業を行います。野菜だけでなく、麺・肉・海鮮・タレなどたくさんの具材を扱っています。[p]
        [free layer="1" name="photo"  time="500" ]
        #
    [endadv]
@eval exp="f.fstSet=true"
[return ]
[s ]

*wap
[eval exp="tf.aoi='これはwap(計量包装室(セット室))初回イベント'" ]
[trace exp="tf.aoi" ]
    [iadv]
        #案内人
       セット準備室で計画した通りに食材と付属品の組み合わせとセット作業を行います。[p]
       #
    [endadv]
@eval exp="f.fstWap=true"
[return ]

*pic
[eval exp="tf.aoi='これはpic(ピッキング室(生産管理室))初回イベント'" ]
[trace exp="tf.aoi" ]
    [iadv]
        [image layer="1" name="photo" visible="true" storage="../image/process/p6cab.jpg" pos="c" time="500" ]
        #案内人
        すべての商品がここに集約され、取引先ごとに決められた出荷方法で仕分けをします。[r]製造部の指示出しも行っています。[p]
        [free layer="1" name="photo"  time="500" ]
        #
        [show name="hara" side="R"]
        ;TODO:後で消す(chara_show)
        ;[chara_show layer="1" zindex="99" name="mob" left="0" top="&720-660"   ]
        #ハラ
        ここが最後の部屋だな![p]
        [chara_hide_all layer="1"]
        #
    [endadv]
@eval exp="f.fstPic=true"
[return ]
[s ]

;ラベル数でまとめる

;立ち入り禁止
*21722
;以上のラベルで第二工場前室の時のイベント内容
*142942
;生産管理室も追加
[if exp="f.mpnm=='f201_39_13_ant'||f.mpnm=='f101_34_01_pic'"]
    [trace exp="tf.hoge3='21722か21182ノックバックイベント中'" ]
    [noenter]

    @eval exp="f.ismdeve=true"
[endif ]
[return]
[s]

;移動先変更---

*131012
;移動先変更(第二玄関->第二前室)
[mod_dest dest="f201_39_13_ant" etl="g4r" cond="f.mpnm=='f201_46_01_ent'"]
[jump target="*confirm" cond="f.mpnm=='f201_46_01_ent'"]
[s]

*111122
;移動先変更(セット準備室->計量室)
[mod_dest dest="f201_06_15_wgh" etl="ac10l" cond="f.mpnm=='f101_20_01_set'"]
[jump target="*confirm" cond="f.mpnm=='f101_20_01_set'"]
[s]

*110172
;移動先変更(生産管理室->セット室)
[mod_dest dest="f101_12_25_wap" etl="u1b" cond="f.mpnm=='f101_34_01_pic'"]
[jump target="*confirm" cond="f.mpnm=='f101_34_01_pic'"]
[s]

*confirm
    [dialog text="マップ移動するけどいいかな？" type="confirm" target="*go"  ]
    [knockback]
[return]

*go
    ;マップ生成に必要な色々を削除する

    ;マップに登場するキャラクター・モノ削除
    ;[chara_delete name="akane" ]
    [iscript ]
        //マップ読み込み済みの処理(1度だけの処理を行わない)
        f.isnmp=false;
        //現在のマップ名<=次に呼び出すマップ名
        f.mpnm=tf.mpnm;

         //f.etlを分解収納するsplitをかける
        split(f.etl);//f.povxyzにそれぞれ入る

        //イベント復帰用リセットポイントを初期化
        f.reps.x=undefined;
    [endscript ]
    /*
        問題
        ・01適用のみで出現-＞01に書く
        ・設定していない部屋でもエラーが発生しない仕組み
            -＞ない場合はない画像を用意するnone.png
                ->飛ぶ先が設定しているか確認する方法は？
                -＞設定したという変数を用意する
                どこから飛ぶか、というよりその部屋になったとき(tf.mpnm)に表示させるみたいな感じか
        ・画像ファイルをどこに置くか、名前は

    */

    ;特殊レイヤーを追加する
    ;[image name="field" visible="true" layer="1" folder="bgimage" storage="&'map/'+f.mpnm+'a.png'" x="&f.nx.mp.x" y="&f.nx.mp.y"  wait="false" cond="f.isma"]

    [trace exp="tf.log='01.ks return前'" ]
    [return]
[s]

;=====会話

;第二前室
*11193
;トリミング室東、北封鎖イベント
*221893
;*321353
;TODO:トリミングとセット準備室合体。あとでバラす
;*13163
*1210113
;TODO:生産管理室追加
*12173
;計量室追加
*113373
[if exp="f.mpnm=='f201_29_01_trm'||f.mpnm=='f101_20_01_set'||f.mpnm=='f101_34_01_pic'||f.mpnm=='f201_39_13_ant'||f.mpnm=='f201_06_15_wgh'" ]
    [iscript ]
    if(f.mpnm=='f201_29_01_trm')tf.way='左(←)';
    if(f.mpnm=='f101_20_01_set')tf.way='下(↓)';
    if(f.mpnm=='f201_06_15_wgh')tf.way='下(↓)';
    if(f.mpnm=='f101_34_01_pic')tf.way='右(→)';
    if(f.mpnm=='f201_39_13_ant')tf.way='上(↑)';
    
    [endscript ]
    [iadv]
    [if exp="f.mpnm=='f201_39_13_ant'" ]
    [show name="mbg"]
    ;TODO:あとで消す(chara_show)
    ;[chara_show name="mbg" left="0" top="&720-700"  ]
    #mbg
    そうそう、私みたいな人が「緑の帽子の人」ですよ。[p]
    こんな風に選択肢が出るからね。[p]文字クリックかキーの1or2を押してエンターだよ。[r]
        [font color="0xccc" bold="true"  ]
            [link keyfocus="1" target="113373_1" ][emb exp="(tf.sct[0]!='')?tf.sct[0]:f.sct_def[0];"][endlink ][r]
            [link keyfocus="2" target="113373_2" ][emb exp="(tf.sct[1]!='')?tf.sct[1]:f.sct_def[1];"][endlink ]
        [resetfont]
        [s]
*113373_1
    [cm]
    #mbg
    『取るミング』を使用するかチェックしていますよ[p]

*113373_2
    [cm]
    #mbg
    ああ、そうそう。この選択肢は2回話しかけると新しいのが出たりするから、何回か話しかけてみてね[p]
    もう工場見学に戻りたい？[r]ああどうぞ[p]

    [else ]
    [show name="kuri"]
    #クリ
    ふんふん…なるほどなぁ[r]
    [endif]
    あ、こっちは進行方向じゃないよ、[emb exp="tf.way"]だって。[p]

    [endadv]
    @eval exp="f.ismdeve=true"
[endif ]

[return ]
[s ]

;生産管理室
*1127243
[if exp="f.mpnm=='f101_34_01_pic'" ]
    [iadv]
    #
    ここが第一工場の玄関だって。ところでもう勉強は終わったのかい？[p]

    [endadv]
    @eval exp="f.ismdeve=true"

[endif ]
[return ]
[s]

;生産管理室(システム室)
*1115233
[if exp="f.mpnm=='f101_34_01_pic'" ]
    [iadv]
    #
    ここはシステム室。中には入れられないんだ。ごめんね[p]
    [endadv]
    @eval exp="f.ismdeve=true"

[endif ]
[return ]
[s]


;会話イベント==========================
;---トリミング室---
;従業員フラグ上(トリミング室)
*22753
[if exp="f.mpnm='f201_29_01_trm'" ]

    [iadv ]
    ;TODO:あとで消す(chara_show周り)
        [show name="mbw"]
        ;[chara_show name="akane" top="&720-600" layer="1" ]
        #
            あのー…[l][r]
            [font color="0xccc" bold="true"  ]
                [link keyfocus="1" target="22753_1" ][emb exp="(tf.sct[0]!='')?tf.sct[0]:f.sct_def[0];"][endlink ][r]
                [link keyfocus="2" target="22753_2" ][emb exp="(tf.sct[1]!='')?tf.sct[1]:f.sct_def[1];" cond="f.flg01trm1!==undefined"][endlink ]
            [resetfont]
        [s ]
        *22753_1
            [cm ]
            ;#akane:happy
            #mbw
            キャベツの芯を取っています[p]
            [iscript ]
                if(typeof f.flg01trm1==='undefined'){
                    (typeof f.flg01trm!=='undefined')?f.flg01trm=f.flg01trm+25:f.flg01trm=25;
                    f.flg01trm1=1;
                }
            [endscript ]
            [jump target="*22753_cmn" ]
        [s ]
        *22753_2
            [cm]
            ;#akane:doki
            #mbw
            虫がついていないか見ています[p]
            [iscript ]
                if(f.flg01trm1==1)f.flg01trm=f.flg01trm+25;
                f.flg01trm1++;
            [endscript ]
            [jump target="*22753_cmn" ]
        [s ]
        *22753_cmn
        [cm ]
    [endadv ]
    @eval exp="f.ismdeve=true"
[endif ]
[return ]
[s ]
;従業員フラグ下(トリミング室)
*227133
[if exp="f.mpnm='f201_29_01_trm'" ]
    [iadv ]
    ;TODO:あとで消す(chara_show周り)
        [show name="mbm"]
        ;[chara_show name="akane" top="&720-600" layer="1" ]
        #
            あのー…[l][r]
            [font color="0xccc" bold="true"  ]
                [link keyfocus="1" target="227133_1" ][emb exp="(tf.sct[0]!='')?tf.sct[0]:f.sct_def[0];"][endlink ][r]
                [link keyfocus="2" target="227133_2" ][emb exp="(tf.sct[1]!='')?tf.sct[1]:f.sct_def[1];" cond="f.flg01trm2!==undefined"][endlink ]
            [resetfont]
        [s ]
        *227133_1
            [cm ]
            ;#akane:happy
            #mbm
            プリーツレタスをばらしています[p]
            [iscript ]
                if(typeof f.flg01trm2==='undefined'){
                    (typeof f.flg01trm!=='undefined')?f.flg01trm=f.flg01trm+25:f.flg01trm=25;
                    f.flg01trm2=1;
                }
            [endscript ]
            [jump target="*227133_cmn" ]
        [s ]
        *227133_2
            [cm]
            ;#akane:doki
            #mbm
            野菜の鮮度に気を付けます[p]
            [iscript ]
                if(f.flg01trm2==1)f.flg01trm=f.flg01trm+25;
                f.flg01trm2++;
            [endscript ]
            [jump target="*227133_cmn" ]
        [s ]
        *227133_cmn
        [cm ]
    [endadv ]

@eval exp="f.ismdeve=true"
[endif ]
[return ]
[s ]

;トリミング室全員話したかチェック
*121103
[if exp="f.mpnm='f201_29_01_trm'" ]
    [ignore exp="f.flg01trm==true" ]
        [iadv ]
            @eval exp="if(typeof f.flg01trm==='undefined')f.flg01trm=0"
            #
            現在の勉強率は[emb exp="f.flg01trm" ]/100です。[l][er]
            [if exp="f.flg01trm==100"]
                #
                条件を満たしました。次は『カット室』です。[p]
                [eval exp="f.flg01trm=true"]
                    [else ]
                #
                条件を満たしていません。緑色の帽子の人物からお話を聞いてきてください[l][r]
                この部屋には2名います。[p]
            [endif ]
        [endadv ]
    [endignore ]
    [mod_dest dest="f201_01_01_mac" etl="ab10l" cond="f.flg01trm"]
    [jump target="*confirm" cond="f.flg01trm"]

    @eval exp="f.ismdeve=true"
[endif ]
[return ]
[s ]

;---カット室---
;従業員フラグ上(カット室)
*222073
[if exp="f.mpnm='f201_01_01_mac'" ]

    [iadv ]
    ;TODO:あとで消す(chara_show周り)
        [show name="mbw"]
        ;[chara_show name="akane" top="&720-600" layer="1" ]
        #
            あのー…[l][r]
            [font color="0xccc" bold="true"  ]
                [link keyfocus="1" target="222073_1" ][emb exp="(tf.sct[0]!='')?tf.sct[0]:f.sct_def[0];"][endlink ][r]
                [link keyfocus="2" target="222073_2" ][emb exp="(tf.sct[1]!='')?tf.sct[1]:f.sct_def[1];" cond="f.flg01mac1!==undefined"][endlink ]
            [resetfont]
        [s ]
        *222073_1
            [cm ]
            ;#akane:happy
            #mbw
            規格を合わせてスライサーでカットしています[p]
            [iscript ]
                if(typeof f.flg01mac1==='undefined'){
                    (typeof f.flg01mac!=='undefined')?f.flg01mac=f.flg01mac+25:f.flg01mac=25;
                    f.flg01mac1=1;
                }
            [endscript ]
            [jump target="*222073_cmn" ]
        [s ]
        *222073_2
            [cm]
            ;#akane:doki
            #mbw
            規格を間違わないように合わせています[p]
            [iscript ]
                if(f.flg01mac1==1)f.flg01mac=f.flg01mac+25;
                f.flg01mac1++;
            [endscript ]
            [jump target="*222073_cmn" ]
        [s ]
        *222073_cmn
        [cm ]
    [endadv ]
    @eval exp="f.ismdeve=true"
[endif ]
[return ]
[s ]
;従業員フラグ下(カット室)
*2220103
[if exp="f.mpnm='f201_01_01_mac'" ]
    [iadv ]
    ;TODO:あとで消す(chara_show周り)
        [show name="mbm"]
        ;[chara_show name="akane" top="&720-600" layer="1" ]
        #
            あのー…[l][r]
            [font color="0xccc" bold="true"  ]
                [link keyfocus="1" target="2220103_1" ][emb exp="(tf.sct[0]!='')?tf.sct[0]:f.sct_def[0];"][endlink ][r]
                [link keyfocus="2" target="2220103_2" ][emb exp="(tf.sct[1]!='')?tf.sct[1]:f.sct_def[1];" cond="f.flg01mac2!==undefined"][endlink ]
            [resetfont]
        [s ]
        *2220103_1
            [cm ]
            ;#akane:happy
            #mbm
            洗浄後の野菜を脱水しています[p]
            [iscript ]
                if(typeof f.flg01mac2==='undefined'){
                    (typeof f.flg01mac!=='undefined')?f.flg01mac=f.flg01mac+25:f.flg01mac=25;
                    f.flg01mac2=1;
                }
            [endscript ]
            [jump target="*2220103_cmn" ]
        [s ]
        *2220103_2
            [cm]
            ;#akane:doki
            #mbm
            洗浄、殺菌の時間に気を付けます[p]
            [iscript ]
                if(f.flg01mac2==1)f.flg01mac=f.flg01mac+25;
                f.flg01mac2++;
            [endscript ]
            [jump target="*2220103_cmn" ]
        [s ]
        *2220103_cmn
        [cm ]
    [endadv ]

@eval exp="f.ismdeve=true"
[endif ]
[return ]
[s ]

;カット室全員話したかチェック
*2123143
[if exp="f.mpnm='f201_01_01_mac'" ]
    [ignore exp="f.flg01mac==true"" ]
        [iadv ]
            @eval exp="if(typeof f.flg01mac==='undefined')f.flg01mac=0"
            #
            現在の勉強率は[emb exp="f.flg01mac" ]/100です。[l][er]
            [if exp="f.flg01mac==100"]
            #
            条件を満たしました。次は『計量室』です。[p]
            [eval exp="f.flg01mac=true"]
                [else ]
            #
            条件を満たしていません。緑色の帽子の人物からお話を聞いてきてください[l][r]
            この部屋には2名います。[p]
            [endif ]
        [endadv ]
    [endignore ]
    [mod_dest dest="f201_06_15_wgh" etl="r1b" cond="f.flg01mac"]
    [jump target="*confirm" cond="f.flg01mac"]

    @eval exp="f.ismdeve=true"
[endif ]
[return ]
[s ]

;---計量室---
;従業員フラグ央(計量室)
*121553
[if exp="f.mpnm='f201_06_15_wgh'" ]

    [iadv ]
        ;TODO:あとで消す(chara_show周り)
        ;[chara_show name="akane" top="&720-600" layer="1" ]
        [show name="mbw"]
        #
            あのー…[l][r]
            [font color="0xccc" bold="true"  ]
                [link keyfocus="1" target="121553_1" ][emb exp="(tf.sct[0]!='')?tf.sct[0]:f.sct_def[0];"][endlink ][r]
                [link keyfocus="2" target="121553_2" ][emb exp="(tf.sct[1]!='')?tf.sct[1]:f.sct_def[1];" cond="f.flg01wgh1!==undefined"][endlink ]
            [resetfont]
        [s ]
        *121553_1
            [cm ]
            ;#akane:happy
            #mbw
            ピーマンを量ってパックしています[p]
            [iscript ]
                if(typeof f.flg01wgh1==='undefined'){
                    (typeof f.flg01wgh!=='undefined')?f.flg01wgh=f.flg01wgh+25:f.flg01wgh=25;
                    f.flg01wgh1=1;
                }
            [endscript ]
            [jump target="*121553_cmn" ]
        [s ]
        *121553_2
            [cm]
            ;#akane:doki
            #mbw
            野菜の変色に気を付けています[p]
            [iscript ]
                if(f.flg01wgh1==1)f.flg01wgh=f.flg01wgh+25;
                f.flg01wgh1++;
            [endscript ]
            [jump target="*121553_cmn" ]
        [s ]
        *121553_cmn
        [cm ]
    [endadv ]
    @eval exp="f.ismdeve=true"
[endif ]
[return ]
[s ]
;従業員フラグ西(計量室)
*11863
[if exp="f.mpnm='f201_06_15_wgh'" ]
    [iadv ]
    ;TODO:あとで消す(chara_show周り)
        ;[chara_show name="akane" top="&720-600" layer="1" ]
        [show name="mbm"]
        #
            あのー…[l][r]
            [font color="0xccc" bold="true"  ]
                [link keyfocus="1" target="11863_1" ][emb exp="(tf.sct[0]!='')?tf.sct[0]:f.sct_def[0];"][endlink ][r]
                [link keyfocus="2" target="11863_2" ][emb exp="(tf.sct[1]!='')?tf.sct[1]:f.sct_def[1];" cond="f.flg01wgh2!==undefined"][endlink ]
            [resetfont]
        [s ]
        *11863_1
            [cm ]
            ;#akane:happy
            #mbm
            千切りキャベツを真空パックしています[p]
            [iscript ]
                if(typeof f.flg01wgh2==='undefined'){
                    (typeof f.flg01wgh!=='undefined')?f.flg01wgh=f.flg01wgh+25:f.flg01wgh=25;
                    f.flg01wgh2=1;
                }
            [endscript ]
            [jump target="*11863_cmn" ]
        [s ]
        *11863_2
            [cm]
            ;#akane:doki
            #mbm
            数量間違いがないようにカウントします[p]
            [iscript ]
                if(f.flg01wgh2==1)f.flg01wgh=f.flg01wgh+25;
                f.flg01wgh2++;
            [endscript ]
            [jump target="*11863_cmn" ]
        [s ]
        *11863_cmn
        [cm ]
    [endadv ]

@eval exp="f.ismdeve=true"
[endif ]
[return ]
[s ]

;計量室全員話したかチェック
*1230103
[if exp="f.mpnm='f201_06_15_wgh'" ]
    [ignore exp="f.flg01wgh==true"" ]
        [iadv ]
            @eval exp="if(typeof f.flg01wgh==='undefined')f.flg01wgh=0"
            #
            現在の勉強率は[emb exp="f.flg01wgh" ]/100です。[l][er]
            [if exp="f.flg01wgh==100"]
            #
            条件を満たしました。次は『セット準備室』です。[p]
            [eval exp="f.flg01wgh=true"]
                [else ]
            #
            条件を満たしていません。緑色の帽子の人物からお話を聞いてきてください[l][r]
            この部屋には2名います。[p]
            [endif ]
        [endadv ]
    [endignore ]
    [mod_dest dest="f101_20_01_set" etl="j2l" cond="f.flg01wgh"]
    [jump target="*confirm" cond="f.flg01wgh"]

    @eval exp="f.ismdeve=true"
[endif ]
[return ]
[s ]

;---セット準備室---
;従業員フラグ央(セット準備室)
*224113
[if exp="f.mpnm='f101_20_01_set'" ]

    [iadv ]
    ;TODO:あとで消す(chara_show周り)
        ;[chara_show name="akane" top="&720-600" layer="1" ]
        [show name="mbw"]
        #
            あのー…[l][r]
            [font color="0xccc" bold="true"  ]
                [link keyfocus="1" target="224113_1" ][emb exp="(tf.sct[0]!='')?tf.sct[0]:f.sct_def[0];"][endlink ][r]
                [link keyfocus="2" target="224113_2" ][emb exp="(tf.sct[1]!='')?tf.sct[1]:f.sct_def[1];" cond="f.flg01set1!==undefined"][endlink ]
            [resetfont]
        [s ]
        *224113_1
            [cm ]
            ;#akane:happy
            #mbw
            必要な肉を冷蔵庫から運んでいます[p]
            [iscript ]
                if(typeof f.flg01set1==='undefined'){
                    (typeof f.flg01set!=='undefined')?f.flg01set=f.flg01set+25:f.flg01set=25;
                    f.flg01set1=1;
                }
            [endscript ]
            [jump target="*224113_cmn" ]
        [s ]
        *224113_2
            [cm]
            ;#akane:doki
            #mbw
            名前が似ているものやサイズの近い物の入れ間違いに気を付けています[p]
            [iscript ]
                if(f.flg01set1==1)f.flg01set=f.flg01set+25;
                f.flg01set1++;
            [endscript ]
            [jump target="*224113_cmn" ]
        [s ]
        *224113_cmn
        [cm ]
    [endadv ]
    @eval exp="f.ismdeve=true"
[endif ]
[return ]
[s ]
;従業員フラグ下(セット準備室)
*226173
[if exp="f.mpnm='f101_20_01_set'" ]
    [iadv ]
    ;TODO:あとで消す(chara_show周り)
        ;[chara_show name="akane" top="&720-600" layer="1" ]
        [show name="mbm"]
        #
            あのー…[l][r]
            [font color="0xccc" bold="true"  ]
                [link keyfocus="1" target="226173_1" ][emb exp="(tf.sct[0]!='')?tf.sct[0]:f.sct_def[0];"][endlink ][r]
                [link keyfocus="2" target="226173_2" ][emb exp="(tf.sct[1]!='')?tf.sct[1]:f.sct_def[1];" cond="f.flg01set2!==undefined"][endlink ]
            [resetfont]
        [s ]
        *226173_1
            [cm ]
            ;#akane:happy
            #mbm
            商品企画書を見て具材を準備しています[p]
            [iscript ]
                if(typeof f.flg01set2==='undefined'){
                    (typeof f.flg01set!=='undefined')?f.flg01set=f.flg01set+25:f.flg01set=25;
                    f.flg01set2=1;
                }
            [endscript ]
            [jump target="*226173_cmn" ]
        [s ]
        *226173_2
            [cm]
            ;#akane:doki
            #mbm
            材料を過不足なく集めることです[p]
            [iscript ]
                if(f.flg01set2==1)f.flg01set=f.flg01set+25;
                f.flg01set2++;
            [endscript ]
            [jump target="*226173_cmn" ]
        [s ]
        *226173_cmn
        [cm ]
    [endadv ]

@eval exp="f.ismdeve=true"
[endif ]
[return ]
[s ]

;セット準備室全員話したかチェック
*413253
[if exp="f.mpnm='f101_20_01_set'" ]
    [ignore exp="f.flg01set==true"" ]
        [iadv ]
            @eval exp="if(typeof f.flg01set==='undefined')f.flg01set=0"
            #
            現在の勉強率は[emb exp="f.flg01set" ]/100です。[l][er]
            [if exp="f.flg01set==100"]
            #
            条件を満たしました。次は『セット室』です。[p]
            [eval exp="f.flg01set=true"]
                [else ]
            #
            条件を満たしていません。緑色の帽子の人物からお話を聞いてきてください[l][r]
            この部屋には2名います。[p]
            [endif ]
        [endadv ]
    [endignore ]
    [mod_dest dest="f101_12_25_wap" etl="k1b" cond="f.flg01set"]
    [jump target="*confirm" cond="f.flg01set"]

    @eval exp="f.ismdeve=true"
[endif ]
[return ]
[s ]

;---セット室---
;従業員フラグ央(セット室)
*2218123
[if exp="f.mpnm='f101_12_25_wap'" ]

    [iadv ]
    ;TODO:あとで消す(chara_show周り)
        ;[chara_show name="akane" top="&720-600" layer="1" ]
        [show name="mbw"]
        #
            あのー…[l][r]
            [font color="0xccc" bold="true"  ]
                [link keyfocus="1" target="2218123_1" ][emb exp="(tf.sct[0]!='')?tf.sct[0]:f.sct_def[0];"][endlink ][r]
                [link keyfocus="2" target="2218123_2" ][emb exp="(tf.sct[1]!='')?tf.sct[1]:f.sct_def[1];" cond="f.flg01wap1!==undefined"][endlink ]
            [resetfont]
        [s ]
        *2218123_1
            [cm ]
            ;#akane:happy
            #mbw
            準備してくれた具材を1商品ごとにセットアップしています[p]
            [iscript ]
                if(typeof f.flg01wap1==='undefined'){
                    (typeof f.flg01wap!=='undefined')?f.flg01wap=f.flg01wap+25:f.flg01wap=25;
                    f.flg01wap1=1;
                }
            [endscript ]
            [jump target="*2218123_cmn" ]
        [s ]
        *2218123_2
            [cm]
            ;#akane:doki
            #mbw
            材料の入れ間違いがないようにしています[p]
            [iscript ]
                if(f.flg01wap1==1)f.flg01wap=f.flg01wap+25;
                f.flg01wap1++;
            [endscript ]
            [jump target="*2218123_cmn" ]
        [s ]
        *2218123_cmn
        [cm ]
    [endadv ]
    @eval exp="f.ismdeve=true"
[endif ]
[return ]
[s ]
;従業員フラグ下(セット室)
*226153
[if exp="f.mpnm='f101_12_25_wap'" ]
    [iadv ]
    ;TODO:あとで消す(chara_show周り)
        ;[chara_show name="akane" top="&720-600" layer="1" ]
        [show name="mbm"]
        #
            あのー…[l][r]
            [font color="0xccc" bold="true"  ]
                [link keyfocus="1" target="226153_1" ][emb exp="(tf.sct[0]!='')?tf.sct[0]:f.sct_def[0];"][endlink ][r]
                [link keyfocus="2" target="226153_2" ][emb exp="(tf.sct[1]!='')?tf.sct[1]:f.sct_def[1];" cond="f.flg01wap2!==undefined"][endlink ]
            [resetfont]
        [s ]
        *226153_1
            [cm ]
            ;#akane:happy
            #mbm
            海老の計量とパックをしています[p]
            [iscript ]
                if(typeof f.flg01wap2==='undefined'){
                    (typeof f.flg01wap!=='undefined')?f.flg01wap=f.flg01wap+25:f.flg01wap=25;
                    f.flg01wap2=1;
                }
            [endscript ]
            [jump target="*226153_cmn" ]
        [s ]
        *226153_2
            [cm]
            ;#akane:doki
            #mbm
            決められた時間に次の部署に出せるようにしています[p]
            [iscript ]
                if(f.flg01wap2==1)f.flg01wap=f.flg01wap+25;
                f.flg01wap2++;
            [endscript ]
            [jump target="*226153_cmn" ]
        [s ]
        *226153_cmn
        [cm ]
    [endadv ]

@eval exp="f.ismdeve=true"
[endif ]
[return ]
[s ]

;セット室全員話したかチェック
*212003
[if exp="f.mpnm='f101_12_25_wap'" ]
    [ignore exp="f.flg01wap==true"" ]
        [iadv ]
            @eval exp="if(typeof f.flg01wap==='undefined')f.flg01wap=0"
            #
            現在の勉強率は[emb exp="f.flg01wap" ]/100です。[l][er]
            [if exp="f.flg01wap==100"]
            #
            条件を満たしました。次は『生産管理室』です。[p]
            [eval exp="f.flg01wap=true"]
                [else ]
            #
            条件を満たしていません。緑色の帽子の人物からお話を聞いてきてください[l][r]
            この部屋には2名います。[p]
            [endif ]
        [endadv ]
    [endignore ]
    [mod_dest dest="f101_34_01_pic" etl="a17r" cond="f.flg01wap"]
    [jump target="*confirm" cond="f.flg01wap"]

    @eval exp="f.ismdeve=true"
[endif ]
[return ]
[s ]

;---生産管理室---
;従業員フラグ西(生産管理室)
*122103
[if exp="f.mpnm='f101_34_01_pic'" ]

    [iadv ]
    ;TODO:あとで消す(chara_show)
        ;[chara_show name="akane" top="&720-600" layer="1" ]
        [show name="mbw"]
        #
            あのー…[l][r]
            [font color="0xccc" bold="true"  ]
                [link keyfocus="1" target="122103_1" ][emb exp="(tf.sct[0]!='')?tf.sct[0]:f.sct_def[0];"][endlink ][r]
                [link keyfocus="2" target="122103_2" ][emb exp="(tf.sct[1]!='')?tf.sct[1]:f.sct_def[1];" cond="f.flg01pic1!==undefined"][endlink ]
            [resetfont]
        [s ]
        *122103_1
            [cm ]
            ;#akane:happy
            #mbw
            商品ラベルシールを貼っています[p]
            [iscript ]
                if(typeof f.flg01pic1==='undefined'){
                    (typeof f.flg01pic!=='undefined')?f.flg01pic=f.flg01pic+25:f.flg01pic=25;
                    f.flg01pic1=1;
                }
            [endscript ]
            [jump target="*122103_cmn" ]
        [s ]
        *122103_2
            [cm]
            ;#akane:doki
            #mbw
            出荷時間に遅れないようにします[p]
            [iscript ]
                if(f.flg01pic1==1)f.flg01pic=f.flg01pic+25;
                f.flg01pic1++;
            [endscript ]
            [jump target="*122103_cmn" ]
        [s ]
        *122103_cmn
        [cm ]
    [endadv ]
    @eval exp="f.ismdeve=true"
[endif ]
[return ]
[s ]
;従業員フラグ東(生産管理室)
*222173
[if exp="f.mpnm='f101_34_01_pic'" ]
    [iadv ]
    ;TODO:あとで消す(chara_show周り)
        ;[chara_show name="akane" top="&720-600" layer="1" ]
        [show name="mbm"]
        #
            あのー…[l][r]
            [font color="0xccc" bold="true"  ]
                [link keyfocus="1" target="222173_1" ][emb exp="(tf.sct[0]!='')?tf.sct[0]:f.sct_def[0];"][endlink ][r]
                [link keyfocus="2" target="222173_2" ][emb exp="(tf.sct[1]!='')?tf.sct[1]:f.sct_def[1];" cond="f.flg01pic2!==undefined"][endlink ]
            [resetfont]
        [s ]
        *222173_1
            [cm ]
            ;#akane:happy
            #mbm
            行先ごとに商品を仕分けしています[p]
            [iscript ]
                if(typeof f.flg01pic2==='undefined'){
                    (typeof f.flg01pic!=='undefined')?f.flg01pic=f.flg01pic+25:f.flg01pic=25;
                    f.flg01pic2=1;
                }
            [endscript ]
            [jump target="*222173_cmn" ]
        [s ]
        *222173_2
            [cm]
            ;#akane:doki
            #mbm
            行先、数を間違えないようにしています[p]
            [iscript ]
                if(f.flg01pic2==1)f.flg01pic=f.flg01pic+25;
                f.flg01pic2++;
            [endscript ]
            [jump target="*222173_cmn" ]
        [s ]
        *222173_cmn
        [cm ]
    [endadv ]

@eval exp="f.ismdeve=true"
[endif ]
[return ]
[s ]

;TODO:③従業員会話フラグ関連を入れる

;動画イベント==========================

;前室トリミングイベント追記
*11392
    [if exp="f.mpnm=='f201_39_13_ant'" ]
        [ignore exp="f.istoruming" ]
            [iadv ]
                [show name="mbg"]
                ;[chara_show name="mbg" left="0" top="&720-700"  ]
                #社員さん
                ちょっと待って！[p]
                ここから先は衣服の埃や髪の毛を取ってから進んでください。[r]
                そこにある『取るミング』を使ってね[p]
                #
                動画を見て『取るミング』をしよう。[p]
                [chara_hide name="mbg" wait="true" left="0" top="&720-700"]
            [endadv ]
        [endignore ]
        [iscript ]
            tf.url='https://www.youtube.com/embed/'+'TnX09mIwdI0'
            f.ismdeve=true
        [endscript ]

        [dialog type="confirm" text="動画を見ますか?(youtubeへ接続します)" target_cancel="*11392_f"]
        ;ここで動画を出す
            [clearfix ]
            [cm ]
            [html ]
                <iframe id="videoFrame" width="1280" height="720" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture;" allowfullscreen mute="1"></iframe>  
                [endhtml ]
                [eval exp="document.getElementById('videoFrame').src= tf.url;" ]
                [glink target="*11392_t" text="動画を閉じる" x="1000" y="60" color="btn_12_blue"]
            [s]
        *11392_f
        @eval exp="tf.nxjump='cancel'"
    [endif ]
    [jump target="*11392_cancel" cond="tf.nxjump=='cancel'&&f.mpnm=='f201_39_13_ant'"]
    *11392_t
    [wait_cancel]
    [cm ]
    [eval exp="f.istoruming=true" cond="f.mpnm=='f201_39_13_ant'"]
[return ]
[s ]
*11392_cancel
    [ignore exp="f.istoruming" ]
        [iadv ]
            #社員さん
            使わないならここは通せないな。[p]
        [endadv ]
        @eval exp="tf.nxjump=''"
        [noenter]
    [endignore ]
[return ]
[s ]

;カット室より
*1320122
*712262
;計量室より
/*
*113712
*182312
*1112382
*/
;セット室より
*96143
;*2182333


;TODO:トリミングイベント用に変更してみる
    [iscript ]
        //カット室
        if(f.label=='1320122')tf.txt='ここから先を見渡せるみたいだ。',tf.url='lqLNYD2AgV0';//部屋見渡し下
        if(f.label=='712262')tf.txt='ここから先を見渡せるみたいだ。',tf.url='WbnmksW7vTA';//部屋見渡し上
        //計量室
        /*
        if(f.label=='113712')tf.txt='ここから先を見渡せるみたいだ。',tf.url='fjjR9f7NFNo';//部屋見渡し西
        if(f.label=='182312'||f.label=='1112382')tf.txt='ここから先を見渡せるみたいだ。',tf.url='tN_ZcXQQ2Yw';//部屋見渡し東
        */
        //セット室
        if(f.label=='96143')tf.txt='ここから先を見渡せるみたいだ。',tf.url='rdBZObyktmI';//部屋見渡し西
        //if(f.label=='2182333')tf.txt='ここから先を見渡せるみたいだ。',tf.url='vRp_R3ScnhQ';//部屋見渡し東


        tf.url='https://www.youtube.com/embed/'+tf.url+'?mute=1'
        tf.moveve = f.mpnm=='f201_01_01_mac'||
                    f.mpnm=='f201_06_15_wgh'||
                    f.mpnm=='f101_12_25_wap';
    [endscript ]
[if exp="tf.moveve" ]
    [iadv]
        #
        [emb exp="tf.txt" ][p]
    [endadv]
    @eval exp="f.ismdeve=true;tf.moveve='';"

    [dialog type="confirm" text="動画を見ますか?(youtubeへ接続します)" target_cancel="*mov_f"]
    ;ここで動画を出す
        [clearfix ]
        [cm ]
        [html ]
            <iframe id="videoFrame" width="1280" height="720" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture;" allowfullscreen mute="1"></iframe>  
            [endhtml ]
            [eval exp="document.getElementById('videoFrame').src= tf.url;" ]
            [glink target="*mov_t" text="動画を閉じる" x="1000" y="60" color="btn_12_blue"]
        [s]
    *mov_f
    @eval exp="tf.nxjump='cancel'"
[endif ]
    [jump target="*mov_cancel" cond="tf.nxjump=='cancel'"]
    *mov_t
    [wait_cancel]
    [cm ]
    [knockback]
    [return ]
[s]

*mov_cancel
    @eval exp="tf.nxjump=''"
    [noenter]
[return ]
[s ]