resource "aws_ecr_repository" "main" {
  name = var.repository_name

  tags = {
    Name = var.repository_name
  }
}

resource "aws_iam_role" "execution_role" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_execution_policy" {
  role       = aws_iam_role.execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

output "repository_uri" {
  value = aws_ecr_repository.main.repository_url
}

output "execution_role_arn" {
  value = aws_iam_role.execution_role.arn
}
