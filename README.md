## GCP to AWS HA VPN Terraform module

This module provisions HA VPN between GCP and AWS. The minimum number of tunnels required is 4, but can be incremented in multiples of 2.

### Reference Architecture

![Reference Architecture](https://cloud.google.com/static/network-connectivity/docs/vpn/images/build-ha-vpn-connections-google-cloud-aws.svg)

Image Credit: https://cloud.google.com/network-connectivity/docs/vpn/tutorials/create-ha-vpn-connections-google-cloud-aws#architecture_overview.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 1.6 |
| aws | ~> 5.31 |
| google | ~> 5.10 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 5.31 |
| awscc | n/a |
| google | ~> 5.10 |

## Resources

| Name | Type |
|------|------|
| [aws_customer_gateway.gwy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/customer_gateway) | resource |
| [aws_ec2_transit_gateway.tgw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway) | resource |
| [aws_vpn_connection.vpn_conn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_connection) | resource |
| [awscc_ec2_transit_gateway_attachment.tgw_attachment](https://registry.terraform.io/providers/hashicorp/awscc/latest/docs/resources/ec2_transit_gateway_attachment) | resource |
| [google_compute_external_vpn_gateway.ext_gwy](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_external_vpn_gateway) | resource |
| [google_compute_ha_vpn_gateway.gwy](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_ha_vpn_gateway) | resource |
| [google_compute_router.router](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router) | resource |
| [google_compute_router_interface.interface](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_interface) | resource |
| [google_compute_router_peer.peer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_peer) | resource |
| [google_compute_vpn_tunnel.tunnel](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_vpn_tunnel) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_private\_subnets | n/a | `list(string)` | n/a | yes |
| aws\_router\_asn | n/a | `string` | n/a | yes |
| aws\_vpc\_cidr | n/a | `string` | n/a | yes |
| aws\_vpc\_id | n/a | `string` | n/a | yes |
| gcp\_network | Name of the GCP network. | `string` | n/a | yes |
| gcp\_router\_asn | n/a | `string` | n/a | yes |
| num\_tunnels | Total number of VPN tunnels. This needs to be in multiples of 2. | `number` | n/a | yes |
| prefix | Prefix used for all the resources. | `string` | n/a | yes |
| project\_id | n/a | `string` | n/a | yes |
| shared\_secret | n/a | `string` | n/a | yes |
| vpn\_gwy\_region | n/a | `string` | n/a | yes |
<!-- END_TF_DOCS -->    

## Contributing

See [`CONTRIBUTING.md`](CONTRIBUTING.md) for details.

## License

Apache 2.0. See [`LICENSE`](LICENSE) for details.

## Disclaimer

This project is not an official Google project. It is not supported by
Google and Google specifically disclaims all warranties as to its quality,
merchantability, or fitness for a particular purpose.