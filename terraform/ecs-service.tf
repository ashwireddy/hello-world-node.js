resource "aws_ecs_service" "hello_world" {
  name            = "hello-world-service"
  cluster         = aws_ecs_cluster.ecs-cluster.id
  task_definition = aws_ecs_task_definition.hello_world.arn
  desired_count   = 1

  network_configuration {
    subnets         = [aws_subnet.public-sub.id]
    security_groups = [aws_security_group.node_sg.id]
  }

   depends_on = [
    aws_ecs_task_definition.hello_world
  ]
}