provider "aws" {
  region = "eu-central-1"
}

module "kms_key" {
  source = "./../"

  name        = "kms"
  environment = "test"
  label_order = ["name", "environment"]

  deletion_window_in_days         = 15
  alias                           = "alias/cloudtrail_Name"
  enabled                         = true
  multi_region                    = false
  create_replica_external_enabled = false
  create_replica_enabled          = false
  create_external_enabled         = false
  valid_to                        = "2023-11-21T23:20:50Z"
  key_material_base64             = "Wblj06fduthWggmsT0cLVoIMOkeLbc2kVfMud77i/JY="
}