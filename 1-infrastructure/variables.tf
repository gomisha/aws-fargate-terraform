variable "region" {
  default     = "us-east-1"
  description = "AWS Region"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
  description = "VPC CIDR block"
}
