var tf = TYRANO.kag.variable.tf;
var f = TYRANO.kag.stat.f;
var TG = tyrano.plugin.kag;

//let characterList = ["pl", "kuri"];
// その部屋に登場するキャラ一覧
f.characterList = [];
f.characterList["ENTER2"] = ["pl", "kuri"];
f.characterList["ANTE2"] = ["pl", "kuri", "mbg"];
f.characterList["TRIM2"] = ["pl", "kuri", "mbm", "mbw", "mob"];
f.characterList["CUT2"] = ["pl", "kuri", "mbm", "mbw"];
f.characterList["KEIRYO2"] = ["pl", "kuri", "mbm", "mbw"];
f.characterList["SETPre"] = ["pl", "kuri", "mbm", "mbw"];
f.characterList["SET"] = ["pl", "kuri", "mbm", "mbw"];
f.characterList["SEISAN"] = ["pl", "kuri", "mbm", "mbw"];
f.characterList["ENTER1"] = ["pl", "kuri"];

// キャラクターの基本情報 [キャラ名, 表示名, メイン画像ファイル名, 顔画像の有無]
f.characterData = [
  ["pl", "プレイヤー", "chara/hara1.png", true],
  ["kuri", "マロン", "chara/kuri1.png", true],
  ["mbm", "社員さん", "chara/man0.png", false],
  ["mbw", "社員さん", "chara/wom0.png", false],
  ["mbg", "社員さん", "chara/mon0.png", false],
  ["mob", "パートさん", "chara/man1.png", false],
];

// 顔画像情報 [キャラ名, 顔名, 顔画像ファイル名]
f.faceData = [
  ["pl", "suit", "chara/hara0.png"],
  ["kuri", "suit", "chara/kuri0.png"],
];

// すでに処理済みのキャラクター名を記録
f.processedCharacters = [];

/**
 * キャラクター情報を出力する関数
 * @param {string[]} characterList - 処理対象キャラ名リスト
 * @param {Array[]} characterData - 各キャラの基本データ
 * @param {Array[]} faceData - 各キャラの顔画像データ
 * @param {string[]} processedCharacters - 処理済みキャラ名を記録する配列
 * @returns {string[]} - 更新された処理済みキャラ名リスト
 */
function generateCharacterData(
  characterList,
  characterData,
  faceData,
  processedCharacters
) {
  // キャラクター名リストをループ処理
  for (let i = 0; i < characterList.length; i++) {
    const targetName = characterList[i];

    // すでに処理済みであればスキップ
    if (!processedCharacters.includes(targetName)) {
      // characterData の各要素（[キャラ名, 表示名, ...]）からキャラ名を name として取り出して一致をチェック
      const characterEntry = characterData.find(
        ([name]) => name === targetName
      );
      if (!characterEntry) continue; // 見つからなければスキップ

      // 取得した情報を分解
      const [charName, displayName, imagePath, hasFace] = characterEntry;

      // キャラクターの基本タグを出力
      console.log(
        `[chara_new name="${charName}" jname="${displayName}" storage="${imagePath}"]`
      );
      tyrano.plugin.kag.ftag.startTag("chara_new", {
        name: charName,
        jname: displayName,
        storage: imagePath,
      });

      // 顔画像の登録がある場合
      if (hasFace) {
        // faceData の各要素（[キャラ名, 顔名, ...]）からキャラ名を name として取り出して一致をチェック
        const matchedFaces = faceData.filter(([name]) => name === charName);

        // 各顔画像に対してタグ出力
        matchedFaces.forEach(([_, faceName, faceImagePath]) => {
          console.log(
            `[chara_face name="${charName}" face="${faceName}" storage="${faceImagePath}"]`
          );
          tyrano.plugin.kag.ftag.startTag("chara_face", {
            name: charName,
            face: faceName,
            storage: faceImagePath,
          });
        });
      }

      // 処理済みキャラとして記録
      processedCharacters.push(targetName);
    }
  }

  return processedCharacters; // 処理済みリストを返す
}

// // 関数の実行
// generateCharacterData(
//   characterList,
//   characterData,
//   faceData,
//   processedCharacters
// );

// console.log("===========================================");

// characterList = ["pl", "kuri", "mob"];

// generateCharacterData(
//   characterList,
//   characterData,
//   faceData,
//   processedCharacters
// );

/*
    [loadjs storage="../scenario/js/characterSetList.js"]


    [iscript ]

        let characterList = ["pl", "kuri"];

        f.processedCharacters = generateCharacterData(
        characterList,
        f.characterData,
        f.faceData,
        f.processedCharacters
        );

    [endscript ]

    [chara_show name="pl"]


    [s]
*/
