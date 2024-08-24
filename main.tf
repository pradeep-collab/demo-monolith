terraform {
  required_providers {
    assert = {
      source = "hashicorp/assert"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = "~> 1.9"
}

provider "aws" {}

data "aws_availability_zones" "ctx" {}

data "aws_caller_identity" "ctx" {}

data "aws_default_tags" "ctx" {}

data "aws_region" "ctx" {}

locals {
  azs = slice(data.aws_availability_zones.ctx.names, 0, 3)
}

module "subnets" {
  source = "hashicorp/subnets/cidr"

  base_cidr_block = var.vpc_cidr_block
  networks = [
    for i in range(length(local.azs) * 2) : {
      name     = i < 3 ? "public-${substr(local.azs[i], length(data.aws_region.ctx.name), length(local.azs[i]))}" : "private-${substr(local.azs[(i - 3)], length(data.aws_region.ctx.name), length(local.azs[(i - 3)]))}"
      new_bits = 3
    }
  ]
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidr_block

  azs                  = local.azs
  private_subnet_names = slice(keys(module.subnets.network_cidr_blocks), 0, 3)
  private_subnets      = slice(values(module.subnets.network_cidr_blocks), 0, 3)
  public_subnet_names  = slice(keys(module.subnets.network_cidr_blocks), 3, 6)
  public_subnets       = slice(values(module.subnets.network_cidr_blocks), 3, 6)

  enable_nat_gateway = true
}

locals {
  hosts = {
    for i, subnet in module.vpc.private_subnets : "web-${substr(local.azs[i], length(data.aws_region.ctx.name), length(local.azs[i]))}" => {
      subnet_id = subnet
    }
  }
}

module "ec2" {
  for_each = local.hosts
  source   = "terraform-aws-modules/ec2-instance/aws"

  name = each.key

  instance_type = "t2.micro"
  monitoring    = true
  subnet_id     = each.value.subnet_id
}
