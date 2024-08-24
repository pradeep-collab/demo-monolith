variable "vpc_cidr_block" {
  default     = "10.42.0.0/16"
  description = "VPC IP address space."
  type        = string

  validation {
    condition     = provider::assert::cidrv4(var.vpc_cidr_block)
    error_message = "vpc_cidr_block must include a valid RFC4632 IPv4 or IPv6  address space in CIDR notation."
  }
}

variable "vpc_name" {
  default     = "my-vpc"
  description = "VPC name"
  type        = string
}
