; カメラ移動版マクロの呼び出し場所

; 矢印キーを押すと発火。キャラを適切に操作
[macro name="move"]

    [iscript]
        // 停止感知(何も操作しない時間)
        f.suspention = 1100;

    // --- 単一の発火を管理するバージョン ---
        // 直前の予約があればキャンセル
        if (tf.bTimer !== null) {
            clearTimeout(tf.bTimer);
        }
        // あらためて予約
        tf.bTimer = setTimeout(() => {
             //console.log("Bが発火しました");
            if(tf.SMNmove !== 0) tf.SMNmove = -1*1;
            tf.bTimer = null; // 後片付け
            tf.First_SMNmove = true; // 1度目である宣言
            tf.Iscontinuous = false; // 連続行動解除
        }, f.suspention); // 停止したと判断する時間。500ミリ秒。方向転換で処理落ちしない最適時間。
        // traceやconsole.logで処理時間を調整。
        // 早すぎるとtimuoutが即発動してカウント数がバグる
        /*
         * 初期化すると処理落ちで間に合わず×
         * キー離すと発火×
         * これ以上速くすると処理が間に合わず繰り返し発火する。-1になり続ける。
         * tf.SMNmoveが増えなくなる不具合になる。
         * 200にすると連続行動が発生しないまま続けることになる。
        */
    

        // 初期化
        tf.NotEvent = false;
        tf.Iscontinuous = false;

    [endscript ]

    ; 連続行動カウント
    [eval exp="tf.SMNmove = tf.SMNmove+1 | 0"]

    [iscript]

        // 連続行動の場合のスイッチ
        tf.Iscontinuous = (tf.SMNmove !== 0)

        // 早すぎて追い付けないときの保険。処理中。
        f.isProcessing = true;

    [endscript]

    ; [trace exp="'連続行動中です'+tf.SMNmove+tf.Iscontinuous" cond="tf.Iscontinuous"]
    ; [trace exp="'初回中です'+tf.SMNmove+tf.Iscontinuous" cond="!tf.Iscontinuous"]

    ; 十字ボタンを押すと押した方向のe.keyを取得して発火
    [iscript ]
        if(tf.moveOnce === undefined) tf.moveOnce = true;

        const Arrow = (mp.dir) ? mp.dir : mp.ekey.replace("Arrow", "") ;
        f.position = f.position || { x: 0, y: 0 };
        // もしf.vが前回と変わってなかったらf.positionの中身をf.vにする(連続行動中)
        if(tf.isStop && tf.Iscontinuous)f.position = tf.v;

        const cellSize = 80; // 1マスの大きさ
        const step = cellSize; // 移動距離は1マスの大きさ
        const mapColumns = f.mapsz.w  / cellSize; // マップの横マス数
        const mapRows = f.mapsz.h  / cellSize; // マップの縦マス数


        // 各方向の処理データをまとめる
        const directions = {
            Up: { dx: 0, dy: step, move1: "up", move0: "stop_u", left: "+=0", top: `-=${step}` },
            Right: { dx: step, dy: 0, move1: "right", move0: "stop_r", left: `+=${step}`, top: "+=0" },
            Down: { dx: 0, dy: -step, move1: "down", move0: "stop_d", left: "+=0", top: `+=${step}` },
            Left: { dx: -step, dy: 0, move1: "left", move0: "stop_l", left: `-=${step}`, top: "+=0" },
        };

        // カメラの稼働可能範囲(=マップのオフセット範囲=マップ余白)
        const { leftMoves, rightMoves, upMoves, downMoves } = f.Moves;
        const minX = -leftMoves - cellSize; // 左方向の余白
        const maxX = rightMoves + cellSize; // 右方向の余白
        const minY = -downMoves - cellSize; // 上方向の余白
        const maxY = upMoves + cellSize; // 下方向の余白

        // 前回押した方向を記録する変数を初期化
        tf.lastDirection = tf.lastDirection || null;

        // 移動処理
        if (directions[Arrow]) {
            const dir = directions[Arrow];

                // スーツ姿の場合変更
                if(f.Issuit){
                    dir.move1= 'suit'+dir.move1;
                    dir.move0= 'suit'+dir.move0;
                }

            // 異なる方向を向いていると振り向く。dir指定の時は強制的にfalseへ
            if (tf.lastDirection !== Arrow && !mp.dir) {
                // 振り向きのみの場合、移動しない
                f.position.left = "+=0";
                f.position.top = "+=0";
                // 処理中にして連続行動を止める
                f.isProcessing = true;
                //console.log(`方向変換しました`);
                // tyrano.plugin.kag.ftag.startTag("stop_keyconfig", {});
                // tyrano.plugin.kag.ftag.startTag("wait", {time:1500});
                //  console.log(`座標:振り向いた＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝`);
            } else {

                // その他の位置関連プロパティ更新 tf.st.x,y　を進行確定座標へ更新。(1,1)
                const moveResult = moveCharacter(Arrow, tf.st.x, tf.st.y, mapColumns, mapRows); // tf.isStop,tf.StopCameraX,Yもここ

                // "+=80"か"-=80"か"+=0"(初期値)が入る

                // ここをボタン押しっぱなしのときに数値を増やすようにする
                f.position.left = moveResult.left;
                f.position.top = moveResult.top;

                /*
                    tf.isStop で振り向いたか同じ方向に力を入れたかを判定。not＝振り向いていないということ。
                    tf.StopCameraX,Y で現在確定位置が指定外側範囲にあるかどうかを判定。ある場合停止。
                    この場合の止まるは0ではなく以前の箇所にとどまるなので起動させないが正。
                */
                if(!tf.isStop){
                    f.position.x =Number((tf.StopCameraX)?f.position.x: String(Math.min(Math.max(Number(f.position.x) + dir.dx, minX), maxX)));
                    f.position.y =Number((tf.StopCameraY)?f.position.y: String(Math.min(Math.max(Number(f.position.y) + dir.dy, minY), maxY)));
                }

            }

            // 移動方向情報を更新
            f.position.move1 = dir.move1;
            f.position.move0 = dir.move0;
            tf.lastDirection = Arrow; // 現在の方向を記録
        }

        // console.log(`現在地:${tf.st.x},${tf.st.y}`);

    [endscript ]

    ; 振り向き処理の場合、キー入力をカットする
    ; [stop_keyconfig cond="tf.lastDirection !== Arrow && !mp.dir"]
    ; [wait time="15000" cond="tf.lastDirection !== Arrow && !mp.dir"]


    ; [eval exp="removeKeyListener()" ]
    ; [iscript]
    ;     // console.log(`既存のリスナーを削除します`);
    ;     removeKeyListener();
    ;     // console.log(`既存のリスナーを削除しました`);
    ; [endscript]

    ; 処理中というブロック処理を解除
    [eval exp="f.isProcessing = false" cond="tf.SMNmove <= 60"]
    [eval exp="f.isProcessing = true" cond="tf.SMNmove >= 61"]

    ; [trace exp="'初回行動か？:'+tf.First_SMNmove"]

    ; 1周後の1回目だけ連続行動の停止
    [if exp="tf.First_SMNmove"]
        [eval exp="f.isProcessing = true"]
        [eval exp="tf.First_SMNmove = false"]
    [endif]


    ; 移動したことで発生するイベント
    ; A.そこへ移動してから自動で発火
    ; B.そこへ移動して、特定の方向を向いてボタンを押したとき発火

    ; IDの呼び方
    /*
    events[type][id] = params;
    をしているので、発火したときにはそのIDしか読み込まないよ
    */

    [ignore exp="mp.dir" ]

        [clearstack stack="macro"]

        [iscript ]

            // この時条件式が定義されてなかったらfalseを返す。イベント時の1歩下がる処理に使用
            tf.isStop = !!(tf && tf.v && tf.v.left === "+=0" && tf.v.top === "+=0");

            // イベント初期化
            tf.nowEvent = undefined;
            tf.move = [];
            tf.push = [];

            // ONイベント発火
            if (isTriggerEvent(tf.st.x, tf.st.y, "triggerOn")) {
                // console.log('座標:行先にイベントアリ');
                
                // この時点でONイベントがあることが確定
                if(!tf.Iscontinuous){ // 単行動のとき

                    // より後ろに書いた要素を優先して1つだけ取り出す
                    tf.arr=['mapMove','contact'];
                    checkAndTriggerEventsWithBounds(tf.st.x, tf.st.y, tf.arr);

                    /*

                        // 確認用
                            if (tf.nowEvent === "mapMove") {
                                console.log(`イベント発火しました。：${tf.move.from} → ${tf.move.to}`);
                            }
                            if (tf.nowEvent === "contact") {
                                console.log(`イベント発火しました。ID：${tf.contact.id}`);
                                // 飛ぶ準備
                            }

                    */
                   
                }
                    // 処理中にして連続行動を停止
                if(!tf.isStop && tf.Iscontinuous) { // 連続行動のとき 振り向いたとき(移動停止中)は行わない

                    f.isProcessing = true;
                    tf.NotEvent = true;
                    // tf.st.x, tf.st.yを1つ前に戻す
                    const Re_directionOffsets = {
                        Up: { x: 0, y: 1 },
                        Right: { x: -1, y: 0 },
                        Down: { x: 0, y: -1 },
                        Left: { x: 1, y: 0 },
                    };
                    tf.st.x += Re_directionOffsets[tf.lastDirection].x;
                    tf.st.y += Re_directionOffsets[tf.lastDirection].y;

                    // console.log(`座標:変更${tf.st.x},${tf.st.y}`);

                }            

            }

        [endscript]

    [endignore]


    ; 実際に動く処理＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
            ; イベントがない(=連続移動中)と判定したら実際に動かす。
            ; イベントが次にない場合は連続でも単移動でも以下は発火する
        [iscript ]
            // 最終位置をtf.vに保存
            tf.v = f.position;
            tf.isStop = tf.v.left === "+=0" && tf.v.top === "+=0";

            //　チップキャラの移動自体を停止(連続移動+イベント発見時)
            if(tf.NotEvent)tf.isStop = true;

            //console.log(`移動現在地2:${tf.st.x},${tf.st.y}`);　//キャラ位置の絶対値だったはず
            //console.log(`移動現在地2:${tf.v.left},${tf.v.top}`); //-=80,+=80 左に選択した時点で-80は確定で入っている

        [endscript]

        ; mp.dirが起動しているときは方向転換しない
        [ignore exp="tf.isStop" ]
            [chara_part name="player" move="&tf.v.move1" cond="!mp.dir"]
            ; [anim name="player" left="&tf.v.left" top="&tf.v.top" time="500" effect="easeInSine"]
            [chara_move name="player" anim="true" left="&tf.v.left" top="&tf.v.top" time="500" effect="easeInSine" wait="false"]
            
            [camera layer="0" x="&tf.v.x" y="&tf.v.y" time="500" ease_type="linear" wait="false"]
            [camera layer="1" x="&tf.v.x" y="&tf.v.y" time="500" ease_type="linear" wait="true"]
        [endignore ]
        ; 方向転換の時、鎮火する
        [eval exp="removeKeyListener()" cond="tf.isStop"]
        ; 振り返る処理の時は連続呼び出しさせない
        [eval exp="f.isProcessing = true" cond="tf.isStop"]
        [stop_keyconfig cond="tf.isStop &&tf.SMNmove >= 2"]
        ; 壁、マップ外の時のみ鳴る
        [playse storage="conflict.mp3" cond="tf.isConflict"]

        [wait time="&f.suspention" cond="tf.isStop &&tf.SMNmove >= 2"]
        ; 止める
        [chara_part name="player" move="&tf.v.move0" time="50" cond="!mp.dir||tf.isStop"]
        ; [wa cond="!tf.isStop"]
        ; [wait time="100" cond="!tf.isStop"]

        ; 他で今のところ使わないので初期化
        [iscript ]
            tf.isConflict = false;
        [endscript ]


    ; ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝/実際に動く処理


        [eval exp="console.log(`今は連続行動である:${tf.Iscontinuous}`)"]
    ; イベントがあれば発火
        [iscript]
            // Pushイベント発火(*zkeyに飛ぶ)
            // triggerPushで固定になっている
            checkAndTriggerPushEvent(tf.st.x, tf.st.y, tf.lastDirection, "triggerPush");
            checkAndTriggerPushEvent(tf.st.x, tf.st.y, tf.lastDirection, "search");
            /*
                console.table(
                );
                console.log(JSON.stringify(events, null, 2));
            */
        [endscript]


            ; 単行動のときなら
        [if exp="!tf.Iscontinuous && !mp.dir" ]

            ; ここがONイベントの発火部分。ジャンプする。
            ; 振り向きの場合は発生しないようにする
            ; OnEventが成立して、typeがそれの場合のみ
            ; 無駄に飛び過ぎてオーバーフロー起きてる
            [if exp="tf.arr.includes(tf.nowEvent) && !tf.isStop" ]

                [clearstack stack="macro"]
                ; ジャンプ前にイベント中に変更(矢印キー処理を停止)
                [eval exp="f.isEventRunning=true"]

                [jump storage="onEvent.ks"]
            [endif ]
            
        [endif]

    ; 処理中というブロック処理を解除
    [eval exp="f.isProcessing = false"]
    [trace exp="'カウント数:'+tf.SMNmove"]
    [if exp="tf.SMNmove >= 31" ]
        [eval exp="tf.SMNmove = 0"]
    [endif]

