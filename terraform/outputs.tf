output "alb_dns" {
  description = "ALB DNS name"
  value       = module.alb.dns_name
}

output "ecs_cluster_name" {
  description = "ECS Cluster Name"
  value       = aws_ecs_cluster.main.name
}

output "ecs_service_name" {
  description = "ECS Service Name"
  value       = aws_ecs_service.app.name
}

output "app_target_group_arn" {
  description = "Target group ARN"
  value       = module.alb.target_groups["app_tg"].arn
}
