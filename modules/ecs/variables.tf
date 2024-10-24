variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "task_execution_role" {
  description = "IAM role for ECS task execution"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for ECS service"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID for ECS service"
  type        = string
}

variable "ecr_repository_uri" {
  description = "ECR repository URI for the application"
  type        = string
}
