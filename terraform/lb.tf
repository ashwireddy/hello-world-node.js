resource "aws_lb" "hello_world" {
  name               = "hello-world-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.node_sg.id]
  subnets            = [aws_subnet.public-sub.id]

  enable_deletion_protection = false
  

   depends_on = [
    aws_subnet.public-sub,
    aws_security_group.node_sg,
    aws_ecs_service.hello_world
  ]
}

resource "aws_lb_target_group" "hello_world" {
  name     = "hello-world-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.node_vpc.id

  health_check {
    path = "/"
  }
}

resource "aws_lb_listener" "hello_world" {
  load_balancer_arn = aws_lb.hello_world.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.hello_world.arn
  }
}

resource "aws_lb_target_group_attachment" "hello_world" {
  target_group_arn = aws_lb_target_group.hello_world.arn
  target_id        = aws_ecs_service.hello_world.id
  port             = 80
}