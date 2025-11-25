// イベント管理オブジェクト
var events = {};

// イベントを登録するマクロ
function registerEvent(x, y, type, callback) {
  const key = `${x},${y}`;
  if (!events[key]) {
    events[key] = [];
  }
  events[key].push({ type, callback });
}

// イベントを呼び出す
function executeEvent(x, y, type) {
  const key = `${x},${y}`;
  if (events[key]) {
    events[key].forEach((event) => {
      if (event.type === type) {
        event.callback(); // コールバックを実行
      }
    });
  }
}

// イベント登録例
// registerEvent(3, 4, "triggerOn", () => {
//   console.log("イベントAが発火しました。");
// });

// registerEvent(20, 15, "triggerOn", () => {
//   console.log("イベントBが発火しました。");
// });

// ジャンルごとの処理をまとめた関数
var eventHandlers = {
  mapMove: (params) => {
    // 処理中に切り替え。ボタン移動を無効化(returnですぐに返す)
    f.isProcessing = true;
    //console.log(`マップ移動: ${params.from} → ${params.to}`);
    console.log(`moveイベントが発動しました:`, params);

    // 実際の移動処理など
    // ここでparams.hoge~で登録した値を取り出せる
    tf.move = { ...params };

    // ここにidだけ取り出す
    f.NowRoomName = tf.move.id;
  },

  contact: (params) => {
    //console.log(`マップ移動: ${params.from} → ${params.to}`);
    console.log(`contactイベントが発動しました:`, params);

    // 主に座標に侵入したときに発火
    // 実際の移動処理など
    // ここでparams.hoge~で登録した値を取り出せる
    tf.contact = { ...params };
  },

  search: (params) => {
    console.log(`searchイベントが発動しました:`, params);
    tyrano.plugin.kag.ftag.startTag("jump", {
      storage: "test_cameraworld.ks",
      target: "zkey",
    });
  },
  triggerPush: (params) => {
    console.log(`Pushイベントが発動しました:`, params);
    // ここに処理を記述
    tf.push = { ...params };

    tyrano.plugin.kag.ftag.startTag("jump", {
      storage: "test_cameraworld.ks",
      target: "zkey",
    });
  },
  uniqueEvent: (params) => {
    console.log(`ユニークイベント: ${params.description}`);
    // ユニークなイベント処理
  },
};

// イベント登録マクロ
function SetEvent({ type, id, params }) {
  if (!events[type]) events[type] = {};
  events[type][id] = params;
}

// イベント発火処理
function triggerEvent(type, id) {
  try {
    // イベントが存在するか確認
    if (events[type] && events[type][id]) {
      const params = events[type][id];

      // イベントハンドラが存在するか確認して実行
      if (eventHandlers[type]) {
        // ここで実行発火
        eventHandlers[type](params);
      } else {
        console.error(`イベントハンドラが見つかりません: type=${type}`);
      }
    } else {
      console.error(`イベントが見つかりません: type=${type}, id=${id}`);
    }
  } catch (error) {
    console.error(`triggerEvent 内でエラーが発生しました:`, error);
  }
}

// ==================
// 登録済みデータ例(SetEventで作成した内容例)
// ==================
// const events = {
//   mapMove: {
//     map1_to_map2: { from: "Map1", to: "Map2" },
//   },
//   uniqueEvent: {
//     treasure_chest: { description: "宝箱イベント" },
//   },
// };
// ==================

// 範囲チェックとイベント発火
function checkAndTriggerEventsWithBounds(x, y, type, condition) {
  checkAndTriggerEvent(x, y, type, {
    condition,
    // ↑がTrueの時以下が発火
    // ここにOnEvent.ksに飛ぶ処理を書けばいいんじゃない？
    onTrigger: (type, matchedType) => {
      //matchingEventId) => {
      // 全てのイベントのいずれかが発火成功したら発火する場所
      /*
        if (type === "mapMove") {
          console.log(
            `イベンベント発火しました。：${tf.move.from} → ${tf.move.to}`
          );
        }
        */
    },
  });
}

// params.facingで方向チェック
function isFacingCorrectDirection(currentFacing, expectedFacing) {
  return currentFacing === expectedFacing;
}

