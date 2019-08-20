provider "aws" {
  region = "us-east-1"
}

module "kms_key" {
  source                  = "git::https://github.com/clouddrove/terraform-aws-kms.git?ref=tags/0.11.0"
  name                    = "kms"
  application             = "clouddrove"
  environment             = "test"
  description             = "KMS key for chamber"
  deletion_window_in_days = 30
  enable_key_rotation     = "true"
  alias                   = "alias/parameter_store_key"
}
