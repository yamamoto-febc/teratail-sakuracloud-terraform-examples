# サーバ管理者のパスワード
variable password {
    # 以下任意の値を設定してください。
    # コメントアウトしたままの場合、terraform apply時に入力ダイアログが表示されます。
    # default = "YOUR_PASSWORD_HERE"
}

# さくらのクラウド APIキーの設定など
provider sakuracloud {
    # APIトークン: 環境変数SAKURACLOUD_ACCESS_TOKENを設定する、または以下の行で設定する
    # token = "YOUR_TOKEN_HERE"
    
    # APIシークレット: 環境変数SAKURACLOUD_ACCESS_TOKENを設定する、または以下の行で設定する
    # secret = "YOUR_SECRET_HERE"

    # 操作対象ゾーン
    zone = "tk1a"
}

# OS(CentOS 7.3)
data sakuracloud_archive "centos"{
    os_type = "centos"
}

#------------------------------------------------------------------------------
# サーバー(web-server)の定義
#------------------------------------------------------------------------------
# ディスク(20GB/SSD)
resource sakuracloud_disk "web-server" {
    name = "web-server"
    # OSとしてCentOS7.3を指定
    source_archive_id = "${data.sakuracloud_archive.centos.id}"
    # サイズ
    size = 20
    # SSH or HDD
    plan = "ssd"
    # パスワード
    password = "${var.password}"
    # ホスト名
    hostname = "web-server"
}

# サーバ
resource sakuracloud_server "web-server" {
    name = "web-server"
    disks = ["${sakuracloud_disk.web-server.id}"]
    tags = ["@virtio-net-pci"]
    # 追加NIC(スイッチに接続)
    additional_interfaces = ["${sakuracloud_switch.switch.id}"]
}

#------------------------------------------------------------------------------
# スイッチの定義
#------------------------------------------------------------------------------
resource sakuracloud_switch "switch" {
    name = "192.168.0.0/24セグメント用"
    description = "ローカル接続用のスイッチ"
}