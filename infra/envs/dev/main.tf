terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = { source = "hashicorp/aws", version = "~> 5.0" }
  }
  backend "s3" {}
}

provider "aws" {
  region = var.region
}

data "aws_caller_identity" "current" {}

module "vpc" {
  source   = "../../modules/vpc"
  name     = "sample-dev"
  cidr     = "10.0.0.0/16"
  az_count = 2
}

module "ecr" {
  source    = "../../modules/ecr"
  repo_name = "sample-api"
}

module "eks" {
  source          = "../../modules/eks"
  cluster_name    = "sample-dev"
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
}
