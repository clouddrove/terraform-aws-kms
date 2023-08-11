output "key_arn" {
  value       = try(aws_kms_key.default[0].arn, aws_kms_external_key.external[0].arn, aws_kms_replica_key.replica[0].arn, aws_kms_replica_external_key.replica_external[0].arn)
  description = "Key ARN."
}

output "key_id" {
  value       = try(aws_kms_key.default[0].key_id, aws_kms_external_key.external[0].id, aws_kms_replica_key.replica[0].key_id, aws_kms_replica_external_key.replica_external[0].key_id)
  description = "Key ID."
}

output "alias_arn" {
  value       = join("", aws_kms_alias.default.*.arn)
  description = "Alias ARN."
}

output "alias_name" {
  value       = join("", aws_kms_alias.default.*.name)
  description = "Alias name."
}

output "tags" {
  value       = module.labels.tags
  description = "A mapping of tags to assign to the resource."
}

output "target_key_id" {
  value       = join("", aws_kms_alias.default.*.target_key_id)
  description = "Identifier for the key for which the alias is for, can be either an ARN or key_id."
}