[start_keyconfig]

[endmacro ]
; [endmacro cond="tf.SMNmove >= -1"]
[endmacro cond="tf.SMNmove >= 1"]
[endmacro cond="tf.SMNmove >= 2"]
[endmacro cond="tf.SMNmove >= 3"]
[endmacro cond="tf.SMNmove >= 4"]
[endmacro cond="tf.SMNmove >= 5"]
[endmacro cond="tf.SMNmove >= 6"]
[endmacro cond="tf.SMNmove >= 7"]
[endmacro cond="tf.SMNmove >= 8"]
[endmacro cond="tf.SMNmove >= 9"]
[endmacro cond="tf.SMNmove >= 10"]
[endmacro cond="tf.SMNmove >= 11"]
[endmacro cond="tf.SMNmove >= 12"]
[endmacro cond="tf.SMNmove >= 13"]
[endmacro cond="tf.SMNmove >= 14"]
[endmacro cond="tf.SMNmove >= 15"]
[endmacro cond="tf.SMNmove >= 16"]
[endmacro cond="tf.SMNmove >= 17"]
[endmacro cond="tf.SMNmove >= 18"]
[endmacro cond="tf.SMNmove >= 19"]
[endmacro cond="tf.SMNmove >= 20"]
[endmacro cond="tf.SMNmove >= 21"]
[endmacro cond="tf.SMNmove >= 22"]
[endmacro cond="tf.SMNmove >= 23"]
[endmacro cond="tf.SMNmove >= 24"]
[endmacro cond="tf.SMNmove >= 25"]
[endmacro cond="tf.SMNmove >= 26"]
[endmacro cond="tf.SMNmove >= 27"]
[endmacro cond="tf.SMNmove >= 28"]
[endmacro cond="tf.SMNmove >= 29"]
[endmacro cond="tf.SMNmove >= 30"]
[endmacro cond="tf.SMNmove >= 40"]
[endmacro cond="tf.SMNmove >= 41"]
[endmacro cond="tf.SMNmove >= 42"]
[endmacro cond="tf.SMNmove >= 43"]
[endmacro cond="tf.SMNmove >= 44"]
[endmacro cond="tf.SMNmove >= 45"]
[endmacro cond="tf.SMNmove >= 46"]
[endmacro cond="tf.SMNmove >= 47"]
[endmacro cond="tf.SMNmove >= 48"]
[endmacro cond="tf.SMNmove >= 49"]
[endmacro cond="tf.SMNmove >= 50"]
[endmacro cond="tf.SMNmove >= 51"]
[endmacro cond="tf.SMNmove >= 52"]
[endmacro cond="tf.SMNmove >= 53"]
[endmacro cond="tf.SMNmove >= 54"]
[endmacro cond="tf.SMNmove >= 55"]
[endmacro cond="tf.SMNmove >= 56"]
[endmacro cond="tf.SMNmove >= 57"]
[endmacro cond="tf.SMNmove >= 58"]
[endmacro cond="tf.SMNmove >= 59"]
[endmacro cond="tf.SMNmove >= 60"]
[if exp="tf.SMNmove >= 60" ]
    [eval exp="tf.SMNmove = 0"]
