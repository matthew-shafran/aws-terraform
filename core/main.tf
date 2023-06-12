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

# Get Admin and Read Only Policies
data "aws_iam_policy" "administrator_access" {
  name = "AdministratorAccess"
}

data "aws_iam_policy" "readonly_access" {
  name = "ReadOnlyAccess"
}

# Attach Admin policy to admin group and Read Only to Dev group
resource "aws_iam_group_policy_attachment" "admin_group_policy" {
  group      = aws_iam_group.admins.name
  policy_arn = data.aws_iam_policy.administrator_access.arn
}

resource "aws_iam_group_policy_attachment" "developer_group_policy" {
  group      = aws_iam_group.developers.name
  policy_arn = data.aws_iam_policy.readonly_access.arn
}