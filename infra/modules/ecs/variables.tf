
variable "name" {
  description = "Application name"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "aws_region" {
  description = "AWS deployment region"
  type        = string
}

variable "image_uri" {
  description = "ECR Docker image URI"
  type        = string
}

variable "container_name" {
  description = "ECS container name"
  type        = string
  default     = "enterprise-grade-devsecops-app"
}

variable "container_port" {
  description = "Application container port"
  type        = number
  default     = 3000
}

variable "cpu" {
  description = "Fargate CPU units"
  type        = number
  default     = 256
}

variable "memory" {
  description = "Fargate memory in MB"
  type        = number
  default     = 512
}

variable "desired_count" {
  description = "Desired ECS task count"
  type        = number
  default     = 1
}

variable "private_subnet_ids" {
  description = "Private subnet IDs"
  type        = list(string)
}

variable "security_group_ids" {
  description = "ECS security group IDs"
  type        = list(string)
}

variable "target_group_arn" {
  description = "Application Load Balancer target group ARN"
  type        = string
}
