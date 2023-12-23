########################################################################
################ GCP Network ###########################################
########################################################################

resource "google_compute_network" "net" {
  name                    = var.network_name
  auto_create_subnetworks = false
  routing_mode            = "GLOBAL"
}

resource "google_compute_subnetwork" "subnet" {
  count = length(var.subnet_regions)

  ip_cidr_range            = cidrsubnets("10.0.0.0/16", 2, 2)[count.index]
  name                     = "snet-${count.index}"
  network                  = google_compute_network.net.name
  region                   = var.subnet_regions[count.index]
  private_ip_google_access = true
}

########################################################################
################ AWS Network ###########################################
########################################################################

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "aws-net"
  cidr = "10.2.0.0/16"

  azs             = ["us-east-2a", "us-east-2b", "us-east-2c"]
  private_subnets = cidrsubnets("10.2.0.0/20", 2, 2, 2)
  public_subnets  = cidrsubnets("10.2.16.0/20", 2, 2, 2)

  enable_nat_gateway = true
  enable_vpn_gateway = false
}

