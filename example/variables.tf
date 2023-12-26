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

variable "impersonate_service_account" {
  type = string
}

variable "project_id" {
  type = string
}

variable "network_name" {
  type = string
}

variable "subnet_regions" {
  type = list(string)
}

variable "vpn_gwy_region" {
  type = string
}

variable "gcp_router_asn" {
  type = string
}

variable "aws_router_asn" {
  type = string
}

variable "aws_vpc_cidr" {
  type = string
}

variable "shared_secret" {
  type = string
}

variable "num_tunnels" {
  type = number
  validation {
    condition     = var.num_tunnels % 2 == 0
    error_message = "number of tunnels needs to be in multiples of 2."
  }
  validation {
    condition     = var.num_tunnels >= 4
    error_message = "min 4 tunnels required for high availability."
  }
  description = <<EOF
    Total number of VPN tunnels. This needs to be in multiples of 2.
  EOF
}