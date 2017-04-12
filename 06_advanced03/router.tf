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