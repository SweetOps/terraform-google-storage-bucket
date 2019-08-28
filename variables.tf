variable "namespace" {
  type        = string
  default     = ""
  description = "Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp'"
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT'"
}

variable "stage" {
  type        = string
  default     = ""
  description = "Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release'"
}

variable "name" {
  type        = string
  default     = ""
  description = "Solution name, e.g. 'app' or 'jenkins'"
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Set to false to prevent the module from creating any resources"
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between `namespace`, `environment`, `stage`, `name` and `attributes`"
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`"
}

variable "location" {
  type        = string
  default     = ""
  description = "The GCS region."
}

variable "project" {
  type        = string
  default     = ""
  description = "The project in which the resource belongs. If it is not provided, the provider project is used."
}

variable "force_destroy" {
  type        = bool
  default     = false
  description = "When deleting a bucket, this boolean option will delete all contained objects."
}

variable "storage_class" {
  type        = string
  default     = "REGIONAL"
  description = "The Storage Class of the new bucket. Supported values include: MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE."
}

variable "kms_key_name" {
  type        = string
  default     = ""
  description = "A Cloud KMS key that will be used to encrypt objects inserted into this bucket"
}

# lifecycle_rule condition block
variable "age" {
  type        = number
  default     = 60
  description = "Minimum age of an object in days to satisfy this condition."
}

variable "created_before" {
  type        = string
  default     = ""
  description = "Creation date of an object in RFC 3339 (e.g. 2017-06-13) to satisfy this condition."
}

variable "is_live" {
  default     = false
  type        = bool
  description = "Relevant only for versioned objects. If true, this condition matches live objects, archived objects otherwise."
}

variable "matches_storage_class" {
  type        = "list"
  default     = ["REGIONAL"]
  description = "Storage Class of objects to satisfy this condition. Supported values include: MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, STANDARD, DURABLE_REDUCED_AVAILABILITY."
}

variable "num_newer_versions" {
  type        = number
  default     = 10
  description = "Relevant only for versioned objects. The number of newer versions of an object to satisfy this condition."
}

# lifecycle_rule action block
variable "action_type" {
  type        = string
  default     = "SetStorageClass"
  description = "The type of the action of this Lifecycle Rule. Supported values include: Delete and SetStorageClass."
}

variable "action_storage_class" {
  type        = string
  default     = "NEARLINE"
  description = "The target Storage Class of objects affected by this Lifecycle Rule. Supported values include: MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE."
}

# versioning block
variable "versioning_enabled" {
  type        = bool
  default     = true
  description = "While set to true, versioning is fully enabled for this bucket."
}

# bucket ACL
variable "default_acl" {
  type        = string
  default     = "projectPrivate"
  description = "Configure this ACL to be the default ACL."
}

variable "role_entity" {
  type        = "list"
  default     = []
  description = "List of role/entity pairs in the form ROLE:entity.Must be set if predefined_acl is not"
}
