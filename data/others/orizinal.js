/*
オリジナルタグを作る
参照
https://note.com/milkcat/n/n0597d78dd931
*/



(function(){
    TYRANO.kag.ftag.master_tag.jumpS = {
        pm: { storage: null, target: null, countpage: !0 },
        start: function (pm) {
          if (this.kag.stat.hold_glink && !pm.storage && !pm.target) {
            pm.storage = this.kag.stat.hold_glink_storage;
            pm.target = this.kag.stat.hold_glink_target;
            this.kag.stat.hold_glink = !1;
            this.kag.stat.hold_glink_storage = "";
            this.kag.stat.hold_glink_target = "";
          }
          var that = this;
          setTimeout(function () {
            that.kag.ftag.nextOrderWithLabel(pm.target, pm.storage);
          }, 1);
          //jump先を変数に入れる
          const tf = this.kag.variable.tf
          tf.nextjump=pm.storage;
        },
        
        kag: TYRANO.kag

    };

})();

// tyrano.plugin.kag.tag.jump = {
//     pm: { storage: null, target: null, countpage: !0 },
//     start: function (pm) {
//       if (this.kag.stat.hold_glink && !pm.storage && !pm.target) {
//         pm.storage = this.kag.stat.hold_glink_storage;
//         pm.target = this.kag.stat.hold_glink_target;
//         this.kag.stat.hold_glink = !1;
//         this.kag.stat.hold_glink_storage = "";
//         this.kag.stat.hold_glink_target = "";
//       }
//       var that = this;
//       setTimeout(function () {
//         that.kag.ftag.nextOrderWithLabel(pm.target, pm.storage);
//       }, 1);
//     },
//   };