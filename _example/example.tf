####----------------------------------------------------------------------------------
## Provider block added, Use the Amazon Web Services (AWS) provider to interact with the many resources supported by AWS.
####----------------------------------------------------------------------------------


provider "aws" {
  region = "us-east-1"
}

####----------------------------------------------------------------------------------
## AWS Key Management Service (AWS KMS) is a managed service that makes it easy for you to create and control the cryptographic keys that are used to protect your data.
####----------------------------------------------------------------------------------
module "kms_key" {

  source = "./../"

  name        = "kms"
  environment = "test"
  label_order = ["name", "environment"]

  deletion_window_in_days = 7
  alias                   = "alias/cloudtrail_Name"
  enabled                 = true
  kms_key_enabled         = true
  multi_region            = true
  create_external_enabled = true
  valid_to                = "2023-11-21T23:20:50Z"
  key_material_base64     = "Wblj06fduthWggmsT0cLVoIMOkeLbc2kVfMud77i/JY="
}