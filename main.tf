locals {
  # Project configuration from the JSON file.
  configuration = yamldecode(file(var.infrastructure_configuration_file))

  conf_google                    = try(local.configuration.google, tomap({}))
  conf_google_project            = try(local.conf_google.project, null)
  conf_spanner                   = try(local.conf_google.spanner, tomap({}))
  conf_spanner_instance          = try(local.conf_spanner.instance, tomap({}))
  conf_instance_name             = try(local.conf_spanner_instance.name, null)
  conf_instance_configuration    = try(local.conf_spanner_instance.configuration, null)
  conf_instance_processing_units = try(local.conf_spanner_instance.processingUnits, null)

  # Configuration with variable overrides.
  gcp_project_id            = coalesce(var.gcp_project_id, local.conf_google_project)
  instance_name             = coalesce(var.instance_name, local.conf_instance_name)
  instance_configuration    = coalesce(var.instance_configuration, local.conf_instance_configuration)
  instance_processing_units = coalesce(var.instance_processing_units, local.conf_instance_processing_units)
}
