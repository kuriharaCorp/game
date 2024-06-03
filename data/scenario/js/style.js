/*
全判的に使うfunction
*/

//ab=オブジェサイズwh,cd=オブジェ左上位置xy,e=オブジェ種類…1移動不可2床3壁
function push(a,b,c,d,e){
    let tf = TYRANO.kag.variable.tf;
    if(isNaN(e) || e === "")e=1;//eが何も入ってない場合1にする
    //tf['pl1']=[];tf['pl2']=[];tf['pl3']=[];tf['pl4']=[];tf['pl5']=[];
    tf['pl1'].push(a);
    tf['pl2'].push(b);
    tf['pl3'].push(c);
    tf['pl4'].push(d);
    tf['pl5'].push(e);
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