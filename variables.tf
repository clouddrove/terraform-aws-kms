variable "application" {
  type        = "string"
  description = "Application (e.g. `cp` or `clouddrove`)"
}

variable "environment" {
  type        = "string"
  description = "Environment (e.g. `prod`, `dev`, `staging`)"
}

variable "name" {
  type        = "string"
  description = "name (e.g. `test`)"
}

variable "delimiter" {
  type        = "string"
  default     = "-"
  description = "Delimiter to be used between `namespace`, `stage`, `name` and `attributes`"
}

variable "attributes" {
  type        = "list"
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "tags" {
  type        = "map"
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)"
}

variable "deletion_window_in_days" {
  default     = 10
  description = "Duration in days after which the key is deleted after destruction of the resource"
}

variable "enable_key_rotation" {
  default     = "true"
  description = "Specifies whether key rotation is enabled"
}

variable "description" {
  type        = "string"
  default     = "Parameter Store KMS master key"
  description = "The description of the key as viewed in AWS console"
}

variable "alias" {
  type        = "string"
  default     = ""
  description = "The display name of the alias. The name must start with the word `alias` followed by a forward slash"
}
