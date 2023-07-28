# The Spanner instance for all databases.
resource "google_spanner_instance" "instance" {
  project          = local.gcp_project_id
  config           = local.instance_configuration
  name             = local.instance_name
  display_name     = local.instance_name
  processing_units = local.instance_processing_units

  force_destroy = !var.deletion_protection
}