[endif]

; 表示準備＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝


; 渡したパスの画像解像度を返す
[macro name="getResolution"]
    [iscript ]
    tf.loading = true; //読込中
    const filePath = (typeof mp.folder === "undefined") ? 'data/bgimage/map2/'+mp.filePath : mp.folder + mp.filePath;

    async function initializeResolution() {
    //const filePath = "data/bgimage/map/f101_01_01_cy.png";

    try {
        const { x, y } = await getImageResolution(filePath); // 解像度を取得
        //console.log(`Width: ${x}px, Height: ${y}px`);
        tf.imgWidth = x;
        tf.imgHeight = y;
    } catch (error) {
        console.error(error.message);
        tf.imgWidth = 0;
        tf.imgHeight = 0;
    }
    }

    initializeResolution().then(() => {
        // ここに処理を追加する予定がある場合
        tf.loading = false;
        console.log('Resolution initialization complete.');
         this.kag.ftag.nextOrder();
    });
    [endscript stop="true"]

    ; 非同期の完了を待つ
    ; [wait time="100" cond="tf.loading"]

[endmacro]

; 狙ったマスに適応したtf.positionsを返す(画像解像度を算出してから使用)
[macro name="calculatePositions"]
    [iscript ]
        const screenWidth = TG.config.scWidth;
        const screenHeight = TG.config.scHeight;
        const charSize = 80; // キャラクターのサイズ
        const bgSize = { width: f.mapsz.w, height: f.mapsz.h }; // 背景のサイズ
        const gridX = mp.x; // 狙ったマスのX座標
        const gridY = mp.y; // 狙ったマスのY座標

        tf.positions = calculatePositions(
            screenWidth,
            screenHeight,
            charSize,
            bgSize,
            gridX,
            gridY
        );
    [endscript ]
