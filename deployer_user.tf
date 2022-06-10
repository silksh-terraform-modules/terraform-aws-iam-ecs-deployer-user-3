resource "aws_iam_user" "this" {
  name = "${var.user_prefix}-${var.env_name}"
  tags = {
    description = "uzytkownik z mozliwoscia deploymentu aplikacji ${var.env_name}"
  }
}

resource "aws_iam_access_key" "this" {
  user = aws_iam_user.this.name
}

resource "aws_iam_user_group_membership" "this" {
  user = aws_iam_user.this.name

  groups = [
    aws_iam_group.this.name,
  ]
}