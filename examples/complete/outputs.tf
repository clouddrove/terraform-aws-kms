output "key_arn" {
  value       = module.kms_key.key_arn
  description = "Key ARN."
}

output "tags" {
  value       = module.kms_key.tags
  description = "A mapping of tags to assign to the KMS."
}

output "key_id" {
  value       = module.kms_key.key_id
  description = "The globally unique identifier for the key."
}

output "target_key_id" {
  value       = module.kms_key.target_key_id
  description = "Identifier for the key for which the alias is for, can be either an ARN or key_id."
}
