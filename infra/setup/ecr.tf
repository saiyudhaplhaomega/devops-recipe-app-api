###################################################
# Create ECR repository for storing Docker images #
###################################################

#create a new resource give the name app for ecr repository
# one for app and one for porxy
resource "aws_ecr_repository" "app" {
  name                 = "recipe-app-api-app"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    # Note: update to true for real deployments
    # because of old version could give a lot of security errors
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "proxy" {
  name                 = "recipe-app-api-proxy"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    # Note: update to true for real deployments
    # because of old version could give a lot of security errors
    scan_on_push = false
  }
}
