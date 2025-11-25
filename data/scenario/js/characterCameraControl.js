var tf = TYRANO.kag.variable.tf;
var f = TYRANO.kag.stat.f;
var TG = tyrano.plugin.kag;

function getImageResolution(filePath) {
  return new Promise((resolve, reject) => {
    const img = new Image();
    img.src = filePath;

    img.onload = function () {
      // 解像度をオブジェクトで返す
      resolve({ x: img.naturalWidth, y: img.naturalHeight });
    };

    img.onerror = function () {
      // エラーの場合は reject
      reject(new Error(`Failed to load the image at ${filePath}`));
    };
  });
}

/*
 * 画像が存在するか確認する
 * @param {string} url チェックしたい画像パス
 * @returns {Promise<boolean>} 存在すればtrue、なければfalseを返す
 */
function checkImageExists(url) {
  return new Promise((resolve) => {
    const img = new Image();

    // 読み込み成功 ⇒ 存在するとみなす
    img.onload = function () {
      resolve(true);
    };

    // 読み込み失敗 ⇒ 存在しないとみなす
    img.onerror = function () {
      resolve(false);
    };

    // URLを設定すると読み込みが始まる
    img.src = url;
  });
}

// ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
// 移動制限
/*
  function calculateMovementLimits(
    mapWidth,
    mapHeight,
    screenWidth,
    screenHeight,
    stepSize = 80
  ) {
    // 水平方向と垂直方向の全体移動可能回数
    const horizontalMoves = Math.max(
      0,
      Math.floor((mapWidth - screenWidth) / stepSize)
    );
    const verticalMoves = Math.max(
      0,
      Math.floor((mapHeight - screenHeight) / stepSize)
    );

    return { horizontalMoves, verticalMoves };
  }
*/
function calculateRemainingMoves(
  offsetX,
  offsetY,
  mapWidth,
  mapHeight,
  screenWidth,
  screenHeight,
  stepSize = 80
) {
  // 数字型として全て変換
  [offsetX, offsetY, mapWidth, mapHeight, screenWidth, screenHeight, stepSize] =
    [
      offsetX,
      offsetY,
      mapWidth,
      mapHeight,
      screenWidth,
      screenHeight,
      stepSize,
    ].map(Number);

  // スクリーンの左上座標
  const screenLeft = -offsetX;
  const screenTop = -offsetY;

  //   左上が基準

  // 左上座標を使って最大移動値を計算(絶対値)
  const upMoves =
    mapHeight < screenHeight ? 0 : Math.abs(Math.floor(screenTop));
  const downMoves =
    mapHeight < screenHeight
      ? 0
      : Math.abs(Math.floor(mapHeight - (screenTop + screenHeight)));
  const leftMoves =
    mapWidth < screenWidth
      ? 0 // マップがスクリーンより小さいなら移動不可
      : Math.abs(Math.floor(screenLeft));
  const rightMoves =
    mapWidth < screenWidth
      ? 0 // マップがスクリーンより小さいなら移動不可
      : Math.abs(Math.floor(mapWidth - (screenLeft + screenWidth)));
  console.log(
    `移動可能距離:${upMoves}, ${downMoves}, ${leftMoves}, ${rightMoves}`
  );
  return { upMoves, downMoves, leftMoves, rightMoves };
}

// ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
// キャラと背景の位置調整

function calculatePositions(
  screenWidth,
  screenHeight,
  charSize,
  bgSize,
  gridX,
  gridY
) {
  const cellSize = 80; // 1マスの大きさ

  // キャラクターの中央配置位置（画面上）
  const charCenterX = screenWidth / 2 - charSize / 2;
  const charCenterY = screenHeight / 2 - charSize / 2;

  // 格子上の目標位置（マス目の左上座標）(スクリーン上の本来の置場┏)
  const targetX = (gridX - 1) * cellSize;
  const targetY = (gridY - 1) * cellSize;

  // 背景の左上の配置位置(キャラ中央配置に対し、実際に置く予定の位置のズレ)
  // キャラクターよりターゲットが左上の場合、プラス
  // キャラクターよりターゲットが右下の場合、マイナスになる
  let offsetX = charCenterX - targetX;
  let offsetY = charCenterY - targetY;

  // 背景のスクリーン端制限
  const clampedOffsetX =
    bgSize.width < screenWidth
      ? 0 // マップが小さいならオフセットを固定
      : Math.max(Math.min(offsetX, 0), screenWidth - bgSize.width);

  const clampedOffsetY =
    bgSize.height < screenHeight
      ? 0 // マップが小さいならオフセットを固定
      : Math.max(Math.min(offsetY, 0), screenHeight - bgSize.height);

  // キャラクターの位置を背景の制限位置に合わせる
  const adjustedCharX = targetX + clampedOffsetX;
  const adjustedCharY = targetY + clampedOffsetY;

  return {
    background: {
      // image で使う数値(背景画像,layer0)
      // tf.oに渡してAutoputに利用。背景画像の原点として利用。
      x: clampedOffsetX,
      y: clampedOffsetY,
    },
    character: {
      // chara_Show で使う数値(1,1のときは0になる必要がある)
      x: adjustedCharX,
      y: adjustedCharY,
    },
    offset: {
      //　calculateMoves で使う。calculateMovesは[move]で使うtf.movesを作成する
      x: clampedOffsetX,
      y: clampedOffsetY,
    },
  };
}

// ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
// キャラの移動制限

// 障害物の配置（複数マスを占有する）
// 画像作成の中に詰める
// const obstacles = [
//   { x: 2, y: 3, w: 3, h: 2 }, // (2,3)から3マス右、2マス下を占有
//   { x: 5, y: 5, w: 2, h: 4 }, // (5,5)から2マス右、4マス下を占有
// ];

function placeItem(x, y, w, h, targetArrayName, additionalProps = {}) {
  if (!tf[targetArrayName]) {
    tf[targetArrayName] = [];
  }
  tf[targetArrayName].push({ x, y, w, h, ...additionalProps });

  // console.log(`${targetArrayName} に配置: x=${x}, y=${y}, w=${w}, h=${h}`);
}

// 障害物を配置
function placeObject(x, y, w, h) {
  placeItem(x, y, w, h, "obstacles", { type: "obstacle" });
}

// イベントを配置(triggerOn or triggerPush)
function placeEvent(x, y, w, h, eventType) {
  placeItem(x, y, w, h, "eventmap", { eventType });
}

// 共通処理: 座標がオブジェクト内にあるかを判定
function isWithinBounds(x, y, obj, condition = () => true) {
  // マクロから渡すと文字列になるので変換して計算
  return (
    Number(x) >= Number(obj.x) && // 左端より右
    Number(x) < Number(obj.x) + Number(obj.w) && // 右端より左
    Number(y) >= Number(obj.y) && // 上端より下
    Number(y) < Number(obj.y) + Number(obj.h) && // 下端より上
    condition(obj) // 追加条件をチェック
  );
}

// 汎用的な衝突チェック関数
function checkCollision(x, y, objects, condition = () => true) {
  if (objects === undefined) return null; // オブジェクトが存在しない場合
  return objects.some((obj) => isWithinBounds(x, y, obj, condition));
}

// 既存の衝突判定にイベント優先の処理を追加
function isObstacle(x, y) {
  // 建物の侵入判定(現在地から向いている方向1マス先に対して)
  const obstacleCheck = checkCollision(x, y, tf.obstacles);

  /*
  // もしtriggerOnがあれば侵入可能にする
  const triggerCheck = isTriggerEvent(x, y, "triggerOn");

  // triggerON以外の進入可能typeを作成する
  // もしThroughがあれば侵入可能にする
  const ThroughCheck = isTriggerEvent(x, y, "Through");

  return obstacleCheck && !triggerCheck && !ThroughCheck;

  */

  // もしtriggerOn,Throughがあれば侵入可能にする
  const triggerCheck = isTriggerEvent(x, y, ["triggerOn", "Through"]);
  return obstacleCheck && !triggerCheck;
}

// イベント判定 (eventTypeが'triggerPush','triggerOn',他指定すれば増やせる)
function isTriggerEvent(x, y, eventType) {
  return checkCollision(
    x,
    y,
    tf.eventmap,
    //  (obj) => obj.eventType === eventType //eventTypeはtriggerOnかPushの文字列をkeyで取り出している
    (obj) => eventType.includes(obj.eventType) //一度で二度検索
  );
}

