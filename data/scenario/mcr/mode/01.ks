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


注意
現本にあるイベントの上書きのうち、以下は不可能。
- 移動先の上書きのとき、移動先が原本にあり移動先の初期位置が設定されている場合
- 移動のときは原本.ksを通って変更した内容がさらに上書きされるため。
*/

;初回読み込み用(bsc呼び出し)
[macro name="evt_fst"]
    ; [trace exp="&`'現在'+f.mode+'モードです'`" ]
[skipstart]
    [iadv]
        [bgm nm="talk"]
        [chara_config pos_mode="false" ]
        [show name="kuri" face="suit"]
        #マロン
        こんにちは！[<mid]工場見学隊のマロン[>]です！[l][r]
        今日はクリハラの工場内を探検しましょう。頑張りましょうね！[p]
        /*
            ここで名前入力
        */

    ;     [edit left="600" top="200" name="f.playername" initial="あなた" maxchars="6"]
    ;     [show name="pl" face="suit" side="R"]

    ;     [glink color="btn_01_red" text="あなたの名前を決定→" target=next x=600 y=300 cm=false]
    ;     [s]

    ;     *next
    ;     [commit name="f.playername"]
    ;     [cm]

    ;     [reg_chara01]
    ;     [show name="pl" face="suit" side="R"]
    ;     #pl
    ;     はーい！[p]
    ;     ;[l]同じく[<mid][emb exp="f.playername"][>]です！[p]
    ;     #案内人
    ;     それではみなさん、2Fの更衣室で白衣に着替えてください[p]
    ;     [se nm="imp"]
    ;     [image name="keyboard" layer="1" folder="image/tutorial" storage="keyboard.png" width="400" left="&1280/2-200" top="0" ]
    ;     #◇操作説明◇
    ;     画面左下の十字ボタンをクリック、あるいはキーボードの十字キーで[<mid][emb exp="f.playername"][>]を動かすことができます。[p]
    ;     [<imp]Shiftキーを押しながら十字キーを長押し[>]で少し早く動けます。[p]
    ;     [free name="keyboard" layer="1" time="2000"]
    ;     さっそく階段へ移動しましょう![p]

    ;     [se nm="imp"]
    ;     #pl
    ;     [<imp]階段を上って更衣室で着替える[>]だったね。[l ]よし、行こう![p]
    ;      @eval exp="f.isevt_fst=true"
    ;     [mask time="1000" ]
    ;     [fadeoutbgm]
    ;     [wait time="1000" ]

    ; [endadv]

    ; ///////////
    ; 省略用
    [iscript]
         f.isevt_fst=true
         f.playername="あなた"
    [endscript]
    ; ///////////

    [endadv]
[skipstop]
    ;エンジンの限界で、一度にfor文まで処理ができないためここで再起動させる。
    ;もっかい破壊
    [destroy]
    ;マップに登場するキャラクター・モノ宣言
    ;[call storage="&'map/'+tf.stmap+'.ks'" target="*dec" cond="!f.isnmp" ]
    ;全体創造。レイヤー1読込処理をtrueに戻す(処理後falseになる)
    [iscript ]
        tf.mpnm=tf.stmap;
        f.isnmp=false;
        f.isma=true;//aと01を表示するか否か。
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
    ; [dialog text="通った"]

    ;収回場(第一工場玄関・プラットフォーム)
    [call target="ent" cond="f.mpnm=='f101_62_01_ent'&&f.fstEnt!=true"]


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

        f.end01=true;
    [endscript ]

    [if exp="f.end01&&!f.isevt_end1"]
        [iadv ]
            [se nm="eye"]
            [bgm nm="talk"]
            #収集回収トラック
            トラックが来たよ！[p]
            [show name="kuri"]

            #kuri
            やあ！どうやらトラックが来たみたいだね。[r]
            [emb exp="f.playername"]、積み込みを見に行こう。この部屋の右から外に出よう。[p]

            @eval exp="f.isevt_end1=true"

            @eval exp="f.evt_ed01=true"
            [chara_hide_all layer="1"]
        [endadv]
    [endif ]



    ; [if exp="f.end01" ]
    ;     [iadv ]
    ;     [se nm="eye"]
    ;     [bgm nm="talk"]
    ;     [show name="kuri"]
    ;         #kuri
    ;         おつかれさま！回ってこられた？[p ]
    ;     [show name="pl" side="R"]
    ;         #pl
    ;         うん！一通り見てきたよ！[p ]
    ;         社員さんに話を聞けたよ。[p ]
    ;         #kuri
    ;         それは良かった！[p ]
    ;         クリハラでは野菜のカットを含めた「惣菜キット」を作っていることがわかったね。[p ]
    ;         #pl
    ;         そうだね！スーパーでどんなお惣菜になるのか、ワクワクするね！[p ]
    ;         #kuri
    ;         それでは今日の工場見学は終わりだよ。[p ]
    ;         もっとクリハラのことを知りたい！と思ったら、ぜひリアルの工場見学もしてみてね。[p ]
    ;     [mask time="2000" ]
    ;     [wait time="2000" ]

    ;     [endadv ]
    ;     [dialog text="タイトル画面に戻ります" ]
    ;     [destroy ]
    ;     [mask_off time="50" ]
    ;     [jump storage="titlever2.ks" ]
    ; [endif ]
