resource "aws_security_group" "allow_http_lb" {
  name        = "allow_http_lb"
  description = "Allow http"
  vpc_id      = aws_vpc.dbvpc.id

  ingress {
    description = "Http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_http"
  }
}

resource "aws_lb" "job_dblb" {
  name               = "job-notifier-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_http_lb.id]
  subnets            = [aws_subnet.public_subnet_a.id, aws_subnet.public_subnet_b.id]

}

resource "aws_lb_listener" "dbwebserver_listener" {
  load_balancer_arn = aws_lb.job_dblb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.dbwebserver_target.arn
  }
}

resource "aws_lb_target_group" "dbwebserver_target" {
  name     = "webserver-target"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.dbvpc.id
}

output "load_balancer_dns" {
  value       = aws_lb.job_dblb.dns_name
  description = "Dns name of lb"
}