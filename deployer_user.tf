resource "aws_iam_user" "this" {
  name = "ecs-deployer-${var.env_name}"
  tags = {
    description = "uzytkownik z mozliwoscia deploymentu aplikacji ${var.env_name}"
  }
}

resource "aws_iam_access_key" "this" {
  user = aws_iam_user.deployer.name
}

resource "aws_iam_user_group_membership" "this" {
  user = aws_iam_user.deployer.name

  groups = [
    aws_iam_group.deployer.name,
  ]
}