[endmacro ]

;移動先変更マクロ
;移動先部屋名/移動先初期位置
;[mod_dest dest="" etl="" cond="適用する部屋名"]
[macro name="mod_dest" ]
    [iscript ]
    //キャンセル対策に現在のmpnm,etlを保持しておく
        tf.mpnm_bu=tf.mpnm
        tf.mpnm=mp.dest
        tf.etl=f.etl
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
    f.mod_image[9]='f101_62_01_ent';
    

[endscript ]

;キャラ登録
    [chara_config pos_mode="false" ]
    [macro name="reg_chara01"]
        [chara_new name="pl" jname="&f.playername" storage="chara/hara1.png"]
        [chara_face name="pl" face="suit" storage="chara/hara0.png"]
    [endmacro]
    [macro name="reg_chara02"]
        [chara_new name="kuri" jname="マロン" storage="chara/kuri1.png"]
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
        [chara_show name="&mp.name" layer="1" zindex="99" name="&mp.name" face="%face|default"  left="&mp.left" top="&720-700" time="500"]
    [endmacro]

;話しかけシステム雛形マクロ===
[iscript ]
    f.sct_def=[];
    f.sct_def[0]='◆何をしていますか？[1]';
    f.sct_def[1]='◇どんなことを気を付けていますか？[2]';
    tf.sct=['',''];

    //会話内容
    f.talkto=[];
    f.talkto['trm']=[];//トリミング室
    f.talkto['trm'][0]=[];
    f.talkto['trm'][0][0]='キャベツの芯を取っています';
    f.talkto['trm'][0][1]='虫がついていないか見ています';
    f.talkto['trm'][1]=[];
    f.talkto['trm'][1][0]='プリーツレタスをばらしています';
    f.talkto['trm'][1][1]='野菜の鮮度に気を付けます';
    f.talkto['mac']=[];//カット室
    f.talkto['mac'][0]=[];
    f.talkto['mac'][0][0]='規格を合わせてスライサーでカットしています';
    f.talkto['mac'][0][1]='規格を間違わないように合わせています';
    f.talkto['mac'][1]=[];
    f.talkto['mac'][1][0]='野菜を機械でカットしています';
    f.talkto['mac'][1][1]='出荷量にあわせた量を切るようにしています';
    f.talkto['wgh']=[];//計量室
    f.talkto['wgh'][0]=[];
    f.talkto['wgh'][0][0]='ピーマンを量ってパックしています';
    f.talkto['wgh'][0][1]='野菜の変色に気を付けています';
    f.talkto['wgh'][1]=[];
    f.talkto['wgh'][1][0]='千切りキャベツを真空パックしています';
    f.talkto['wgh'][1][1]='穴が開いて真空漏れしていないか確認しています';
    f.talkto['set']=[];//セット準備室
    f.talkto['set'][0]=[];
    f.talkto['set'][0][0]='必要な肉を冷蔵庫から運んでいます';
    f.talkto['set'][0][1]='名前が似ているものやサイズの近い物の入れ間違いに気を付けています';
    f.talkto['set'][1]=[];
    f.talkto['set'][1][0]='商品規格書を見て具材を準備しています';
    f.talkto['set'][1][1]='材料を過不足なく集めることです';   
    f.talkto['wap']=[];//セット室
    f.talkto['wap'][0]=[];
    f.talkto['wap'][0][0]='準備してくれた具材を1キットごとにセットアップしています';
    f.talkto['wap'][0][1]='材料の入れ間違いがないようにしています';
    f.talkto['wap'][1]=[];
    f.talkto['wap'][1][0]='海老の計量とパックをしています';
    f.talkto['wap'][1][1]='決められた時間に次の部署に出せるようにしています'; 
    f.talkto['pic']=[];//生産管理室
    f.talkto['pic'][0]=[];
    f.talkto['pic'][0][0]='商品ラベルシールを貼っています';
    f.talkto['pic'][0][1]='出荷時間に遅れないようにします';
    f.talkto['pic'][1]=[];
    f.talkto['pic'][1][0]='行先ごとに商品を仕分けしています';
    f.talkto['pic'][1][1]='行先、数を間違えないようにしています';
    


