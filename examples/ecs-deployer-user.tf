module "deployer_user" {
  source  = "github.com/silksh-terraform-modules/terraform-aws-iam-ecs-deployer-user?ref=v0.0.1"

  env_name = var.env_name
  tld = var.tld
  aws_region = var.aws_region
  env_variables_s3_bucket_id = aws_s3_bucket.env_variables.id

}

output "deployer_user_id" {
  value = module.deployer_user.deployer_id
  sensitive = true
}

output "deployer_user_secret" {
  value = module.deployer_user.deployer_secret
  sensitive = true
}
