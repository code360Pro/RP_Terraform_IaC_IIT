terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.20.0"
    }
  }
}

provider "google" {
    project = "rp-dev-450309"
    }

resource "google_storage_bucket" "rp-tf-state" {
  project = "rp-dev-450309"
  name = "rp-tf-state"
  location = "US"
}