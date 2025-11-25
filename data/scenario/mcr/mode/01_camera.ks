; 01の時の入室時のカメラの操作

[eval exp="f.IsEntranceCamera = true"]

[macro name="entrance"]

    ; 初期化
    [camera x=0 y=0 zoom=1]
    [layopt layer="2" visible="true"  ]
    [iscript]

        switch (mp.roomname){
            case 'ANTE2': f.roomtitle = '[第二工場]前室';
            break;
            case 'TRIM2': f.roomtitle = 'トリミング室';
            break;
            case 'CUT2': f.roomtitle = 'カット室';
            break;
            case 'KEIRYO2': f.roomtitle = '計量室';
            break;
            case 'SETPre': f.roomtitle = 'セット準備室';
            break;
            case 'SET': f.roomtitle = 'セット室';
            break;
            case 'SEISAN': f.roomtitle = '生産管理室';
            break;

            case 'ENTER1': f.roomtitle = 'プラットﾌｫｰﾑ';
            break;

            default:
            f.roomtitle = '[第二工場]玄関';
        }

    [endscript ]

    [if exp="mp.roomname == 'ANTE2'"]
    ; 第二工場前室
        [iscript]

            tf.caFst = [-500 , 200];
            tf.caNex1 = [-500 , -250];
            tf.caNex2 = [-400 , -250];

        [endscript ]
        [cameraControl fz="2"]

    [elsif exp="mp.roomname == 'TRIM2'"]
    ; トリミング室
        [iscript]

            tf.caFst = [500 , 500];
            tf.caNex1 = [-500 , 500];
            tf.caNex2 = [-500 , -200];

        [endscript ]
        [cameraControl]

    [elsif exp="mp.roomname == 'CUT2'"]
    ; カット室
        [iscript]

            tf.caFst = [0 , -200];
            tf.caNex1 = [-0 , 0];
            tf.caNex2 = [-0 , 200];
            tf.caNex3 = [-0 , 500];

        [endscript ]
        [cameraControl time="500"]

    [elsif exp="mp.roomname == 'KEIRYO2'"]
    ; 計量室
        [iscript]

            tf.caFst = [800 , -300];
            tf.caNex1 = [500 , -300];
            tf.caNex2 = [-300 , -300];
            tf.caNex3 = [-500 , 100];

        [endscript ]
        [cameraControl]

    [elsif exp="mp.roomname == 'SETPre'"]
    ; セット準備室
        [iscript]

            tf.caFst = [0 , -1300];
            tf.caNex1 = [0 , -1100];
            tf.caNex2 = [0 , -500];

        [endscript ]
        [cameraControl time="1500"]

    [elsif exp="mp.roomname == 'SET'"]
    ; セット室
        [iscript]

            tf.caFst = [500 , 200];
            tf.caNex1 = [500 , 0];
            tf.caNex2 = [500 , -600];
            tf.caNex3 = [-300 , -600];

        [endscript ]
        [cameraControl time="1500"]

    [elsif exp="mp.roomname == 'SEISAN'"]
    ; 生産管理室
        [iscript]

            tf.caFst = [-200 , 0];
            tf.caNex1 = [-200 , 700];
            tf.caNex2 = [1300 , 700];
            tf.caNex3 = [1300 , -600];

        [endscript ]
        [cameraControl time="1500"]
    [elsif exp="mp.roomname == 'ENTER1'"]
    ; 玄関1
        ; カメラの初期化
        [camera x="0" y="0" time="50"]
        [eval exp="tf.skipCamera = true"]
        [mask_off time="50" ]

    [else]
    ; 玄関2
        [cameraFirstToEnd fx="500" fy="200" fz="2" time="2000"]
    [endif]

    [ignore exp="tf.skipCamera"]
        ; 会話前に少し引く
        [camera x=0 y=0 zoom=0.9 layer="0" time="500" wait="false" ease_type="ease-out"]
        [camera x=0 y=0 zoom=0.9 layer="1" time="500" wait="true" ease_type="ease-out"]
        [wait time="100"]
    [endignore]
    [eval exp="f.isProcessing = false"]
    [eval exp="tf.skipCamera = false"]

    [free layer="2" name="roomname" time="500" wait="true" ]
    ; 変数の削除
    [clearvar exp="tf.caFst"]
    [clearvar exp="tf.caNex1"]
    [clearvar exp="tf.caNex2"]
    [clearvar exp="tf.caNex3"]


[endmacro]


; カメラ挙動のマクロ化
[macro name="cameraFirstToEnd"]

    [camera layer="0" from_x=%fx|'' from_y=%fy|'' from_zoom=%fz|1 x=%x|0 y=%y|0 zoom=%z|1 time=%time|1500 wait="false" ease_type="ease-in-out"]
    [camera layer="1" from_x=%fx|'' from_y=%fy|'' from_zoom=%fz|1 x=%x|0 y=%y|0 zoom=%z|1 time=%time|1500 wait="false" ease_type="ease-in-out"]
    [mask_off time="50" ]
    [ptext name="roomname" layer="2" align="center" x="&1280/2-500/2" y="&720/2-100" text="&f.roomtitle" size="72" width="500" overwrite="true" time="2000" bold="true" edge="4px 0x000000, 2px 0xFFFFFF"]


    [wait_camera]
    [wait time=1500]
    ; [cameraFirst fx="-500" fy="200" fz="2" x="-500" y="-250"]

[endmacro]

[macro name="cameraNext"]

    [camera layer="0"  * from_x=%fx from_y=%fy zoom=%z|1 wait="false" ease_type="ease-in-out"]
    [camera layer="1"  * from_x=%fx from_y=%fy zoom=%z|1 wait="true" ease_type="ease-in-out"]
    [wait *]
    ; [cameraNext fx="-500" fy="500" x="-500" y="-200" time="2000"]

[endmacro]

[macro name="cameraControl"]
    [cameraFirstToEnd fx="&tf.caFst[0]" fy="&tf.caFst[1]" fz=%fz|1 x="&tf.caNex1[0]" y="&tf.caNex1[1]"]

    [cameraNext fx="&tf.caNex1[0]" fy="&tf.caNex1[1]" x="&tf.caNex2[0]" y="&tf.caNex2[1]" time=%time|1000 cond="tf.caNex2!=undefined"]
    [cameraNext fx="&tf.caNex2[0]" fy="&tf.caNex2[1]" x="&tf.caNex3[0]" y="&tf.caNex3[1]" time=%time|1000 cond="tf.caNex3!=undefined"]

    [cameraFirstToEnd]
[endmacro]


[return ]