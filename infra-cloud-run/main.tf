resource "google_cloud_run_v2_service" "default" {
  name     = "cloudrun-service"
  project  = "rp-dev-450309"
  location = "us-central1"
  deletion_protection = false
  ingress = "INGRESS_TRAFFIC_ALL"

  template {
    service_account = "cloud-run-deployment-dev@rp-dev-450309.iam.gserviceaccount.com"
    containers {
      image = "us-central1-docker.pkg.dev/rp-dev-450309/rp-dev-net-repo/dotnet8-api:d727895"
      startup_probe {
        http_get {
          path = "/health"
          port = 8080
        }
        initial_delay_seconds = 10
        period_seconds        = 5
        failure_threshold     = 30
      }
    }
  }
}
resource "google_cloud_run_service_iam_member" "noauth" {
  project        = google_cloud_run_v2_service.default.project
  location       = google_cloud_run_v2_service.default.location
  service        = google_cloud_run_v2_service.default.name
  role           = "roles/run.invoker"
  member         = "allUsers"
}


