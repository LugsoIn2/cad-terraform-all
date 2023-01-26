module "create_scraperservice_user" {
    source = "./../sub_modules/modules/iam_user/"
    iam_user_name = "${terraform.workspace}_dbuser_scraperservice"
}

resource "aws_iam_policy" "scraperservice_policy" {
  name        = "${terraform.workspace}_scraperservice_policy"
  description = "scraperservice Policy for ${terraform.workspace}"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "dynamodb:*",
        ]
        Effect   = "Allow"
        Resource = [
          "arn:aws:dynamodb:eu-central-1:150625325991:table/${terraform.workspace}_tenants",
          "arn:aws:dynamodb:eu-central-1:150625325991:table/${terraform.workspace}_event_table"
        ]
      },
    ]
  })
}

resource "aws_iam_user_policy_attachment" "scraperservice_access" {
  user = module.create_scraperservice_user.created_user_name
  policy_arn = aws_iam_policy.scraperservice_policy.arn
}



