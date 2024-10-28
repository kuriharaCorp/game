; 01modeのモブセリフと仕組み全て


/*
（どこでも）	こんにちは！ここは〇〇室だよ。	
	クリハラはいろんな働き方ができるよ。パートなら、勤務時間もその人に合わせて相談できるんだよ。	
	スーパーのお惣菜で何が好き？私は天ぷらが好きだな。	
		
トリミング室（2人）	野菜が傷まないようにこのフロアは〇℃以下に保たれているよ。	
	このフロアにはダンボールの持ち込みが禁止なんだ。衛生管理のきまりだよ。	
		
カット室（0人）	スライサーでけがをしないように、たくさんルールが決まっているよ。	
	キャベツだけでも〇通りのカット規格があるんだよ。	
		
計量室（6人）	野菜の種類、規格、重量、個数…絶対間違えないようにチェックしなきゃ。	
	一日に何百個も計量しなきゃいけないものは、パッケージ機で計量するよ。	
	一日に数個しか作らないものは、手で計って袋に入れるよ。	
	知ってる？この工場の床の中には水が通っていて、常に冷やされているんだよ。	
	手にケガがあるなら、金属探知機で検知される特別なばんそうこうを貼ってね。	
	古い野菜から順番に使わないとダメだよ！買った野菜が無駄になっちゃうからね。	
	こまめにテーブルと床をきれいに掃除するよ。	
	次は何の野菜をはかればいいかな？タブレットに次の指示が表示されるんだよ。	
		
セット準備室（4人）	えーっと、あのお肉はどこの冷凍庫にしまってあるんだっけ？	
	間違ったものがキット組みされないように、いろんな人が何重にもチェックするきまりになっているんだよ。	
*/

; 初回読み込み用

;mob専用メッセージレイヤーの設定
[position layer="message1" left=160 top=500 width=1000 height=200 marginl="50" page=fore visible=false]
	;※marginはpositionを設定する度リセットされるのでそのたび入れなおす
	;文字が表示される領域を調整（message1）
	[position layer="message1" page=fore margint="15" marginl="20" marginr="20" marginb="20"]

[macro name="Cngmsg"]
	[iscript ]
	(mp.n=='1')?tf.n=1:tf.n=0;
	[endscript]

	[if exp="tf.n==1"]
		; プレイヤーが向いている方向でtopとleftの位置を変える
		[iscript]
			switch (f.vec){
				case 'T': //上
					tf.t=50 , tf.l=450 ; break;
				case 'R': //右
					tf.t=100 , tf.l=1280-500 ; break;
				case 'B': //下
					tf.t=500 , tf.l=450 ; break;
				case 'L': //左
					tf.t=100 , tf.l=0 ; break;
			}
		[endscript]
		[fuki_chara name="others" left="&tf.l" top="&tf.t" sippo="top" max_width=500 fix_width=500 radius=100 color="0xccc"]
		; 枠大きさが変化するので再定義
		[position layer="message1" page=fore margint="15" marginl="20" marginr="20" marginb="20"]
		
		[current layer="message1"]
		@layopt layer=message1 visible=true
		@layopt layer=message0 visible=false
		[font shadow="0x000000"]
	[else ]
		;現在のメッセージレイヤをmessage0に
		[current layer="message0"]
		;通常のメッセージレイヤを表示
		@layopt layer=message0 visible=true
		;ふきだし用のメッセージレイヤの非表示
		@layopt layer=message1 visible=false
		[cm]
	[endif]

[endmacro]

