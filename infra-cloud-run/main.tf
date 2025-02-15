resource "google_cloud_run_v2_service" "default" {
  name     = "cloudrun-service"
  project  = "rp-dev-450309"
  location = "us-central1"
  deletion_protection = false
  ingress = "INGRESS_TRAFFIC_ALL"

  template {
    service_account = "cloud-run-deployment-dev@rp-dev-450309.iam.gserviceaccount.com"
    containers {
      image = "us-central1-docker.pkg.dev/rp-dev-450309/rp-dev-net-repo/dotnet8-api:04ce075"
    }
  }
}