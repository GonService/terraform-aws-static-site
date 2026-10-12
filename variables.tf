variable "name" {
  description = "Short name used for the bucket and resource names (lowercase, digits and hyphens)."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]{1,40}[a-z0-9]$", var.name))
    error_message = "Use 3 to 42 lowercase letters, digits or hyphens."
  }
}

variable "domain_name" {
  description = "Custom domain, e.g. www.example.com. Empty = serve only on the CloudFront domain."
  type        = string
  default     = ""
}

variable "hosted_zone_id" {
  description = "Route 53 hosted zone ID for domain_name. Required when domain_name is set."
  type        = string
  default     = ""

  validation {
    condition     = var.hosted_zone_id == "" || can(regex("^Z[A-Z0-9]+$", var.hosted_zone_id))
    error_message = "Use a Route 53 hosted zone ID such as Z123ABC456DEF."
  }
}

variable "price_class" {
  description = "CloudFront price class. PriceClass_100 (US, Canada, Europe) is the cheapest."
  type        = string
  default     = "PriceClass_100"

  validation {
    condition     = contains(["PriceClass_100", "PriceClass_200", "PriceClass_All"], var.price_class)
    error_message = "Use PriceClass_100, PriceClass_200 or PriceClass_All."
  }
}

variable "spa_mode" {
  description = "Single-page app: answer 403/404 with /index.html and 200 (for client-side routing)."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags added to every resource."
  type        = map(string)
  default     = {}
}

variable "github_repository" {
  description = "GitHub repository (owner/name) allowed to deploy the site through OIDC. Empty = no deploy role."
  type        = string
  default     = ""
}

variable "github_branch" {
  description = "Branch allowed to deploy."
  type        = string
  default     = "main"
}

variable "create_github_oidc_provider" {
  description = "Create the GitHub OIDC identity provider in this AWS account (only one per account; set false if it already exists)."
  type        = bool
  default     = false
}