; ここらへんに番地とセリフを配列で登録(初回読み込み用)
[iscript]
	tf.address_book=[];
	
	//第二工場玄関(テスト用)　ここは全部出る
	//tf.address_book['f201_46_01_ent']=[];
	//tf.address_book['f201_46_01_ent'][0]=[[1,1,11,4,3],'テスト用メッセージ'];
	//tf.address_book['f201_46_01_ent'][1]=[[1,1,12,4,3],'一つ右だよ'];

	//第二工場トリミング室
	tf.address_book['f201_29_01_trm']=[];
	tf.address_book['f201_29_01_trm'][0]=[[2,1,5,3,3],'野菜が傷まないようにこのフロアは15℃以下に保たれているよ'];
	tf.address_book['f201_29_01_trm'][1]=[[2,1,2,3,3],'このフロアにはダンボールの持ち込みが禁止なんだ。衛生管理のきまりだよ'];

	//第二工場カット室 該当者がいないので見渡し定点に追加
	tf.address_book['f201_01_01_mac']=[];
	tf.address_book['f201_01_01_mac'][0]=[[1,3,20,12,3],'キャベツだけでも10通りのカット規格があるんだよ'];
	tf.address_book['f201_01_01_mac'][1]=[[7,1,22,6,3],'キャベツだけでも10通りのカット規格があるんだよ'];		

	//第二工場計量室
	tf.address_book['f201_06_15_wgh']=[];
	tf.address_book['f201_06_15_wgh'][0]=[[1,3,8,2,3],'野菜の種類、規格、重量、個数…絶対間違えないようにチェックしなきゃ'];
	tf.address_book['f201_06_15_wgh'][1]=[[1,1,8,6,3],'一日に何百個も計量しなきゃいけないものは、パッケージ機で計量するよ'];
	tf.address_book['f201_06_15_wgh'][2]=[[1,2,16,5,3],'知ってる？この工場の床の中には水が通っていて、常に冷やされているんだよ'];
	tf.address_book['f201_06_15_wgh'][3]=[[2,2,21,5,3],'手にケガがあるなら、金属探知機で検知される特別なばんそうこうを貼ってね'];
	tf.address_book['f201_06_15_wgh'][4]=[[1,2,15,11,3],'古い野菜から順番に使わないとダメだよ！買った野菜が無駄になっちゃうからね'];
	//tf.address_book['f201_06_15_wgh'][5]=[[],'こまめにテーブルと床をきれいに掃除するよ'];
	//tf.address_book['f201_06_15_wgh'][6]=[[],'次は何の野菜をはかればいいかな？タブレットに次の指示が表示されるんだよ'];

	//第一工場セット準備室 ここは全部出る
	tf.address_book['f101_20_01_set']=[];
	tf.address_book['f101_20_01_set'][0]=[[1,2,8,12,3],'えーっと、あのお肉はどこの冷凍庫にしまってあるんだっけ？'];
	tf.address_book['f101_20_01_set'][1]=[[2,2,8,17,3],'間違ったものがキット組みされないように、いろんな人が何重にもチェックするきまりになっているんだよ'];
	tf.address_book['f101_20_01_set'][2]=[[1,2,9,19,3],'青い手袋を使うきまりになっているよ。万が一破片が混入した時に見つけやすい色だからね'];
	tf.address_book['f101_20_01_set'][3]=[[2,1,7,21,3],'似たような名前のタレがたくさんあるから、気を付けてね'];

	//セット室
	tf.address_book['f101_12_25_wap']=[];
	tf.address_book['f101_12_25_wap'][0]=[[1,1,17,11,3],'あわてずに、正確にキット組みすることが大事だよ'];
	tf.address_book['f101_12_25_wap'][1]=[[1,2,21,8,3],'スーパーのお惣菜で何が好き？私は天ぷらが好きだな'];


	//生産管理室
	tf.address_book['f101_34_01_pic']=[];
	tf.address_book['f101_34_01_pic'][0]=[[2,1,19,16,3],'ハンディっていう小型の機械でピッキングをして、スーパーのお店ごとに箱に詰めていくんだよ'];
	tf.address_book['f101_34_01_pic'][1]=[[1,2,4,7,3],'クリハラはいろんな働き方ができるよ。パートなら、勤務時間もその人に合わせて相談できるんだよ'];
	tf.address_book['f101_34_01_pic'][2]=[[2,1,23,20,3],'スーパーが発注した商品が届いてない、なんてことが無いように、一人一人が責任をもってピッキングをしているよ'];
	//tf.address_book['f101_34_01_pic'][3]=[[1,2,8,12,3],'え？商品がひとつ余った？大変だ！最初から見直ししなきゃ！'];


[endscript]





; 部屋変更の度読み込む
; 上で登録していない部屋の場合は無視する
[ignore exp="tf.address_book[f.mpnm]===undefined"]
	[iscript ]
		var address //部屋移動のたび初期化
		address=[];
		f.mob_line=[];
		var n //配列の数(何回繰り返すか)
		n = tf.address_book[f.mpnm].length;

		for(let i=0;i<n;i++){
			address[i]=tf.address_book[f.mpnm][i][0];//[1,1,11,4,3]
			push(...address[i],'m');
			//f.arlblに追加する
			tf.adls=address[i].join('');
			f.arlbl.push(tf.adls);
			f.mob_line[tf.adls]=tf.address_book[f.mpnm][i][1];//'こんにちは！'//ここは〇〇室だよ。'
		}
	[endscript]
[endignore]

[return]
[s]


仕組みは同じでセリフだけ違うので、
仕組みは01、違いはmobに記載する
イベント3の時にmob用カートリッジに切り替える方法を考える
pushに６番目を作る