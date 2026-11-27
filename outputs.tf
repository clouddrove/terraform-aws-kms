output "key_arn" {
  value       = try(aws_kms_key.default[0].arn, aws_kms_external_key.external[0].arn, aws_kms_replica_key.replica[0].arn, aws_kms_replica_external_key.replica_external[0].arn, null)
  description = "Key ARN."
}

output "key_id" {
  value       = try(aws_kms_key.default[0].key_id, aws_kms_external_key.external[0].id, aws_kms_replica_key.replica[0].key_id, aws_kms_replica_external_key.replica_external[0].key_id, null)
  description = "Key ID."
}

output "alias_arn" {
  value       = try(aws_kms_alias.default[*].arn, null)
  description = "Alias ARN."
}

output "alias_name" {
  value       = try(aws_kms_alias.default[*].name, null)
  description = "Alias name."
}

output "tags" {
  value       = try(module.labels.tags, null)
  description = "A mapping of tags to assign to the resource."
}

output "target_key_id" {
  value       = try(aws_kms_alias.default[0].target_key_id, null)
  description = "Identifier for the key for which the alias is for, can be either an ARN or key_id."
}

output "additional_alias_arns" {
  value       = { for key, alias in aws_kms_alias.additional : key => alias.arn }
  description = "ARNs of additional aliases created for the key."
}

output "grant_ids" {
  value       = { for name, grant in aws_kms_grant.this : name => grant.grant_id }
  description = "Grant IDs keyed by the grant map key."
}

output "grant_tokens" {
  value       = { for name, grant in aws_kms_grant.this : name => grant.grant_token }
  description = "Grant tokens keyed by the grant map key. These can be used before a new grant reaches eventual consistency."
  sensitive   = true
}

output "key_state" {
  value       = try(aws_kms_external_key.external[0].key_state, aws_kms_replica_external_key.replica_external[0].key_state, null)
  description = "State of an external or replica external KMS key. Null for AWS-generated keys."
}

output "expiration_model" {
  value       = try(aws_kms_external_key.external[0].expiration_model, aws_kms_replica_external_key.replica_external[0].expiration_model, null)
  description = "Whether imported key material expires. Null for AWS-generated keys."
}
