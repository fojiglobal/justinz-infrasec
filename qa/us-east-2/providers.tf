terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }


  ##### Backend for my s3 bucket ########
  backend "s3" {
    bucket         = "justin-cs2-terraform"
    key            = "qa/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "cs2-infrasec-terraform"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-2"
}


