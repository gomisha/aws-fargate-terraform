# resource "aws_acm_certificate" "ecs_domain_certificate" {
#   domain_name = "*.${var.ecs_domain_name}"
#   tags        = { Name = "${var.ecs_cluster_name}-Certificate" }
# }
