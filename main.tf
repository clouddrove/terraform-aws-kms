## Managed By : CloudDrove
# Description : This Script is used to create Cloudfront CDN on AWS.
## Copyright @ CloudDrove. All Right Reserved.

#Module      : label
#Description : This terraform module is designed to generate consistent label names and tags
#              for resources. You can use terraform-labels to implement a strict naming
#              convention.
module "labels" {
  source = "git::https://github.com/clouddrove/terraform-labels.git?ref=tags/0.12.0"

  name        = var.name
  application = var.application
  environment = var.environment
  label_order = var.label_order
}

# Module      : KMS KEY
# Description : This terraform module creates a KMS Customer Master Key (CMK) and its alias.
resource "aws_kms_key" "default" {
  count = var.enabled ? 1 : 0
  description             = var.description
  key_usage               = var.key_usage
  deletion_window_in_days = var.deletion_window_in_days
  is_enabled              = var.is_enabled
  enable_key_rotation     = var.enable_key_rotation
  policy                  = var.policy
  tags                    = module.labels.tags
}

# Module      : KMS ALIAS
# Description : Provides an alias for a KMS customer master key..
resource "aws_kms_alias" "default" {
  count = var.enabled ? 1 : 0
  name          = coalesce(var.alias, format("alias/%v", module.labels.id))
  target_key_id = join("", aws_kms_key.default.*.id)
}
