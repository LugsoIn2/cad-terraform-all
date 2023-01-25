module "ecr-repo-adminservice" {
    source = "./../../sub_modules/modules/ecr"
    ecr_name = "cad-adminservice"
    tags = {
    "Environment" = "Prod"
    }
    image_mutability = "MUTABLE"
}

module "ecr-repo-scraper" {
    source = "./../../sub_modules/modules/ecr"
    ecr_name = "cad-event-scraper"
    tags = {
    "Environment" = "Prod"
    }
    image_mutability = "MUTABLE"
}

module "ecr-repo-eventservice" {
    source = "./../../sub_modules/modules/ecr"
    ecr_name = "cad-eventservice"
    tags = {
    "Environment" = "Prod"
    }
    image_mutability = "MUTABLE"
}