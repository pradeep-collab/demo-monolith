# demo-monolith

1. Create a repository in GitHub called `demo-monolith`.
2. Initialize the local directory, add the contents, and commit the changes.
   - `git init`
   - `git add .`
   - `git commit -m "Initial commit"`
3. Add the remote repository
   - `git remote add origin <url>`
4. Push the changes to the remote repository
   - `git push origin main`
5. Create a project in your TFC organization called `session-07`.
6. Create a workspace in the project called `demo-monolith`.
   - Add the new repository as the VCS driven workflow
7. In your AWS Account, create an IAM Role that uses the `app.terraform.io` IDP:
   - organization: <Your TFC Organization>
   - project: `session-07`
   - workspace: `demo-monolith`
   - run_phase: `*`
8. Copy the Role ARN
9. In your TFC workspace, create the following environment variables:
   - AWS_REGION: `us-east-1`
   - TFC_AWS_PROVIDER_AUTH: true
   - TFC_AWS_RUN_ROLE_ARN: <RoleArn>
10. Run your workspace
11. Inspect the results
12. Create a destroy plan at the end and apply it

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.64.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ec2"></a> [ec2](#module\_ec2) | terraform-aws-modules/ec2-instance/aws | n/a |
| <a name="module_subnets"></a> [subnets](#module\_subnets) | hashicorp/subnets/cidr | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_availability_zones.ctx](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.ctx](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_default_tags.ctx](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/default_tags) | data source |
| [aws_region.ctx](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | VPC IP address space. | `string` | `"10.42.0.0/16"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | VPC name | `string` | `"my-vpc"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->