// 移動処理（元の形を維持）
function moveCharacter(direction, x, y, mapColumns, mapRows) {
  const cellSize = 80;
  let move = { left: "+=0", top: "+=0" }; // デフォルトは移動しない
  tf.isStop = false;

  // x,yは移動前の位置

  const playWallHitSound = () => {
    tf.isStop = true;
    tf.isConflict = true;
    // console.log("壁にぶつかる音を再生");
  };

  // 移動先にあるイベント名(オブジェクト名指定)がある場合condを入れ替える

  // 現在位置から押した方向へプラスマイナスして値を代入する
  const dirMap = {
    Right: [1, 0, "left", "+=80"],
    Left: [-1, 0, "left", "-=80"],
    Up: [0, -1, "top", "-=80"],
    Down: [0, 1, "top", "+=80"],
  };

  // 移動する方向(direction)で実数を変更
  const [dx, dy, axis, delta] = dirMap[direction] || [0, 0, null, null];
  const NextX = tf.st.x + dx;
  const NextY = tf.st.y + dy;

  //map最大グリッド数を超えた場合はfalseにする。(条件A)
  const condA =
    direction === "Right"
      ? x + 1 > mapColumns
      : direction === "Left"
      ? x - 1 <= 0
      : direction === "Up"
      ? y - 1 <= 0
      : direction === "Down"
      ? y + 1 > mapRows
      : false;

  // 次の座標が通れるイベントの場合False(条件B)
  const condB = isObstacle(NextX, NextY);
  // 次の座標の建物進入衝突判定
  const isChange = checkCollision(NextX, NextY, tf.obstacles);

  // 条件によりcondABの優先度を変更する
  const shouldBlock = isChange ? condB || (condA && condB) : condA || condB;

  // 各方向の処理
  if (shouldBlock) {
    playWallHitSound();
  } else {
    if (!isTriggerEvent(NextX, NextY, "triggerPush")) {
      tf.st.x += dx;
      tf.st.y += dy;
      if (axis) move[axis] = delta;
    } else {
      playWallHitSound();
    }
  }

  // 外側Nマスでのカメラ停止合否判定＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
  // 中間
  const medX = mapColumns / 2;
  const medY = mapRows / 2;

  // マップサイズがスクリーンと比較して

  function getInOut(current, target, median) {
    if (current === target) return "MID";
    if (current <= median) return current < target ? "OUT" : "IN";
    return current < target ? "IN" : "OUT";
  }

  function getNX(inout, threshold, maxSize) {
    if (threshold) return maxSize;
    switch (inout) {
      case "IN":
        return 5;
      case "OUT":
        return 3;
      default:
        return 0;
    }
  }

  function getNY(inout, threshold, maxSize) {
    if (threshold) return maxSize;
    switch (inout) {
      case "IN":
        return 3;
      case "OUT":
        return 1;
      default:
        return 0;
    }
  }

  // 閾値の判定(マップとスクリーンのサイズ比較/スクリーン内に収まる場合はTrue)
  const thresholdX = mapColumns <= TG.config.scWidth / cellSize;
  const thresholdY = mapRows <= TG.config.scHeight / cellSize;

  // IN/OUT/MID 判定
  // st.x=後(確定現在)、x=前、med=中間線
  const isInOutX = thresholdX ? "MID" : getInOut(tf.st.x, x, medX);
  const isInOutY = thresholdY ? "MID" : getInOut(tf.st.y, y, medY);

  // n の決定（XとY別の値を使う/カメラ停止のマス範囲）
  const nX = getNX(isInOutX, thresholdX, TG.config.scWidth / cellSize);
  const nY = getNY(isInOutY, thresholdY, TG.config.scHeight / cellSize);

  // カメラ停止判定(確定現在でカメラを停止合否)
  tf.StopCameraX = tf.st.x + nX > mapColumns || tf.st.x - nX <= 0;
  tf.StopCameraY = tf.st.y + nY > mapRows || tf.st.y - nY <= 0;

  // =====================================

  return move; // left と top を返す
}

// tf.Movesを作成。[move]で使う
function calculateMoves() {
  // マップとスクリーンのサイズ
  const mapWidth = f.mapsz.w; // マップの幅
  const mapHeight = f.mapsz.h; // マップの高さ
  const screenWidth = TG.config.scWidth; // スクリーンの幅
  const screenHeight = TG.config.scHeight; // スクリーンの高さ

  // 背景の現在のオフセット位置
  const offsetX = tf.positions.offset.x; // オフセットX
  const offsetY = tf.positions.offset.y; // オフセットY
  console.log(
    `マップサイズ/スクリーンサイズw:${mapWidth}h:${mapHeight}/W:${screenWidth}h:${screenHeight}//オフセットX:${offsetX}Y:${offsetY}`
  );

  // 移動可能な残りの回数を計算し、tf.Moves に設定
  f.Moves = calculateRemainingMoves(
    offsetX, //400
    offsetY, //-80
    mapWidth, //880
    mapHeight, //960
    screenWidth, //1280
    screenHeight //720
  );

  // 移動可能な回数をログ出力
  // console.log(
  //   `Remaining moves: Up=${tf.Moves.upMoves}, Down=${tf.Moves.downMoves}, Left=${tf.Moves.leftMoves}, Right=${tf.Moves.rightMoves}`
  // );
}
