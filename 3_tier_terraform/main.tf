module "google_compute_instance" {
  source = "./modules/compute-engine"
  name = "marong-public-vm-01-test"
  machine_type = "e2-micro"
  zone = "asia-northeast3-a"
  image = "ubuntu-os-cloud/ubuntu-2204-lts"
  disk_size = 30
  subnetwork = module.vpc.subnets_names[2]
  ssh_key_path = "~/.ssh/id_rsa.pub"
  tags = ["allow-ssh-test", "allow-http-https-test"]
  service_account_email = "340121241354-compute@developer.gserviceaccount.com"
}

module "nat" {
  source = "./modules/nat-gateway"
  name = "marong-nat-gateway"
  network = module.vpc.network_name
  region = "asia-northeast3"
  private_subnets = [module.vpc.subnets_names[0], module.vpc.subnets_names[1]]
}