resource "aws_lb_target_group" "wordpress" {
  name        = "wordpress-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
 
  health_check {
    path = "/health"
  }
}
 
resource "aws_lb_listener_rule" "wordpress_rule" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 100
 
  action {
    type             = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      status_code  = "200"
      content      = "OK"
    }
  }
 
  condition {
    path_pattern {
      values = ["/wordpress/*"]
    }
  }
}
