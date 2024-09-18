##### Launch Template ###############

resource "aws_launch_template" "staging_lt" {
  name     = "${var.staging_env}-lt"
  image_id = "ami-085f9c64a9b75eed5"
  #image_id                             = "aws_ami"
  instance_type                        = "t2.micro"
  instance_initiated_shutdown_behavior = "terminate"
  vpc_security_group_ids               = [aws_security_group.Pri_sg.id]
  key_name                             = "cs2-use2-main"
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.staging_env}-web"
    }
  }

  user_data = filebase64("web.sh")
}

######## Auto Scaling Group ###########

resource "aws_autoscaling_group" "staging_asg" {
  name = "${var.staging_env}-asg"
  #availability_zones = ["us-east-2a", "us-east-2b"]
  vpc_zone_identifier = [aws_subnet.staging_Pri_1.id, aws_subnet.staging_Pri_2.id]
  desired_capacity    = 2
  max_size            = 3
  min_size            = 1
  target_group_arns   = [aws_lb_target_group.staging_tg.arn]
  launch_template {
    id      = aws_launch_template.staging_lt.id
    version = "$Latest"
  }
  tag {
    key                 = "name"
    value               = "staging-web"
    propagate_at_launch = true
  }
}

