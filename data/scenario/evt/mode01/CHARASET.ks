; 部屋ごとに登録するキャラクター情報

    ;         [chara_new name="pl" jname="&f.playername" storage="chara/hara1.png"]
    ;         [chara_face name="pl" face="suit" storage="chara/hara0.png"]
    ; または
    ;         [chara_new name="pl" jname="&f.playername" storage="chara/hara1.png"]

    ; の二種がある。faceの数が0または無数にある。

    ; キャラ一覧

    ; 操作キャラ
    ;     pl
    ; 補助キャラ
    ;     kuri

    ; 社員キャラ
    ;     玄関・前室を除き各部屋2名ずつ

    ; 非社員キャラ
    ;     玄関・前置きを除き各部屋にランダム数

    ;     ADV表示のときの設定
    ;     画像だったり立ち位置だったり。


    ;             [chara_new name="pl" jname="&f.playername" storage="chara/hara1.png"]
    ; を全員やる

    ;         [chara_face name="pl" face="suit" storage="chara/hara0.png"]
    ; は表記があればリストから登録する

    ; すでにnew を行っている場合は呼び出されても無視する

    ; キャラクター個別として登録
    ; キャラ1 | name | jname | storage | face = true |

    ; faceがtrueの場合さらに読込

    ; キャラ1(face) | name | facename1 | storage1|
    ; キャラ1(face) | name | facename2 | storage2|

    ; newが終わったら

    ; 終わり = キャラ1 | キャラ2 …
    ; とＰＯＰで詰めていく

    ; hoooge = [呼び出したいchara名のリスト]

    ; const hoge = [['chara1','jname','storage',true],['chara2','jname2','storage2',false]]…;

    ; const fuga = [['chara1','fname','storage']['chara1','fname2','storage2'],['chara2',…]];


    ; let hooge = hoooge;

    ; for let m; m < hooge.let ;m++;

    ;     if( もし piyo の中に hooge[m] がなければ){

    ;         // n を0から繰り上げて当てはめていく
    ;     const fuuga = (hoge[n][0] === hooge[m])? n : ~~~  ;

    ;     const [nm ,jnm, str, face] = hoge[fuuga];

    ;         [chara_new name="&nm" jname="&jnm" storage="&str"]

    ;         if(face){
    ;             // n を0から繰り上げて当てはめていく
    ;             const piiyo = (fuga[n][0] === nm) ? n : ~~~ ;
    ;             // 複数ヒットする場合は全て入れる
    ;             const piiyo2 = ~~
    ;             const piiyo3 = ~~

    ;             const [fnm[0] ,fstr[0]] = fuga[piiyo]
    ;             [fnm[1],fstr[1]] = fuga[piiyo2]
    ;             [fnm[2],fstr[2]] = fuga[piiyo3]

    ;             // i を0から繰り上げて当てはめる
    ;             [chara_face name="&nm" face="&fnm[i]" storage="&fstr[i]"]

    ;         }

    ;         piyo.pop = hooge[m];
    ;     }

    ; end for

[iscript ]
// 変数と関数をimport
import {
  characterData,
  characterList,
  faceData,
  generateCharacterData,
  processedCharacters,
} from "../js/characterSetList.js";

generateCharacterData(
  characterList,
  characterData,
  faceData,
  processedCharacters
);

[endscript ]
