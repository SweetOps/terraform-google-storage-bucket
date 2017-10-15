output "bucket_self_link" {
  value       = ["${google_storage_bucket.default.*.self_link}"]
  description = "The URI of the created resource."
}

output "bucket_url" {
  value       = ["${google_storage_bucket.default.*.url}"]
  description = "The base URL of the bucket, in the format gs://<bucket-name>."
}

output "bucket_name" {
  value       = ["${google_storage_bucket.default.*.name}"]
  description = "The name of bucket."
}