[endmacro ]


; ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝


; 操作キャラクターの登録＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝


; player設定。目パチ口パチのスプライトアニメーションとストップを設定。
[chara_new name="player" storage="chara/tip/sprite/null.png" width="80" height="80" jname="最初に入力した名前"  ]

; [chara_layer name="player" part="move" id="up" storage="chara/tip/sprite/u0.png" frame_image="u1,u2,u3,u3" frame_time="100,100,100,50" frame_direction="alternate" frame_loop="true"]
; [chara_layer name="player" part="move" id="stop_u" storage="chara/tip/sprite/u0.png"]

; [chara_layer name="player" part="move" id="right" storage="chara/tip/sprite/r0.png" frame_image="r1,r2,r3,r3" frame_time="100,100,100,50" frame_direction="alternate" frame_loop="true"]
; [chara_layer name="player" part="move" id="stop_r" storage="chara/tip/sprite/r0.png"]

; [chara_layer name="player" part="move" id="down" storage="chara/tip/sprite/d0.png" frame_image="d1,d2,d3,d3" frame_time="100,100,100,50" frame_direction="alternate" frame_loop="true"]
; [chara_layer name="player" part="move" id="stop_d" storage="chara/tip/sprite/d0.png"]

; [chara_layer name="player" part="move" id="left" storage="chara/tip/sprite/l0.png" frame_image="l1,l2,l3,l3" frame_time="100,100,100,50" frame_direction="alternate" frame_loop="true"]
; [chara_layer name="player" part="move" id="stop_l" storage="chara/tip/sprite/l0.png"]



[chara_layer name="player" part="move" id="up"      storage="chara/tip/sprite/player/armor/u0.png" frame_image="u1,u2,u3" frame_time="150,150,150" frame_direction="alternate" frame_loop="true"]
[chara_layer name="player" part="move" id="stop_u"  storage="chara/tip/sprite/player/armor/u0.png"]

