# terraform-aws-kms basic example

This is a basic example of the `terraform-aws-kms` module.

## Usage

```hcl
module "kms" {
  source      = "clouddrove/kms/aws"
  name        = "kms"
  environment = "test"
}
```
