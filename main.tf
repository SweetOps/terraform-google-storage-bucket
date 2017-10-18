data "google_client_config" "default" {}

resource "google_storage_bucket" "default" {
  count         = "${length(var.name)}"
  name          = "${element(var.name, count.index)}"
  location      = "${length(var.location) > 0 ? var.location : data.google_client_config.default.region}"
  project       = "${length(var.project) > 0 ? var.project : data.google_client_config.default.project}"
  storage_class = "${var.storage_class}"
  force_destroy = "${var.force_destroy}"

  lifecycle_rule {
    action    = "${var.action}"
    condition = "${var.condition}"
  }

  website = "${var.website}"
  cors    = "${var.cors}"

  versioning {
    enabled = "${var.versioning_enabled}"
  }
}

resource "google_storage_bucket_acl" "default" {
  count       = "${length(var.role_entity) > 0 ? length(google_storage_bucket.default.*.name) : 0}"
  default_acl = "${var.default_acl}"
  bucket      = "${element(google_storage_bucket.default.*.name, count.index)}"

  role_entity = [
    "${var.role_entity}",
  ]
}
