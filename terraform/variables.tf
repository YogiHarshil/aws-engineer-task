variable "app_name" {
  description = "Name of the app"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "env_name" {
  description = "Deployment environment (dev/stage/prod)"
  type        = string
}

variable "image_uri" {
  description = "Docker image URI for ECS"
  type        = string
}

variable "acm_certificate_arn" {
  description = "ACM certificate ARN for HTTPS"
  type        = string
}
