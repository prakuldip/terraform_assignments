//ecs cluster
resource "aws_ecs_cluster" "this_ecs_cluster" {
  name = var.ecs_cluster_name
  //aws_ecs_cluster_capacity_providers = ["FARGATE"]
  //vpc_id = var.vpc_id
  //subnet_ids = var.subnet_ids_for_ecs_cluster
}

//ecs task definition
resource "aws_ecs_task_definition" "this_ecs_task_definition" {
  family                   = var.task_definition_name
  requires_compatibilities = ["FARGATE"]
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "app-container",
    "image": "${var.app_image_url}",
    "cpu": 256,
    "memory": 512,
    "essential": true,
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80,
        "protocol" : "tcp"
      }
    ]
  }
]
TASK_DEFINITION

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}

//iam role
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs-task-execution-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole",
      "Sid": ""
    }
  ]
}
EOF
}

//iam role policy
resource "aws_iam_policy" "ecs_policy" {
  name = "ecs_policy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "ecs:*",
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": "ecr:*",
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "ecs_policy_attachment" {
  policy_arn = aws_iam_policy.ecs_policy.arn
  role       = aws_iam_role.ecs_task_execution_role.name
}

//service
resource "aws_ecs_service" "this_ecs_service" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.this_ecs_cluster.id
  task_definition = aws_ecs_task_definition.this_ecs_task_definition.arn
  desired_count   = 1
  //iam_role        = aws_iam_role.this_ecs_task_role.arn
  depends_on      = [aws_iam_role.ecs_task_execution_role]
  
  capacity_provider_strategy {
    capacity_provider = "FARGATE"
    weight = 100
  }
  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }
  network_configuration {
    subnets          = var.service_subnets
    security_groups  = var.service_security_group_ids
    assign_public_ip = false
  }
}


