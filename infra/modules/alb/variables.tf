
variable "name" {
  description = "Application name"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs for ALB"
  type        = list(string)
}

variable "security_group_ids" {
  description = "ALB security group IDs"
  type        = list(string)
}

variable "container_port" {
  description = "Application container port"
  type        = number
  default     = 3000
}
