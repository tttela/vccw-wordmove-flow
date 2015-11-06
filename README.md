# vccw-wordmove-flow
vccw,gulp,wordmoveでローカル本番環境を同期するメモ<br>
ローカルで先に開発していてステージングに後からあげるパターン<br>
まずはこのリポジトリをclone<br>
`$ git clone https://github.com/tttela/vccw-wordmove-flow.git`
## vccwをここからclone
先ほどのcloneした中身は1階層上にして今からcloneするものと同階層にしておく<br>
`$ git clone https://github.com/miya0001/vccw.git`<br>
で、この中身も1階層上にしておく。この辺りのフローなにか良い方法があればいいな…
## vagrantる
### site.ymlの設定を変更
site.ymlの設定でホスト名を変更してないと後で面倒くさい<br>
(またprovisionするハメになる)

`$ vagrant up`<br>
立ち上げる
## gulpる
### gulpfile.coffee,bower.jsonの設定を変更
gulpfile.coffeeのtheme名を変更<br>
bower.jsonは適時追加

`$ sudo npm i`<br>
`$ gulp`<br>
`$ bower i`<br>
設定していたものが色々出てくる
## ステージングにローカルと同じバージョンのWPをインストールしておく
インストールしなくていい方法あればとても良いけど、現状は手動でインストール
## wordmoveる
この辺りの設定をしておく、一度すればOK<br>
[ssh-agentを使ってVagrant上のゲストOSからMac側の秘密鍵を使えるようにする | Firegoby](https://firegoby.jp/archives/5694)<br>
[WordMove メモ（あっさり解決） | 自然体](http://private.hibou-web.com/archives/5345)
### Movefileを編集
local,staging,stagingのdatabase,ssh部分をステージングに合わせる<br>
wordpress_pathが分かりにくいので各サーバー会社のものを調べる<br>
Xserverの場合はこちらを参考<br>
[VCCW+WordMoveでエックスサーバーとローカル環境を同期する | Show-web](http://show-web.jp/2015/03/31/vccw-wordmove%E3%81%A7%E3%82%A8%E3%83%83%E3%82%AF%E3%82%B9%E3%82%B5%E3%83%BC%E3%83%90%E3%83%BC%E3%81%A8%E3%83%AD%E3%83%BC%E3%82%AB%E3%83%AB%E7%92%B0%E5%A2%83%E5%90%8C%E6%9C%9F/)

`$ wordmove push --all`<br>
ステージングに反映されました