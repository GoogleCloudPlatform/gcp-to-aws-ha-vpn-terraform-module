variable "project_id" {
  type = string
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

variable "aws_vpc_id" {
  type = string
}

variable "gcp_network" {
  type        = string
  description = "Name of the GCP network."
}

variable "aws_vpc_cidr" {
  type = string
}

variable "aws_private_subnets" {
  type = list(string)
}

variable "shared_secret" {
  type = string
}

variable "prefix" {
  type        = string
  description = "Prefix used for all the resources."
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