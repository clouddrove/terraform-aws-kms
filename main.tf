##----------------------------------------------------------------------------------
## Labels module callled that will be used for naming and tags.
##----------------------------------------------------------------------------------
module "labels" {
  source      = "clouddrove/labels/aws"
  version     = "1.3.1"
  name        = var.name
  enabled     = var.enabled
  repository  = var.repository
  environment = var.environment
  managedby   = var.managedby
  label_order = var.label_order
  attributes  = var.attributes
  extra_tags  = var.tags
}

locals {
  selected_key_variants = compact([
    !var.create_external_enabled && !var.create_replica_enabled && !var.create_replica_external_enabled ? "standard" : null,
    var.create_external_enabled ? "external" : null,
    var.create_replica_enabled ? "replica" : null,
    var.create_replica_external_enabled ? "replica_external" : null,
  ])
  key_id = try(
    aws_kms_key.default[0].key_id,
    aws_kms_external_key.external[0].id,
    aws_kms_replica_key.replica[0].key_id,
    aws_kms_replica_external_key.replica_external[0].id,
    null,
  )
  external_key_material_present = nonsensitive(var.key_material_base64 != null)
  primary_alias_name            = coalesce(var.alias, format("alias/%v", module.labels.id))
}

####----------------------------------------------------------------------------------
## This terraform resource creates a KMS Customer Master Key (CMK) and its alias.
####----------------------------------------------------------------------------------
resource "aws_kms_key" "default" {
  count                              = var.enabled && !var.create_external_enabled && !var.create_replica_enabled && !var.create_replica_external_enabled ? 1 : 0
  region                             = var.region
  description                        = var.description
  key_usage                          = var.key_usage
  deletion_window_in_days            = var.deletion_window_in_days
  is_enabled                         = var.kms_key_enabled
  enable_key_rotation                = var.enable_key_rotation
  rotation_period_in_days            = var.rotation_period_in_days
  customer_master_key_spec           = var.customer_master_key_spec
  custom_key_store_id                = var.custom_key_store_id
  xks_key_id                         = var.xks_key_id
  policy                             = var.policy
  multi_region                       = var.multi_region
  bypass_policy_lockout_safety_check = var.bypass_policy_lockout_safety_check
  tags                               = module.labels.tags
}

####----------------------------------------------------------------------------------
## Create KMS keys in an external key store backed by your cryptographic keys outside of AWS.
####----------------------------------------------------------------------------------
resource "aws_kms_external_key" "external" {
  count                              = var.enabled && var.create_external_enabled ? 1 : 0
  region                             = var.region
  bypass_policy_lockout_safety_check = var.bypass_policy_lockout_safety_check
  deletion_window_in_days            = var.deletion_window_in_days
  description                        = var.description
  enabled                            = local.external_key_material_present ? var.kms_key_enabled : false
  key_spec                           = var.customer_master_key_spec
  key_usage                          = var.key_usage
  key_material_base64                = var.key_material_base64
  multi_region                       = var.multi_region
  policy                             = var.policy
  valid_to                           = var.valid_to
  tags                               = module.labels.tags
}

####----------------------------------------------------------------------------------
## Replica Key
####----------------------------------------------------------------------------------

resource "aws_kms_replica_key" "replica" {
  count                              = var.enabled && var.create_replica_enabled ? 1 : 0
  region                             = var.region
  bypass_policy_lockout_safety_check = var.bypass_policy_lockout_safety_check
  deletion_window_in_days            = var.deletion_window_in_days
  description                        = var.description
  primary_key_arn                    = var.primary_key_arn
  enabled                            = var.kms_key_enabled
  policy                             = var.policy
  tags                               = module.labels.tags
}

####----------------------------------------------------------------------------------
## Replica External Key
####----------------------------------------------------------------------------------

resource "aws_kms_replica_external_key" "replica_external" {
  count                              = var.enabled && var.create_replica_external_enabled ? 1 : 0
  region                             = var.region
  bypass_policy_lockout_safety_check = var.bypass_policy_lockout_safety_check
  deletion_window_in_days            = var.deletion_window_in_days
  description                        = var.description
  enabled                            = local.external_key_material_present ? var.kms_key_enabled : false
  key_material_base64                = var.key_material_base64
  policy                             = var.policy
  primary_key_arn                    = var.primary_external_key_arn
  valid_to                           = var.valid_to

  tags = module.labels.tags
}

##----------------------------------------------------------------------------------
## Provides an alias for a KMS customer master key.
##----------------------------------------------------------------------------------
resource "aws_kms_alias" "default" {
  count         = var.enabled && var.create_alias ? 1 : 0
  region        = var.region
  name          = local.primary_alias_name
  target_key_id = local.key_id
}

resource "aws_kms_alias" "additional" {
  for_each      = var.enabled ? var.aliases : toset([])
  region        = var.region
  name          = each.value
  target_key_id = local.key_id
}

resource "aws_kms_grant" "this" {
  for_each = var.enabled ? var.grants : {}

  region                = var.region
  name                  = try(each.value.name, null)
  key_id                = local.key_id
  grantee_principal     = each.value.grantee_principal
  operations            = each.value.operations
  retiring_principal    = try(each.value.retiring_principal, null)
  grant_creation_tokens = try(each.value.grant_creation_tokens, [])
  retire_on_delete      = try(each.value.retire_on_delete, false)

  dynamic "constraints" {
    for_each = try(each.value.encryption_context_equals, null) != null || try(each.value.encryption_context_subset, null) != null ? [each.value] : []

    content {
      encryption_context_equals = try(constraints.value.encryption_context_equals, null)
      encryption_context_subset = try(constraints.value.encryption_context_subset, null)
    }
  }
}
