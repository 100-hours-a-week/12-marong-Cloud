module "vpc" {
  source = "terraform-google-modules/network/google"
  version = "11.1.0"

/*
    고정 IP 할당 받는 거 아직 안 함 해야 함
*/
  project_id = var.project_id
  network_name = "marong-vpc-network"
  routing_mode = "REGIONAL"

  // 포트번호 설정
  firewall_rules = [
    {
      name = "allow-internal-test"
      description = "Allow internal traffic"
      direction = "INGRESS"
      priority = 65534
      ranges = ["10.10.0.0/16"]
      allow = [
        {
          protocol = "tcp"
          ports = ["0-65535"]
        },
        {
          protocol = "udp"
          ports = ["0-65535"]
        },
        {
          protocol = "icmp"
        }
      ]
    }, 
    {
      name = "allow-ssh-test"
      description = "Allow SSH traffic"
      direction = "INGRESS"
      priority = 1000
      ranges = ["0.0.0.0/0"]
      allow = [
        {
          protocol = "tcp"
          ports = ["22"]
        }
      ]
      target_tags = ["allow-ssh-test"]
    },
    {
      name = "allow-https-test"
      description = "Allow HTTPS traffic"
      direction = "INGRESS"
      priority = 1000
      ranges = ["0.0.0.0/0"]
      allow = [
        {
          protocol = "tcp"
          ports = ["443", "80"]
        }
      ]
      target_tags = ["allow-https-test"]
    },
    {
      name = "allow-be-test"
      description = "Allow be traffic"
      direction = "INGRESS"
      priority = 1000
      ranges = ["0.0.0.0/0"]
      allow = [
        {
          protocol = "tcp"
          ports = ["8080"]
        }
      ]
      target_tags = ["allow-be-test"]
    }
  ]

  // 서브넷 설정
  subnets = [
    {
      subnet_name = "public-subnet-01"
      subnet_ip = "10.10.0.0/24"
      subnet_region = "asia-northeast3"
    },
    {
      subnet_name = "public-subnet-02"
      subnet_ip = "10.10.1.0/24"
      subnet_region = "asia-northeast3"
    },
    {
      subnet_name = "private-subnet-01"
      subnet_ip = "10.10.2.0/24"
      subnet_region = "asia-northeast3"
      subnet_private_access = "true"
    },
    {
      subnet_name = "private-subnet-02"
      subnet_ip = "10.10.3.0/24"
      subnet_region = "asia-northeast3"
      subnet_private_access = "true"
    },
    {
      subnet_name = "database-subnet-01"
      subnet_ip = "10.10.4.0/24"
      subnet_region = "asia-northeast3"
      subnet_private_access = "true"
    }
  ]

  routes = [
    {
      name = "egress-internet"
      description = "인터넷 게이트웨이 역할"
      destination_range = "0.0.0.0/0"
      tags = "egress-inet"
      next_hop_internet = true
    }
  ]
}