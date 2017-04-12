# プライベートIP
variable private_ip_addresses {
    default = ["192.168.0.1","192.168.0.2"]
}

# データソース(アーカイブ)
data sakuracloud_archive "centos" {
    os_type="centos"
}

# ディスク
resource "sakuracloud_disk" "disks" {
    # 2台分
    count = 2
    # ディスク名
    name = "${format("web%02d", count.index + 1)}"
    # コピー元アーカイブ(CentOS7を利用)
    source_archive_id = "${data.sakuracloud_archive.centos.id}"
    # パスワード
    password = "${var.password}"
    # ホスト名
    hostname = "${format("web%02d", count.index + 1)}"
    
    # スタートアップスクリプトと紐付け
    note_ids = ["${sakuracloud_note.setup_lb_dsr.id}"]

    # SSH公開鍵
    ssh_key_ids = ["${sakuracloud_ssh_key.key.id}"]
    # パスワード/チャレンジレスポンスでのSSHログイン無効化
    disable_pw_auth = true

}

# サーバー
resource "sakuracloud_server" "servers" {
    # 2台分
    count = 2
    # サーバー名
    name = "${format("web%02d", count.index + 1)}"
    # 接続するディスク
    disks = ["${sakuracloud_disk.disks.*.id[count.index]}"]
    # タグ(NICの準仮想化モード有効化)
    tags = ["@virtio-net-pci"]

    # ルータ+スイッチを接続
    base_interface = "${sakuracloud_internet.router.switch_id}"

    # eth0のIPアドレス/ネットマスク/ゲートウェイ設定
    base_nw_ipaddress = "${sakuracloud_internet.router.nw_ipaddresses[2 + count.index]}"
    base_nw_mask_len = "${sakuracloud_internet.router.nw_mask_len}"
    base_nw_gateway = "${sakuracloud_internet.router.nw_gateway}"

    # パケットフィルタを接続
    packet_filter_ids = ["${sakuracloud_packet_filter.web-filter.id}"]

    # 追加NIC(スイッチに接続)
    additional_interfaces = ["${sakuracloud_switch.switch.id}"]

    # SSHで接続してhttpdをインストール
    connection {
       user = "root"
       host = "${self.base_nw_ipaddress}"
       private_key = "${file("id_rsa")}" #秘密鍵を指定
    }
    # httpdインストール
    provisioner "remote-exec" {
        inline = [
            "yum install -y httpd",
            "hostname >> /var/www/html/index.html",
            "systemctl enable httpd.service",
            "systemctl start httpd.service"
        ]
    }
    # プライベートIP設定
    provisioner "remote-exec" {
        inline = [
          "nmcli connection add type ethernet con-name local-eth1 ifname eth1 ip4 ${var.private_ip_addresses[count.index]}/24 gw4 192.168.0.254",
          "nmcli connection up local-eth1"
        ]
    }
}