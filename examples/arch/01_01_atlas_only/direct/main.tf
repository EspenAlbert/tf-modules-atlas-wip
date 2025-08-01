# source/includes/examples/tf-example-complete-staging-prod.tf

locals {
  tags = {
    "BU"       = "ConsumerProducts"
    "TeamName" = "TeamA"
    "AppName"  = "ProductManagementApp"
    "Env"      = var.environment
    "Version"  = "8.0"
    "Email"    = "marissa@acme.com"
  }
  clusterWithAlertsName = "ClusterPortalProd"
  audit_filter_json = jsonencode({
    atype = "authenticate"
    param = {
      user      = "auditAdmin"
      db        = "admin"
      mechanism = "SCRAM-SHA-1"
    }
  })
}

# Create a Project
resource "mongodbatlas_project" "atlas_project" {
  org_id = var.atlas_org_id
  name   = var.atlas_project_name
}

# Create an Atlas Advanced Cluster
resource "mongodbatlas_advanced_cluster" "atlas_cluster" {
  project_id             = mongodbatlas_project.atlas_project.id
  name                   = local.clusterWithAlertsName
  cluster_type           = "REPLICASET"
  mongo_db_major_version = var.mongodb_version

  replication_specs = [{
    region_configs = [{
      electable_specs = {
        instance_size = var.cluster_instance_size_name
        node_count    = 3
      }
      priority      = 7
      provider_name = var.cloud_provider
      region_name   = var.atlas_region
    }]
  }]
  tags = local.tags
}

# Set up an alert notification when REPLICATION_OPLOG_WINDOW_RUNNING_OUT is greater than 1 hour for more than 5 minutes
resource "mongodbatlas_alert_configuration" "test_replication_lag_alert" {
  project_id = mongodbatlas_project.atlas_project.id
  event_type = "REPLICATION_OPLOG_WINDOW_RUNNING_OUT"
  enabled    = true

  notification {
    type_name     = "GROUP"
    interval_min  = 5
    delay_min     = 1
    sms_enabled   = false
    email_enabled = true
    roles         = ["GROUP_CLUSTER_MANAGER"]
  }

  matcher {
    field_name = "CLUSTER_NAME"
    operator   = "EQUALS"
    value      = local.clusterWithAlertsName
  }

  threshold_config {
    operator  = "LESS_THAN"
    threshold = 1
    units     = "HOURS"
  }
}

# Enable auditing and create an audit filter for your cluster
resource "mongodbatlas_auditing" "test" {
  project_id                  = mongodbatlas_project.atlas_project.id
  audit_filter                = local.audit_filter_json
  audit_authorization_success = false
  enabled                     = true
}

# Configure backup schedule
locals {
  atlas_clusters = {
    "cluster_1" = { name = "m10-aws-1e", region = "US_EAST_1" },
    "cluster_2" = { name = "m10-aws-2e", region = "US_EAST_2" },
  }
}

resource "mongodbatlas_advanced_cluster" "automated_backup_test_cluster" {
  for_each     = local.atlas_clusters
  project_id   = mongodbatlas_project.atlas_project.id
  name         = each.value.name
  cluster_type = "REPLICASET"

  replication_specs = [{
    region_configs = [{
      electable_specs = {
        instance_size = "M10"
        node_count    = 3
      }
      analytics_specs = {
        instance_size = "M10"
        node_count    = 1
      }

      provider_name = "AWS"
      region_name   = each.value.region
      priority      = 7
    }]
  }]

  backup_enabled = true # enable cloud backup snapshots
  pit_enabled    = true
}

resource "mongodbatlas_cloud_backup_schedule" "test" {
  for_each                 = local.atlas_clusters
  project_id               = mongodbatlas_project.atlas_project.id
  cluster_name             = mongodbatlas_advanced_cluster.automated_backup_test_cluster[each.key].name
  reference_hour_of_day    = 3
  reference_minute_of_hour = 45
  restore_window_days      = 4

  copy_settings {
    cloud_provider = var.cloud_provider
    frequencies = ["HOURLY",
      "DAILY",
      "WEEKLY",
      "MONTHLY",
      "YEARLY",
    "ON_DEMAND"]
    region_name        = "US_WEST_1"
    zone_id            = mongodbatlas_advanced_cluster.automated_backup_test_cluster[each.key].replication_specs[0].zone_id
    should_copy_oplogs = true
  }

  policy_item_hourly {
    frequency_interval = 1 #accepted values = 1, 2, 4, 6, 8, 12 -> every n hours
    retention_unit     = "days"
    retention_value    = 4
  }
  policy_item_daily {
    frequency_interval = 1 #accepted values = 1 -> every 1 day
    retention_unit     = "days"
    retention_value    = 4
  }
  policy_item_weekly {
    frequency_interval = 4 # accepted values = 1 to 7 -> every 1=Monday,2=Tuesday,3=Wednesday,4=Thursday,5=Friday,6=Saturday,7=Sunday day of the week
    retention_unit     = "weeks"
    retention_value    = 4
  }
  policy_item_monthly {
    frequency_interval = 5 # accepted values = 1 to 28 -> 1 to 28 every nth day of the month
    # accepted values = 40 -> every last day of the month
    retention_unit  = "months"
    retention_value = 4
  }
  policy_item_yearly {
    frequency_interval = 1 # accepted values = 1 to 12 -> 1st day of nth month
    retention_unit     = "years"
    retention_value    = 4
  }

  depends_on = [
    mongodbatlas_advanced_cluster.automated_backup_test_cluster
  ]
}
