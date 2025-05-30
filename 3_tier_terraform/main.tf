module "google_compute_instance" {
  source = "./modules/backend-compute-engine"
  backend_name = "marong-public-vm-01-test"
  machine_type = "e2-micro"
  region = "asia-northeast3"
  image = "ubuntu-os-cloud/ubuntu-2204-lts"
  disk_size = 30
  subnetwork = module.vpc.subnets_names[2]
  ssh_key_path = var.ssh_key_path 
  tags = ["allow-ssh-test", "allow-http-https-test"]
  service_account_email = var.service_account_email
  target_size = 2
}

module "google_compute_instance_db" {
  source = "./modules/db-compute-engine"
  db_name = "marong-db-01-test"
  machine_type = "e2-micro"
  zone = "asia-northeast3-a"
  image = "ubuntu-os-cloud/ubuntu-2204-lts"
  disk_size = 30  
  subnetwork = module.vpc.subnets_names[3]
  ssh_key_path = var.ssh_key_path
  tags = ["allow-ssh-test", "allow-http-https-test"]
  service_account_email = var.service_account_email
}

module "lb" {
  source = "./modules/lb"
  backend_name = "marong-public-vm-01-test"
  backend_group = module.google_compute_instance.instance_group_name
  url_map_name = "marong-url-map"
  http_proxy_name = "marong-http-proxy"
  http_forwarding_rule_name = "marong-http-forwarding-rule"
}

module "nat" {
  source = "./modules/nat-gateway"
  name = "marong-nat-gateway"
  network = module.vpc.network_name
  region = "asia-northeast3"
  private_subnets = [module.vpc.subnets_names[0], module.vpc.subnets_names[1]]

}

# module "gcs" {
#   source = "./modules/gcs"
#   bucket_name = var.bucket_name
#   location = "asia-northeast3"
#   labels = {
#     "environment" = "production"
#   }
# }

# module "ci-cd" {
#   source = "./modules/ci-cd"
#   bucket_name = var.bucket_name
#   location = "asia-northeast3"
#   backup_bucket_name = var.backup_bucket_name
#   apply_topic_name = "marong-apply-topic"
#   destroy_topic_name = "marong-destroy-topic"
#   apply_trigger_name = "marong-apply-trigger"
#   destroy_trigger_name = "marong-destroy-trigger"
#   apply_schedule_name = "marong-apply-schedule"
#   destroy_schedule_name = "marong-destroy-schedule"
#   apply_cron = "0 0 * * *"
#   destroy_cron = "0 0 * * *"
#   time_zone = "Asia/Seoul"
# }