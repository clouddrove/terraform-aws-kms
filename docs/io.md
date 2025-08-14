## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| alias | The display name of the alias. The name must start with the word `alias` followed by a forward slash. | `string` | `""` | no |
| attributes | Additional attributes (e.g. `1`). | `list(string)` | `[]` | no |
| bypass\_policy\_lockout\_safety\_check | A flag to indicate whether to bypass the key policy lockout safety check. Setting this value to true increases the risk that the KMS key becomes unmanageable | `bool` | `false` | no |
| create\_external\_enabled | Determines whether an external CMK (externally provided material) will be created or a standard CMK (AWS provided material) | `bool` | `false` | no |
| create\_replica\_enabled | Determines whether a replica standard CMK will be created (AWS provided material) | `bool` | `false` | no |
| create\_replica\_external\_enabled | Determines whether a replica external CMK will be created (externally provided material) | `bool` | `false` | no |
| customer\_master\_key\_spec | Specifies whether the key contains a symmetric key or an asymmetric key pair and the encryption algorithms or signing algorithms that the key supports. Valid values: SYMMETRIC\_DEFAULT, RSA\_2048, RSA\_3072, RSA\_4096, ECC\_NIST\_P256, ECC\_NIST\_P384, ECC\_NIST\_P521, or ECC\_SECG\_P256K1. Defaults to SYMMETRIC\_DEFAULT. | `string` | `"SYMMETRIC_DEFAULT"` | no |
| deletion\_window\_in\_days | Duration in days after which the key is deleted after destruction of the resource. | `number` | `10` | no |
| description | The description of the key as viewed in AWS console. | `string` | `"Parameter Store KMS master key"` | no |
| enable\_key\_rotation | Specifies whether key rotation is enabled. | `string` | `true` | no |
| enabled | Specifies whether the kms is enabled or disabled. | `bool` | `true` | no |
| environment | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| key\_material\_base64 | Base64 encoded 256-bit symmetric encryption key material to import. The CMK is permanently associated with this key material. External key only | `string` | `null` | no |
| key\_usage | Specifies the intended use of the key. Defaults to ENCRYPT\_DECRYPT, and only symmetric encryption and decryption are supported. | `string` | `"ENCRYPT_DECRYPT"` | no |
| kms\_key\_enabled | Specifies whether the kms is enabled or disabled. | `bool` | `true` | no |
| label\_order | label order, e.g. `name`,`application`. | `list(any)` | <pre>[<br>  "name",<br>  "environment"<br>]</pre> | no |
| managedby | ManagedBy, eg 'CloudDrove'. | `string` | `"hello@clouddrove.com"` | no |
| multi\_region | Indicates whether the KMS key is a multi-Region (true) or regional (false) key. | `bool` | `true` | no |
| name | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| policy | A valid policy JSON document. Although this is a key policy, not an IAM policy, an `aws_iam_policy_document`, in the form that designates a principal, can be used | `string` | `null` | no |
| primary\_external\_key\_arn | The primary external key arn of a multi-region replica external key | `string` | `null` | no |
| primary\_key\_arn | The primary key arn of a multi-region replica key | `string` | `""` | no |
| repository | Terraform current module repo | `string` | `"https://github.com/clouddrove/terraform-aws-kms"` | no |
| valid\_to | Time at which the imported key material expires. When the key material expires, AWS KMS deletes the key material and the CMK becomes unusable. If not specified, key material does not expire | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| alias\_arn | Alias ARN. |
| alias\_name | Alias name. |
| key\_arn | Key ARN. |
| key\_id | Key ID. |
| tags | A mapping of tags to assign to the resource. |
| target\_key\_id | Identifier for the key for which the alias is for, can be either an ARN or key\_id. |