[chara_layer name="player" part="move" id="right"   storage="chara/tip/sprite/player/armor/r0.png" frame_image="r1,r2,r3" frame_time="150,150,150" frame_direction="alternate" frame_loop="true"]
[chara_layer name="player" part="move" id="stop_r"  storage="chara/tip/sprite/player/armor/r0.png"]

[chara_layer name="player" part="move" id="down"    storage="chara/tip/sprite/player/armor/d0.png" frame_image="d1,d2,d3" frame_time="150,150,150" frame_direction="alternate" frame_loop="true"]
[chara_layer name="player" part="move" id="stop_d"  storage="chara/tip/sprite/player/armor/d0.png"]

[chara_layer name="player" part="move" id="left"    storage="chara/tip/sprite/player/armor/l0.png" frame_image="l1,l2,l3" frame_time="150,150,150" frame_direction="alternate" frame_loop="true"]
[chara_layer name="player" part="move" id="stop_l"  storage="chara/tip/sprite/player/armor/l0.png"]


[chara_layer name="player" part="move" id="suitup"      storage="chara/tip/sprite/player/suit/u0.png" frame_image="u1,u2,u3" frame_time="150,150,150" frame_direction="alternate" frame_loop="true"]
[chara_layer name="player" part="move" id="suitstop_u"  storage="chara/tip/sprite/player/suit/u0.png"]

[chara_layer name="player" part="move" id="suitright"   storage="chara/tip/sprite/player/suit/r0.png" frame_image="r1,r2,r3" frame_time="150,150,150" frame_direction="alternate" frame_loop="true"]
[chara_layer name="player" part="move" id="suitstop_r"  storage="chara/tip/sprite/player/suit/r0.png"]

[chara_layer name="player" part="move" id="suitdown"    storage="chara/tip/sprite/player/suit/d0.png" frame_image="d1,d2,d3" frame_time="150,150,150" frame_direction="alternate" frame_loop="true"]
[chara_layer name="player" part="move" id="suitstop_d"  storage="chara/tip/sprite/player/suit/d0.png"]

[chara_layer name="player" part="move" id="suitleft"    storage="chara/tip/sprite/player/suit/l0.png" frame_image="l1,l2,l3" frame_time="150,150,150" frame_direction="alternate" frame_loop="true"]
[chara_layer name="player" part="move" id="suitstop_l"  storage="chara/tip/sprite/player/suit/l0.png"]



; 最初に表示するキャラ画像(下向き停止)
[chara_part name="player" move="stop_d"  cond="!f.Issuit"]
[chara_part name="player" move="suitstop_d" cond="f.Issuit"]
[chara_config pos_mode="false"]


; ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝


; オブジェクト、イベントの設置＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

; 配置する画像のサイズを取得して表示と進行不可能力を与える
    ; 引数名	使用目的・内容
    ; mp.c	    一時的に tf.plc を "common" に切り替えるフラグ。使用後に元に戻す処理あり。
    ; mp.name	オブジェクトの識別名。tf.putname や tf.named に使われる。重複防止や座標記録用。NPCなど個別指定用。
    ; mp.pct	表示する画像ファイル名。deb_filePath（画像パス）と obj（名前）として使用。
    ; mp.layer	表示するレイヤー。0 なら "0"、それ以外は "1" になる。
    ; mp.folder	画像のフォルダ指定（省略時は "data/bgimage/map2/" が使われる）。
    ; mp.x	    表示位置のX座標（マス単位）。left 値や placeObject に使用。
    ; mp.y	    表示位置のY座標（マス単位）。top 値や placeObject に使用。
    ; mp.t	    上下左右のスルー領域設定用（u,r,d,l）。placeEventでスルー範囲を指定。※表示バグはこれ
    ; tf.plc -> フォルダ名(マップ名)
