# さくらのクラウド APIキーの設定など
provider sakuracloud {
    # APIトークン: 環境変数SAKURACLOUD_ACCESS_TOKENを設定する、または以下の行で設定する
    # token = "YOUR_TOKEN_HERE"
    
    # APIシークレット: 環境変数SAKURACLOUD_ACCESS_TOKENを設定する、または以下の行で設定する
    # secret = "YOUR_SECRET_HERE"

    # 操作対象ゾーン
    zone = "tk1a"
}

#------------------------------------------------------------------------------
# ルータ+スイッチの定義
#------------------------------------------------------------------------------
resource "sakuracloud_internet" "router" {
    name = "ルータ＋スイッチ"
    # プリフィックス
    nw_mask_len = 28
    # 帯域幅
    band_width = 100
}

#------------------------------------------------------------------------------
# ロードバランサの定義
#------------------------------------------------------------------------------
# ロードバランサ(本体)
resource "sakuracloud_load_balancer" "lb" {
    name = "ロードバランサ"

    # 接続するルータ+スイッチのID
    switch_id = "${sakuracloud_internet.router.switch_id}"
    # VRID
    VRID = 1

    # IPv4アドレス#1 / ネットマスク / ゲートウェイ
    ipaddress1 = "${sakuracloud_internet.router.nw_ipaddresses[0]}"
    nw_mask_len = "${sakuracloud_internet.router.nw_mask_len}"
    default_route = "${sakuracloud_internet.router.nw_gateway}"
}

# ロードバランサー(VIP)
resource "sakuracloud_load_balancer_vip" "vip" {
    # VIPが紐づくロードバランサのID
    load_balancer_id = "${sakuracloud_load_balancer.lb.id}"
    # VIP
    vip = "${sakuracloud_internet.router.nw_ipaddresses[1]}"
    # 監視ポート
    port = 80
    # 監視間隔(秒)
    delay_loop = 10
}

# ロードバランサー(サーバ)
resource "sakuracloud_load_balancer_server" "servers"{
    # 2台分
    count = 2
    # VIPリソースのID
    load_balancer_vip_id = "${sakuracloud_load_balancer_vip.vip.id}"

    # 実サーバーのIPアドレス
    ipaddress = "${sakuracloud_internet.router.nw_ipaddresses[2 + count.index]}"

    # 監視設定
    check_protocol = "http"
    check_path = "/"
    check_status = "200"
}
