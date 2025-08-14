####----------------------------------------------------------------------------------
## Provider block added, Use the Amazon Web Services (AWS) provider to interact with the many resources supported by AWS.
####----------------------------------------------------------------------------------
provider "aws" {
  region = "us-east-1"
}

####----------------------------------------------------------------------------------
## AWS External KMS Key Replica.
## Should be deployed in different region as of primary key.
####----------------------------------------------------------------------------------
module "kms_key" {
  source                          = "./../../"
  name                            = "kms"
  environment                     = "test"
  deletion_window_in_days         = 7
  alias                           = "alias/replicate_key"
  kms_key_enabled                 = false
  create_replica_external_enabled = true
  enabled                         = true
  multi_region                    = false
  key_material_base64             = "Wblj06fduthWggmsT0cLVoIMOkeLbc2kVfMud77i/JY="
  primary_key_arn                 = "arn:aws:kms:xxxxxxxxxxxxxxxxxxxxx"
  policy                          = data.aws_iam_policy_document.default.json
}

data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

##----------------------------------------------------------------------------------
## Data block called to get Permissions that will be used in creating policy.
##----------------------------------------------------------------------------------
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
          join("", data.aws_partition.current[*].partition),
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
          join("", data.aws_partition.current[*].partition),
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
          join("", data.aws_partition.current[*].partition),
          data.aws_caller_identity.current.account_id
        )
      ]
    }
    actions   = ["kms:CreateAlias"]
    resources = ["*"]
  }
}
