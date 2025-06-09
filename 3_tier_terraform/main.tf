module "google_compute_instance_01" {
  source = "./modules/backend-compute-engine"
  backend_name = "marong-public-vm-01-test"
  machine_type = "e2-standard-2"
  region = "asia-northeast3"
  image = "ubuntu-os-cloud/ubuntu-2204-lts"
  disk_size = 30
  subnetwork = module.vpc.subnets_names[2]
  ssh_key_path = var.ssh_key_path 
  tags = ["allow-ssh-test", "allow-http-https-test"]
  service_account_email = var.service_account_email
  target_size = 1
}

module "google_compute_instance_02" {
  source = "./modules/backend-compute-engine"
  backend_name = "marong-public-vm-02-test"
  machine_type = "e2-standard-2"
  region = "asia-northeast3"
  image = "ubuntu-os-cloud/ubuntu-2204-lts"
  disk_size = 30
  subnetwork = module.vpc.subnets_names[3]
  ssh_key_path = var.ssh_key_path
  tags = ["allow-ssh-test", "allow-http-https-test"]
  service_account_email = var.service_account_email
  target_size = 1
}

module "google_compute_instance_db" {
  source = "./modules/db-compute-engine"
  db_name = "marong-db-01-test"
  machine_type = "e2-standard-2"
  region = "asia-northeast3"
  image = "ubuntu-os-cloud/ubuntu-2204-lts"
  disk_size = 30  
  subnetwork = module.vpc.subnets_names[4]
  ssh_key_path = var.ssh_key_path
  tags = ["allow-ssh-test", "allow-http-https-test"]
  service_account_email = var.service_account_email
}

module "google_compute_instance_ai" {

  source = "./modules/ai-compute-engine"
  ai_name = "marong-ai-01-test"
  machine_type = "e2-standard-2"
  region = "asia-northeast3"
  image = "ubuntu-os-cloud/ubuntu-2204-lts"
  disk_size = 30
  subnetwork = module.vpc.subnets_names[4]
  ssh_key_path = var.ssh_key_path
  tags = ["allow-ssh-test", "allow-http-https-test"]
  service_account_email = var.service_account_email
}

module "lb" {
  source = "./modules/lb"
  backend_name = "marong-public-vm-01-test"
  backend_group_01 = module.google_compute_instance_01.instance_group_name
  backend_group_02 = module.google_compute_instance_02.instance_group_name
  url_map_name = "marong-url-map"
  http_proxy_name = "marong-http-proxy"
  http_forwarding_rule_name = "marong-http-forwarding-rule"
  security_policy = module.cloud-armor.security_policy_name
  project_id = var.project_id
  zone = "asia-northeast3-a"  
  lb_name = "marong-lb-01"
}

module "nat" {
  source = "./modules/nat-gateway"
  name = "marong-nat-gateway"
  network = module.vpc.network_name
  region = "asia-northeast3"
  private_subnets = [module.vpc.subnets_names[2], module.vpc.subnets_names[3]]
}

module "cloud-armor" {
  source = "./modules/cloud-armor"
  name = "marong-cloud-armor"
  description = "Cloud Armor policy for marong" 
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