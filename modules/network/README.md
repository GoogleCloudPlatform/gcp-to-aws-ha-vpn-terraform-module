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
| google | ~> 5.10 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| vpc | terraform-aws-modules/vpc/aws | n/a |

## Resources

| Name | Type |
|------|------|
| [google_compute_network.net](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [google_compute_subnetwork.subnet](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| network\_name | n/a | `string` | n/a | yes |
| subnet\_regions | n/a | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| aws\_private\_subnets | n/a |
| aws\_vpc\_id | n/a |
| gcp\_network | n/a |
<!-- END_TF_DOCS -->    