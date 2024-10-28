/*
全判的に使うfunction
*/

//ab=オブジェサイズwh,cd=オブジェ左上位置xy,e=オブジェ種類…1移動不可2床3壁
function push(a,b,c,d,e,f){
    let tf = TYRANO.kag.variable.tf;
    if(isNaN(e) || e === "")e=1;//eが何も入ってない場合1にする
    if(f === undefined || f === "")f="";//fが何も入ってない場合空白にする
    //tf['pl1']=[];tf['pl2']=[];tf['pl3']=[];tf['pl4']=[];tf['pl5']=[];
    tf['pl1'].push(a);
    tf['pl2'].push(b);
    tf['pl3'].push(c);
    tf['pl4'].push(d);
    tf['pl5'].push(e);
    tf['pl6'].push(f);
};

//a2rをa/2/rと分離して入れる。
function split(str){
    let f = TYRANO.kag.stat.f;
    let a = str.match(/[^0-9]/g), n = a.length-1;
    f['povz']=a[n];a[n]='';
    f['povx']=a.join("");
    f['povy']= str.split(/[^0-9]/g).join("");
};

    //点数計算関数(01.ks)
    //func=>flg01trm, cnt=>f.flg01trm1, n=>加点(25)
    function calstudy(flg,cnt,c,n){
        if(c==1){
                if(typeof cnt==='undefined'){
                    (typeof flg!=='undefined')?flg=flg+n*1:flg=n*1;
                    cnt=1;
                }}
        if(c==2){
                if(cnt==1)flg=flg+n*1;
                cnt++;
        }
        return[flg,cnt];
    };




//Shiftキーを押しているかどうか。押し続けている場合5秒まで。
let isFunctionEnabled = false; // Shiftキー押下中はtrueに設定
let shiftPressedTime = 0; // Shiftキーが押された時間
let coolDownTime = 10000; // クールタイム（ミリ秒）

document.addEventListener('keydown', function(event) {
  if (event.key === 'Shift' && isFunctionEnabled != "none") {
    shiftPressedTime = Date.now(); // Shiftキーが押された時間を記録
    isFunctionEnabled = true;
    //console.log('Shiftキーが押されました'+isFunctionEnabled);

    // 5秒後にShiftキーを解除するタイマーを設定
    setTimeout(function() {
      if (isFunctionEnabled) {
        isFunctionEnabled = "none";
        //console.log('Shiftキーを解除しました'+isFunctionEnabled);

      }
    }, 5000);
  }
});

document.addEventListener('keyup', function(event) {
  if (event.key === 'Shift') {
    isFunctionEnabled = false;
    //console.log('Shiftキーを離しました');

    // クールタイムタイマーを設定
    setTimeout(function() {
      isFunctionEnabled = true;
      //console.log('Shiftキーが再び押せるようになりました');
    }, coolDownTime);
  }
});


//ベクトルキーを押し続けた時に押し上げて連打と同じ判定にする
//Shiftキーを押している間のみ。
document.addEventListener('keydown', function(event) {
  if (event.code === 'ArrowUp' || event.code === 'ArrowDown' ||
      event.code === 'ArrowLeft' || event.code === 'ArrowRight') {
    if (isFunctionEnabled) {
      event.preventDefault(); // 矢印キー無効化
      setTimeout(function() {
        document.dispatchEvent(new KeyboardEvent('keyup', { code: event.code }));
        //console.log('停止した');
      }, 100);
    }
  }
});
