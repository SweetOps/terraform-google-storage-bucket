variable "namespace" {
  type        = "string"
  description = "Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp'"
}

variable "environment" {
  type        = "string"
  default     = ""
  description = "Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT'"
}

variable "stage" {
  type        = "string"
  description = "Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release'"
}

variable "name" {
  type        = "string"
  description = "Solution name, e.g. 'app' or 'jenkins'"
}

variable "enabled" {
  type        = "string"
  default     = "true"
  description = "Set to false to prevent the module from creating any resources"
}

variable "delimiter" {
  type        = "string"
  default     = "-"
  description = "Delimiter to be used between `namespace`, `environment`, `stage`, `name` and `attributes`"
}

variable "attributes" {
  type        = "list"
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "tags" {
  type        = "map"
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`"
}

variable "context" {
  type        = "map"
  default     = {}
  description = "Default context to use for passing state between label invocations"
}

variable "location" {
  description = "The GCS location."
  default     = ""
}

variable "project" {
  description = "The project in which the resource belongs. If it is not provided, the provider project is used."
  default     = ""
}

variable "force_destroy" {
  description = "When deleting a bucket, this boolean option will delete all contained objects."
  default     = "false"
}

variable "storage_class" {
  description = "The Storage Class of the new bucket. Supported values include: MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE."
  default     = "REGIONAL"
}

variable "kms_key_name" {
  description = "A Cloud KMS key that will be used to encrypt objects inserted into this bucket"
  default     = ""
}

# lifecycle_rule condition block
variable "age" {
  description = "Minimum age of an object in days to satisfy this condition."
  default     = "60"
}

variable "created_before" {
  description = "Creation date of an object in RFC 3339 (e.g. 2017-06-13) to satisfy this condition."
  default     = ""
}

variable "is_live" {
  description = "Relevant only for versioned objects. If true, this condition matches live objects, archived objects otherwise."
  default     = "false"
}

variable "matches_storage_class" {
  description = "Storage Class of objects to satisfy this condition. Supported values include: MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, STANDARD, DURABLE_REDUCED_AVAILABILITY."
  type        = "list"
  default     = ["REGIONAL"]
}

variable "num_newer_versions" {
  description = "Relevant only for versioned objects. The number of newer versions of an object to satisfy this condition."
  default     = "10"
}

# lifecycle_rule action block
variable "action_type" {
  description = "The type of the action of this Lifecycle Rule. Supported values include: Delete and SetStorageClass."
  default     = "SetStorageClass"
}

variable "action_storage_class" {
  description = "The target Storage Class of objects affected by this Lifecycle Rule. Supported values include: MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE."
  default     = "NEARLINE"
}

# versioning block
variable "versioning_enabled" {
  description = "While set to true, versioning is fully enabled for this bucket."
  default     = "true"
}

# bucket ACL
variable "default_acl" {
  description = "Configure this ACL to be the default ACL."
  default     = "projectPrivate"
}

variable "role_entity" {
  description = "List of role/entity pairs in the form ROLE:entity."
  type        = "list"
  default     = []
}
