variable "location" {
  type        = string
  default     = null
  description = "The GCS region."
}

variable "project" {
  type        = string
  default     = null
  description = "The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
}

variable "force_destroy" {
  type        = bool
  default     = false
  description = "When deleting a bucket, this boolean option will delete all contained objects."
}

variable "storage_class" {
  type        = string
  default     = "REGIONAL"
  description = "The Storage Class of the new bucket. Allowed values: `STANDARD`, `MULTI_REGIONAL`, `REGIONAL`, `NEARLINE`, `COLDLINE`, `ARCHIVE`."

  validation {
    condition     = contains(["STANDARD", "MULTI_REGIONAL", "REGIONAL", "NEARLINE", "COLDLINE", "ARCHIVE"], var.storage_class)
    error_message = "Allowed values: `STANDARD`, `MULTI_REGIONAL`, `REGIONAL`, `NEARLINE`, `COLDLINE`, `ARCHIVE`."
  }
}

variable "default_kms_key_name" {
  type        = string
  default     = null
  description = "The `id` of a Cloud KMS key that will be used to encrypt objects inserted into this bucket, if no encryption method is specified."
}

variable "versioning_enabled" {
  type        = bool
  default     = true
  description = "While set to `true`, versioning is fully enabled for this bucket."
}

variable "retention_policy" {
  type = object({
    is_locked        = bool
    retention_period = number
  })
  default     = null
  description = <<-DOC
    Configuration of the bucket's data retention policy for how long objects in the bucket should be retained.
      is_locked:
        If set to `true`, the bucket will be locked and permanently restrict edits to the bucket's retention policy.
      retention_period:
        The period of time, in seconds, that objects in the bucket must be retained and cannot be deleted, overwritten, or archived.
  DOC
}

variable "lifecycle_rules" {
  type = set(object({
    action    = any
    condition = any
  }))
  default     = []
  description = <<-DOC
    The list of bucket Lifecycle Rules.
      action:
        type:
          The type of the action of this Lifecycle Rule. Allowed values: `Delete` and `SetStorageClass`.
        storage_class:
          The target Storage Class of objects affected by this Lifecycle Rule.
          Required if action type is `SetStorageClass`.
          Allowed values: `STANDARD`, `MULTI_REGIONAL`, `REGIONAL`, `NEARLINE`, `COLDLINE`, `ARCHIVE`.
      condition:
        age:
          Minimum age of an object in days to satisfy this condition.
        created_before:
          Creation date of an object in RFC 3339 (e.g. 2017-06-13) to satisfy this condition.
        with_state:
          Match to live and/or archived objects. Unversioned buckets have only live objects. 
          Allowed values: `LIVE`, `ARCHIVED`, `ANY`.
        matches_storage_class:
          Storage Class of objects to satisfy this condition.
          Allowed values: `STANDARD`, `MULTI_REGIONAL`, `REGIONAL`, `NEARLINE`, `COLDLINE`, `ARCHIVE`.
        num_newer_versions:
          Relevant only for versioned objects. 
          The number of newer versions of an object to satisfy this condition.
        custom_time_before:
          Creation date of an object in RFC 3339 (e.g. `2017-06-13`) to satisfy this condition.
        days_since_custom_time:
          Date in RFC 3339 (e.g. `2017-06-13`) when an object's Custom-Time metadata is earlier than the date specified in this condition.
        days_since_noncurrent_time:
          Relevant only for versioned objects. 
          Number of days elapsed since the noncurrent timestamp of an object.
        noncurrent_time_before:
          Relevant only for versioned objects. 
          The date in RFC 3339 (e.g. `2017-06-13`) when the object became nonconcurrent.
  DOC
}
