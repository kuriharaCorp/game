;このファイルは削除しないでください！
;
;make.ks はデータをロードした時に呼ばれる特別なKSファイルです。
;Fixレイヤーの初期化など、ロード時点で再構築したい処理をこちらに記述してください。
;
;

; f,tf,TGの略宣言
[loadjs storage="../scenario/js/tranceTyrano.js"]

[iscript ]

  console.log(`中身確認：make通過開始`);


  f.sq=[]
  f.sq['x']=$(".grid").width();
  f.sq['y']=$(".grid").height();

  //現在位置用の変数宣言
  tf.cpos=[]
  //前後左右の位置の変数宣言
  tf.adps=[]
  //現在座標の変数宣言
  tf.loc=[];
  tf.loc['x']=0;
  tf.loc['y']=0;

  const source = f.roomname[f.scNameTemp];

  /*
    // 計測用
    try {
      console.log(`中身確認：${source.name}`);
    } catch (e) {
      console.warn("中身確認：source.name の取得に失敗", source, e);
    }
  */

  // 部屋のファイルネーム(例:f201_39_13_ant)
  tf.name = source.name;

  // 部屋の初期位置XYステータス(ワープの場合はこっち)
  // tf.st = { ...source.st }; // 浅いコピー
          
  //↑sleepgameで消える

    //マクロ参照先を現在のシナリオデータ準拠にする
    // 不調だったら入れてみる
    // TYRANO.kag.stat.map_macro = $.extend(
    //     true, 
    //     {}, 
    //     TYRANO.kag.stat.map_macro, 
    //     tyrano.plugin.kag.stat.map_macro
    // )
    
  tf.scName = f.scNameTemp;
  tf.obstacles = f.obstaclesTemp;
  tf.lastDirection = f.lastDirectionTemp;
  tf.named = f.namedTemp;
  tf.sct = f.sctTemp;
  tf.score = f.scoreTemp;
  tf.count = f.countTemp;
  tf.contact = f.contactTemp;
  tf.st = f.stTemp; // 位置情報
  // tf.arr = f.arrTemp;
  tf.eventmap = f.eventmapTemp;
          
  //↑sleepgameで消える
[endscript ]
[clearvar exp="f.scNameTemp"]
[clearvar exp="f.obstaclesTemp"]
[clearvar exp="f.lastDirectionTemp"]
[clearvar exp="f.namedTemp"]
[clearvar exp="f.sctTemp"]
[clearvar exp="f.scoreTemp"]
[clearvar exp="f.countTemp"]
[clearvar exp="f.contactTemp"]
[clearvar exp="f.stTemp"]
; [clearvar exp="f.arrTemp"]
[clearvar exp="f.eventmapTemp"]

 [endscript]
 [clearstack stack="if"]
 [clearstack stack="macro"]
 [crbtn]

/*
  本当はロードする度にカメラをリセットして再設定した方がいい
*/
; ; カメラを使う前の準備運動
; [camera x=0 y=0 time="50" wait="true" ]
; [layopt layer="message0" visible="false"  ]


;make.ks はロード時にcallとして呼ばれるため、return必須です。
[return]

[s]

; 十字ボタンの左右の切り替え(return必要なし)
*Cngbtn
[eval exp="f.isProcessing = true"]
[clearfix name="ar" ]

[crbtn]

[eval exp="f.isProcessing = false"]
[s ]