[macro name="AutoPut"]
    [iscript ]
    //AutoPutも混ぜる
        if(mp.c){tf.temp=String(tf.plc); tf.plc='common'; }
        (mp.name)?tf.putname=mp.name:tf.putname='none';
        const deb_filePath = tf.plc+'/'+mp.pct;
        const obj = mp.pct;
        const add_filePath = 'data/bgimage/map2/';
        const layer = (mp.layer==0)?'0':'1';
        const zindex = (mp.zindex===undefined)?'1':mp.zindex;

    //getResolution処理をここに追加する
        tf.loading = true; //読込中
        const filePath = (typeof mp.folder === "undefined") ? add_filePath + deb_filePath : mp.folder + deb_filePath;

        async function initializeResolution() {
        try {
            const { x, y } = await getImageResolution(filePath); // 解像度を取得
            tf.imgWidth = x;
            tf.imgHeight = y;
        } catch (error) {
            console.error('失敗',error.message);
            tf.imgWidth = 0;
            tf.imgHeight = 0;
        }
        }
    initializeResolution().then(() => {
        //画像を表示

        const ch = mp.ch === true || mp.ch === "true" || ["cross.gif", "ex_floor_conc11.png"].includes(obj);
        console.log(`chの判定:${ch}`);
        const plc = tf.plc;
        const x = mp.x * 1 ; //ここを変更するとイベント座標がズレて×
        let y = ch ? mp.y * 1 : mp.y * 1 + 0.5;
        const w = Math.round(tf.imgWidth/10)*10 / 80 ;
        const h = Math.round(tf.imgHeight/10)*10 / 80 ;

        const realImagePath = `${plc}/${obj}`;
        const shadowImagePath = realImagePath.replace(/\.png$/, '_SD.png'); //置き換える

        // tf.o＝tf.positions.background
        // [image]で行う場合はx,yを-1にする

        // Tyranoタグの共通パラメータ
        const baseParams = {
        folder: "bgimage/map2",
        visible: true,
        layer: layer,
        left: tf.o.x + 80 * (x-1),
        top: tf.o.y + 80 * (y-1),
        name: mp.name,
        zindex: zindex,
        };

        // 1. tf.namedが未定義であれば空オブジェクトとして初期化
        if (!tf.named) tf.named = {};

        // 2. そのあとで必要なときだけ代入
        if (tf.putname !== 'none') {
        tf.named[mp.name] = {
            left: tf.o.x + 80 * (x-1),
            top : tf.o.y + 80 * (y-1)
        };
        }

        // 1枚目（実物）を表示
        tyrano.plugin.kag.ftag.startTag("image", {
            ...baseParams,
            storage: realImagePath
        });

        // イベント発火位置用に修正
        if (!ch) y -= 0.5;

        // 衝突判定を付ける
        placeObject(x, y, w, h);

        // 上下左右いずれか端一列をスルーする追加機能
        if(mp.t){
            if (!['u', 'r', 'd', 'l'].includes(mp.t)) {
                alert('エラー: mp.tの値が不正です');
                throw new Error('停止しました'); // 処理を完全に止めるならこれも
            }                
            const directions = {
                u: [x,         y,         w,         1],
                r: [x + w - 1, y,         1,         h],
                d: [x,         y + h - 1, w,         1],
                l: [x,         y,         1,         h]
            };
            const [x2, y2, w2, h2] = directions[mp.t];
            console.log(`x2:${x2} y2:${y2} w2:${w2} h2:${h2} `)

            placeEvent(x2,y2,w2,h2,"Through");
            // tf.eventmapにThroughの座標をpush
        }

        // 影があれば2枚目（影）を表示（placeObjectは呼ばない）
        (async () => {
            if (await checkImageExists(add_filePath + shadowImagePath)) {
                tyrano.plugin.kag.ftag.startTag("image", {
                    ...baseParams,
                    zindex: 0,
                    storage: shadowImagePath
                });
                //　ここに返り値が来るまで止まっているコードを書く？

            }
        })();
    
            // ここに処理を追加する予定がある場合
        tf.loading = false;
        console.log('Resolution initialization complete.');

        if(mp.c) tf.plc=tf.temp; //commonだった場合大元に戻す

        this.kag.ftag.nextOrder();
    });

    [endscript  stop="true"]

    [wait time="50" cond="tf.loading"]
    [wait time="50" cond="tf.loading"]
[endmacro]

[macro name="SetEvent"]
    [iscript ]
        let eventType;
        if (mp.EventType == 2) eventType = "triggerOn";
        if (mp.EventType == 3) eventType = "triggerPush";
        placeEvent(mp.x, mp.y, mp.w, mp.h, eventType);

        // イベントの登録
        SetEvent({
            type: mp.type,
            id: mp.id,
            // 全共通。パラメーターは必要なら増やす。
            params: {id: mp.id, name: mp.name, dic: mp.dic, from: 'Map1', to: 'Map2', x: mp.x, y: mp.y, w: mp.w, h: mp.h},
        });

    [endscript ]

[endmacro ]

; テーブルなど前後でレイヤーを切り替えるオブジェクト用
[macro name="AutoZPut"]
    [eval exp="tf.p = mp.pct"]
    [AutoPut * pct="&tf.p+'T.png'" t="u" layer="1" cond="mp.t != 'd'"]
    [AutoPut * pct="&tf.p+'T.png'" t="" layer="1" cond="mp.t == 'd'"]
    [AutoPut * pct="&tf.p+'D.png'" t="d" layer="0" cond="mp.t != 'u'"]
    [AutoPut * pct="&tf.p+'D.png'" t="" layer="0" cond="mp.t == 'u'"]
    ; [AutoPut * pct="&tf.p+'D.png'" t="" layer="0"]
[endmacro]

