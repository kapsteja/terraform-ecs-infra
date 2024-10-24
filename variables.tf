variable "region" {
  description = "AWS region"
  default     = "us-west-2"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  default     = "10.0.1.0/24"
}

variable "repository_name" {
  description = "Name of the ECR repository"
  default     = "my-app-repo"
}

variable "cluster_name" {
  description = "Name of the ECS cluster"
  default     = "my-ecs-cluster"
}
