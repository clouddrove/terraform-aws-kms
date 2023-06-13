provider "aws" {
  alias  = "primary"
  region = "us-east-1"
}
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
}


data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

####----------------------------------------------------------------------------------
## This terraform resource creates a KMS Customer Master Key (CMK) and its alias.
####----------------------------------------------------------------------------------
resource "aws_kms_key" "default" {
  count = var.enabled && var.kms_key_enabled ? 1 : 0

  description              = var.description
  key_usage                = var.key_usage
  deletion_window_in_days  = var.deletion_window_in_days
  is_enabled               = var.is_enabled
  enable_key_rotation      = var.enable_key_rotation
  customer_master_key_spec = var.customer_master_key_spec
  policy                   = data.aws_iam_policy_document.default.json
  multi_region             = var.multi_region
  tags                     = module.labels.tags
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
  policy                             = data.aws_iam_policy_document.default.json
  valid_to                           = var.valid_to

  tags = module.labels.tags
}

resource "aws_kms_replica_key" "replica-key" {
  count = var.enabled && var.create_replica_enabled ? 1 : 0

  bypass_policy_lockout_safety_check = var.bypass_policy_lockout_safety_check
  deletion_window_in_days            = var.deletion_window_in_days
  description                        = var.description
  primary_key_arn                    = var.primary_key_arn == "" ? join("", aws_kms_key.default.*.arn) : var.primary_key_arn
  enabled                            = var.is_enabled
  policy                             = data.aws_iam_policy_document.default.json

  tags = module.labels.tags
}

####----------------------------------------------------------------------------------
## Replica External Key.
####----------------------------------------------------------------------------------
resource "aws_kms_replica_external_key" "replica-external-key" {
  count = var.enabled && var.create_replica_external_enabled ? 1 : 0

  bypass_policy_lockout_safety_check = var.bypass_policy_lockout_safety_check
  deletion_window_in_days            = var.deletion_window_in_days
  description                        = var.description
  enabled                            = var.is_enabled
  key_material_base64                = var.key_material_base64
  policy                             = data.aws_iam_policy_document.default.json
  primary_key_arn                    = join("", aws_kms_key.default.*.arn)
  valid_to                           = var.valid_to

  tags = module.labels.tags
}


# Module      : KMS ALIAS
# Description : Provides an alias for a KMS customer master key..
resource "aws_kms_alias" "default" {
  count = var.enabled ? 1 : 0

  name          = coalesce(var.alias, format("alias/%v", module.labels.id))
  target_key_id = join("", aws_kms_key.default.*.id)
}


data "aws_iam_policy_document" "default" {
  version = "2012-10-17"
  statement {
    sid    = "Enable IAM User Permissions"
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = [
        format(
          "arn:%s:iam::%s:root",
          join("", data.aws_partition.current.*.partition),
          data.aws_caller_identity.current.account_id
        )
      ]
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }
  statement {
    sid    = "Allow CloudTrail to encrypt logs"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    actions   = ["kms:GenerateDataKey*"]
    resources = ["*"]
    condition {
      test     = "StringLike"
      variable = "kms:EncryptionContext:aws:cloudtrail:arn"
      values   = ["arn:aws:cloudtrail:*:XXXXXXXXXXXX:trail/*"]
    }
  }

  statement {
    sid    = "Allow CloudTrail to describe key"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    actions   = ["kms:DescribeKey"]
    resources = ["*"]
  }

  statement {
    sid    = "Allow principals in the account to decrypt log files"
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = [
        format(
          "arn:%s:iam::%s:root",
          join("", data.aws_partition.current.*.partition),
          data.aws_caller_identity.current.account_id
        )
      ]
    }
    actions = [
      "kms:Decrypt",
      "kms:ReEncryptFrom"
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"
      values = [
      "XXXXXXXXXXXX"]
    }
    condition {
      test     = "StringLike"
      variable = "kms:EncryptionContext:aws:cloudtrail:arn"
      values   = ["arn:aws:cloudtrail:*:XXXXXXXXXXXX:trail/*"]
    }
  }

  statement {
    sid    = "Allow alias creation during setup"
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = [
        format(
          "arn:%s:iam::%s:root",
          join("", data.aws_partition.current.*.partition),
          data.aws_caller_identity.current.account_id
        )
      ]
    }
    actions   = ["kms:CreateAlias"]
    resources = ["*"]
  }
}