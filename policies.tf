# policy grupy
data "aws_iam_policy_document" "ecs-tasks-restart" {
  statement {
    actions = [
      "ecs:RunTask",
      "ecs:StopTask",
      "ecs:ListTasks",
      "ecs:UpdateService"
    ]
    resources = ["*"]

    condition {
      test = "ArnEquals"
      variable = "ecs:cluster"

      values = [
        "arn:aws:ecs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:cluster/${var.env_name}"
      ]

    }
  }

  statement {
    actions = [
      "iam:GetRole",
      "iam:PassRole"
    ]
    resources = [
      "arn:aws:iam:::role/ecsTaskExecutionRole"
    ]
  }
}

data "aws_iam_policy_document" "route53-allow-change-zone" {
  statement {
    actions = [
      "route53:ChangeResourceRecordSets",
      "route53:ListResourceRecordSets"
    ]
    resources = [
      "arn:aws:route53:::hostedzone/${data.aws_route53_zone.zone.id}"
    ]
  }
}


data "aws_iam_policy_document" "ecr" {
  statement {
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer",
      "ecr:CompleteLayerUpload",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart"
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "env_variables_bucket_rw_access" {
  statement {

    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation",
      "s3:ListBucketMultipartUploads"
    ]

    resources = ["arn:aws:s3:::${var.env_variables_s3_bucket_id}"]
  }
  statement {

    actions = [
      "s3:AbortMultipartUpload",
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:GetObjectVersion",
      "s3:GetObjectVersionAcl",
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:PutObjectAclVersion"
    ]

    resources = ["arn:aws:s3:::${var.env_variables_s3_bucket_id}/*"]
  }

  statement {

    actions = [
      "s3:ListAllMyBuckets"
    ]

    resources = ["*"]
  }

}
