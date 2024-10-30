provider "aws" {
    region = var.region

    default_tags {
      tags = {
        project = "devops-assessment-medici"
        environment = "dev"
        team = "medici"
        owner = "nate.ndlovu@icloud.com"
        terraform = true
      }
    } 
}
terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "nat-github-terraform-aws-tfstate"
    key = "terraform/devops-assessment-medici/dev/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "nat-github-terraform-aws-tfstate-lock"
  }  
}
