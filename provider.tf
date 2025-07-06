terraform {
  required_version = "~> 1.10"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "my-tfm-state-bucket-july-2025"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}

provider "aws" {
  # Configuration options
  region  = "ap-south-1"
  profile = "dem-profile"
}