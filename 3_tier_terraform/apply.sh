BACKUP_BUCKET_NAME=var.backup_bucket_name
BUCKET_NAME=var.bucket_name

echo "Copying data from ${BACKUP_BUCKET_NAME} to ${BUCKET_NAME}"
gsutil -m cp -r gs://${BACKUP_BUCKET_NAME}/* gs://${BUCKET_NAME}

echo "Initializing Terraform"
terraform init
terraform apply -auto-approve