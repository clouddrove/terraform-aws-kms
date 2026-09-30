#Module      : LABEL
#Description : Terraform label module variables.
variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "repository" {
  type        = string
  default     = "https://github.com/clouddrove/terraform-aws-kms"
  description = "Terraform current module repo"
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "label_order" {
  type        = list(any)
  default     = ["name", "environment"]
  description = "label order, e.g. `name`,`application`."
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = "Additional attributes (e.g. `1`)."
}

variable "managedby" {
  type        = string
  default     = "hello@clouddrove.com"
  description = "ManagedBy, eg 'CloudDrove'."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags to apply to all resources managed by the module (merged with module.labels.tags via extra_tags)."
}

variable "region" {
  type        = string
  default     = null
  nullable    = true
  description = "Region where KMS resources are managed. Defaults to the Region configured on the AWS provider. Requires AWS provider v6 or later."
}

# Module      : KMS KEY
# Description : Provides a KMS customer master key.
variable "deletion_window_in_days" {
  type        = number
  default     = 10
  description = "Duration in days after which the key is deleted after destruction of the resource."

  validation {
    condition     = var.deletion_window_in_days >= 7 && var.deletion_window_in_days <= 30
    error_message = "deletion_window_in_days must be between 7 and 30."
  }
}

variable "description" {
  type        = string
  default     = "Parameter Store KMS master key"
  description = "The description of the key as viewed in AWS console."
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Specifies whether the kms is enabled or disabled."
}
variable "kms_key_enabled" {
  type        = bool
  default     = true
  description = "Specifies whether the kms is enabled or disabled."
}


variable "key_usage" {
  type        = string
  default     = "ENCRYPT_DECRYPT"
  description = "Intended cryptographic use of the key: ENCRYPT_DECRYPT, SIGN_VERIFY, or GENERATE_VERIFY_MAC."
}

variable "alias" {
  type        = string
  default     = ""
  description = "The display name of the alias. The name must start with the word `alias` followed by a forward slash."

  validation {
    condition = var.alias == "" || (
      startswith(var.alias, "alias/") &&
      !startswith(var.alias, "alias/aws/") &&
      can(regex("^alias/[0-9A-Za-z/_-]+$", var.alias))
    )
    error_message = "alias must be empty or a valid customer alias beginning with alias/; alias/aws/ is reserved by AWS."
  }
}

variable "create_alias" {
  type        = bool
  default     = true
  description = "Whether to create the primary KMS alias. Additional aliases in aliases are controlled separately."
}

variable "aliases" {
  type        = set(string)
  default     = []
  description = "Additional KMS aliases to create for the key."

  validation {
    condition = alltrue([
      for alias_name in var.aliases :
      startswith(alias_name, "alias/") &&
      !startswith(alias_name, "alias/aws/") &&
      can(regex("^alias/[0-9A-Za-z/_-]+$", alias_name))
    ])
    error_message = "Every value in aliases must be a valid customer alias beginning with alias/; alias/aws/ is reserved by AWS."
  }
}

variable "customer_master_key_spec" {
  type        = string
  default     = "SYMMETRIC_DEFAULT"
  description = "Cryptographic configuration of the key. Supports symmetric encryption, RSA, NIST/secp256k1/Edwards ECC, HMAC, ML-DSA, and SM2 (China Regions only) key specs supported by AWS KMS."
}

variable "enable_key_rotation" {
  type        = bool
  default     = true
  description = "Specifies whether key rotation is enabled."
}

variable "rotation_period_in_days" {
  type        = number
  default     = null
  nullable    = true
  description = "Custom number of days between automatic rotations for symmetric KMS keys. Valid values are 90 through 2560."

  validation {
    condition     = var.rotation_period_in_days == null || (var.rotation_period_in_days >= 90 && var.rotation_period_in_days <= 2560)
    error_message = "rotation_period_in_days must be null or between 90 and 2560."
  }
}

variable "custom_key_store_id" {
  type        = string
  default     = null
  nullable    = true
  description = "ID of an existing AWS KMS custom key store where the key is stored."
}

variable "xks_key_id" {
  type        = string
  default     = null
  nullable    = true
  description = "External key ID in an existing external key store (XKS)."
}

variable "multi_region" {
  type        = bool
  default     = true
  description = "Indicates whether the KMS key is a multi-Region (true) or regional (false) key."
}

variable "bypass_policy_lockout_safety_check" {
  type        = bool
  default     = false
  description = "A flag to indicate whether to bypass the key policy lockout safety check. Setting this value to true increases the risk that the KMS key becomes unmanageable"
}

variable "valid_to" {
  type        = string
  default     = null
  nullable    = true
  description = "Time at which the imported key material expires. When the key material expires, AWS KMS deletes the key material and the CMK becomes unusable. If not specified, key material does not expire"
}

variable "key_material_base64" {
  type        = string
  default     = null
  nullable    = true
  sensitive   = true
  description = "Base64-encoded key material to import. When null, an external key is created in PendingImport state. The value is stored in Terraform state; secure the state accordingly."
}

variable "create_external_enabled" {
  type        = bool
  default     = false
  description = "Determines whether an external CMK (externally provided material) will be created or a standard CMK (AWS provided material)"
}

variable "primary_external_key_arn" {
  type        = string
  default     = null
  description = "The primary external key arn of a multi-region replica external key"
}

variable "primary_key_arn" {
  type        = string
  default     = ""
  description = "The primary key arn of a multi-region replica key"
}

variable "policy" {
  type        = string
  default     = null
  description = "A valid policy JSON document. Although this is a key policy, not an IAM policy, an `aws_iam_policy_document`, in the form that designates a principal, can be used"
}

variable "create_replica_enabled" {
  type        = bool
  default     = false
  description = "Determines whether a replica standard CMK will be created (AWS provided material)"
}

variable "create_replica_external_enabled" {
  type        = bool
  default     = false
  description = "Determines whether a replica external CMK will be created (externally provided material)"
}

variable "grants" {
  type = map(object({
    name                      = optional(string)
    grantee_principal         = string
    operations                = set(string)
    retiring_principal        = optional(string)
    grant_creation_tokens     = optional(set(string), [])
    retire_on_delete          = optional(bool, false)
    encryption_context_equals = optional(map(string))
    encryption_context_subset = optional(map(string))
  }))
  default     = {}
  description = "KMS grants to create for the managed key, keyed by a stable Terraform identifier."

  validation {
    condition = alltrue([
      for grant in values(var.grants) :
      !(grant.encryption_context_equals != null && grant.encryption_context_subset != null)
    ])
    error_message = "A grant cannot set both encryption_context_equals and encryption_context_subset."
  }
}
