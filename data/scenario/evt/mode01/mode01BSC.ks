; mode01限定のcommonページ


; トリミング室～生産管理室までのオートイベント
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
    [image layer="2" name="photo,photoAF" visible="true" storage="&f.add+'p'+(tf.n*1+1)+'cab.jpg'" pos="c" time="500" wait="false"]
    [image layer="2" name="photo,photoBF" visible="true" storage="&f.add+'p'+(tf.n*1+0)+'cab.jpg'" pos="c" time="500" wait="true"]

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
    [free layer="2" name="photo"  time="500" ]
    #
[endmacro]

; 100点でなくても無理やり通れるのを修正
;勉強チェックマシーン
[macro name="checkstudy"]
    [iscript ]
        tf.next=mp.next; // 次の部屋の名前。次は「〇〇〇」です。という使用。
        tf.c=mp.c; // 部屋の達成率。0から始まり100になる。
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

                [noenter]
            [endif ]
        [endadv ]
    [endignore ]
[endmacro]


;話しかけシステム雛形マクロ===
[iscript ]
    f.TalkFrom = {
        what: '◆何をしていますか？[1]',
        how: '◇どんなことを気を付けていますか？[2]',
    };

    // 選んだ人物と何回目の会話かを記録
    tf.sct=['',''];

    //会話内容

    // talk_data.js
    f.talkto = {
    trm: {
        Cabbage:{
            WHAT: 'キャベツの芯を取っています',
            HOW: '虫がついていないか見ています',
        },
        Letas:{
            WHAT: 'プリーツレタスをばらしています',
            HOW: '野菜の鮮度に気を付けます',
        },
        Mob1:{
            WHAT:'野菜が傷まないようにこのフロアは15℃以下に保たれているよ',
        },
        Mob2:{
            WHAT:'このフロアにはダンボールの持ち込みが禁止なんだ。衛生管理のきまりだよ',
        },
    },
    cut: {
        Slicer:{
            WHAT: '規格を合わせてスライサーでカットしています',
            HOW: '規格を間違わないように合わせています',
        },
        Cutter:{
            WHAT: '野菜を機械でカットしています',
            HOW: '出荷量にあわせた量を切るようにしています',
        },
        Mob1:{
            WHAT: 'キャベツだけでも10通りのカット規格があるんだよ',
        },
        Mob2:{
            WHAT: 'キャベツだけでも10通りのカット規格があるんだよ',
        },
    },
    keiryo: {
        Gpepper:{
            WHAT: 'ピーマンを量ってパックしています',
            HOW: '野菜の変色に気を付けています',
        },
        Cabbage:{
            WHAT: '千切りキャベツを計量して機械で袋詰めしています',
            HOW: '野菜の規格を間違えないようにしています',
        },
        Mob1:{
            WHAT: '野菜の種類、規格、重量、個数…絶対間違えないようにチェックしなきゃ',
        },
        Mob2:{
            WHAT: '一日に何百個も計量しなきゃいけないものは、パッケージ機で計量するよ',
        },
        Mob3:{
            WHAT: '知ってる？この工場の床の中には水が通っていて、常に冷やされているんだよ',
        },
        Mob4:{
            WHAT: '手にケガがあるなら、金属探知機で検知される特別なばんそうこうを貼ってね',
        },
        Mob5:{
            WHAT: '古い野菜から順番に使わないとダメだよ！買った野菜が無駄になっちゃうからね',
        },
        Mob6:{
            WHAT: 'こまめにテーブルと床をきれいに掃除するよ',
        },
        Mob7:{
            WHAT: '次は何の野菜をはかればいいかな？タブレットに次の指示が表示されるんだよ',
        },
    },
    setpre: {
        Fridge:{
            WHAT: '必要な肉を冷蔵庫から運んでいます',
            HOW: '名前が似ているものやサイズの近い物の入れ間違いに気を付けています',
        },
        Forage:{
            WHAT: '商品規格書を見て具材を準備しています',
            HOW: '材料を過不足なく集めることです',
        },
        Mob1:{
            WHAT: 'えーっと、あのお肉はどこの冷凍庫にしまってあるんだっけ？',
        },
        Mob2:{
            WHAT: '間違ったものがキット組みされないように、いろんな人が何重にもチェックするきまりになっているんだよ',
        },
        Mob3:{
            WHAT: '青い手袋を使うきまりになっているよ。万が一破片が混入した時に見つけやすい色だからね',
        },
        Mob4:{
            WHAT: '似たような名前のタレがたくさんあるから、気を付けてね',
        },
        Mob5:{
            WHAT: 'スーパーのお惣菜で何が好き？私は天ぷらが好きだな。',
        },
    },
    set: {
        Setup:{
            WHAT: '準備班がセットしてくれた具材を1キットごとにセットアップしています',
            HOW: '材料の入れ間違いがないようにしています',
        },
        Pack:{
            WHAT: '海老の計量とパックをしています',
            HOW: '決められた時間に次の部署に出せるようにしています',
        },
        Mob1:{
            WHAT: 'スーパーのお惣菜で何が好き?私は天ぷらが好きだな',
        },
        Mob2:{
            WHAT: 'あわてずに、正確にキット組みすることが大事だよ',
        },

    },
    seisan: {
        Seal:{
            WHAT: '商品ラベルシールを貼っています',
            HOW: '出荷時間に遅れないようにします',
        },
        Sort:{
            WHAT: '行先ごとに商品を仕分けしています',
            HOW: '行先、数を間違えないようにしています',
        },
        Mob1:{
            WHAT: 'ハンディっていう小型の機械でピッキングをして、スーパーのお店ごとに箱に詰めていくんだよ',
        },
        Mob2:{
            WHAT: 'クリハラはいろんな働き方ができるよ。パートなら、勤務時間もその人に合わせて相談できるんだよ',
        },
        Mob3:{
            WHAT: 'スーパーが発注した商品が届いてない、なんてことが無いように、一人一人が責任をもってピッキングをしているよ',
        },
        Sistem:{
            WHAT: 'ここはシステム室。中には入れられないんだ。ごめんね',
        },

    },
    ante2: {
        tutorial:{
            WHAT:'『取るミング』を使用するかチェックしていますよ',
            HOW:'ああ、そうそう。この選択肢は2回話しかけると新しいのが出たりするから、何回か話しかけてみてね',
        },
    },

    };

    //! 登録していく↓
