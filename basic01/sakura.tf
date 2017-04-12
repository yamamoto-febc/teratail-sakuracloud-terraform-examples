# サーバ管理者のパスワード
variable password {
    # terraform apply時に入力ダイアログが表示される。
    # default = "YOUR_PASSWORD_HERE"
}

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
    description = "Teratail and SakuraCloud tutorial: basic01"
    tags = ["@virtio-net-pci"]
}