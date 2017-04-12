# クラウドでのインフラ構築を始めよう: 応用編3

応用編3: https://teratail.com/sakura-cloud/tutorial/6

応用編は最終的に以下のような構成になります。

![応用編](https://teratail.storage.googleapis.com/assets/img/sakura/article/4/01_1.png?1491901812195333 "応用編")

> 引用元ページ: https://teratail.com/sakura-cloud/tutorial/6

応用編3では以下を行います。  

- プライベートネットワーク用のスイッチ作成
- WebサーバへのNIC追加 & IP設定
- DBサーバ作成
- VPCルータ作成

## 準備

### キーペアの生成

以下のコマンドでキーペアを生成しておきます。(SSH公開鍵生成機能の代わり)

    ssh-keygen -f id_rsa -C ""

パスフレーズは任意で設定してください。

サーバー作成後は生成した秘密鍵を使って以下のようにSSH接続します。

    ssh -i id_rsa root@<サーバのIPアドレス>

DBサーバへは公開鍵を登録していないため、VPN接続を確立した上で以下のようにSSH接続します。

    ssh root@192.168.0.100