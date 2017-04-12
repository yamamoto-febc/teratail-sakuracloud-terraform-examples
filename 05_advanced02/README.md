# クラウドでのインフラ構築を始めよう: 応用編2

応用編2: https://teratail.com/sakura-cloud/tutorial/5

応用編は最終的に以下のような構成になります。

![応用編](https://teratail.storage.googleapis.com/assets/img/sakura/article/4/01_1.png?1491901812195333 "応用編")

> 引用元ページ: https://teratail.com/sakura-cloud/tutorial/5

応用編2では以下を行います。  

- SSH公開鍵の作成
- パケットフィルタの作成
- Webサーバー(2台)作成

また、Terraformで構築するために、以下の点がチュートリアルと異なります

- 現在のTerraform for さくらのクラウドはSSH公開鍵の生成に対応していないため、手元のマシーンで公開鍵を生成する。
- スタートアップスクリプト`lb-dsr`を利用しない。代わりに同等機能を実現するためのスクリプトを手元のマシーンで作成&アップロードする

## 準備

### キーペアの生成

以下のコマンドでキーペアを生成しておきます。(SSH公開鍵生成機能の代わり)

    ssh-keygen -f id_rsa -C ""

パスフレーズは任意で設定してください。

サーバー作成後は生成した秘密鍵を使って以下のようにSSH接続します。

    ssh -i id_rsa root@<サーバのIPアドレス>
