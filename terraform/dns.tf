# Fetch the existing hosted zone
data "aws_route53_zone" "domain_zone" {
  name         = var.domain_name
  private_zone = false
}

# Create DNS records for main and www subdomains
resource "aws_route53_record" "frontend_record" {
  zone_id = data.aws_route53_zone.domain_zone.zone_id
  name    = var.frontend_domain
  type    = "A"
  ttl     = 300
  records = [aws_instance.ec2.public_ip]
}

resource "aws_route53_record" "www_frontend_record" {
  zone_id = data.aws_route53_zone.domain_zone.zone_id
  name    = "www.${var.frontend_domain}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.ec2.public_ip]
}

resource "aws_route53_record" "db_record" {
  zone_id = data.aws_route53_zone.domain_zone.zone_id
  name    = var.db_domain
  type    = "A"
  ttl     = 300
  records = [aws_instance.ec2.public_ip]
}

resource "aws_route53_record" "www_db_record" {
  zone_id = data.aws_route53_zone.domain_zone.zone_id
  name    = "www.${var.db_domain}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.ec2.public_ip]
}

resource "aws_route53_record" "traefik_record" {
  zone_id = data.aws_route53_zone.domain_zone.zone_id
  name    = var.traefik_domain
  type    = "A"
  ttl     = 300
  records = [aws_instance.ec2.public_ip]
}

resource "aws_route53_record" "www_traefik_record" {
  zone_id = data.aws_route53_zone.domain_zone.zone_id
  name    = "www.${var.traefik_domain}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.ec2.public_ip]
}
