output "aws_private_subnets" {
  value = module.vpc.private_subnets
}

output "aws_vpc_id" {
  value = module.vpc.vpc_id
}

output "gcp_network" {
  value = google_compute_network.net.name
}