# teratail-sakuracloud-terraform-examples

## 概要

Teratailとさくらのクラウドのコラボキャンペーンで公開されている各チュートリアルの構成を[Terraform for さくらのクラウド](https://github.com/yamamoto-febc/terraform-provider-sakuracloud)で構築するためのtfファイル集です。

Teratailキャンペーンページ  
https://teratail.com/sakura-cloud

## 使い方

チュートリアルごとにディレクトリを分けてtfファイルを格納しています。  
このリポジトリをクローンし、各チュートリアルのディレクトリにcdしてからterraformコマンドを実行してください。

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
