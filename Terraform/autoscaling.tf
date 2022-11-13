resource "aws_launch_template" "dynodbwebserver123" {
  name = "dynodbwebserver123"

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 20
    }
  }


  iam_instance_profile {
    name = "LabInstanceProfile"
  }

  image_id = "ami-0d593311db5abb72b"

  
  instance_type = "t3.micro"
  
  key_name = "vockey"


  vpc_security_group_ids = [aws_security_group.allow_http.id]


  user_data = filebase64("script/userdata.sh")
}

resource "aws_autoscaling_group" "dbwebserver" {
  vpc_zone_identifier       = [aws_subnet.private_subnet_a.id, aws_subnet.private_subnet_b.id]
  desired_capacity   = 2
  max_size           = 3
  min_size           = 2

  launch_template {
    id      = aws_launch_template.dynodbwebserver123.id
    version = "$Latest"
  }
  depends_on = [
    aws_nat_gateway.nat
  ]
  target_group_arns = [aws_lb_target_group.dbwebserver_target.arn]
}

