# VPCルーター本体の定義
resource "sakuracloud_vpc_router" "vpc" {
    name = "vpc_router"
}

# VPCルーター配下のプライベートNIC(192.168.11.0/24を割当)
resource "sakuracloud_vpc_router_interface" "eth1"{
    vpc_router_id = "${sakuracloud_vpc_router.vpc.id}"
    index = 1                                       # NICのインデックス(1〜7)
    switch_id = "${sakuracloud_switch.switch.id}"   # スイッチのID
    ipaddress = ["192.168.0.254"]                   # 実IPリスト
    nw_mask_len = 24                                # ネットマスク長
}

# リモートアクセス:L2TP/IPSec
resource "sakuracloud_vpc_router_l2tp" "l2tp" {
    vpc_router_id = "${sakuracloud_vpc_router.vpc.id}"
    vpc_router_interface_id = "${sakuracloud_vpc_router_interface.eth1.id}"

    pre_shared_secret = "${var.pre_shared_secret}" # 事前共有シークレット
    range_start = "192.168.0.200"                 # IPアドレス動的割り当て範囲(開始)
    range_stop = "192.168.0.249"                  # IPアドレス動的割り当て範囲(終了)
}

# リモートユーザーアカウント
resource "sakuracloud_vpc_router_user" "user1" {
    vpc_router_id = "${sakuracloud_vpc_router.vpc.id}"

    name = "${var.vpn_username}"     # ユーザー名
    password = "${var.vpn_password}" # パスワード
}
