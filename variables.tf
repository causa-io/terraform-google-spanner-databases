variable "infrastructure_configuration_file" {
  type        = string
  description = "The path to the configuration file for the infrastructure project. It should be in JSON or YAML."
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

variable "deletion_protection" {
  type        = bool
  description = "Whether the Cloud Spanner instance and its databases are protected against deletion. Defaults to `true`."
  default     = true
}
