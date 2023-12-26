# Copyright 2023 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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