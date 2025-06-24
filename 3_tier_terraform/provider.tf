terraform {
  required_providers {
    google = {
        source = "hashicorp/google"
        version = "6.19.0"
    }
  }
}

provider "google" {
  project = "marong-463804"
  region = "asia-northeast3"
  zone = "asia-northeast3-a"
}