/*
トリガーイベントのマクロ収納場所。
後にもうちょっと細かく要素別けしておきたい
*/

[macro name="changeDirection"]
    ; 押した方向で画像を切り替える
    [iscript]

        // 押した方向ごとの設定
        const directionSettings = {
        Up:    { options: ['l', 'r'], dic: 't', fallback: 'b' },
        Right: { options: ['b', 't'], dic: 'r', fallback: 'l' },
        Down:  { options: ['l', 'r'], dic: 'b', fallback: 't' },
        Left:  { options: ['t', 'b'], dic: 'l', fallback: 'r' }
        };


        const setting = directionSettings[tf.lastDirection];
        if (setting) {
        tf.anoDirection = (mp.dic !== setting.dic)
            ? setting.fallback
            : setting.options[Math.floor(Math.random() * setting.options.length)];


            console.log(`方向チェック=向いている方向:${mp.dic}/NG:${setting.dic}/話しかけた方向:${tf.lastDirection}/呼び出す顔向き:${tf.anoDirection}`);

        }


    // // 真後ろから話しかけられた場合の処理
    // dicオプションを作ってmobが向いている方向を記録する

    //tf.anoDirection=(mp.name=='mob')?tf.anoDirection+'0':tf.anoDirection+'2';
    tf.anoDirection = mp.name.endsWith('-F') ? tf.anoDirection + '2' : tf.anoDirection + '0';


    [endscript]
    [free layer="1" name="&mp.name" ]

    ; 特定のキャラの場合URLを付け加える
    [eval exp="tf.IsKuri =(tf.push.id == '方向転換Ending')?'surt/':'';"]

    [image name="&mp.name" layer="1" visible="true" folder="&'bgimage/map2/common/human/' + tf.IsKuri" storage="&tf.anoDirection+'.png'" left="&tf.named[mp.name].left" top="&tf.named[mp.name].top"]

[endmacro]

[macro name="serach_truming"]

    ; 動画出現
    [iscript ]
        tf.url='https://www.youtube.com/embed/'+'I7WBBplYTRo'+'?mute=1'
        f.ismdeve=true
        tf.str = 'test_cameraworld.ks';
    [endscript ]

    [dialog type="confirm" text="動画を見ますか?(youtubeへ接続します)" storage_cancel="&tf.str" target_cancel="*end_Event"]
    ;ここで動画を出す

    [fadeoutbgm]
    [wa]
    [clearfix ]
    [cm ]
    [html ]
        <iframe id="videoFrame" width="1280" height="720" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture;" allowfullscreen mute="1"></iframe>  
    [endhtml ]
    [eval exp="document.getElementById('videoFrame').src= tf.url;" ]

    [eval exp="f.istoruming=true"]
    [glink storage="&tf.str" target="*end_Event" text="動画を閉じる" x="1000" y="60" color="btn_12_blue"]
    [s]

[endmacro]

[return]

[s ]