/*
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
*/ 

[endscript ]


; 最初期設定。これは必須。
[iscript]
    f.score = {};
    f.count = {};
[endscript]


[macro name="QuesAndAnswer"]
    [iadv ]
        [bgm nm="talk"]
        [iscript]
            // mp置場
            // mp.category //部屋の名前、大区分。
            // mp.item //人物・担当野菜、中区分。
            // mp.name //答える人を指定(ADVの姿と名前表示用)


            // 初期作成
            f.count[mp.category] = f.count[mp.category] || {};
            f.count[mp.category][mp.item] = f.count[mp.category][mp.item] || 0;
            // 長いので簡略
            tf.score = f.score[mp.category];
            tf.count = f.count[mp.category][mp.item];

        [endscript ]

            ; ! 立ち位置を調整
            [show name="&mp.name"]

            #
                あのー…[l][r]
                [font color="0xccc" bold="true"  ]
                    [link keyfocus="1" target="Answer_1" ]
                        [emb exp="(tf.sct[0]!='')?tf.sct[0]:f.TalkFrom.what;"]
                        [endlink ][r]
                    [link keyfocus="2" target="Answer_2" ]
                        [emb exp="(tf.sct[1]!='')?tf.sct[1]:f.TalkFrom.how;" cond="tf.count >= 1"]
                        [endlink ]
                [resetfont]
            [s ]
            *Answer_1
                [cm ]
                [chara_ptext name="&mp.name"]

                [emb exp="getTalk(mp.category, mp.item, 'WHAT')"][p]
                [eval exp="[f.score[mp.category], f.count[mp.category][mp.item]] = StudyScore(tf.score, tf.count,1,25);" cond="tf.count === 0"]
                ; 暫定処理
                [clearvar exp="f.score[mp.category]" cond="mp.category == 'ante2'"]
                
                [jump target="*QAAEnd" ]
            [s ]
            *Answer_2
                [cm]
                [chara_ptext name="&mp.name"]

                [emb exp="getTalk(mp.category, mp.item, 'HOW')"][p]
                [eval exp="[f.score[mp.category], f.count[mp.category][mp.item]] = StudyScore(tf.score, tf.count,2,25);" cond="tf.count === 1"]
                ; 暫定処理
                [clearvar exp="f.score[mp.category]" cond="mp.category == 'ante2'"]

                [jump target="*QAAEnd" ]
            [s ]
            *QAAEnd
            [cm ]

            ; [iscript]
            ;     console.log(`現在作成されている全てが100か？:${Object.values(f.score).every(v => v === 100)}//現在作成されているトピック数は?:${Object.keys(f.score).length}`);

            ; [endscript ]

            ; ここに条件を満たした場合のイベントを挟む
            ; f.score[hoge]が全て100である必要がある。
            [if exp="Object.values(f.score).every(v => v === 100)" ]

                [dialogS text="この部屋での勉強が完了しました！"]


                [if exp="Object.keys(f.score).length === 6"]
                ; [if exp="Object.keys(f.score).length === 1"]

                        ; [se nm="eye"]
                        ; [bgm nm="talk"]
                        ; [show name="kuri"]
                        ;     #マロン
                        ;     おつかれさま！回ってこられた？[p ]
                        ; [show name="pl" side="R"]
                        ;     #pl
                        ;     うん！一通り見てきたよ！[p ]
                        ;     社員さんに話を聞けたよ。[p ]
                        ;     #マロン
                        ;     それは良かった！[p ]
                        ;     クリハラでは野菜のカットを含めた「惣菜キット」を作っていることがわかったね。[p ]
                        ;     #pl
                        ;     そうだね！スーパーでどんなお惣菜になるのか、ワクワクするね！[p ]
                        ;     #マロン
                        ;     それでは今日の工場見学は終わりだよ。[p ]
                        ;     もっとクリハラのことを知りたい！と思ったら、ぜひリアルの工場見学もしてみてね。[p ]
                        ; [mask time="2000" ]
                        ; [wait time="2000" ]
                        ; [dialog text="タイトル画面に戻ります" ]
                        ; [destroy ]
                        ; [mask_off time="50" ]
                        ; [jump storage="titlever2.ks" ]


                    ; [adv]
                    #
                    ぴんぽんぱんぽん[p]

                    トラックの音だ！[r]
                    外へ出てみよう![p]
                    [endadv]

                    ; [playse storage="scenechange.mp3"]

                    ; ジャンプ前にイベント中に変更(矢印キー処理を停止)
                    [eval exp="f.isEventRunning=true"]
                    [eval exp="f.NEXTMAP[tf.move.id]='ENTER1'"]
                    [ClearVars cond="tf.nowEvent == 'mapMove'"]
                    [clearstack ]
                    [clearstack stack="anim" ]
                    [wa]
                    [fadeoutbgm]
                    [wa]
                    [dialogS text="ジャンプします。"]
                    ; ジャンプ成功。人や物が消えていない。
                    [ClearVars]
                    ; [reset_camera time="500" wait="true"]
                    [jump storage="test_cameraworld.ks" target="*MAPLOAD"]
                    [s ]
                    
                [endif ]

            [endif ]

    [endadv ]

[endmacro]

; mob用。[Fuki]で表示
[macro name="SoloAnswer"]

    [iadv mode="1"]

        [cm ]
        [chara_ptext name="&mp.name"]
        [fuki_start layer="message1"]

            [emb exp="getTalk(mp.category, mp.item, 'WHAT')"][p]

        [fuki_stop]
        [cm ]

    [endadv ]

[endmacro]



; ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

[return]
[s]