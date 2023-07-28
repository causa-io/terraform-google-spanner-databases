output "instance_name" {
  description = "The name of the Cloud Spanner instance."
  value       = google_spanner_instance.instance.name
}

output "database_ids" {
  description = "The ID of each Cloud Spanner database."
  value = [
    for id, database in google_spanner_database.database :
    database.id
  ]
}

output "database_ddls" {
  description = "The DDL of each Cloud Spanner database. This can be used to express a reference dependency on a database, with a Cloud Run service or Cloud Function."
  value = {
    for id, database in google_spanner_database.database :
    id => database.ddl
  }
}
