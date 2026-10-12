# Example: static site on www.example.com with a GitHub Actions deploy role.
# terraform init && terraform apply -var 'hosted_zone_id=Z123...' -var 'domain_name=www.example.com'

terraform {
  required_version = ">= 1.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.70"
    }
  }
}

provider "aws" {
  region = var.region
}

# CloudFront certificates must live in us-east-1.
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

variable "region" {
  type    = string
  default = "sa-east-1"
}

variable "domain_name" {
  type    = string
  default = ""
}

variable "hosted_zone_id" {
  type    = string
  default = ""
}

variable "github_repository" {
  type    = string
  default = ""
}

module "site" {
  source = "../.."

  providers = {
    aws           = aws
    aws.us_east_1 = aws.us_east_1
  }

  name                        = "example"
  domain_name                 = var.domain_name
  hosted_zone_id              = var.hosted_zone_id
  github_repository           = var.github_repository
  create_github_oidc_provider = true

  tags = {
    project = "example"
  }
}

output "url" {
  value = module.site.url
}

output "bucket_name" {
  value = module.site.bucket_name
}

output "distribution_id" {
  value = module.site.distribution_id
}

output "deploy_role_arn" {
  value = module.site.deploy_role_arn
}
