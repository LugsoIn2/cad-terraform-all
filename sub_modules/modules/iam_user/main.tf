resource "aws_iam_user" "iam_user" {
  name = var.iam_user_name
}
resource "aws_iam_access_key" "iam_user_access" {
  user = aws_iam_user.iam_user.name
}

output "iam_access_key" {
  value = aws_iam_access_key.iam_user_access.id
}
output "iam_secret_key" {
  value = aws_iam_access_key.iam_user_access.secret
}
output "created_user_name" {
  value = aws_iam_user.iam_user.name
}