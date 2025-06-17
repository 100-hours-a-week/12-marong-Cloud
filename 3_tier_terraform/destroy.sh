BACKUP_BUCKET_NAME=var.backup_bucket_name
BUCKET_NAME=var.bucket_name

gsutil -m cp -r gs://${BUCKET_NAME}/* gs://${BACKUP_BUCKET_NAME}

terraform init
terraform destroy -auto-approve