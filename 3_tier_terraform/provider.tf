terraform {
  required_providers {
    google = {
        source = "hashicorp/google"
        version = "6.19.0"
    }
  }
}

provider "google" {
  project = "marong-459104"
  region = "asia-northeast3"
  zone = "asia-northeast3-a"
}