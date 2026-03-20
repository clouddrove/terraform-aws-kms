provider "aws" {
  region = "us-east-1"
}

module "kms" {
  source      = "../../"
  name        = "kms"
  environment = "test"
}
