resource "aws_lb_target_group" "target_group" {
  name        = var.alb_tg_name
  depends_on  = [aws_vpc.vpc]
  port        = var.alb_tg_port
  protocol    = var.alb_tg_protocol
  vpc_id      = aws_vpc.vpc.id
  target_type = var.target_type
  health_check {
    interval            = var.health_interval
    port                = var.health_port
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = var.healthy_timeout
    protocol            = var.healthy_protocol
    matcher             = var.healthy_matcher
  }
}

resource "aws_lb" "load_balancer" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = var.alb_type
  security_groups    = [aws_security_group.sg_alb.id]
  subnets            = [aws_subnet.public_a.id, aws_subnet.public_b.id]
  tags = {
    name = var.tags_name

  }
}
# Create ALB Listener
resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = var.alb_lis_port
  protocol          = var.alb_lis_protocol
  default_action {
    type             = var.default_action_type
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}