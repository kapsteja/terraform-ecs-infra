resource "aws_ecs_cluster" "main" {
  name = var.cluster_name
}

resource "aws_ecs_task_definition" "my_app" {
  family                   = "my-app"
  requires_compatibilities = ["FARGATE"]
  network_mode            = "awsvpc"
  execution_role_arn      = var.task_execution_role

  cpu    = "256"
  memory = "512"

  container_definitions = jsonencode([
    {
      name      = "my-app-container"
      image     = var.ecr_repository_uri
      memory    = 512
      cpu       = 256
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        },
      ]
    }
  ])
}

resource "aws_ecs_service" "my_app_service" {
  name            = "my-app-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.my_app.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = [var.security_group_id]
    assign_public_ip = true
  }
}

output "cluster_name" {
  value = aws_ecs_cluster.main.name
}
    