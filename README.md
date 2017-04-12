# teratail-sakuracloud-terraform-examples

## 概要

Teratailとさくらのクラウドのコラボキャンペーンで公開されている各チュートリアルの構成を[Terraform for さくらのクラウド](https://github.com/yamamoto-febc/terraform-provider-sakuracloud)で構築するためのtfファイル集です。

Teratailキャンペーンページ  
https://teratail.com/sakura-cloud

## 使い方

チュートリアルごとにディレクトリを分けてtfファイルを格納しています。  
このリポジトリをクローンし、各チュートリアルのディレクトリにcdしてからterraformコマンドを実行してください。

|チュートリアル| ディレクトリ名|
|---------|--------------|
| 超入門編 | [01_pre_basic](01_pre_basic) |
| 入門編1  | [02_basic01](02_basic01) |
| 入門編2  | [03_basic02](03_basic02) |
| 応用編1  | [04_advanced01](04_advanced01) |
| 応用編2  | [05_advanced02](05_advanced02) |
| 応用編3  | [06_advanced03](06_advanced03) |


#### 実行例

```bash

# 1) このリポジトリをクローン
git clone https://github.com/yamamoto-febc/teratail-sakuracloud-terraform-examples.git
cd teratail-sakuracloud-terraform-examples

# 2) 各チュートリアルのディレクトリへ移動
cd 01_pre_basic

# 3) terraformコマンド実行
terraform apply

# 使い終わったらdestroyで消す
terraform destroy

```

## License

 `teratail-sakuracloud-terraform-examples` Copyright (C) 2017 Kazumichi Yamamoto.

  This project is published under [Apache 2.0 License](LICENSE.txt).
  
## Author

  * Kazumichi Yamamoto ([@yamamoto-febc](https://github.com/yamamoto-febc))
