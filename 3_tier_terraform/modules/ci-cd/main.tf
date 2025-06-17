resource "google_pubsub_topic" "apply_topic" {
  name = var.apply_topic_name
}

resource "google_pubsub_topic" "destroy_topic" {
  name = var.destroy_topic_name
}
    
resource "google_cloudbuild_trigger" "apply_trigger" {
  name = var.apply_trigger_name
  pubsub_config {
    topic = google_pubsub_topic.apply_topic.name
  }
  substitutions = {
    _BUCKET_NAME = var.bucket_name
    _BACKUP_BUCKET_NAME = var.backup_bucket_name
  }
}

resource "google_cloudbuild_trigger" "destroy_trigger" {
  name = var.destroy_trigger_name
  pubsub_config {
    topic = google_pubsub_topic.destroy_topic.name
  }
  substitutions = {
    _BUCKET_NAME = var.bucket_name
    _BACKUP_BUCKET_NAME = var.backup_bucket_name
  }
}

resource "google_cloud_scheduler_job" "apply_schedule" {
  name = var.apply_schedule_name
  schedule = var.apply_cron
  time_zone = var.time_zone
  pubsub_target {
    topic_name = google_pubsub_topic.apply_topic.name
    data = base64encode("{}")
  }
}

resource "google_cloud_scheduler_job" "destroy_schedule" {
  name = var.destroy_schedule_name
  schedule = var.destroy_cron
  time_zone = var.time_zone
  pubsub_target {
    topic_name = google_pubsub_topic.destroy_topic.name
    data = base64encode("{}")
  }
}