# パケットフィルタ
resource "sakuracloud_packet_filter" "web-filter" {
    name = "web-filter"
    expressions = {
        protocol = "tcp"
        dest_port = "22"
        allow = true
    }
    expressions = {
        protocol = "tcp"
        dest_port = "80"
        allow = true
    }
    expressions = {
        protocol = "tcp"
        dest_port = "1024-65535"
        allow = true
    }
    expressions = {
        protocol = "udp"
        dest_port = "1024-65535"
        allow = true
    }
    expressions = {
        protocol = "icmp"
        allow = true
    }
    expressions = {
        protocol = "ip"
        allow = false
    }
}