output "deployer_name" {
  value = aws_iam_user.this.id
}

output "deployer_id" {
  value = aws_iam_access_key.this.id
}

output "deployer_secret" {
  value = aws_iam_access_key.this.secret
}

output "deployer_group_name" {
  value = aws_iam_group.this.name
}