; コンテナ専用
[macro name="AutoCont"]
    [iscript]
        // 斜め0を1つだけ表示させる場合(途中)
        if(mp.t === undefined)tf.OnlyCont0=true;

        // 上にコンテナを追加しない場合
        if(mp.t0 === undefined)tf.NotCont0=true;

        // 左上から左下のXY基準を修正にする
        const revTable = {
            1: 0,
            2: 2,
            5: 2.5
        };
        let rev;
        if (mp.n in revTable) {rev = revTable[mp.n];
        } else { rev = 1; // デフォルト値
        }
        mp.y = mp.y - rev;
        tf.x = mp.x *1;
        tf.y = mp.y *1;
        // if(mp.n==1)tf.offsetY = 0.5*1;
        if (mp.n == 1 ) {
            const randomOffset = (Math.floor(Math.random() * 6) + 5) * 0.1;
            tf.offsetY = randomOffset;
            }
        if (mp.n==2)tf.offsetY =0 ;
        if (mp.n==5)tf.offsetY =0 ;
    [endscript]
    [AutoPut * pct="&'container'+mp.n+'_'+mp.color+'.png'" c="t" cond="!tf.OnlyCont0"]
    [AutoPut * pct="&'container0_'+mp.color+'.png'" x="&tf.x-1" y="&tf.y-tf.offsetY" c="t" t="&mp.t0" cond="!tf.NotCont0"]

    ; 初期化(1個だけなら変数消してもいいかも)
    [iscript]
        tf.NotCont0 = false;
        tf.OnlyCont0 = false;
    [endscript ]
[endmacro]

; 人物の配置、振り向きアクション自動添付
[macro name="AutoNPC"]
    [eval exp="tf.ad='human/'"]

    [iscript ]
        //tf.d = mp.dic;
        tf.ad ='human/';
        if(mp.name == 'Ending')tf.ad = tf.ad + 'surt/';
        tf.head = mp.name.endsWith('-F') ? '2' : '0';
        //alert(tf.head);
    [endscript ]

    ; 体
    ; [AutoPut pct="&tf.ad+mp.dic+'1.png'" x="&mp.x" y="&mp.y" c="t"]
    [AutoPut * pct="&tf.ad+mp.dic+'1.png'" name="" c="t" layer="0" ch="true" zindex="2"]
    ; 頭
    ; [AutoPut pct="&tf.ad+mp.dic+tf.head+'.png'" x="&mp.x" y="&mp.y" c="t" name="&mp.name" dic="&mp.dic"]
    [AutoPut * pct="&tf.ad+mp.dic+tf.head+'.png'" c="t" layer="1" zindex="5" ch="true"]
    ; 基本動作
    ; [SetEvent EventType="3" x="&mp.x" y="&mp.y" w="1" h="1" name="&mp.name" dic="&mp.dic" type="triggerPush" id="&'方向転換'+mp.name"]
    [SetEvent * EventType="3" w="1" h="1" type="triggerPush" id="&'方向転換'+mp.name"]

[endmacro]


; ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
; ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

; map呼び出し差分登録
; プレイヤー初期位置をここで記述
[iscript ]

        f.roomname = {
        //Aroom: { hoge: "部屋1", fuga: "部屋2", piyo: 3 },
        //Broom: { hoge: "部屋A", fuga: "部屋B", piyo: 4 },
        ANTE2: { name: "f201_39_13_ant", st: {x: 7 , y: 5}},
        //tes ANTE2: { name: "f201_39_13_ant", st: {x: 2 , y: 2}},
        ENTER2: { name: "f201_46_01_ent", st: {x: 13 , y: 2}},
        TRIM2: { name: "f201_29_01_trm", st: {x: 12 , y: 12}},
        //  testTRIM2: { name: "f201_29_01_trm", st: {x: 1 , y: 10}},
        CUT2: { name: "f201_01_01_mac", st: {x: 28 , y: 10}},
        KEIRYO2: { name: "f201_06_15_wgh", st: {x: 18 , y: 1}},
        // tes KEIRYO2: { name: "f201_06_15_wgh", st: {x: 25 , y: 10}},
        SETPre: { name: "f101_20_01_set", st: {x: 10 , y: 2}},
        // tes SETPre: { name: "f101_20_01_set", st: {x: 3 , y: 21}},
        SET: { name: "f101_12_25_wap", st: {x: 11 , y: 2}},
        SEISAN: { name: "f101_34_01_pic", st: {x: 1 , y: 17}},
        // tes SEISAN: { name: "f101_34_01_pic", st: {x: 27, y: 5}},
        ENTER1: { name: "f101_62_01_ent", st: {x: 1 , y: 12}},
    };

    // ({ hoge: f.hoge, fuga: f.fuga } = f.roomname['Broom']);

        //参照渡しで元の部屋に戻るときの参照値で使う
        //値渡しで指定した箇所へ飛ばすようにする
        f.roomnameRef = JSON.parse(JSON.stringify(f.roomname));

[endscript ]


