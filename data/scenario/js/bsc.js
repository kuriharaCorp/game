// 全てのモードで使う基本的なコード

// 四方向ボタン(画像が表示されたあとに発火する)
function ImgBtnTrance() {
  document.querySelectorAll(".ar").forEach((button) => {
    button.addEventListener("click", function () {
      let key = "";
      let Mov = "";

      if (button.classList.contains("arT")) {
        key = "ArrowUp";
        // console.log("上ボタンが押されました");
      } else if (button.classList.contains("arR")) {
        key = "ArrowRight";
        // console.log("右ボタンが押されました");
      } else if (button.classList.contains("arB")) {
        key = "ArrowDown";
        // console.log("下ボタンが押されました");
      } else if (button.classList.contains("arL")) {
        key = "ArrowLeft";
        // console.log("左ボタンが押されました");
      } else if (button.classList.contains("ent")) {
        key = "Enter";
        // console.log("Enterが押されました");
      } else if (button.classList.contains("movR")) {
        Mov = true;
        f.Placebtn = "Right";
        // console.log("右移動ボタンが押されました");
      } else if (button.classList.contains("movL")) {
        Mov = true;
        f.Placebtn = "Left";
        // console.log("左移動ボタンが押されました");
      }

      if (key !== "") {
        const e = $.Event("keydown");
        e.key = key;
        $(document).trigger(e); // キーイベントを手動で発火
      }

      if (Mov) {
        tyrano.plugin.kag.ftag.startTag("jump", {
          storage: "make.ks",
          target: "Cngbtn",
          cond: Mov,
        });
      }
    });
  });
}

/**
 * 学習ポイント加算処理
 * @param {number|undefined} score 現在のスコア（未定義なら初期化）
 * @param {number|undefined} count 加点状態（1なら初回済み）
 * @param {number} step モード（1=初回チェック, 2=継続チェック）
 * @param {number} point 加算する点数
 * @returns {[number, number]} 更新されたスコアとカウント
 */
function StudyScore(score, count, step, point) {
  // 初期化
  score = typeof score === "number" ? score : 0;
  count = typeof count === "number" ? count : 0;

  if (step === 1) {
    score += point;
    count = 1;
  } else if (step === 2) {
    if (count === 1) {
      score += point;
      count++;
    }
  }

  return [score, count];
}

/**
 * 学習ポイント加算処理
 * @param {string|undefined} category 部屋名。大区分。trmなど。
 * @param {string|undefined} character 人物・担当野菜。中区分。cabbageなど。
 * @param {string} type WHAT or HOW。小区分。
 */
// セリフ呼び出し
function getTalk(category, character, type) {
  let nm;
  switch (category) {
    case "trm":
      nm = "トリミング室";
      break;
    case "cut":
      nm = "カット室";
      break;
    case "keiryo2":
      nm = "計量室";
      break;
    case "setpre":
      nm = "セット準備室";
      break;
    case "set":
      nm = "セット室";
      break;
    case "seisan":
      nm = "生産管理室";
      break;
    case "enter1":
      nm = "玄関";
      break;
    default:
      nm = "未登録な部屋";
      break;
  }
  const notFoundMessages = [
    "クリハラはいろんな働き方ができるよ。パートなら、勤務時間もその人に合わせて相談できるんだよ。",
    "スーパーのお惣菜で何が好き？私は天ぷらが好きだな",
    "こんにちは！ここは" + nm + "だよ。",
    "……沈黙が返ってきた。",
  ];
  if (
    f.talkto &&
    f.talkto[category] &&
    f.talkto[category][character] &&
    f.talkto[category][character][type]
  ) {
    return f.talkto[category][character][type];
  } else {
    // return "そのセリフは登録されていません。";
    return notFoundMessages[
      Math.floor(Math.random() * notFoundMessages.length)
    ];
  }
}

//dialogSの構成要素

var keyPressScheduled = false;

// 1キーイベント（keyup → keydown）を発火する関数
function fireKey1() {
  console.log("（処理Aによってトリガー）1キーイベントを発火");

  const keyUp = new KeyboardEvent("keyup", {
    key: "1",
    code: "Digit1",
    keyCode: 49,
    which: 49,
    bubbles: true,
  });
  document.dispatchEvent(keyUp);

  // 少しだけ遅延して keydown を発火（人間の操作っぽくする）
  setTimeout(() => {
    const keyDown = new KeyboardEvent("keydown", {
      key: "1",
      code: "Digit1",
      keyCode: 49,
      which: 49,
      bubbles: true,
    });
    document.dispatchEvent(keyDown);
  }, 10); // 10ms 程度で十分
}

// 1キーイベントの予約
function scheduleKeyPress(delay = 100) {
  keyPressScheduled = true;
  setTimeout(() => {
    if (keyPressScheduled) {
      fireKey1();
      keyPressScheduled = false;
    }
  }, delay);
}

// ② 処理A：マウスまたはキーボードで発火可能な処理
function triggerActionByUser(text) {
  tyrano.plugin.kag.ftag.startTag("dialog", {
    text: text,
  });

  console.log("処理Aが実行されました");
  // この時点で1キーのイベントが予約されていれば、発火が許可される
}

// ③ 予約→処理Aの流れを作る
function setupFlow(text) {
  scheduleKeyPress(800); // 0.5秒後に発火予約
  triggerActionByUser(text);
}
