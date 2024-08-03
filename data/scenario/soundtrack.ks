;使用する音楽とSEの一覧読込ページ

[iscript ]
//storageはbgmフォルダ直下が基本。
f.msc=[];
f.msc['title']='music.m4a';
f.msc['bsc']='music.m4a';
f.msc['evt']='explanation.mp3';
f.msc['talk']='shortbreak.mp3';
f.msc['imp']='music.m4a';

f.se=[];
f.se['select']='btn3.mp3';
f.se['ok']='btn4.mp3';
f.se['ng']='beep4.mp3';
f.se['imp']='success.mp3';
f.se['eye']='scenechange.mp3';
[endscript ]


[macro name="bgm"]
[iscript ]
    tf.mgcnm=mp.nm
[endscript ]
[playbgm storage="&f.msc[tf.mgcnm]" restart="false" ]
[endmacro ]

[macro name="se" ]
@eval exp="tf.mgcnm=mp.nm" 

[playse storage="&f.se[tf.mgcnm]"]
[endmacro ]


[return ]
[s ]

