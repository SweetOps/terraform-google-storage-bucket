output "self_link" {
  value       = join("", google_storage_bucket.default.*.self_link)
  description = "The URI of the created resource"
}

output "url" {
  value       = join("", google_storage_bucket.default.*.url)
  description = "The base URL of the bucket, in the format gs://<bucket-name>"
}

output "name" {
  value       = join("", google_storage_bucket.default.*.name)
  description = "The name of bucket"
}
