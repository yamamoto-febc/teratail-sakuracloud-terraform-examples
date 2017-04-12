#------------------------------------------------------------------------------
# DBサーバー(db-server)の定義
#------------------------------------------------------------------------------
# ディスク(20GB/SSD)
resource sakuracloud_disk "db01" {
    name = "db01"
    # OSとしてCentOS7.3を指定
    source_archive_id = "${data.sakuracloud_archive.centos.id}"
    # サイズ
    size = 20
    # SSH or HDD
    plan = "ssd"
    # パスワード
    password = "${var.password}"
    # ホスト名
    hostname = "db01"
}

# サーバ
resource sakuracloud_server "db01" {
    name = "db01"
    disks = ["${sakuracloud_disk.db01.id}"]
    tags = ["@virtio-net-pci"]
    # ローカル接続用のスイッチに接続
    base_interface = "${sakuracloud_switch.switch.id}"
    # IPアドレス
    base_nw_ipaddress = "192.168.0.100"
    # サブネットマスク長
    base_nw_mask_len = 24
    # ゲートウェイ
    base_nw_gateway = "192.168.0.254"
}