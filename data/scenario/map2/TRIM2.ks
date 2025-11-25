

; plc=place(場所)
    [eval exp="tf.plc='f201_29_01_trm'" ]


; ◆◆左上エリア(X1-10,Y1-10)＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝


    ; ◆左上支柱周り(X1-4,Y1-2)
    ; 右側で進入できるハズのものができていない

        [AutoPut pct="pillar12y.png" x="1" y="0" c="t"]
        [AutoPut pct="container3_OR.png" x="1" y="1" c="t"]
        [AutoPut pct="container0_OR.png" x="0" y="0.5" c="t"]

    ; ◆左テーブル周り(X1-3,Y3-6)

        ; 人物置くコンテナ
        [AutoCont n="1" color="BL" x="2.5" y="3" t="r" t0="r"]
        ; 人物
        [AutoNPC dic="l" name="mob1" x="3" y="4"]
        ; 左上の正方形テーブル
        [AutoZPut pct="table22" c="t" x="1" y="3.8"]
        ; コンテナ(テーブル上)
        [AutoCont n="1" color="BL" x="1" y="4" t="r"]
        [AutoCont n="1" color="BL" x="2" y="4.5" t="r"]

    ; ◆右テーブル周り(X5-8,Y3-6)

        ; 人物置くコンテナ
        [AutoCont n="2" color="BL" x="5" y="3" t="l" layer="0"]
        ; 人物
        [AutoNPC dic="b" name="mob2" x="6" y="2"]
        ; 左上長方形横テーブル
        [AutoZPut pct="table42" c="t" x="5" y="2"]
        ; 左2
        [AutoCont n="1" color="BL" x="6" y="2" t=""]
        ; 左3
        [AutoCont n="1" color="BL" x="7" y="3" t="" layer="0"]
        ; 左4
        [AutoCont n="1" color="BL" x="8" y="2" t=""]
        ; 左1
        [AutoCont n="1" color="BL" x="5" y="2.5" t=""]
        ; 人物置くコンテナ
        [AutoCont n="2" color="BL" x="6.5" y="5" t="d" t0="d" layer="0"]
        ; 人物
        [AutoNPC dic="t" name="Letas-F" x="8" y="5"]


; ◆◆右上エリア(X11-20,Y1-10)＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

    ; ◆ゴミ室(X11-20,Y0-5)

        [AutoPut pct="room_gomi.png" x="11" y="0" layer="0"]

    ; ◆コンテナ(X11,Y4-6)

        ; 中央ゴミ室前コンテナ
        [AutoCont n="5" color="BL" x="11" y="6" t="" t0="l"]

    ; ◆コンテナ(X19,Y5-7)

        ; 右端コンテナ
        [AutoCont n="5" color="BL" x="19" y="7" t="d"]


; ◆◆左下エリア(X1-10,Y11-14)＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝


    ; ◆次のマップ周り

        [AutoPut pct="ex_floor_conc11.png" x="0" y="10" c="t" t="u" layer="0"]
        [AutoPut pct="ex_floor_conc11.png" x="0" y="11" c="t" t="u" layer="0"]

    ; ◆左テーブル周り(X1-3,Y12-14)

        ; 左下正方形テーブル
        [AutoZPut pct="table22" c="t" x="2" y="11"]
        [AutoCont n="1" color="BL" x="3" y="11.5" t=""]

    ; ◆右テーブル周り(X6-8,Y12-14)

        ; 左下2長方形テーブル
        [AutoZPut pct="table32" c="t" x="6" y="11"]
        [AutoCont n="1" color="BL" x="7" y="11.5" t=""]
        ; 人物となりのコンテナ(作用業に横に置くやつ)
        [AutoCont n="2" color="BL" x="6.5" y="15" t="" t0=""]
        ; 人物配置
        [AutoNPC dic="t" name="Cabbage-F" x="8" y="14"]

; ◆◆右下エリア(X11-20,Y11-14)＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

; ◆前室への柱(X11-12,Y12-16)
    [AutoPut pct="pillar23y.png" x="11" y="11.5" c="t" t="u"]



; マップ移動
[AutoPut layer="0" pct="ex_floor_conc11.png" x="0" y="10" c="t" t="u" name="exroad"]
[AutoPut layer="0" pct="ex_floor_conc11.png" x="0" y="11" c="t" t="u" name="exroad2"]

; ここにしないと、表示階層が狂うことがある
; アニメーション
[AutoPut pct="arrow_anim_L.gif" x="0" y="10"  c="t" t="u" layer="0"]
[AutoPut pct="cross.gif" x="13" y="5" c="t" layer="0"]
[AutoPut pct="cross.gif" x="14" y="5" c="t" layer="0"]
[AutoPut pct="cross.gif" x="15" y="5" c="t" layer="0"]
[AutoPut pct="cross.gif" x="20" y="9" c="t" layer="0"]
[AutoPut pct="cross.gif" x="20" y="10" c="t" layer="0"]
[AutoPut pct="cross.gif" x="15" y="15" c="t" layer="0"]
[AutoPut pct="cross.gif" x="16" y="15" c="t" layer="0"]




; 退室時ONイベント
[SetEvent EventType="2" x="1" y="10" w="1" h="2" type="contact" id="採点トリミング室"]


[SetEvent EventType="2" x="0" y="10" w="1" h="2" type="mapMove" id="トリミング室toカット室"]

[return]

トリミング室まで。
レイヤーの表示順番など試行錯誤する

・左下テーブルの両方が貫通する
    - コンテナの影響?
・左上テーブル右の上部位とコンテナ周りが進入可能
    - テーブル上部位はキャラの高さと合わない。下へずらすなどする。
・左上テーブル左のコンテナ周りが進入可能
    - 同文
・左上柱とコンテナが通れない
    ・影などの上が通れない。

    オブジェクトの種類でまとめるのではなく、1構成のオブジェクトとして1まとめにする

    テンプレ


; ◆◆左上エリア(X1-10,Y1-10)＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝


; ◆左上支柱周り(X1-4,Y1-2)

; ◆左テーブル周り(X1-3,Y3-6)

; ◆右テーブル周り(X5-8,Y3-6)


; ◆◆右上エリア(X11-20,Y1-10)＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝


; ◆コンテナ(X11,Y4-6)

; ◆コンテナ(X19,Y5-7)


; ◆◆左下エリア(X1-10,Y11-14)＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝


; ◆左テーブル周り(X1-3,Y12-14)

; ◆右テーブル周り(X6-8,Y12-14)


; ◆◆右下エリア(X11-20,Y11-14)＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

; ◆前室への柱(X11-12,Y12-16)
