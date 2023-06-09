provider "aws" {
  region = "eu-central-1"
}

module "kms_key" {
  source = "./../"

  name        = "kms"
  environment = "test"
  label_order = ["name", "environment"]

  deletion_window_in_days            = 15
  alias                              = "alias/cloudtrail_Name"
  enabled = false
  multi_region                       = true
  create_replica_external_enabled    = true
  create_replica_enabled             = true
  create_external_enabled            = true
  valid_to                           = "2023-11-21T23:20:50Z"
  key_material_base64                = "Wblj06fduthWggmsT0cLVoIMOkeLbc2kVfMud77i/JY="



}