resource "aws_ecs_cluster" "ecs-cluster" {
  name = "node-ecs"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}