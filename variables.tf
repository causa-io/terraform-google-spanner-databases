variable "infrastructure_configuration_file" {
  type        = string
  description = "The path to the configuration file for the infrastructure project. It should be in JSON or YAML."
}

variable "databases_directory" {
  type        = string
  description = "The path to the directory containing the Spanner database configurations."
}

variable "gcp_project_id" {
  type        = string
  description = "The GCP project ID in which resources will be placed. Defaults to the `google.project` configuration."
  default     = null
}

variable "instance_name" {
  type        = string
  description = "The name of the Cloud Spanner instance. Defaults to the `google.spanner.instance.name` configuration."
  default     = null
}

variable "instance_configuration" {
  type        = string
  description = "The name of the Cloud Spanner instance geographic configuration. Defaults to the `google.spanner.instance.configuration` configuration."
  default     = null
}

variable "instance_processing_units" {
  type        = number
  description = "The number of processing units allocated to the Cloud Spanner instance. Defaults to the `google.spanner.instance.processingUnits` configuration."
  default     = null
}

variable "database_version_retention_period" {
  type        = string
  description = "The retention period for the database. Defaults to the `google.spanner.versionRetentionPeriod` configuration. For database-level configuration, set the period in the DDL instead."
  default     = null
}

variable "instance_autoscaling" {
  type = object({
    max_processing_units                 = optional(number)
    min_processing_units                 = optional(number)
    high_priority_cpu_utilization_target = optional(number)
    storage_utilization_target           = optional(number)
  })
  description = "The autoscaling configuration for the Cloud Spanner instance. Targets are in percent. Defaults to the `google.spanner.instance.autoscaling` configuration."
  default     = null
}

variable "instance_edition" {
  type        = string
  description = "The edition for the Cloud Spanner instance. Defaults to the `google.spanner.instance.edition` configuration. If not set, defaults to `STANDARD` when autoscaling is disabled, or `ENTERPRISE` when autoscaling is enabled."
  default     = null
}

variable "deletion_protection" {
  type        = bool
  description = "Whether the Cloud Spanner instance and its databases are protected against deletion. Defaults to `true`."
  default     = true
}
