module "create_adminservice_user" {
    source = "./../sub_modules/modules/iam_user/"
    iam_user_name = "${terraform.workspace}_dbuser_adminservice"
}

resource "aws_iam_policy" "adminservice_policy" {
  name        = "${terraform.workspace}_adminservice_policy"
  description = "adminservice Policy for ${terraform.workspace}"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "dynamodb:*",
        ]
        Effect   = "Allow"
        Resource = [
          "arn:aws:dynamodb:eu-central-1:150625325991:table/${terraform.workspace}_tenants"
        ]
      },
    ]
  })
}

resource "aws_iam_user_policy_attachment" "adminservice_access" {
  user = module.create_adminservice_user.created_user_name
  policy_arn = aws_iam_policy.adminservice_policy.arn
}
