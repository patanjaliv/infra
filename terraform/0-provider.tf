provider "aws" {
  region = "us-east-1"
}

variable "cluster_name" {
  default = "poojit"
}

variable "cluster_version" {
  default = "1.27"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
