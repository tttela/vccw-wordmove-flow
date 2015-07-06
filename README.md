# vccw-wordmove-flow
vccw,gulp,wordmoveでローカル本番環境を同期するメモ
ローカルで先に開発していてステージングに後からあげるパターン
まずはこのリポジトリをclone
`$ git clone https://github.com/tttela/vccw-wordmove-flow.git`
## vccwをここからclone
`$ git clone https://github.com/miya0001/vccw.git`
## vagrantる
### site.ymlの設定を変更
site.ymlの設定でtheme名とホスト名を変更してないと後で面倒くさい
(またprovisionするハメになる)
### WPオリジナルテーマのディレクトリ設置
先に作っておかないとupする時に怒られる
テーマデータは適当に入れておく

`$ vagrant up`
立ち上げる
## gulpる
### gulpfile.coffee,bower.jsonの設定を変更
gulpfile.coffeeのtheme名を変更
bower.jsonは適時追加

`$ gulp`
設定していたものが色々出てくる
## ステージングにローカルと同じバージョンのWPをインストールしておく
インストールしなくていい方法あればとても良いけど、現状は手動でインストール
## wordmoveる
この辺りの設定をしておく、一度すればOK
[ssh-agentを使ってVagrant上のゲストOSからMac側の秘密鍵を使えるようにする | Firegoby](https://firegoby.jp/archives/5694)
[WordMove メモ（あっさり解決） | 自然体](http://private.hibou-web.com/archives/5345)
### Movefileを編集
local,staging,stagingのdatabase,ssh部分をステージングに合わせる
wordpress_pathが分かりにくいので各サーバー会社のものを調べる
Xserverの場合はこちらを参考
[VCCW+WordMoveでエックスサーバーとローカル環境を同期する | Show-web](http://show-web.jp/2015/03/31/vccw-wordmove%E3%81%A7%E3%82%A8%E3%83%83%E3%82%AF%E3%82%B9%E3%82%B5%E3%83%BC%E3%83%90%E3%83%BC%E3%81%A8%E3%83%AD%E3%83%BC%E3%82%AB%E3%83%AB%E7%92%B0%E5%A2%83%E5%90%8C%E6%9C%9F/)

`$ wordmove push --all`
ステージングに反映されました