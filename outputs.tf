output "bucket_name" {
  description = "S3 bucket that holds the site files."
  value       = aws_s3_bucket.site.bucket
}

output "distribution_id" {
  description = "CloudFront distribution ID (used for cache invalidations)."
  value       = aws_cloudfront_distribution.site.id
}

output "cloudfront_domain" {
  description = "CloudFront domain name."
  value       = aws_cloudfront_distribution.site.domain_name
}

output "url" {
  description = "Public URL of the site."
  value       = "https://${local.use_custom_domain ? var.domain_name : aws_cloudfront_distribution.site.domain_name}"
}

output "deploy_role_arn" {
  description = "IAM role for GitHub Actions (set as AWS_ROLE_ARN secret). Null when github_repository is empty."
  value       = local.create_deploy_role ? aws_iam_role.deploy[0].arn : null
}
