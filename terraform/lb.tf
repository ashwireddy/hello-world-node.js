resource "aws_lb" "hello_world_lb" {
  name               = "hello-world-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.node_sg.id]
  subnets            = ["subnet-01942ecd801bdd9d6", "subnet-054663795c7db4d40"]

  enable_deletion_protection = false


   depends_on = [
    aws_security_group.node_sg,
    aws_ecs_service.hello_world
  ]
}

resource "aws_lb_target_group" "hello_world_node-tg" {
  name     = "hello-world-node-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-0fdf12c7f24b737c1"

  health_check {
    path = "/"
  }
}

resource "aws_lb_listener" "hello_world" {
  load_balancer_arn = aws_lb.hello_world_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.hello_world_node-tg.arn
  }
}

resource "aws_lb_target_group_attachment" "hello_world" {
  target_group_arn = aws_lb_target_group.hello_world_node-tg.arn
  target_id        = aws_ecs_service.hello_world.id
  port             = 80
}
