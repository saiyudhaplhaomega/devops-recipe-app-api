variable "tf_state_bucket" {
  description = "The name of the S3 bucket to store the Terraform state"
  default     = "devops-recipe-app-tf-state-sai"
}

variable "tf_state_lock_table" {
  description = "Name of the DynamoDB table for Terraform state locking"
  default     = "devops-recipe-app-api-tf-lock"
}

variable "project" {
  description = "The name of the project"
  default     = "recipe-app-api"
}

variable "contact" {
  description = "Contact information for the tagging resources"
  default     = "resourcesaiyudh@gmail.com"

}
