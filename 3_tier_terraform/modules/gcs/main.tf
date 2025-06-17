resource "google_storage_bucket" "bucket" {
  name = var.bucket_name
  location = var.location
  storage_class = "STANDARD"
  force_destroy = false
  uniform_bucket_level_access = true
  versioning {
    enabled = true
  }

  labels = var.labels
}