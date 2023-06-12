# Create my user
resource "aws_iam_user" "mshafran" {
  name = "mshafran"
}

resource "aws_iam_user_group_membership" "mshafran_admin" {
  user = aws_iam_user.mshafran.name

  groups = [
    aws_iam_group.admins.name,
  ]
}


# Create standard org level groups for developers and admins
resource "aws_iam_group" "developers" {
  name = "developers"
}

resource "aws_iam_group" "admins" {
  name = "admins"
}

# Give standard org level groups permissions
data "aws_iam_policy" "administrator_access" {
  name = "AdministratorAccess"
}

data "aws_iam_policy" "readonly_access" {
  name = "ReadOnlyAccess"
}

resource "aws_iam_group_policy_attachment" "admin_group_policy" {
  group      = aws_iam_group.admins
  policy_arn = data.aws_iam_policy.administrator_access.arn
}

resource "aws_iam_group_policy_attachment" "developer_group_policy" {
  group      = aws_iam_group.developers
  policy_arn = data.aws_iam_policy.readonly_access.arn
}