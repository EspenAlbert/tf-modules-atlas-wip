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

module "atlas_project" {
  source = "../../../modules/02_project"
  name   = var.atlas_project_name
  org_id = var.atlas_org_id
  auditing = {
    audit_authorization_success = false
    audit_filter                = local.audit_filter_json
  }
  auditing_enabled = true
  tags             = local.tags
}

module "atlas_cluster" {
  source                 = "../../../modules/01_cluster"
  project_id             = module.atlas_project.id
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

module "automated_backup_test_cluster" {
  source = "../../../modules/01_cluster"

  for_each = {
    "cluster_1" = { name = "m10-aws-1e", region = "US_EAST_1" },
    "cluster_2" = { name = "m10-aws-2e", region = "US_EAST_2" },
  }

  cloud_backup_schedule_enabled = true
  cloud_backup_schedule = {
    copy_settings = [{
      # cloud_provider = "AWS"
      # zone_id inferred inside module
      region_name = "US_WEST_1"
      frequencies = ["HOURLY",
        "DAILY",
        "WEEKLY",
        "MONTHLY",
        "YEARLY",
      "ON_DEMAND"]
      should_copy_oplogs = true
    }]
    policy_item_hourly = [{
      frequency_interval = 1
      retention_unit     = "days"
      retention_value    = 4
    }]
    policy_item_daily = [{
      frequency_interval = 1
      retention_unit     = "days"
      retention_value    = 4
    }]
    policy_item_weekly = [{
      frequency_interval = 4
      retention_unit     = "weeks"
      retention_value    = 4
    }]
    policy_item_monthly = [{
      frequency_interval = 5
      retention_unit     = "months"
      retention_value    = 4
    }]
    policy_item_yearly = [{
      frequency_interval = 1
      retention_unit     = "years"
      retention_value    = 4
    }]
  }

  project_id             = module.atlas_project.id
  name                   = each.value.name
  cluster_type           = "REPLICASET"
  mongo_db_major_version = var.mongodb_version

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

module "alert_configuration" {
  source     = "../../../modules/03_alert_configuration"
  project_id = module.atlas_project.id
  event_type = "REPLICATION_OPLOG_WINDOW_RUNNING_OUT"
  enabled    = true
  matcher = {
    field_name = "CLUSTER_NAME"
    operator   = "EQUALS"
    value      = local.clusterWithAlertsName
  }
  notification = {
    type_name     = "GROUP"
    interval_min  = 5
    delay_min     = 1
    sms_enabled   = false
    email_enabled = true
    roles         = ["GROUP_CLUSTER_MANAGER"]
  }
  threshold_config = {
    operator  = "LESS_THAN"
    threshold = 1
    units     = "HOURS"
  }
}
