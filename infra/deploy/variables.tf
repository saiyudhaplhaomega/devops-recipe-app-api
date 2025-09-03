variable "prefix" {
  description = "The prefix to use for resource names in AWS"
  default     = "raa"

}

variable "project" {
  description = "Project name for tagging resources"
  default     = "recipe-app-api"

}

variable "contact" {
  description = "Contact information for tagging resources"
  default     = "resourcesaiyudh@gmail.com"

}

variable "db_username" {
  description = "Username for the recipe app api database"
  default     = "recipeapp"
}

variable "db_password" {
  description = "Password for the Terraform database"
}

variable "ecr_proxy_image" {
  description = "Path to the ECR repo with the proxy image"
}

variable "ecr_app_image" {
  description = "Path to the ECR repo with the API image"
}

variable "django_secret_key" {
  description = "Secret key for Django"
}
