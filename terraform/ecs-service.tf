resource "aws_ecs_service" "hello_world" {
  name            = "hello-world-service"
  cluster         = aws_ecs_cluster.ecs-cluster.id
  task_definition = aws_ecs_task_definition.hello_world.arn
  desired_count   = 1


  network_configuration {
    subnets         = ["subnet-01942ecd801bdd9d6", "subnet-054663795c7db4d40"]
    security_groups = [aws_security_group.node_sg.id]
  }

   depends_on = [
    aws_ecs_task_definition.hello_world
  ]
}
