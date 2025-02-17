resource "google_compute_instance" "cloud_sql_proxy_vm" {
  name         = "cloud-sql-proxy-vm"
  machine_type = "n1-standard-1" # Or another appropriate machine type
  zone         = "us-central1-a" # Choose your desired zone
  project      = "rp-dev-450309" # Replace with your project ID

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11" # Or another Linux image
    }
  }

    network_interface {
    network    = "projects/rp-dev-450309/global/networks/npe-vpc" # Replace with your VPC network ID
    subnetwork = "projects/rp-dev-450309/regions/us-central1/subnetworks/rp-dev-subnet" # Replace with your subnetwork ID
    access_config {
      # Ephemeral public IP
    }
  }

  metadata_startup_script = <<EOF
#!/bin/bash

# Install Cloud SQL Proxy
wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 -O cloud_sql_proxy
chmod +x cloud_sql_proxy

# Create the Cloud SQL instance connection string
CONNECTION_STRING="rp-dev-450309:us-central1:rp-sql-dev" # Example: project:region:instance

# Run Cloud SQL Proxy in the background
nohup ./cloud_sql_proxy -instances="$CONNECTION_STRING"=tcp:5432 &

# Install postgresql client (if needed)
apt-get update
apt-get install -y postgresql-client

# Example connection test (optional)
# psql -h 127.0.0.1 -p 5432 -U your_db_user -d your_db_name

EOF

  # Allow traffic to the Cloud SQL Proxy port (5432 in this example)
  # This is crucial!
  allow_stopping_for_update = true # Important for updates!

  tags = ["cloud-sql-proxy-vm","ssh"]
}
