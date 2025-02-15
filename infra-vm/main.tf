terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.20.0"
    }
  }
}

provider "google" {
    project = var.project_id
    }

resource "google_compute_instance" "vm_instance" {
  project = var.project_id
  name = var.name
  machine_type = var.machine_type
  zone = var.zone
  boot_disk {
    initialize_params {
      image = var.image
    }
  }
  network_interface {
    network = "default"
    access_config {
      }
  }
}

