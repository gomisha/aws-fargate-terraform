variable "region" {
  default     = "us-east-1"
  description = "AWS Region"
}

variable "remote_state_bucket" {
  
}

variable "remote_state_key" {
  
}

variable "ecs_cluster_name" {
    default = "Production-Fargate-Cluster"
}

variable "internet_cidr_blocks" {
  
}

