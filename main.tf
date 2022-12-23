data "aws_route53_zone" "zone" {
  for_each = toset(var.tld)
  name         = "${each.key}."
}

data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}