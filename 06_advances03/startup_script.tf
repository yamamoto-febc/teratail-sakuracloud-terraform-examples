#---------------------------------------
# スタートアップスクリプト
#---------------------------------------
# DSR方式に対応するための通信設定用スタートアップスクリプト
resource "sakuracloud_note" "setup_lb_dsr" {
    name = "setup_lb_dsr"
    # VIPを反映したテンプレートの値を参照する
    content = "${data.template_file.lb_dsr_tmpl.rendered}"
}
# 割り当てられたVIPをスタートアップスクリプトに反映するためのテンプレート
data "template_file" "lb_dsr_tmpl" {
  template = "${file("setup_lb_dsr.sh")}"

  vars {
    # ロードバランサ(VIP)リソースのVIPを参照
    vip = "${sakuracloud_load_balancer_vip.vip.vip}"
  }
}