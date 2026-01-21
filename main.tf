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

  conf_autoscaling                                      = try(local.conf_spanner_instance.autoscaling, null)
  conf_autoscaling_max_processing_units                 = try(local.conf_autoscaling.maxProcessingUnits, null)
  conf_autoscaling_min_processing_units                 = try(local.conf_autoscaling.minProcessingUnits, null)
  conf_autoscaling_high_priority_cpu_utilization_target = try(local.conf_autoscaling.highPriorityCpuUtilizationTarget, null)
  conf_autoscaling_storage_utilization_target           = try(local.conf_autoscaling.storageUtilizationTarget, null)
  conf_instance_edition                                 = try(local.conf_spanner_instance.edition, null)

  conf_database_version_retention_period = try(local.conf_spanner.versionRetentionPeriod, null)

  # Configuration with variable overrides.
  gcp_project_id            = coalesce(var.gcp_project_id, local.conf_google_project)
  instance_name             = coalesce(var.instance_name, local.conf_instance_name)
  instance_configuration    = coalesce(var.instance_configuration, local.conf_instance_configuration)
  instance_processing_units = coalesce(var.instance_processing_units, local.conf_instance_processing_units)
  instance_autoscaling = var.instance_autoscaling != null || local.conf_autoscaling != null ? coalesce(
    var.instance_autoscaling,
    {
      max_processing_units                 = local.conf_autoscaling_max_processing_units
      min_processing_units                 = local.conf_autoscaling_min_processing_units
      high_priority_cpu_utilization_target = local.conf_autoscaling_high_priority_cpu_utilization_target
      storage_utilization_target           = local.conf_autoscaling_storage_utilization_target
    }
  ) : null
  database_version_retention_period = try(
    coalesce(var.database_version_retention_period, local.conf_database_version_retention_period),
    null,
  )
  instance_edition = coalesce(
    var.instance_edition,
    local.conf_instance_edition,
    local.instance_autoscaling != null ? "ENTERPRISE" : "STANDARD",
  )
}
