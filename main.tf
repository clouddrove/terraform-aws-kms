##----------------------------------------------------------------------------------
## Labels module callled that will be used for naming and tags.
##----------------------------------------------------------------------------------
module "labels" {
  source      = "clouddrove/labels/aws"
  version     = "1.3.0"
  name        = var.name
  repository  = var.repository
  environment = var.environment
  managedby   = var.managedby
  label_order = var.label_order
  attributes  = var.attributes
}

####----------------------------------------------------------------------------------
## This terraform resource creates a KMS Customer Master Key (CMK) and its alias.
####----------------------------------------------------------------------------------
resource "aws_kms_key" "default" {
  count = var.enabled && var.kms_key_enabled ? 1 : 0

  description                        = var.description
  key_usage                          = var.key_usage
  deletion_window_in_days            = var.deletion_window_in_days
  is_enabled                         = var.is_enabled
  enable_key_rotation                = var.enable_key_rotation
  customer_master_key_spec           = var.customer_master_key_spec
  policy                             = var.policy
  multi_region                       = var.multi_region
  bypass_policy_lockout_safety_check = var.bypass_policy_lockout_safety_check
  tags                               = module.labels.tags
}

####----------------------------------------------------------------------------------
## Create KMS keys in an external key store backed by your cryptographic keys outside of AWS.
####----------------------------------------------------------------------------------
resource "aws_kms_external_key" "external" {
  count = var.enabled && var.create_external_enabled ? 1 : 0

  bypass_policy_lockout_safety_check = var.bypass_policy_lockout_safety_check
  deletion_window_in_days            = var.deletion_window_in_days
  description                        = var.description
  enabled                            = var.is_enabled
  key_material_base64                = var.key_material_base64
  multi_region                       = var.multi_region
  policy                             = var.policy
  valid_to                           = var.valid_to

  tags = module.labels.tags
}

####----------------------------------------------------------------------------------
## Replica Key
####----------------------------------------------------------------------------------

resource "aws_kms_replica_key" "replica" {
  count = var.enabled && var.create_replica_enabled ? 1 : 0

  bypass_policy_lockout_safety_check = var.bypass_policy_lockout_safety_check
  deletion_window_in_days            = var.deletion_window_in_days
  description                        = var.description
  primary_key_arn                    = var.primary_key_arn
  enabled                            = var.is_enabled
  policy                             = var.policy

  tags = module.labels.tags
}

####----------------------------------------------------------------------------------
## Replica External Key
####----------------------------------------------------------------------------------

resource "aws_kms_replica_external_key" "replica_external" {
  count = var.enabled && var.create_replica_external_enabled ? 1 : 0

  bypass_policy_lockout_safety_check = var.bypass_policy_lockout_safety_check
  deletion_window_in_days            = var.deletion_window_in_days
  description                        = var.description
  enabled                            = var.is_enabled
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
  count = var.enabled ? 1 : 0

  name          = coalesce(var.alias, format("alias/%v", module.labels.id))
  target_key_id = try(aws_kms_key.default[0].key_id, aws_kms_external_key.external[0].id, aws_kms_replica_key.replica[0].key_id, aws_kms_replica_external_key.replica_external[0].key_id)
}