[endscript ]

;勉強チェックマシーン
[macro name="checkstudy"]
    [iscript ]
        tf.next=mp.next;
        tf.c=mp.c;
    [endscript ]
    [ignore exp="tf.c==true" ]
        [iadv ]
            @eval exp="if(typeof tf.c==='undefined')tf.c=0"
            #
            現在の勉強率は[emb exp="tf.c" ]/100です。[l][er]
            [if exp="tf.c==100"]
                #
                [se nm="ok"]
                条件を満たしました。次は『[emb exp="tf.next"]』です。[p]
                [else ]
                #
                [se nm="ng"]
                条件を満たしていません。緑色の帽子の人物からお話を聞いてきてください[l][r]
                この部屋には2名います。[p]
            [endif ]
        [endadv ]
    [endignore ]
[endmacro]


; アナウンスマクロ化
[macro name="announcement"]
    [iscript ]
    f.add='../image/process/';
    f.arraytext=[];
    f.arraytext[1]=['キャベツや白菜の芯を取ったり、プリーツレタスをばらしたりなど、','野菜の下処理を行います。']//trm
    f.arraytext[2]=['様々な野菜を様々な規格に専用の機械で切り分けます。','洗浄、殺菌、脱水工程までを行います。']//mac
    f.arraytext[3]=['全ての野菜を重量、枚数、本数によって計量します。','異物が入っていないか金属探知機を使って検品もしています。']//wgh
    f.arraytext[4]=[' 計量室で出来上がった食材と付属品の組み合わせや、セット作業を行います。野菜だけでなく、','麺・肉・海鮮・タレなどたくさんの具材を扱っています。']//set
    f.arraytext[5]=['セット準備室で計画した通りに食材と付属品を組み合わせ、キットを完成させます。','']//wap
    f.arraytext[6]=['すべての商品がここに集約され、取引先ごとに決められた出荷方法で仕分けをします。','製造部の指示出しも行っています。']
    
    tf.txtA=f.arraytext[mp.n][0]
    tf.txtB=f.arraytext[mp.n][1]
    tf.n=mp.n
    //5のときだけ画像がないので4に変更
    if(tf.n==5)tf.n=4
    [endscript]


    [bgm nm="evt"]
    ; [image layer="1" name="photo,photoBF" visible="true" storage="&f.add+'p'+(tf.n*1+0)+'cab.jpg'" pos="c" time="500" page="fore" wait="false"]
    ; [image layer="1" name="photo,photoAF" visible="true" storage="&f.add+'p'+(tf.n*1+1)+'cab.jpg'" pos="r" time="500" page="back" wait="true"]
    [image layer="1" name="photo,photoAF" visible="true" storage="&f.add+'p'+(tf.n*1+1)+'cab.jpg'" pos="c" time="500" wait="false"]
    [image layer="1" name="photo,photoBF" visible="true" storage="&f.add+'p'+(tf.n*1+0)+'cab.jpg'" pos="c" time="500" wait="true"]

    #案内人
    [emb exp="tf.txtA"][r]
    ; [trans layer="1" time="2000"]
    ;6は最後で画像がないので移動処理を行わない
    [ignore exp="tf.n==6"]
        [anim name="photoBF" left="-=250"]
        [anim name="photoAF" left="+=250"]
    [endignore]
    [emb exp="tf.txtB"]
    [wait time="1000"][p]
    [free layer="1" name="photo"  time="500" ]
    #
