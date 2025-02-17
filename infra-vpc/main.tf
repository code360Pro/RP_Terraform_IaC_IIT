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
    region  = "us-central1"  

    }


resource "google_compute_network" "vpc_network" {
name = "npe-vpc"
auto_create_subnetworks = false
}

# Create the subnet
resource "google_compute_subnetwork" "subnet_dev_serverless" {
  name          = "rp-dev-subnet-serverless" 
  ip_cidr_range = "10.128.14.0/24"
  region        = "us-central1" 
  network       = google_compute_network.vpc_network.id 
  private_ip_google_access = true

}

resource "google_compute_subnetwork" "subnet_dev" {
  name          = "rp-dev-subnet" 
  ip_cidr_range = "10.128.15.0/28"
  region        = "us-central1" 
  network       = google_compute_network.vpc_network.id 
  private_ip_google_access = true
}

# Output the network and subnet IDs (useful for other resources)
output "vpc_network_id" {
  value = google_compute_network.vpc_network.id
}

output "subnet_dev_serverless_id" {
  value = google_compute_subnetwork.subnet_dev_serverless.id
}

output "subnet_dev_id" {
  value = google_compute_subnetwork.subnet_dev.id
}

resource "google_compute_firewall" "allow-sql-proxy" {
  name    = "allow-sql-proxy"
  network = google_compute_network.vpc_network.id

  allow {
    protocol = "tcp"
    ports    = ["5432"]
  }

  source_ranges = ["0.0.0.0/0"] # Allow traffic from any IP address (use with caution)
  target_tags   = ["cloud-sql-proxy-vm"]
}

resource "google_compute_firewall" "allow-ssh" {
  name    = "allow-ssh"
  network = google_compute_network.vpc_network.id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"] # Allow traffic from any IP address (use with caution)
  target_tags   = ["cloud-sql-proxy-vm"]
}