provider "aws" {
  region = "us-west-2"
}

variable "cluster_name" {
  default = "patanjali"
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
