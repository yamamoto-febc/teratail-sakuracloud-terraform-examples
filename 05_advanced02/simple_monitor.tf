resource "sakuracloud_simple_monitor" "monitor" {
    target = "${sakuracloud_load_balancer_vip.vip.vip}"
    health_check = {
        protocol = "http"
        delay_loop = 60
        path = "/index.html"
        status = "200"
    }
    notify_email_enabled = true
}