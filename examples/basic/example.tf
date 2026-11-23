provider "aws" {
  region = "ca-central-1"
}

module "kms" {
  source      = "../../"
  name        = "kms"
  environment = "test"
}
