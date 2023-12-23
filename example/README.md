<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| google.impersonation | 5.10.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| gcp-aws-ha-vpn | ../ | n/a |
| network | ../modules/network | n/a |

## Resources

| Name | Type |
|------|------|
| [google_service_account_access_token.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/service_account_access_token) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_router\_asn | n/a | `string` | n/a | yes |
| aws\_vpc\_cidr | n/a | `string` | n/a | yes |
| gcp\_router\_asn | n/a | `string` | n/a | yes |
| impersonate\_service\_account | n/a | `string` | n/a | yes |
| network\_name | n/a | `string` | n/a | yes |
| num\_tunnels | Total number of VPN tunnels. This needs to be in multiples of 2. | `number` | n/a | yes |
| project\_id | n/a | `string` | n/a | yes |
| shared\_secret | n/a | `string` | n/a | yes |
| subnet\_regions | n/a | `list(string)` | n/a | yes |
| vpn\_gwy\_region | n/a | `string` | n/a | yes |
<!-- END_TF_DOCS -->    