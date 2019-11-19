provider "aws" {
  region = "${var.region}"
}

terraform {
    backend "s3" {}
}

data "terraform_remote_state" "infrastructure" {
    backend = "s3"

    config = {
        region = "${var.region}"
        bucket = "${var.remote_state_bucket}"
        key    = "${var.remote_state_key}"
    }
}

resource "aws_ecs_cluster" "production-fargate-cluster" {
  name = "${var.ecs_cluster_name}"
}

resource "aws_alb" "ecs_cluster_alb" {
  name            = "${var.ecs_cluster_name}-ALB"
  internal        = false
  security_groups = ["${aws_security_group.ecs_alb_security_group.id}"]
  subnets         = ["${data.terraform_remote_state.infrastructure.outputs.public_subnet_1_id}", "${data.terraform_remote_state.infrastructure.outputs.public_subnet_2_id}", "${data.terraform_remote_state.infrastructure.outputs.public_subnet_3_id}"]
  tags            = { Name = "${var.ecs_cluster_name}-ALB" }
}

resource "aws_alb_target_group" "ecs_default_target_group" {
  name     = "${var.ecs_cluster_name}-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${data.terraform_remote_state.infrastructure.outputs.vpc_id}"
  tags     = { Name = "${var.ecs_cluster_name}"}
}
