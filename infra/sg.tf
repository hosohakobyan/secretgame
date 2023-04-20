#===================sg-alb==========
resource "aws_security_group" "secretgame_sg_alb" {
  name        = "secretgame-sg-alb"
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.secretgame.id

  dynamic "ingress" {
    for_each = var.allow_ports_alb
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "secretgame-sg-alb"
  }
}
#==============sg==========

resource "aws_security_group" "secretgame_sg" {
  name        = "secretgame-sg"
  description = "80 TLS inbound traffic"
  vpc_id      = aws_vpc.secretgame.id

    dynamic "ingress" {
    for_each = var.secretgame_sg_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "secretgame-sg"
  }
}