output "instance_name" {
  description = "The name of the Cloud Spanner instance."
  value       = google_spanner_instance.instance.name
}
