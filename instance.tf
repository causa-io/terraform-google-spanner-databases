# The Spanner instance for all databases.
resource "google_spanner_instance" "instance" {
  project      = local.gcp_project_id
  config       = local.instance_configuration
  name         = local.instance_name
  display_name = local.instance_name
  edition      = local.instance_edition

  processing_units = local.instance_autoscaling == null ? local.instance_processing_units : null

  dynamic "autoscaling_config" {
    for_each = local.instance_autoscaling != null ? [1] : []

    content {
      autoscaling_limits {
        max_processing_units = local.instance_autoscaling.max_processing_units
        min_processing_units = local.instance_autoscaling.min_processing_units
      }

      autoscaling_targets {
        high_priority_cpu_utilization_percent = local.instance_autoscaling.high_priority_cpu_utilization_target
        storage_utilization_percent           = local.instance_autoscaling.storage_utilization_target
      }
    }
  }

  force_destroy = !var.deletion_protection
}
