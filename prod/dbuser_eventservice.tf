module "create_eventservice_user" {
    source = "./../sub_modules/modules/iam_user/"
    iam_user_name = "${terraform.workspace}_dbuser_eventservice"
}

resource "aws_iam_policy" "eventservice_policy" {
  name        = "${terraform.workspace}_eventservice_policy"
  description = "eventservice Policy for ${terraform.workspace}"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "dynamodb:*",
        ]
        Effect   = "Allow"
        Resource = [
          "arn:aws:dynamodb:eu-central-1:150625325991:table/${terraform.workspace}_event_table",
          "arn:aws:dynamodb:eu-central-1:150625325991:table/${terraform.workspace}_event_table/index/eventDate-index",
        ]
      },
    ]
  })
}

resource "aws_iam_user_policy_attachment" "eventservice_access" {
  user = module.create_eventservice_user.created_user_name
  policy_arn = aws_iam_policy.eventservice_policy.arn
}


