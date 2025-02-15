variable "project_id" {
  description = "The ID of the project in which to create resources."
  type        = string
}
variable "machine_type" {
  description = "the machine type to use for the VM"
  type        = string
}
variable "zone" {
  description = "the zone to deploy the VM in"
  type        = string
}
variable "image" {
  description = "the image to use for the VM"
  type        = string
}
variable "name" {
  description = "the name of the VM"
  type        = string
}