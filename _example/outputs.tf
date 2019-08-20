output "key_arn" {
  value       = module.kms_key.key_arn
  description = "Key ARN."
}

output "tags" {
  value       = module.kms_key.tags
  description = "A mapping of tags to assign to the KMS."
}