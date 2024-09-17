
# Create ALB
##############################################################################################################################################################
resource "aws_lb" "prod_app_lb" {
  name               = "${var.environment}-${replace(var.company_name, ".", "-")}-app-lb"
  internal           = var.lb_internal
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.subnet_ids

  enable_deletion_protection = false

}


# TG1-Primary for ALB
resource "aws_lb_target_group" "primary_tg" {
  name     = "${var.environment}-${replace(var.company_name, ".", "-")}-primary-tg"
  port     = var.app_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200-399"
  }

}


# TG2-Secondary for ALB
resource "aws_lb_target_group" "secondary_tg" {
  name     = "${var.environment}-${replace(var.company_name, ".", "-")}-secondary-tg"
  port     = var.app_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200-399"
  }
}

# HTTP-80 > listner1 redirect from http to https as default listner
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.prod_app_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

############################################################3
# Redirect action

# resource "aws_lb_listener_rule" "redirect_http_to_https" {
#   listener_arn = aws_lb_listener.front_end.arn

#   action {
#     type = "redirect"

#     redirect {
#       port        = "443"
#       protocol    = "HTTPS"
#       status_code = "HTTP_301"
#     }
#   }

#   condition {
#     http_header {
#       http_header_name = "X-Forwarded-For"
#       values           = ["192.168.1.*"]
#     }
#   }
# }



##############################################################

# HTTPS-443 > listner2 redirect traffic to tg1 and tg2 50/50
# Note is there is no acm certificate this will fail
# resource "aws_lb_listener" "http" {
#   load_balancer_arn = aws_lb.app_lb.arn
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     type = "forward"

#     forward {
#       target_group {
#         arn    = aws_lb_target_group.tg1.arn
#         weight = 50
#       }

#       target_group {
#         arn    = aws_lb_target_group.tg2.arn
#         weight = 50
#       }
#     }
#   }
# }

# HTTPS-443 > listner2 redirect traffic to tg1 and tg2 50/50
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.prod_app_lb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type = "forward"

    forward {
      target_group {
        arn    = aws_lb_target_group.primary_tg.arn
        weight = 1
      }

      target_group {
        arn    = aws_lb_target_group.secondary_tg.arn
        weight = 0
      }
    }
  }
}


# Listener Rule 1: If HTTP header 'paytring-dev=true', forward to a specific target group
resource "aws_lb_listener_rule" "https_header_rule" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 100 # Priority for rule evaluation

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.primary_tg.arn # Target group to forward traffic to
  }

  condition {
    http_header {
      http_header_name = "paytring-dev"
      values           = ["true"]
    }
  }
}

# Register instances to target group1 and target group2 with spefied instances (tg1 with 1 ec2 and tg2 with 4 ec2)

# resource "aws_lb_target_group_attachment" "tg1_attachment" {
#   count = length(aws_instance.app)

#   target_group_arn = aws_lb_target_group.tg1.arn
#   target_id        = aws_instance.app[count.index].id
#   port             = 80
#   lifecycle {
#     ignore_changes = [target_id]
#   }
# }

# resource "aws_lb_target_group_attachment" "tg2_attachment" {
#   target_group_arn = aws_lb_target_group.tg2.arn
#   target_id        = aws_instance.tg2.id
#   port             = 80
#   lifecycle {
#     ignore_changes = [target_id]
#   }
# }

locals {
  user_data = <<-EOF
    #!/bin/bash
    echo "Running user data script"
    # Your custom script goes here
    # Example: Install nginx HTTP server
    apt update -y
    apt install -y nginx
    systemctl start nginx
    systemctl enable nginx
    echo "<h1>Hello, This is Test Web Page Hosted on the server $(hostname -f). </h1>" > /var/www/html/index.html
    echo "<h1> Thanks To Visit </h1>" >> /var/www/html/index.html
  EOF
}

# Create launch template for application instances ami 
##############################################################################################################################################################
resource "aws_launch_template" "app_launch_template" {
  name          = "${var.environment}-${replace(var.company_name, ".", "-")}-app-launch-template"
  image_id      = var.ami_id
  instance_type = var.instance_type
  # Include user_data in the launch template
  user_data              = base64encode(local.user_data)
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  key_name               = "terraform-key"

}



# Create Auto Scaling Group for tg1
##############################################################################################################################################################
resource "aws_autoscaling_group" "app_asg" {
  name                = "${var.environment}-${replace(var.company_name, ".", "-")}-app-asg"
  desired_capacity    = var.asg_desired_capacity
  max_size            = var.asg_max_size
  min_size            = var.asg_min_size
  vpc_zone_identifier = var.subnet_ids
  target_group_arns   = [aws_lb_target_group.primary_tg.arn]
  launch_template {
    id      = aws_launch_template.app_launch_template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "asg-instance"
    propagate_at_launch = true
  }
}



