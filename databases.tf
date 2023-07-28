locals {
  database_configuration_files = [
    for configuration in fileset(var.databases_directory, "*.{json,yaml}") :
    yamldecode(file("${var.databases_directory}/${configuration}"))
  ]
  database_configurations = {
    for configuration in local.database_configuration_files :
    configuration.id => configuration
  }
}

# The Spanner database for each configuration.
resource "google_spanner_database" "database" {
  for_each = local.database_configurations

  project  = local.gcp_project_id
  instance = google_spanner_instance.instance.name
  name     = each.value.id
  ddl      = each.value.ddls

  deletion_protection = var.deletion_protection
}
