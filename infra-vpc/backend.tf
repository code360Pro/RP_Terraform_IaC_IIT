terraform {
  backend "gcs" {
    bucket = "rp-tf-state"
    prefix = "terraform/state/infra-vpc"
  }
}