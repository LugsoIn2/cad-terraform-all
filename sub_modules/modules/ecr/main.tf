resource "aws_ecr_repository" "ecr_image_repo" {
    name = var.ecr_name
    image_tag_mutability = var.image_mutability
    tags = var.tags
}