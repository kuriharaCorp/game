; 01モードのエンディング
[clearfix]
[cm]

; [dialog text="てすと"]
[iscript ]

  tf.credit=`
  あいうえお<br>

  かきくけこ<br>
  あいうえお<br>

  かきくけこ<br>
  あいうえお<br>

  かきくけこ<br>
  あいうえお<br>

  かきくけこ<br>
  あいうえお<br>

  かきくけこ<br>
  あいうえお<br>

  かきくけこ<br>
  あいうえお<br>

  かきくけこ<br><br><br><br><br><br><br><br><br><br><br><br><br>

  おわり

  `

// 思いつかないのでとりあえず初期化
tf.credit = "";

tf.credit = `

  おしまい
  <br><br><br>

`
tf.credit2 = '©株式会社クリハラ';
[endscript ]


[button name="track" graphic="../fgimage/track.png" x="1100" y="720"]


[layopt layer="0" visible="true"]

; いただきますをする絵
[image name="ed01photo" storage="scene/ed01/1.jpg" layer="0"  left="&1280/2-900/2" time="500" wait="true"]
[wait time="1500"]
[anim name="ed01photo" left="0" time="500"]

; ここでエンドクレジットを流す
[wait time="1500"]


[keyframe name="scroll"]
  [frame p="0%" y="720"]
  [frame p="100%" y="-1500"]
[endkeyframe]

; クレジットの流れる全体的な長さ
[kanim name="track" keyframe="scroll" time="6000" easing="linear"]

; クレジットを流しながら行える
[image name="ed01photo" storage="scene/ed01/2.jpg" layer="0"  left="0" time="1500" wait="true"]
[image name="ed01photo" storage="scene/ed01/3.jpg" layer="0"  left="0" time="1500" wait="true"]


[html name="credit" left="&1280-300" ]
  <head>
    <style>
      .clwhite {
          color: white;
          font-size: 72px;
      }
      .clwhite2 {
          color: white;
          font-size: 18px;
      }
      .container {
          width:300px
      }
    </style>
  </head>
  <body>
    <div class="container">
    <p class="clwhite">[emb exp="tf.credit"]</p>
    <br>
    <p class="clwhite2">[emb exp="tf.credit2"]</p>
    </div>

  </body>
[endhtml]

[kanim name="credit" keyframe="scroll" time="10000" easing="linear"]




[wait time="5000"]
[cm]
[freeimage name="ed01photo" layer="0" time="2000"]

        [mask time="2000" ]

        [dialogS text="タイトル画面に戻ります" ]
        [destroy ]
        [mask_off time="50" ]
        [jump storage="titlever2.ks" ]

[s]
