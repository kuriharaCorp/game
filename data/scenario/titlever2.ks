/*
タイトル改造

初めからと続きから
あとで実績確認ボタンなども。
*/

[freeimage layer="0" ]
[cm]

@hidemenubutton
@clearstack

[iscript ]
    tf.n=0;
    if(f.end01)tf.n=1;

    f.dbg=false;
    tf.dbgcnt=0;
[endscript ]


@bg storage ="&'bg_title'+tf.n+'.jpg'" time=100

@wait time = 200

*start 

[image name="logo" layer="0" page="back"  storage="../image/title/logo_title.png" visible="true" x="26" y="10"   ]

[trans layer="0" time="1500" method="slideInUp"]

[wait time="1500" ]

[button name="stbtn01" x="610" y="420" graphic="title/btn_sts01_0.png" enterimg="title/btn_sts01_1.png" target="gamestart" keyfocus="1" exp="f.mode='01'"]
[button name="dbgbtn" x="1140" y="610" graphic="title/btn_debug.png" fix="true" target="*dbgcount" ]


/*
[button name="conbtn" x="976" y="536" graphic="title/btn_config0.png" enterimg="title/btn_config1.png"  ]
[button name="crebtn" x="976" y="611" graphic="title/btn_credit0.png" enterimg="title/btn_credit1.png"  ]

[button x=135 y=230 graphic="title/btn_md011.png" enterimg="title/btn_md012.png"  target="gamestart" keyfocus="1" exp="f.mode='01'"]
[button x=135 y="&230+100" graphic="title/button_start2.png" enterimg="title/button_start3.png"  target="gamestart" keyfocus="2" exp="f.mode='none'" ]
[button x=135 y=590 graphic="title/button_config.png" enterimg="title/button_config2.png" role="sleepgame" storage="config.ks" keyfocus="5"]
*/
[s]

*dbgcount
[clearstack ]
[iscript ]
    tf.dbgcnt++
    if(tf.dbgcnt==20)f.dbg=true;
[endscript ]
    [dialog text="デバッグモードを起動しました。" cond="f.dbg"]

[s ]

*gamestart
[cm ]
[clearfix ]

;ゲームクリア後の処理
[if exp="f.end01===true" ]
    [dialog type="confirm" text="初期化してもう一度初めから遊びますか？(クリア後変化はありません)" storage_cancel="titlever2.ks"]
    [clearvar]
    @eval exp="f.mode='01';tf.n=0;" 
    @bg storage ="&'bg_title'+tf.n+'.jpg'" time=1000
    @wait time = 1500
[endif]

[image name="bgtitle" layer="0" folder="bgimage"  storage="&'bg_title'+tf.n+'.jpg'" visible="true"]
[wait time="50" ]
[anim name="bgtitle" width="2000"  left="-500" top="-400" ]
[mask time="2000" ]
[wait time="2000" ]
[free layer="0" name="bgtitle" ]
[free layer="0" name="logo" ]
[freeimage layer="base"]
[mask_off time="50" ]


[jump storage="map.ks" ]
[s ]
