# Terraform module for Spanner database management

This module manages a Spanner instance and its child databases, along with their DDLs. It relies on the [`ProjectWriteConfigurations`](https://github.com/causa-io/workspace-module-core#projectwriteconfigurations) and [`GoogleSpannerWriteDatabases`](https://github.com/causa-io/workspace-module-google#googlespannerwritedatabases) infrastructure processor to generate the configuration for the instance and the databases.

## ➕ Requirements

This module depends on the [google Terraform provider](https://registry.terraform.io/providers/hashicorp/google/latest).

## 🎉 Installation

Copy the following in your Terraform configuration, and run `terraform init`:

```terraform
module "my_databases" {
  source  = "causa-io/spanner-databases/google"
  version = "<insert the most recent version number here>"

  # The path to the generated configuration file for the infrastructure project.
  infrastructure_configuration_file = "${local.project_configurations_directory}/infrastructure.json"
  # The path to the generated database configurations.
  databases_directory               = "${local.causa_directory}/spanner-databases"
}
```

## ✨ Features

### Spanner instance

This module creates and manages a Spanner instance. Its configuration can be loaded from the `google.spanner.instance` configuration in the infrastructure project (or its parent workspace configuration), which should be set in the `infrastructure_configuration_file` Terraform variable. The configuration can also be overridden using standard Terraform variables, see the descriptions in the [corresponding file](./variables.tf).

Autoscaling can be enabled for the instance either in the Causa configuration:

```yaml
google:
  spanner:
    instance:
      # Autoscaling will be enabled as long as this property is an object.
      autoscaling:
        # All properties are optional.
        minProcessingUnits: 1000
        maxProcessingUnits: 10000
        highPriorityCpuUtilizationTarget: 65
        storageUtilizationTarget: 90
```

or as a Terraform variable:

```terraform
module "my_databases" {
  # ...

  instance_autoscaling = {
    max_processing_units                 = 1000
    min_processing_units                 = 10000
    high_priority_cpu_utilization_target = 65
    storage_utilization_target           = 90
  }
}
```

### Spanner databases

A Spanner database is created and managed for each database configuration file written by the [`GoogleSpannerWriteDatabases`](https://github.com/causa-io/workspace-module-google#googlespannerwritedatabases) processor at the location set in the `databases_directory` Terraform variable. The databases are found in the workspace as defined in the `google.spanner.ddls` configuration.

### Deletion protection

The `deletion_protection` Terraform variable defaults to `true` and protects both the instance and its databases. It can be set to `false` when it is okay to delete the databases (e.g. in development environments).
