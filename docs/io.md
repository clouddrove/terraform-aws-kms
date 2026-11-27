## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| alias | The display name of the alias. The name must start with the word `alias` followed by a forward slash. | `string` | `""` | no |
| aliases | Additional KMS aliases to create for the key. | `set(string)` | `[]` | no |
| attributes | Additional attributes (e.g. `1`). | `list(string)` | `[]` | no |
| bypass\_policy\_lockout\_safety\_check | A flag to indicate whether to bypass the key policy lockout safety check. Setting this value to true increases the risk that the KMS key becomes unmanageable | `bool` | `false` | no |
| create\_alias | Whether to create the primary KMS alias. Additional aliases in aliases are controlled separately. | `bool` | `true` | no |
| create\_external\_enabled | Determines whether an external CMK (externally provided material) will be created or a standard CMK (AWS provided material) | `bool` | `false` | no |
| create\_replica\_enabled | Determines whether a replica standard CMK will be created (AWS provided material) | `bool` | `false` | no |
| create\_replica\_external\_enabled | Determines whether a replica external CMK will be created (externally provided material) | `bool` | `false` | no |
| customer\_master\_key\_spec | Cryptographic configuration of the key. Supports symmetric encryption, RSA, NIST/secp256k1/Edwards ECC, HMAC, ML-DSA, and SM2 (China Regions only) key specs supported by AWS KMS. | `string` | `"SYMMETRIC_DEFAULT"` | no |
| deletion\_window\_in\_days | Duration in days after which the key is deleted after destruction of the resource. | `number` | `10` | no |
| description | The description of the key as viewed in AWS console. | `string` | `"Parameter Store KMS master key"` | no |
| enable\_key\_rotation | Specifies whether key rotation is enabled. | `bool` | `true` | no |
| enabled | Specifies whether the kms is enabled or disabled. | `bool` | `true` | no |
| environment | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| key\_material\_base64 | Base64-encoded key material to import. When null, an external key is created in PendingImport state. The value is stored in Terraform state; secure the state accordingly. | `string` | `null` | no |
| key\_usage | Intended cryptographic use of the key: ENCRYPT\_DECRYPT, SIGN\_VERIFY, or GENERATE\_VERIFY\_MAC. | `string` | `"ENCRYPT_DECRYPT"` | no |
| kms\_key\_enabled | Specifies whether the kms is enabled or disabled. | `bool` | `true` | no |
| label\_order | label order, e.g. `name`,`application`. | `list(any)` | <pre>[<br>  "name",<br>  "environment"<br>]</pre> | no |
| managedby | ManagedBy, eg 'CloudDrove'. | `string` | `"hello@clouddrove.com"` | no |
| multi\_region | Indicates whether the KMS key is a multi-Region (true) or regional (false) key. | `bool` | `true` | no |
| name | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| policy | A valid policy JSON document. Although this is a key policy, not an IAM policy, an `aws_iam_policy_document`, in the form that designates a principal, can be used | `string` | `null` | no |
| primary\_external\_key\_arn | The primary external key arn of a multi-region replica external key | `string` | `null` | no |
| primary\_key\_arn | The primary key arn of a multi-region replica key | `string` | `""` | no |
| repository | Terraform current module repo | `string` | `"https://github.com/clouddrove/terraform-aws-kms"` | no |
| region | Region where KMS resources are managed. Defaults to the Region configured on the AWS provider. Requires AWS provider v6 or later. | `string` | `null` | no |
| rotation\_period\_in\_days | Custom number of days between automatic rotations for symmetric KMS keys. Valid values are 90 through 2560. | `number` | `null` | no |
| custom\_key\_store\_id | ID of an existing AWS KMS custom key store where the key is stored. | `string` | `null` | no |
| xks\_key\_id | External key ID in an existing external key store (XKS). | `string` | `null` | no |
| grants | KMS grants to create for the managed key, keyed by a stable Terraform identifier. | `map(object)` | `{}` | no |
| tags | Additional tags to apply to all resources managed by the module (merged with module.labels.tags via extra\_tags). | `map(string)` | `{}` | no |
| valid\_to | Time at which the imported key material expires. When the key material expires, AWS KMS deletes the key material and the CMK becomes unusable. If not specified, key material does not expire | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| alias\_arn | Alias ARN. |
| alias\_name | Alias name. |
| additional\_alias\_arns | ARNs of additional aliases created for the key. |
| expiration\_model | Whether imported key material expires. Null for AWS-generated keys. |
| grant\_ids | Grant IDs keyed by the grant map key. |
| grant\_tokens | Grant tokens keyed by the grant map key. These can be used before a new grant reaches eventual consistency. |
| key\_arn | Key ARN. |
| key\_id | Key ID. |
| key\_state | State of an external or replica external KMS key. Null for AWS-generated keys. |
| tags | A mapping of tags to assign to the resource. |
| target\_key\_id | Identifier for the key for which the alias is for, can be either an ARN or key\_id. |