[endmacro]




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
ED追加
f101_62_01_ent(収集回収外)
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
        push(1,2,6,4,2);//移動先変更(玄関)
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
        push(1,1,30,2,3)//話しかけフラグ2
        push(1,2,30,10,3)//全員に話を聞くフラグ
        push(1,4,8,1)//西封鎖
        push(1,1,1,6)//隙間詰め壁
        push(1,1,33,7,3)//前室封鎖会話
    }
    //第一工場セット準備室新規イベント
    if(f.mpnm=='f101_20_01_set'){
        push(2,1,4,2,3)//話しかけフラグ1
        push(2,2,6,17,3)//話しかけフラグ2
        push(1,3,0,6)//壁(西封鎖)
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
    //第一工場玄関(プラットフォーム)新規イベント
    if(f.mpnm=='f101_62_01_ent'){
        push(1,1,3,13,3)//帰宅スイッチ
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
        f.arlbl[2]="12642"//移動先変更
        f.arlbl[3]="11392"//トリミングイベント
        f.arlbl[4]="21722"//立ち入り禁止
        f.arlbl[5]="11193"//立ち入り禁止
        //トリミング室(f201_29_01_trm.ks)
        f.arlbl[8]="221893"//東封鎖
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
        f.arlbl[20]="113023"//西従業員フラグ->北東人物変更
        f.arlbl[21]="113373"//前室封鎖会話
        //セット準備室(f101_20_01_set.ks)
        f.arlbl[24]="21423"//央従業員フラグ
        f.arlbl[25]="226173"//下従業員フラグ
        f.arlbl[26]="413253"//全員に話を聞く門
        f.arlbl[28]="1210113"//東封鎖(コンテナ洗浄室)
        f.arlbl[29]="111122"//移動先変更(計量室)
        //セット室(f101_12_25_wap.ks)
        f.arlbl[30]="2218123"//央話しかけフラグ
        f.arlbl[31]="226153"//西話しかけフラグ
        f.arlbl[32]="212003"//フラグチェック門
        f.arlbl[33]="96143"//部屋見渡し西
        //生産管理室(f101_34_01_pic)
        f.arlbl[35]="122103"//話しかけフラグ西
        f.arlbl[36]="222173"//話しかけフラグ東
        f.arlbl[37]="1115233"//システム室会話
        f.arlbl[38]="12173"//立ち入り禁止+話しかけ(西封鎖)
        f.arlbl[40]="1127243"//立ち入り禁止+話しかけ(南封鎖)
        f.arlbl[42]="142942"//立ち入り禁止(戻し)
        f.arlbl[43]="110172"//移動先変更(セット室へ)
        //第一工場玄関(プラットフォーム)(f101_62_01_ent)
        f.arlbl[44]="113133"//帰宅スイッチ

        
//TODO:②この配列にイベントアドレスを入れる
    [endscript ]

    ; mob情報をさらに読込
    [call storage="mcr/mode/01_mob.ks"]

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
        [se nm="eye"]
        [bgm nm="talk"]
        [show name="pl" side="R"]
        #pl
        さっそく工場の白衣に着替えてきたよ。楽しみだね！[p]
        [show name="kuri"]
        #kuri
        そうだね。[p ]
        [se nm="imp"]
        今日の工場見学は、[<imp]社員さんに話を聞いてきてもらう[>]よ。[p ]
        [se nm="imp"]
        [<imp]緑の帽子をかぶった人[>]が社員さんなんだって。[p ]
        各部屋に社員さんがいるから、話しかけてみてね。[p ]
        [se nm="imp"]
        #◇ゲームの目的◇
        各部屋にいる緑色の帽子の人から話を聞いていきましょう。[r]
        話しかけるには、その人の近くでその方向にボタンを押します。[p]
        #pl
        はーい！わかりました。[l][r]
        どんな工程があるのか聞けるといいな！[p]
        #kuri
        それじゃあいったん解散！また会おう！[p]
        [chara_hide_all layer="1"]
        [bgm nm="evt"]
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
        [announcement n="1"]
    [endadv]
    @eval exp="f.fstTrm=true"
[return ]
[s ]

*mac
;mac(カット室(機械洗浄))
    [iadv]
        [announcement n="2"]
    [endadv]
@eval exp="f.fstMac=true"
[return ]
[s ]

*wgh
;計量室
    [iadv]
        [announcement n="3"]
    [endadv]
@eval exp="f.fstWgh=true"
[return ]
[s ]


*set
;set(セット準備室)
    [iadv]
        [announcement n="4"]
    [endadv]
@eval exp="f.fstSet=true"
[return ]
[s ]

*wap
[eval exp="tf.aoi='これはwap(計量包装室(セット室))初回イベント'" ]
[trace exp="tf.aoi" ]
    [iadv]
        [announcement n="5"]
    [endadv]
@eval exp="f.fstWap=true"
[return ]

*pic
[eval exp="tf.aoi='これはpic(ピッキング室(生産管理室))初回イベント'" ]
[trace exp="tf.aoi" ]
    [iadv]
        [announcement n="6"]
        [show name="pl" side="R"]
        #pl
        [se nm="imp"]
        ここが最後の部屋だな![p]
        [chara_hide_all layer="1"]
        #
    [endadv]
@eval exp="f.fstPic=true"
[return ]
[s]

*ent
[eval exp="tf.aoi='これはent(収回場)初回イベント'" ]
[trace exp="tf.aoi" ]
; ここ内容
    ; [mask color="white"]
    ; [mask_off]
    [movie storage="受け渡し.mp4" ]
    ; [wait_bgmovie]
    ; [stop_bgmovie]

    ; トラックが動き出して画面外に行く
    ; [movie storage="gotrack.mp4"]
    ; [layermode_movie video="gotrack.mp4" loop="false" fit="false" wait="true" left="500"]
    [KA s="OFF"]
        [clearfix ]
        [cm]


        [image name="track" storage="gotrack.gif" layer="0" left="&80*11" top="&-80*5"]
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
    [endadv]

    [iadv]
        [show name="kuri"]
        #kuri
        クリハラで加工した野菜が行っちゃったね。[p]
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

    ; [dialog text="トラック出発アニメ、エンディングが流れる動作をいれる"]

@eval exp="f.fstEnt=true"
[return ]
[s ]
;帰宅スイッチ
*113133
[dialog text="会社見学会を終了しますか？(EDです)" type="confirm" target_cancel="*113133_f"]
[iadv]
    [show name="kuri"]
    [show name="pl" side="R"]
    #kuri
    じゃあ帰ろうか！[p]
    #pl
    はーい！[p]
    #社員さん
    本日はお越しいただきありがとうございました。[r]
    会社説明会にもぜひお越しください！[p]
    #pl
    わかりましたー[p]
    #kuri
    最新情報はホームページをチェック！[p]

    ; ホームページへのボタンが出る

    [destroy]
[endadv]

    [clearstack]
    [jump storage="credit01.ks"]


*113133_f
[eval exp="f.ismdeve=true""]
[return]
[s]

;ラベル数でまとめる

;立ち入り禁止
*21722
;以上のラベルで第二工場前室の時のイベント内容
*142942
;生産管理室も追加

; 142942は、f.evt_ed01=trueのとき以下を無視する。

[if exp="f.mpnm=='f201_39_13_ant'||f.mpnm=='f101_34_01_pic'&&!f.evt_ed01"]
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

*12642
;移動先変更(第二前室->第二玄関)
[trace exp="'移動先変更(第二前室->第二玄関)を実行しました。'"]
[mod_dest dest="f201_46_01_ent" etl="k2r" cond="f.mpnm=='f201_39_13_ant'"]
[jump target="*confirm" cond="f.mpnm=='f201_39_13_ant'"]
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
    [KA s="OFF"]
    [dialog text="マップ移動するけどいいかな？" type="confirm" storage="&tf.nextjump" target="*go"  ]
    [knockback]
    ;キャンセルのとき、mpnmを元に戻す
    @eval exp="tf.mpnm=tf.mpnm_bu"

    ;キャンセルのとき以前のマップ情報に戻す
    @eval exp="f.etl=tf.etl"
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
;セット準備室
*1210113
;生産管理室
*12173
;計量室追加(前室入口)
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
    [bgm nm="talk"]
    [if exp="f.mpnm=='f201_39_13_ant'" ]
    [show name="mbg"]
    #mbg
    そうそう、私みたいな人が「緑の帽子の人」ですよ。[p]
    [se nm="imp"]
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
    #kuri
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
    ここが第一工場の入口だって。ところでもう勉強は終わったのかい？[p]

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
    [bgm nm="talk"]
        [show name="mbw"]
        #
            あのー…[l][r]
            [font color="0xccc" bold="true"  ]
                [link keyfocus="1" target="22753_1" ][emb exp="(tf.sct[0]!='')?tf.sct[0]:f.sct_def[0];"][endlink ][r]
                [link keyfocus="2" target="22753_2" ][emb exp="(tf.sct[1]!='')?tf.sct[1]:f.sct_def[1];" cond="f.flg01trm1!==undefined"][endlink ]
            [resetfont]
        [s ]
        *22753_1
            [cm ]
            #mbw
            ;キャベツの芯を取っています
            [emb exp="f.talkto['trm'][0][0]"][p]
            [eval exp="[f.flg01trm,f.flg01trm1]=calstudy(f.flg01trm,f.flg01trm1,1,25);" ]
            [jump target="*22753_cmn" ]
        [s ]
        *22753_2
            [cm]
            #mbw
            ;虫がついていないか見ています
            [emb exp="f.talkto['trm'][0][1]"][p]
            [eval exp="[f.flg01trm,f.flg01trm1]=calstudy(f.flg01trm,f.flg01trm1,2,25);" ]
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
    [bgm nm="talk"]

        [show name="mbm"]
        #
            あのー…[l][r]
            [font color="0xccc" bold="true"  ]
                [link keyfocus="1" target="227133_1" ][emb exp="(tf.sct[0]!='')?tf.sct[0]:f.sct_def[0];"][endlink ][r]
                [link keyfocus="2" target="227133_2" ][emb exp="(tf.sct[1]!='')?tf.sct[1]:f.sct_def[1];" cond="f.flg01trm2!==undefined"][endlink ]
            [resetfont]
        [s ]
        *227133_1
            [cm ]
            #mbm
            ;プリーツレタスをばらしています
            [emb exp="f.talkto['trm'][1][0]"][p]
            [eval exp="[f.flg01trm,f.flg01trm2]=calstudy(f.flg01trm,f.flg01trm2,1,25);" ]
            [jump target="*227133_cmn" ]
        [s ]
        *227133_2
            [cm]
            #mbm
            ;野菜の鮮度に気を付けます
            [emb exp="f.talkto['trm'][1][1]"][p]
            [eval exp="[f.flg01trm,f.flg01trm2]=calstudy(f.flg01trm,f.flg01trm2,2,25);" ]
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
    [checkstudy next="カット室" c="&f.flg01trm"]
    [eval exp="f.flg01trm=true" cond="f.flg01trm==100"]
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
    [bgm nm="talk"]
        [show name="mbw"]
        #
            あのー…[l][r]
            [font color="0xccc" bold="true"  ]
                [link keyfocus="1" target="222073_1" ][emb exp="(tf.sct[0]!='')?tf.sct[0]:f.sct_def[0];"][endlink ][r]
                [link keyfocus="2" target="222073_2" ][emb exp="(tf.sct[1]!='')?tf.sct[1]:f.sct_def[1];" cond="f.flg01mac1!==undefined"][endlink ]
            [resetfont]
        [s ]
        *222073_1
            [cm ]
            #mbw
            ;規格を合わせてスライサーでカットしています
            [emb exp="f.talkto['mac'][0][0]"][p]
            [eval exp="[f.flg01mac,f.flg01mac1]=calstudy(f.flg01mac,f.flg01mac1,1,25);" ]
            [jump target="*222073_cmn" ]
        [s ]
        *222073_2
            [cm]
            #mbw
            ;規格を間違わないように合わせています
            [emb exp="f.talkto['mac'][0][1]"][p]
            [eval exp="[f.flg01mac,f.flg01mac1]=calstudy(f.flg01mac,f.flg01mac1,2,25);" ]
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
    [bgm nm="talk"]
        [show name="mbm"]
        #
            あのー…[l][r]
            [font color="0xccc" bold="true"  ]
                [link keyfocus="1" target="2220103_1" ][emb exp="(tf.sct[0]!='')?tf.sct[0]:f.sct_def[0];"][endlink ][r]
                [link keyfocus="2" target="2220103_2" ][emb exp="(tf.sct[1]!='')?tf.sct[1]:f.sct_def[1];" cond="f.flg01mac2!==undefined"][endlink ]
            [resetfont]
        [s ]
        *2220103_1
            [cm ]
            #mbm
            ;洗浄後の野菜を脱水しています
            [emb exp="f.talkto['mac'][1][0]"][p]
            [eval exp="[f.flg01mac,f.flg01mac2]=calstudy(f.flg01mac,f.flg01mac2,1,25);" ]
            [jump target="*2220103_cmn" ]
        [s ]
        *2220103_2
            [cm]
            #mbm
            ;洗浄、殺菌の時間に気を付けます
            [emb exp="f.talkto['mac'][1][1]"][p]
            [eval exp="[f.flg01mac,f.flg01mac2]=calstudy(f.flg01mac,f.flg01mac2,2,25);" ]
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
    [checkstudy next="計量室" c="&f.flg01mac"]
    [eval exp="f.flg01mac=true" cond="f.flg01mac==100"]

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
    [bgm nm="talk"]
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
            #mbw
            ;ピーマンを量ってパックしています
            [emb exp="f.talkto['wgh'][0][0]"][p]
            [eval exp="[f.flg01wgh,f.flg01wgh1]=calstudy(f.flg01wgh,f.flg01wgh1,1,25);" ]
            [jump target="*121553_cmn" ]
        [s ]
        *121553_2
            [cm]
            #mbw
            ;野菜の変色に気を付けています
            [emb exp="f.talkto['wgh'][0][1]"][p]
            [eval exp="[f.flg01wgh,f.flg01wgh1]=calstudy(f.flg01wgh,f.flg01wgh1,2,25);" ]
            [jump target="*121553_cmn" ]
        [s ]
        *121553_cmn
        [cm ]
    [endadv ]
    @eval exp="f.ismdeve=true"
[endif ]
[return ]
[s ]
;従業員フラグ西(計量室)->変更北東
*113023
[if exp="f.mpnm='f201_06_15_wgh'" ]
    [iadv ]
    [bgm nm="talk"]
        [show name="mbm"]
        #
            あのー…[l][r]
            [font color="0xccc" bold="true"  ]
                [link keyfocus="1" target="113023_1" ][emb exp="(tf.sct[0]!='')?tf.sct[0]:f.sct_def[0];"][endlink ][r]
                [link keyfocus="2" target="113023_2" ][emb exp="(tf.sct[1]!='')?tf.sct[1]:f.sct_def[1];" cond="f.flg01wgh2!==undefined"][endlink ]
            [resetfont]
        [s ]
        *113023_1
            [cm ]
            #mbm
            ;千切りキャベツを真空パックしています
            [emb exp="f.talkto['wgh'][1][0]"][p]
            [eval exp="[f.flg01wgh,f.flg01wgh2]=calstudy(f.flg01wgh,f.flg01wgh2,1,25);" ]
            [jump target="*113023_cmn" ]
        [s ]
        *113023_2
            [cm]
            #mbm
            ;数量間違いがないようにカウントします
            [emb exp="f.talkto['wgh'][1][1]"][p]
            [eval exp="[f.flg01wgh,f.flg01wgh2]=calstudy(f.flg01wgh,f.flg01wgh2,2,25);" ]
            [jump target="*113023_cmn" ]
        [s ]
        *113023_cmn
        [cm ]
    [endadv ]

@eval exp="f.ismdeve=true"
[endif ]
[return ]
[s ]

;計量室全員話したかチェック
*1230103
[if exp="f.mpnm='f201_06_15_wgh'" ]
    [checkstudy next="セット準備室" c="&f.flg01wgh"]
    [eval exp="f.flg01wgh=true" cond="f.flg01wgh==100"]
    [mod_dest dest="f101_20_01_set" etl="j2l" cond="f.flg01wgh"]
    [jump target="*confirm" cond="f.flg01wgh"]

    @eval exp="f.ismdeve=true"
[endif ]
[return ]
[s ]

;---セット準備室---
;従業員フラグ央(セット準備室)
*21423
[if exp="f.mpnm='f101_20_01_set'" ]

    [iadv ]
    [bgm nm="talk"]
        [show name="mbw"]
        #
            あのー…[l][r]
            [font color="0xccc" bold="true"  ]
                [link keyfocus="1" target="21423_1" ][emb exp="(tf.sct[0]!='')?tf.sct[0]:f.sct_def[0];"][endlink ][r]
                [link keyfocus="2" target="21423_2" ][emb exp="(tf.sct[1]!='')?tf.sct[1]:f.sct_def[1];" cond="f.flg01set1!==undefined"][endlink ]
            [resetfont]
        [s ]
        *21423_1
            [cm ]
            #mbw
            ;必要な肉を冷蔵庫から運んでいます
            [emb exp="f.talkto['set'][0][0]"][p]
            [eval exp="[f.flg01set,f.flg01set1]=calstudy(f.flg01set,f.flg01set1,1,25);" ]
            [jump target="*21423_cmn" ]
        [s ]
        *21423_2
            [cm]
            #mbw
            ;名前が似ているものやサイズの近い物の入れ間違いに気を付けています
            [emb exp="f.talkto['set'][0][1]"][p]
            [eval exp="[f.flg01set,f.flg01set1]=calstudy(f.flg01set,f.flg01set1,2,25);" ]

            [iscript ]
                if(f.flg01set1==1)f.flg01set=f.flg01set+25;
                f.flg01set1++;
            [endscript ]
            [jump target="*21423_cmn" ]
        [s ]
        *21423_cmn
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
    [bgm nm="talk"]
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
            #mbm
            ;商品規格書を見て具材を準備しています
            [emb exp="f.talkto['set'][1][0]"][p]
            [eval exp="[f.flg01set,f.flg01set2]=calstudy(f.flg01set,f.flg01set2,1,25);" ]
            [jump target="*226173_cmn" ]
        [s ]
        *226173_2
            [cm]
            #mbm
            ;材料を過不足なく集めることです
            [emb exp="f.talkto['set'][1][1]"][p]
            [eval exp="[f.flg01set,f.flg01set2]=calstudy(f.flg01set,f.flg01set2,2,25);" ]
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
    [checkstudy next="セット室" c="&f.flg01set"]
    [eval exp="f.flg01set=true" cond="f.flg01set==100"]
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
    [bgm nm="talk"]
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
            #mbw
            ;準備してくれた具材を1商品ごとにセットアップしています
            [emb exp="f.talkto['wap'][0][0]"][p]
            [eval exp="[f.flg01wap,f.flg01wap1]=calstudy(f.flg01wap,f.flg01wap1,1,25);" ]
            [jump target="*2218123_cmn" ]
        [s ]
        *2218123_2
            [cm]
            #mbw
            ;材料の入れ間違いがないようにしています
            [emb exp="f.talkto['wap'][0][1]"][p]
            [eval exp="[f.flg01wap,f.flg01wap1]=calstudy(f.flg01wap,f.flg01wap1,2,25);" ]
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
    [bgm nm="talk"]
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
            #mbm
            ;海老の計量とパックをしています
            [emb exp="f.talkto['wap'][1][0]"][p]
            [eval exp="[f.flg01wap,f.flg01wap2]=calstudy(f.flg01wap,f.flg01wap2,1,25);" ]
            [jump target="*226153_cmn" ]
        [s ]
        *226153_2
            [cm]
            #mbm
            ;決められた時間に次の部署に出せるようにしています
            [emb exp="f.talkto['wap'][1][1]"][p]
            [eval exp="[f.flg01wap,f.flg01wap2]=calstudy(f.flg01wap,f.flg01wap2,2,25);" ]
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
    [checkstudy next="生産管理室" c="&f.flg01wap"]
    [eval exp="f.flg01wap=true" cond="f.flg01wap==100"]
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
    [bgm nm="talk"]
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
            #mbw
            ;商品ラベルシールを貼っています
            [emb exp="f.talkto['pic'][0][0]"][p]
            [eval exp="[f.flg01pic,f.flg01pic1]=calstudy(f.flg01pic,f.flg01pic1,1,25);" ]
            [jump target="*122103_cmn" ]
        [s ]
        *122103_2
            [cm]
            #mbw
            ;出荷時間に遅れないようにします
            [emb exp="f.talkto['pic'][0][1]"][p]
            [eval exp="[f.flg01pic,f.flg01pic1]=calstudy(f.flg01pic,f.flg01pic1,2,25);" ]
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
    [bgm nm="talk"]
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
            #mbm
            ;行先ごとに商品を仕分けしています
            [emb exp="f.talkto['pic'][1][0]"][p]
            [eval exp="[f.flg01pic,f.flg01pic2]=calstudy(f.flg01pic,f.flg01pic2,1,25);" ]
            [jump target="*222173_cmn" ]
        [s ]
        *222173_2
            [cm]
            #mbm
            ;行先、数を間違えないようにしています
            [emb exp="f.talkto['pic'][1][1]"][p]
            [eval exp="[f.flg01pic,f.flg01pic2]=calstudy(f.flg01pic,f.flg01pic2,2,25);" ]
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
                [bgm nm="evt"]
                [show name="mbg"]
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
            tf.url='https://www.youtube.com/embed/'+'I7WBBplYTRo'+'?mute=1'
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
;セット室より
*96143

;TODO:トリミングイベント用に変更してみる
    [iscript ]
        //カット室
        if(f.label=='1320122')tf.txt='ここから先を見渡せるみたいだ。',tf.url='lqLNYD2AgV0';//部屋見渡し下
        if(f.label=='712262')tf.txt='ここから先を見渡せるみたいだ。',tf.url='WbnmksW7vTA';//部屋見渡し上
        //セット室
        if(f.label=='96143')tf.txt='ここから先を見渡せるみたいだ。',tf.url='rdBZObyktmI';//部屋見渡し西

        tf.url='https://www.youtube.com/embed/'+tf.url+'?mute=1'
        tf.moveve = f.mpnm=='f201_01_01_mac'||
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

; モブセリフシステム。6番目にmを付ける。testalphaより。
*mobline
    [Cngmsg n="1"]
    ;ふきだし表示を開始する
    [fuki_start layer="message1"]
        #
        [emb exp="f.mob_line[f.label]"][p]
    [fuki_stop]
    [Cngmsg]


    [eval exp="f.ismdeve=true"]
[return]
[s]