// キー入力の監視
function listenForKey(keys, callback) {
  const keySet = new Set(keys);

  const handleKeyPress = (event) => {
    console.log(`押されたキー: ${event}`);
    if (keySet.has(event)) {
      console.log(`対応するキーが押されました: ${event}`);
      callback(event);
    }
  };

  // グローバル変数に登録して管理
  globalKeyCallback = handleKeyPress;
  window.addEventListener("keydown", handleKeyPress);
  console.log("リスナーを登録しました");
}

// Pushイベント処理
function checkAndTriggerPushEvent(currentX, currentY, currentFacing, type) {
  const directionOffsets = {
    Up: { x: 0, y: -1 },
    Right: { x: 1, y: 0 },
    Down: { x: 0, y: 1 },
    Left: { x: -1, y: 0 },
  };

  checkAndTriggerEvent(currentX, currentY, type, {
    directionOffsets,
    listenKeys: ["Enter", "z"],
  });
}

// リスナーを明示的に削除
var globalKeyCallback = null;

function removeKeyListener() {
  if (globalKeyCallback) {
    console.log("既存のリスナーを削除します");
    window.removeEventListener("keydown", globalKeyCallback);
    globalKeyCallback = null; // リスナーを解除
  }
}

// 座標とtypeでidを返す
function findMatchingEvent(x, y, type, condition = () => true) {
  // 配列でもそうでない場合でも対応
  const arrayType = Array.isArray(type) ? type : [type];

  // 配列の最後から先頭に向かってループ
  for (let i = arrayType.length - 1; i >= 0; i--) {
    const typeName = arrayType[i];

    // 該当typeNameが定義されていない場合はスキップ
    if (events[typeName]) {
      // 同じtypeNameのイベントを順にチェック
      for (const id in events[typeName]) {
        const params = events[typeName][id];

        // `isWithinBounds` を使用して範囲と条件を判定
        if (isWithinBounds(x, y, params, condition)) {
          /*
        返り値:={
          "type": "triggerPush",
          "id": "方向転換"
        }
        */
          // イベントIDだけでなく、ヒットしたtypeNameもまとめて返す
          return { type: typeName, id };
          /*
          const result = { type: typeName, id };
          console.log("返り値:=" + JSON.stringify(result, null, 2));
          return result;
          */
        }
      }
    }
  }

  return null; // 一致するイベントが見つからない場合
}

// 共通化処理
function checkAndTriggerEvent(x, y, type, options = {}) {
  const { directionOffsets, condition, onTrigger, listenKeys } = options;

  // 向きに基づく座標調整（`directionOffsets` が指定されている場合のみ実行）
  if (
    directionOffsets &&
    tf.lastDirection &&
    directionOffsets[tf.lastDirection]
  ) {
    x += directionOffsets[tf.lastDirection].x;
    y += directionOffsets[tf.lastDirection].y;
  }

  // 条件を満たすイベントを検索
  // ・ここまでtypeは配列でもあるが、後ろからヒットした文字列1つだけを返す
  console.log(`座標:${x},${y}`);
  const matchingEventId = findMatchingEvent(x, y, type, condition);

  if (matchingEventId) {
    const { type: matchedType, id: matchedId } = matchingEventId;
    // console.log("見つかったイベントID:", matchedId);
    // console.log("一致したイベントタイプ:", matchedType);

    // リスナーを削除して再登録
    removeKeyListener();
    tf.nowID = "";

    if (listenKeys) {
      // 指定されたキーでイベント発火(現在:z/enterで発火-*zkeyに飛ぶ)
      listenForKey(
        listenKeys,
        (key) => {
          if (f.isEventRunning) {
            console.error("イベントが発動中なのでボタンは無効化されています");
            return;
          }

          console.log(
            `${matchedType}イベントがキー ${key} により進行しました: 使用されたID: ${matchedId}`
          );
          tf.nowID = matchedId;
          triggerEvent(matchedType, matchedId);
          if (onTrigger) onTrigger(matchedType, matchedId);
        },
        console.log("eventHandlerがnullで削除されてます")
      );
    } else {
      // 即座にイベントを発火
      triggerEvent(matchedType, matchedId);
      if (onTrigger) onTrigger(matchedType, matchedId);
    }

    tf.nowEvent = matchedType;
  } else {
    console.log(
      `${matchingEventId}イベント: 条件に一致するイベントが見つかりませんでした`
    );
  }
}
