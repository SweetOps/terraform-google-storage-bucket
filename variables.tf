variable "name" {
  type        = "list"
  description = "The name of the bucket."
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

# lifecycle_rule condition block

variable "condition" {
  default = [
    {
      age                   = "60"
      created_before        = "2017-06-13"
      is_live               = "false"
      matches_storage_class = ["REGIONAL"]
      num_newer_versions    = "10"
    },
  ]
}

# lifecycle_rule action block

variable "action" {
  type = "list"

  default = [
    {
      type          = "SetStorageClass"
      storage_class = "NEARLINE"
    },
  ]
}

variable "website" {
  type    = "list"
  default = []
}

# variable "website" {
#   type = "list"
#
#   default = [
#     {
#       main_page_suffix = "index.html"
#       not_found_page   = "404.html"
#     },
#   ]
# }

# cors block

variable "cors" {
  type    = "list"
  default = []
}

# variable "cors" {
#   type = "list"
#
#   default = [
#     {
#       origin          = ["*"]
#       method          = ["*"]
#       response_header = []
#       max_age_seconds = "3600"
#     },
#   ]
# }

# versioning block
variable "versioning_enabled" {
  description = "While set to true, versioning is fully enabled for this bucket."
  default     = "true"
}

# bucket ACL

variable "default_acl" {
  description = "Configure this ACL to be the default ACL."
  default     = "private"
}

variable "role_entity" {
  description = "List of role/entity pairs in the form ROLE:entity."
  type        = "list"
  default     = []
}
