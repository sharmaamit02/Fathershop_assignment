resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.my_elb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
 
  certificate_arn = "arn:aws:acm:us-west-2:123456789012:certificate/your-ssl-certificate-arn"  # Replace with your ACM certificate ARN
 
  default_action {
    type             = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      status_code  = "200"
      content      = "OK"
    }
  }
}
