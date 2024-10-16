# resource "aws_route53_record" "www_test" {
#   zone_id = data.aws_route53_zone.jcz-realestate.zone_id
#   name    = "www.${data.aws_route53_zone.jcz-realestate.name}"
#   type    = "A"
#   ttl     = "300"
#   records = ["10.0.0.1"]
# }
resource "aws_route53_record" "staging" {
  zone_id = data.aws_route53_zone.jcz-realestate.zone_id
  name    = "jcz-realestate.com"
  type    = "A"

  alias {
    name                   = aws_lb.staging_alb.dns_name
    zone_id                = aws_lb.staging_alb.zone_id
    evaluate_target_health = true
  }
}
