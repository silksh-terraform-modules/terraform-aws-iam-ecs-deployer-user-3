### dopisac mozliwosc wrzucania konfigow do bucketa env_variables zdefiniowanego w ECS

resource "aws_iam_group" "this" {
  name = "${var.group_prefix}-${var.env_name}"
  path = "/"
}

resource "aws_iam_group_policy" "ecs-tasks-restart" {
  name  = "ecs-tasks-restart-${var.env_name}"
  group = aws_iam_group.this.id
  policy = data.aws_iam_policy_document.ecs-tasks-restart.json
}

# resource "aws_iam_group_policy" "route53-allow-change-zone" {
#   name  = "route53-allow-change-zone-${var.env_name}"
#   group = aws_iam_group.this.id
#   policy = data.aws_iam_policy_document.route53-allow-change-zone.json
# }

resource "aws_iam_group_policy" "ecr" {
  name = "deployer-allow-use-ecr-${var.env_name}"
  group = aws_iam_group.this.id
  policy = data.aws_iam_policy_document.ecr.json
}

resource "aws_iam_group_policy" "env_variables_bucket_rw_access" {
  name = "env_variables_bucket_rw_access-${var.env_name}"
  group = aws_iam_group.this.id
  policy = data.aws_iam_policy_document.env_variables_bucket_rw_access.json
}

resource "aws_iam_group_policy_attachment" "ecs_full_access_attach" {
  group      = aws_iam_group.this.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"

}

resource "aws_iam_group_policy_attachment" "logs_ro_access_attach" {
  group      = aws_iam_group.this.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsReadOnlyAccess"

}
