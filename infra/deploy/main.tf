terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.23.0"
    }

  }
  backend "s3" {
    bucket               = "devops-recipe-app-tf-state-sai"
    key                  = "tf-state-deploy"
    workspace_key_prefix = "tf-state-deploy-env"
    region               = "eu-central-1"
    encrypt              = true
    dynamodb_table       = "devops-recipe-app-api-tf-lock"
  }
}
# Configure the AWS provider
provider "aws" {
  region = "eu-central-1"

  default_tags {
    tags = {
      Environment = terraform.workspace
      Project     = var.project
      contact     = var.contact
      ManagedBy   = "Terraform/deploy"
    }
  }
}
# Define local variable for resource name prefix
locals {
  prefix = "${var.prefix}-${terraform.workspace}"
}
# Get the current AWS region
data "aws_region" "current" {}
