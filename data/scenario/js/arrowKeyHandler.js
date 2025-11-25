// 矢印キー;
//const f = TYRANO.kag.stat.f; charactorkeyですでに宣言したので省略

var arrowKeys = new Set(["ArrowUp", "ArrowDown", "ArrowLeft", "ArrowRight"]);

var isPushbutton = false;

// 特定のマウスボタンを押したとき
$(document).ready(function () {
  // 中ボタンなど全部のキーを押したときに通る
  document.addEventListener("mousedown", function (event) {
    if (f.isEventRunning) return; //イベント発動中なら無視
    if (f.isProcessing) return; // 処理中なら無視

    if (event.button === 1 && f.dbg) {
      // 1はマウスの中ボタン
      if (f.isEventRunning) return; //イベント発動中なら無視
      if (f.isProcessing) return; // 処理中なら無視

      /*
         tf.moveはマップ移動時に生成され、移動後に初期化される
         f.NowRoomNameはMapWarpを起動させておく必要がある。
      */

      f.scNameTemp = f.NEXTMAP[f.NowRoomName];
      // 部屋移動以前にメニューを開く場合の処理
      if (!f.scNameTemp) f.scNameTemp = "ENTER2"; //もしmodeごとにスタート位置が異なるなら変更する

      f.obstaclesTemp = tf.obstacles;
      f.lastDirectionTemp = tf.lastDirection;
      f.namedTemp = tf.named;
      f.sctTemp = tf.sct;
      f.scoreTemp = tf.score;
      f.countTemp = tf.count;
      f.contactTemp = tf.contact;
      f.stTemp = tf.st;
      // f.arrTemp = tf.arr;
      f.eventmapTemp = tf.eventmap;

      // マップワープ呼び出し
      tyrano.plugin.kag.ftag.startTag("sleepgame", {
        storage: "test_menuREF.ks",
        next: "false",
      });
    }
  });

  // 特定のキーボタンを押したとき
  $(document).keydown(function (e) {
    // console.log(arrowKeys);
    // if (isPushbutton) {
    //   (async () => {
    //     console.log("停止中…");
    //     // ここで 500ms 待って・・・
    //     await new Promise((resolve) => setTimeout(resolve, 1000));

    //     // 待機後に false にする
    //     isPushbutton = false;
    //   })();
    // }

    if (isPushbutton) onButtonPress();

    if (!isPushbutton) {
      isPushbutton = true;
      console.log(
        `キーをアローを通ったよ: ${f.isEventRunning}/${f.isProcessing}`
      );
      // 矢印キーを処理
      if (arrowKeys.has(e.key)) {
        if (f.isEventRunning) return; //イベント発動中なら無視
        if (f.isProcessing) {
          console.log(`f.isProcessing が=trueなので無視`);
          return;
        } // 処理中なら無視

        f.isProcessing = true;

        // [move]マクロを呼び出し
        var macro = TYRANO.kag.stat.map_macro["move"];
        TYRANO.kag.stat.mp = { ekey: e.key };
        TYRANO.kag.ftag.nextOrderWithIndex(macro.index, macro.storage);

        return; // 矢印キーの処理を終了
      }

      // その他のキーを処理（Enter や z など）
      if (["Enter", "z"].includes(e.key)) {
        //console.log(`キーが押されました: ${e.key}`);
        // listenForKey に渡したコールバックを直接呼び出す
        if (typeof globalKeyCallback === "function") {
          globalKeyCallback(e.key);
        }
      }
    }
    document.addEventListener("keyup", () => {
      isPushbutton = false;
    });
  });
});

var lastPressTime = 0;
function onButtonPress() {
  const now = Date.now();
  if (now - lastPressTime < 500) {
    // 前回の押下からまだ1秒経っていない場合は無視
    return;
  }
  lastPressTime = now;

  // ここに実行したい処理
  console.log("押されたので処理！");
  isPushbutton = false;
  console.log(`キーをfalseに戻した: ${f.isEventRunning}/${f.isProcessing}`);
}
