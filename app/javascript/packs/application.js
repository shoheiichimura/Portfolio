// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application"
import '@fortawesome/fontawesome-free/js/all'

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// ===========ヘッダーメニュー=============
/*global $*/
//ドロップダウンの設定を関数でまとめる
function mediaQueriesWin(){
  var width = $(window).width();
  if(width <= 768) {//横幅が768px以下の場合
    $(".has-child>a").off('click'); //has-childクラスがついたaタグのonイベントを複数登録を避ける為offにして一旦初期状態へ
    $(".has-child>a").on('click', function() {//has-childクラスがついたaタグをクリックしたら
      var parentElem =  $(this).parent();// aタグから見た親要素の<li>を取得し
      $(parentElem).toggleClass('active');//矢印方向を変えるためのクラス名を付与して
      $(parentElem).children('ul').stop().slideToggle(500);//liの子要素のスライドを開閉させる※数字が大きくなるほどゆっくり開く
      return false;//リンクの無効化
    });
  }else{//横幅が768px以上の場合
    $(".has-child>a").off('click');//has-childクラスがついたaタグのonイベントをoff(無効)にし
    $(".has-child").removeClass('active');//activeクラスを削除
    $('.has-child').children('ul').css("display","");//スライドトグルで動作したdisplayも無効化にする
  }
}

// ページがリサイズされたら動かしたい場合の記述
$(window).resize(function() {
  mediaQueriesWin();/* ドロップダウンの関数を呼ぶ*/
});

// ページが読み込まれたらすぐに動かしたい場合の記述
$(window).on('load',function(){
  mediaQueriesWin();/* ドロップダウンの関数を呼ぶ*/
});