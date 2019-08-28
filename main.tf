module "label" {
  source      = "git::https://github.com/SweetOps/terraform-null-label.git?ref=tags/0.7.0"
  enabled     = var.enabled
  namespace   = var.namespace
  name        = var.name
  stage       = var.stage
  environment = var.environment
  delimiter   = var.delimiter
  attributes  = var.attributes
  tags        = var.tags
}

resource "google_storage_bucket" "default" {
  count         = var.enabled ? 1 : 0
  name          = module.label.id
  location      = var.location
  project       = var.project
  storage_class = var.storage_class
  force_destroy = var.force_destroy

  labels = module.label.gcp_labels

  lifecycle_rule {
    action {
      type          = var.action_type
      storage_class = var.action_storage_class
    }

    condition {
      age                   = var.age
      created_before        = var.created_before
      is_live               = var.is_live
      matches_storage_class = var.matches_storage_class
      num_newer_versions    = var.num_newer_versions
    }
  }

  versioning {
    enabled = var.versioning_enabled
  }

  encryption {
    default_kms_key_name = var.kms_key_name
  }
}

resource "google_storage_bucket_acl" "default" {
  count       = var.enabled ? 1 : 0
  default_acl = var.default_acl
  bucket      = join("", google_storage_bucket.default.*.name)
  role_entity = compact(var.role_entity)
}
