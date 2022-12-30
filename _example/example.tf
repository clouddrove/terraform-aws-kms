provider "aws" {
  region = "eu-west-1"
}
data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

module "kms_key" {
  source = "./../"

  name        = "kms"
  environment = "test"
  label_order = ["name", "environment"]

  enabled                 = true
  description             = "KMS key for cloudtrail"
  deletion_window_in_days = 15
  alias                   = "alias/cloudtrail_Name"
  multi_region            = false
  policy                  = data.aws_iam_policy_document.default.json
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
