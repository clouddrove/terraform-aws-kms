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

# Module      : KMS KEY
# Description : Provides a KMS customer master key.
variable "deletion_window_in_days" {
  type        = number
  default     = 10
  description = "Duration in days after which the key is deleted after destruction of the resource."
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
  sensitive   = true
  description = "Specifies the intended use of the key. Defaults to ENCRYPT_DECRYPT, and only symmetric encryption and decryption are supported."
}

variable "alias" {
  type        = string
  default     = ""
  description = "The display name of the alias. The name must start with the word `alias` followed by a forward slash."
}

variable "customer_master_key_spec" {
  type        = string
  default     = "SYMMETRIC_DEFAULT"
  description = "Specifies whether the key contains a symmetric key or an asymmetric key pair and the encryption algorithms or signing algorithms that the key supports. Valid values: SYMMETRIC_DEFAULT, RSA_2048, RSA_3072, RSA_4096, ECC_NIST_P256, ECC_NIST_P384, ECC_NIST_P521, or ECC_SECG_P256K1. Defaults to SYMMETRIC_DEFAULT."
  sensitive   = true
}

variable "enable_key_rotation" {
  type        = string
  default     = true
  description = "Specifies whether key rotation is enabled."
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
  default     = ""
  description = "Time at which the imported key material expires. When the key material expires, AWS KMS deletes the key material and the CMK becomes unusable. If not specified, key material does not expire"
}

variable "key_material_base64" {
  type        = string
  default     = null
  description = "Base64 encoded 256-bit symmetric encryption key material to import. The CMK is permanently associated with this key material. External key only"
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