; 第二前室というmp.roomname が入ったとする。
; マップ作製読込
[macro name="map_loading"]

    [iscript ]

        // 部屋基本数値を代入

        if(tf.iswarp){
            // 値代入(指定した箇所へ飛ばしたい場合)
            ({ name: tf.name, st: tf.st } = JSON.parse(JSON.stringify(f.roomname[mp.roomname])));
            tf.iswarp = false;
        }else{
            // これは参照渡し(基本)
            ({ name: tf.name, st: tf.st } = f.roomnameRef[mp.roomname]) ;
        }


        // 呼び出す基本画像
        tf.bsc_bg = tf.name + '/bg.png' ;

    [endscript ]

    ; ロード中をマスキングする
    ; [mask graphic="mask_loading.jpg"]

    ; 画像を部屋ごとに変更する場合に使用。現在未使用。
    ; [SelectTipMask]

    [mask graphic="mask/mask000.jpg" time="100"]

        ; 呼び出す背景画像のサイズを返す
        [getResolution filePath="&tf.bsc_bg"]

        ; マップ専用に置き換え
        [eval exp="f.mapsz={w : tf.imgWidth , h : tf.imgHeight}"]

    [mask graphic="mask/mask033.jpg" time="100"]

        ; 狙ったマスに適応したtf.positionsを返す(画像解像度を算出してから使用)
        [calculatePositions x="&tf.st.x" y="&tf.st.y"]

        ; 指定が特にない場合画面中央下に配置(pos_mode=falseのときは0,0位置に配置。)
        [chara_show name="player" layer="0" zindex="99"  time="50" left="&tf.positions.character.x" top="&tf.positions.character.y" wait="true"] 
        [layopt visible="true" layer="1"]

        ; 指定が特にない場合x=0,y=0に左上を揃えて配置
        [image folder="bgimage/map2"  storage="&tf.bsc_bg" visible="true" layer="0" left="&tf.positions.background.x" top="&tf.positions.background.y"]

    [mask graphic="mask/mask055.jpg" time="100"]


        ; ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

        ; 建物を追加する
        ; 建物のleft,topを求める。たぶんbgの部位が1,1扱いになるので80pxでoffsetでやる
        [eval exp="tf.o = { ...tf.positions.background };"]

        ; 部屋ごとのAutoPutなどの設定呼び出し
        [call storage="&'map2/'+mp.roomname+'.ks'"]

    [mask graphic="mask/mask066.jpg" time="100"]

        ; ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

        ; その部屋に登場するキャラクターの画像登録
        ; すでに登録済みのものは除く

        [iscript ]
            tf.scName = tf.move !== undefined ? f.NEXTMAP[tf.move.id] : f.NEXTMAP;
            f.processedCharacters = generateCharacterData(
                f.characterList[tf.scName],
                f.characterData,
                f.faceData,
                f.processedCharacters
            );
            tf.isEndFunction = true;
        [endscript]
        [wait time="100" cond="!tf.isEndFunction"]
        [wait time="100" cond="!tf.isEndFunction"]
        [wait time="100" cond="!tf.isEndFunction"]
        [wait time="100" cond="!tf.isEndFunction"]
        [wait time="100" cond="!tf.isEndFunction"]
        [eval exp="tf.isEndFunction = false"]

        ; ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

    [mask graphic="mask/mask099.jpg" time="100"]

        ; 演出用、カメラをマップ全体を映す
        ; [camera zoom="0.5" time="50"]


        ; f.Movesを作成。[move]で使う
        [eval exp="calculateMoves()"]

        ; 十字ボタン再表示
        [crbtn]

    [mask graphic="mask/mask100.jpg" time="100"]

    ; 01_camera.ksを省く場合に作動
    [mask_off time="50" cond="!f.IsEntranceCamera"]

    ; 処理中というブロック処理を解除
    [eval exp="f.isProcessing = false" cond="!f.IsEntranceCamera"]

[endmacro]

; map移動時の初期化一括マクロ
[macro name="ClearVars"]
    ; 部屋固有イベント・建物配置のリセット
    [eval exp="events = {}"]
    [clearvar exp="tf.eventmap"]
    [clearvar exp="tf.obstacles"]

    [freeimage layer="0" ]
    [freeimage layer="1" ]
    [freeimage layer="2" ]
    [freeimage layer="base" ]
    [reset_camera]
    [wait time="1000"]
    ; イベント中を解除
    [eval exp="f.isEventRunning=false" ]
    ; キャラ位置をリセット
    [clearvar exp="f.position" ]
    ; 一時変数を全消去(意味あるかは不明)
    [autosave]
[endmacro]

; マップ移動時に出現するtipマスクの編集
; !未設定

; [macro name="SelectTipMask"]

;     ; 移動先の部屋の名前で画像を変更する。
;         /*
;          *         f.NEXTMAP = {};  // オブジェクトとして初期化
;         f.NEXTMAP['マップ移動玄関2to前室'] = 'ANTE2';
;         f.NEXTMAP['マップ移動前室toトリミング室'] = 'TRIM2';
;         f.NEXTMAP['トリミング室toカット室'] = 'CUT2';
;         f.NEXTMAP['カット室to計量室'] = 'KEIRYO2';
;         f.NEXTMAP['計量室toセット準備室'] = 'SETPre';
;         f.NEXTMAP['セット準備室toセット室'] = 'SET';
;         f.NEXTMAP['セット室to生産管理室'] = 'SEISAN';
;         f.NEXTMAP['生産管理室to玄関1'] = 'ENTER1';

;          * */
;     [iscript ]

;         const graficMap = {
;             ANTE2: A,
;             TRIM2: B,
;             CUT2: C,
;             KEIRYO2: D,
;             SETPre: E,
;             SET: F,
;             SEISAN: G,
;             ENTER1: H,
;         };

;         tf.grafic = graficMap[f.NEXTMAP[tf.move.id]] || null; // 該当なしなら null

;     [endscript ]

;     [mask graphic="&tf.grafic+'.jpg'"]

; [endmacro]

; ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

[return]