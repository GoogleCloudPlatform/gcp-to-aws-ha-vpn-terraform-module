locals {
  four_interface_ext_gwys = [for i in range(floor(var.num_tunnels / 4)) :
    { key : i, redundancy_type = "FOUR_IPS_REDUNDANCY" }
  ]
  two_interface_ext_gwys = [for i in range(ceil(var.num_tunnels / 4) - length(local.four_interface_ext_gwys)) :
    {
      key : i + length(local.four_interface_ext_gwys),
      redundancy_type = "TWO_IPS_REDUNDANCY"
    } if var.num_tunnels % 4 != 0
  ]
  num_ext_gwys = concat(local.four_interface_ext_gwys, local.two_interface_ext_gwys)
  aws_vpn_conn_addresses = {
    for k, v in chunklist([
      for k, v in flatten([
        for k, v in aws_vpn_connection.vpn_conn :
        [v.tunnel1_address, v.tunnel2_address]
      ]) : v
    ], 4) :
    k => v
  }
  tunnels = chunklist(flatten([
    for i in range(length(local.num_ext_gwys)) : [
      for k, v in setproduct(range(2), chunklist(range(4), 2)) :
      {
        ext_gwy : i,
        peer_gwy_interface : k,
        vpn_gwy_interface : v[0] % 2
      }
    ]
  ]), var.num_tunnels)[0]
  bgp_sessions = {
    for k, v in flatten([
      for k, v in aws_vpn_connection.vpn_conn :
      [
        {
          ip_address : v.tunnel1_cgw_inside_address,
          peer_ip_address : v.tunnel1_vgw_inside_address
        },
        {
          ip_address : v.tunnel2_cgw_inside_address,
          peer_ip_address : v.tunnel2_vgw_inside_address
        }
      ]
    ]) : k => v
  }
}

resource "google_compute_ha_vpn_gateway" "gwy" {
  name    = "${var.prefix}-ha-vpn-gwy"
  network = var.gcp_network
  region  = var.vpn_gwy_region
}

resource "google_compute_external_vpn_gateway" "ext_gwy" {
  for_each = { for k, v in local.num_ext_gwys : k => v }

  name            = "${var.prefix}-ext-vpn-gwy-${each.key}"
  redundancy_type = each.value["redundancy_type"]
  dynamic "interface" {
    for_each = local.aws_vpn_conn_addresses[each.key]
    content {
      id         = interface.key
      ip_address = interface.value
    }
  }
}

resource "google_compute_router" "router" {
  name    = "vpn-router"
  network = var.gcp_network
  region  = var.vpn_gwy_region
  bgp {
    asn            = var.gcp_router_asn
    advertise_mode = "CUSTOM"
    advertised_groups = [
      "ALL_SUBNETS"
    ]
  }
}

resource "google_compute_vpn_tunnel" "tunnel" {
  for_each = { for k, v in local.tunnels : k => v }

  name                            = "${var.prefix}-tunnel-${each.key}"
  shared_secret                   = var.shared_secret
  peer_external_gateway           = google_compute_external_vpn_gateway.ext_gwy[each.value["ext_gwy"]].name
  peer_external_gateway_interface = each.value["peer_gwy_interface"]
  region                          = var.vpn_gwy_region
  router                          = google_compute_router.router.name
  ike_version                     = "2"
  vpn_gateway                     = google_compute_ha_vpn_gateway.gwy.id
  vpn_gateway_interface           = each.value["vpn_gwy_interface"]
}

resource "google_compute_router_interface" "interface" {
  for_each = local.bgp_sessions

  name       = "${var.prefix}-interface-${each.key}"
  router     = google_compute_router.router.name
  region     = var.vpn_gwy_region
  ip_range   = "${each.value["ip_address"]}/30"
  vpn_tunnel = google_compute_vpn_tunnel.tunnel[each.key].name
}

resource "google_compute_router_peer" "peer" {
  for_each = local.bgp_sessions

  name            = "${var.prefix}-peer-${each.key}"
  interface       = "${var.prefix}-interface-${each.key}"
  peer_asn        = var.aws_router_asn
  ip_address      = each.value["ip_address"]
  peer_ip_address = each.value["peer_ip_address"]
  router          = google_compute_router.router.name
  region          = var.vpn_gwy_region
}