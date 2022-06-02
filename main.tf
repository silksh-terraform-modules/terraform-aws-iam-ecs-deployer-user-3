data "aws_route53_zone" "zone" {
  name         = "${var.tld}."
}

data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}