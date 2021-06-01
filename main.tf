resource "google_storage_bucket" "default" {
  count = var.enabled ? 1 : 0

  name          = module.this.id
  location      = var.location
  project       = var.project
  storage_class = var.storage_class
  force_destroy = var.force_destroy
  labels        = module.this.tags

  dynamic "retention_policy" {
    for_each = var.retention_policy == null ? [] : [var.retention_policy]
    content {
      is_locked        = var.retention_policy.is_locked
      retention_period = var.retention_policy.retention_period
    }
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rules
    content {
      action {
        type          = lifecycle_rule.value.action.type
        storage_class = lookup(lifecycle_rule.value.action, "storage_class", null)
      }
      condition {
        age                   = lookup(lifecycle_rule.value.condition, "age", null)
        created_before        = lookup(lifecycle_rule.value.condition, "created_before", null)
        with_state            = lookup(lifecycle_rule.value.condition, "with_state", lookup(lifecycle_rule.value.condition, "is_live", false) ? "LIVE" : null)
        matches_storage_class = lookup(lifecycle_rule.value.condition, "matches_storage_class", null)
        num_newer_versions    = lookup(lifecycle_rule.value.condition, "num_newer_versions", null)
      }
    }
  }

  versioning {
    enabled = var.versioning_enabled
  }

  dynamic "encryption" {
    for_each = var.default_kms_key_name != null ? [1] : []
    content {
      default_kms_key_name = var.default_kms_key_name
    }
  }
}
