# 🔖 Changelog

## Unreleased

Features:

- Support configuring the instance edition. Defaults to standard, unless autoscaling is enabled, in which case it defaults to enterprise.

## v0.3.2 (2025-09-12)

Chores:

- Upgrade compatible `google` provider versions to support `7.*.*`.

## v0.3.1 (2024-08-30)

Chores:

- Upgrade compatible `google` provider versions to support `6.*.*`.

## v0.3.0 (2024-05-30)

Features:

- Support setting the database version retention period for all databases.

## v0.2.0 (2024-05-24)

Features:

- Support instance autoscaling.

## v0.1.2 (2024-02-21)

Chores:

- Upgrade compatible `google` provider versions to support `5.*.*`.

## v0.1.1 (2023-07-28)

Fixes:

- Set the GCP project on the Spanner database resources according to the configuration.

## v0.1.0 (2023-07-28)

Features:

- Implement the first version of the Spanner databases module, managing a Spanner instance, its databases, and their DDLs.
