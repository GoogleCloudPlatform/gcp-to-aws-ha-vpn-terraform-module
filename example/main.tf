module "network" {
  source         = "../modules/network"
  network_name   = var.network_name
  subnet_regions = var.subnet_regions
}

module "gcp-aws-ha-vpn" {
  source = "../"

  prefix              = "vpn"
  num_tunnels         = var.num_tunnels
  aws_router_asn      = var.aws_router_asn
  aws_vpc_cidr        = var.aws_vpc_cidr
  gcp_router_asn      = var.gcp_router_asn
  project_id          = var.project_id
  vpn_gwy_region      = var.vpn_gwy_region
  shared_secret       = var.shared_secret
  aws_private_subnets = module.network.aws_private_subnets
  aws_vpc_id          = module.network.aws_vpc_id
  gcp_network         = module.network.gcp_network
}