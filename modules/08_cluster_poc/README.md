# Cluster Module PoC
- This module maps all the attributes of [`mongodbatlas_advanced_cluster (preview provider 2.0.0)`](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/advanced_cluster%2520%2528preview%2520provider%25202.0.0%2529) to [variables.tf](variables.tf).
- Remember to set the `export MONGODB_ATLAS_ADVANCED_CLUSTER_V2_SCHEMA=true` in your terminal before running `terraform` commands.
- All deprecated fields are removed
- The module supports either `auto_scaling` or setting `instance_size` on root level or in each `region`


## Known Limitations (not prioritized due to limited time)
- Only supports `disk_size_gb` at root level
- No support for `disk_iops` or `ebs_volume_type`

<!-- BEGIN_DISCLAIMER -->
## Disclaimer
This Module is not meant for external consumption.
It is part of a development PoC.
Any usage problems will not be supported.
However, if you have any ideas or feedback, feel free to open a Github Issue!

<!-- END_DISCLAIMER -->

<!-- BEGIN_MODULES -->
## Modules

### Modules Instances
```sh
Module Instances
├── 1️⃣  cloud_backup_schedule
│   └── ./modules/cloud_backup_schedule
└── 2️⃣  search_deployment
    └── ./modules/search_deployment
```
### Module Definitions

```sh
cloud_backup_schedule (1️⃣)
└── mongodbatlas_search_deployment.this
search_deployment (2️⃣)
└── mongodbatlas_search_deployment.this
```

### Graph with Dependencies
Any resource without a number prefix is defined at the root level.

```mermaid
graph TD
    cloud_backup_schedule["1️⃣ cloud_backup_schedule"]
    mongodbatlas_advanced_cluster.this["mongodbatlas_advanced_cluster.this"]
    search_deployment["2️⃣ search_deployment"]
    mongodbatlas_advanced_cluster.this --> cloud_backup_schedule
    mongodbatlas_advanced_cluster.this --> search_deployment
```
<!-- END_MODULES -->

<!-- BEGIN_TF_EXAMPLES -->
# Examples
## [01 Single Region](./examples/01_single_region)

```terraform
module "cluster" {
  source = "../.."

  name                   = "single-region"
  project_id             = var.project_id
  mongo_db_major_version = "8.0"
  regions = [
    {
      name          = "US_EAST_1"
      node_count    = 3
      provider_name = "AWS"
    }
  ]
  auto_scaling = {
    compute_enabled            = true
    compute_max_instance_size  = "M60"
    compute_min_instance_size  = "M30"
    compute_scale_down_enabled = true
    disk_gb_enabled            = true
  }
}

output "cluster" {
  value = module.cluster
}

```


## [02 Single Region Sharded](./examples/02_single_region_sharded)

```terraform
module "cluster" {
  source = "../.."

  name       = "single-region-sharded"
  project_id = var.project_id
  regions = [
    {
      name          = "US_EAST_1"
      node_count    = 3
      shard_index   = 0
      instance_size = "M40"
      }, {
      name          = "US_EAST_1"
      node_count    = 3
      shard_index   = 1
      instance_size = "M30"
    }
  ]
  provider_name = "AWS"
}

output "cluster" {
  value = module.cluster
}

```


## [03 Single Region With Analytics](./examples/03_single_region_with_analytics)

```terraform
module "cluster" {
  source = "../.."

  name       = "single-region-with-analytics"
  project_id = var.project_id
  regions = [
    {
      name                 = "US_EAST_1"
      node_count           = 3
      provider_name        = "AWS"
      node_count_analytics = 1
    }
  ]
  auto_scaling = {
    compute_enabled            = true
    compute_max_instance_size  = "M60"
    compute_min_instance_size  = "M30"
    compute_scale_down_enabled = true
    disk_gb_enabled            = true
  }
  auto_scaling_analytics = {
    compute_enabled            = true
    compute_max_instance_size  = "M30"
    compute_min_instance_size  = "M10"
    compute_scale_down_enabled = true
    disk_gb_enabled            = true
  }
}

output "cluster" {
  value = module.cluster
}

```


## [04 Multi Region Single Geo](./examples/04_multi_region_single_geo)

```terraform
module "cluster" {
  source = "../.."

  name                   = "multi-region-single-geo"
  project_id             = var.project_id
  mongo_db_major_version = "8.0"
  regions = [
    {
      name       = "US_EAST_1"
      node_count = 2
      }, {
      name                 = "US_EAST_2"
      node_count           = 1
      node_count_read_only = 2
    }
  ]
  provider_name = "AWS"
  auto_scaling = {
    compute_enabled            = true
    compute_max_instance_size  = "M60"
    compute_min_instance_size  = "M30"
    compute_scale_down_enabled = true
    disk_gb_enabled            = true
  }
}

output "cluster" {
  value = module.cluster
}

```


## [05 Multi Region Multi Geo](./examples/05_multi_region_multi_geo)

```terraform
module "cluster" {
  source = "../.."

  name       = "multi-region-multi-geo"
  project_id = var.project_id
  regions = [
    {
      name        = "US_EAST_1"
      node_count  = 3
      shard_index = 0
      }, {
      name        = "EU_WEST_1"
      node_count  = 2
      shard_index = 1
    }
  ]
  provider_name = "AWS"
  auto_scaling = {
    compute_enabled            = true
    compute_max_instance_size  = "M60"
    compute_min_instance_size  = "M30"
    compute_scale_down_enabled = true
    disk_gb_enabled            = true
  }
}

```


## [06 Multi Geo Zone Sharded](./examples/06_multi_geo_zone_sharded)

```terraform
module "cluster" {
  source = "../.."

  name                   = "multi-geo-zone-sharded"
  project_id             = var.project_id
  mongo_db_major_version = "8.0"
  regions = [
    {
      name       = "US_EAST_1"
      node_count = 3
      zone_name  = "US"
      }, {
      name       = "EU_WEST_1"
      node_count = 3
      zone_name  = "EU"
    }
  ]
  provider_name = "AWS"
  auto_scaling = {
    compute_enabled            = true
    compute_max_instance_size  = "M60"
    compute_min_instance_size  = "M30"
    compute_scale_down_enabled = true
    disk_gb_enabled            = true
  }
}

output "cluster" {
  value = module.cluster
}

```


## [07 Multi Cloud](./examples/07_multi_cloud)

```terraform
module "cluster" {
  source = "../.."

  name       = "multi-cloud"
  project_id = var.project_id
  regions = [
    {
      name                 = "US_WEST_2"
      node_count           = 2
      shard_index          = 0
      node_count_read_only = 2
      provider_name        = "AZURE"
      }, {
      name                 = "US_EAST_2"
      node_count           = 1
      shard_index          = 0
      provider_name        = "AWS"
      node_count_read_only = 2
    },
    {
      name                 = "US_WEST_2"
      node_count           = 2
      shard_index          = 1
      node_count_read_only = 2
      provider_name        = "AZURE"
      }, {
      name                 = "US_EAST_2"
      node_count           = 1
      shard_index          = 1
      provider_name        = "AWS"
      node_count_read_only = 2
    }
  ]
  auto_scaling = {
    compute_enabled            = true
    compute_max_instance_size  = "M60"
    compute_min_instance_size  = "M30"
    compute_scale_down_enabled = true
    disk_gb_enabled            = true
  }
}

output "cluster" {
  value = module.cluster
}

```


## [08 Dev](./examples/08_dev)

```terraform
module "cluster" {
  source = "../.."

  name       = "dev"
  project_id = var.project_id
  regions = [
    {
      name          = "US_EAST_1"
      node_count    = 3
      instance_size = "M10"
    }
  ]
  provider_name = "AWS"
}

output "cluster" {
  value = module.cluster
}

```


## [09 Replication Var](./examples/09_replication_var)

```terraform
module "replication_var" {
  source = "../.."

  name                   = "replication-var"
  project_id             = var.project_id
  mongo_db_major_version = "8.0"
  regions                = []
  replication_specs = [{
    region_configs = [{
      priority      = 7
      provider_name = "AWS"
      region_name   = "US_EAST_1"
      electable_specs = {
        instance_size = "M10"
        node_count    = 3
      }
    }]
  }]
}

```


<!-- END_TF_EXAMPLES -->

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8 |
| <a name="requirement_mongodbatlas"></a> [mongodbatlas](#requirement\_mongodbatlas) | ~> 1.26 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_mongodbatlas"></a> [mongodbatlas](#provider\_mongodbatlas) | 1.40.0 |

## Resources

| Name | Type |
|------|------|
| [mongodbatlas_advanced_cluster.this](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/advanced_cluster%2520%2528preview%2520provider%25202.0.0%2529) | resource |
| [mongodbatlas_advanced_clusters.this](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/data-sources/advanced_clusters) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Human-readable label that identifies this cluster. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Unique 24-hexadecimal digit string that identifies your project. Use the [/groups](#tag/Projects/operation/listProjects) endpoint to retrieve all projects to which the authenticated user has access.<br/><br/>**NOTE**: Groups and projects are synonymous terms. Your group id is the same as your project id. For existing groups, your group/project id remains the same. The resource and corresponding endpoints use the term groups. | `string` | n/a | yes |
| <a name="input_regions"></a> [regions](#input\_regions) | The simplest way to define your cluster topology.<br/>By default REPLICASET cluster.<br/>Use `shard_index` for SHARDED cluster.<br/>Use `zone_name` for GEOSHARDED cluster. | <pre>list(object({<br/>    name                    = optional(string)<br/>    node_count              = optional(number)<br/>    shard_index             = optional(number)<br/>    provider_name           = optional(string)<br/>    node_count_read_only    = optional(number)<br/>    node_count_analytics    = optional(number)<br/>    instance_size           = optional(string)<br/>    instance_size_analytics = optional(string)<br/>    zone_name               = optional(string)<br/>  }))</pre> | n/a | yes |
| <a name="input_accept_data_risks_and_force_replica_set_reconfig"></a> [accept\_data\_risks\_and\_force\_replica\_set\_reconfig](#input\_accept\_data\_risks\_and\_force\_replica\_set\_reconfig) | If reconfiguration is necessary to regain a primary due to a regional outage, submit this field alongside your topology reconfiguration to request a new regional outage resistant topology. Forcedreconfigurations during an outage of the majority of electable nodes carry a risk of data loss if replicated writes (even majority committed writes) have not been replicated to the new primary node. MongoDB Atlas docs contain more information. To proceed with an operation which carries that risk, set **acceptDataRisksAndForceReplicaSetReconfig** to the current date. | `string` | `null` | no |
| <a name="input_advanced_configuration"></a> [advanced\_configuration](#input\_advanced\_configuration) | Additional settings for an Atlas cluster. | <pre>object({<br/>    change_stream_options_pre_and_post_images_expire_after_seconds = optional(number)<br/>    custom_openssl_cipher_config_tls12                             = optional(list(string))<br/>    default_max_time_ms                                            = optional(number)<br/>    default_write_concern                                          = optional(string, "majority")<br/>    javascript_enabled                                             = optional(bool, false)<br/>    minimum_enabled_tls_protocol                                   = optional(string, "TLS1_2")<br/>    no_table_scan                                                  = optional(bool)<br/>    oplog_min_retention_hours                                      = optional(number)<br/>    oplog_size_mb                                                  = optional(number)<br/>    sample_refresh_interval_bi_connector                           = optional(number)<br/>    sample_size_bi_connector                                       = optional(number)<br/>    tls_cipher_config_mode                                         = optional(string)<br/>    transaction_lifetime_limit_seconds                             = optional(number)<br/>  })</pre> | <pre>{<br/>  "default_write_concern": "majority",<br/>  "javascript_enabled": false,<br/>  "minimum_enabled_tls_protocol": "TLS1_2"<br/>}</pre> | no |
| <a name="input_auto_scaling"></a> [auto\_scaling](#input\_auto\_scaling) | Auto scaling config for electable/read-only specs. | <pre>object({<br/>    compute_enabled            = optional(bool)<br/>    compute_max_instance_size  = optional(string)<br/>    compute_min_instance_size  = optional(string)<br/>    compute_scale_down_enabled = optional(bool)<br/>    disk_gb_enabled            = optional(bool)<br/>  })</pre> | `null` | no |
| <a name="input_auto_scaling_analytics"></a> [auto\_scaling\_analytics](#input\_auto\_scaling\_analytics) | Auto scaling config for analytics specs. | <pre>object({<br/>    compute_enabled            = optional(bool)<br/>    compute_max_instance_size  = optional(string)<br/>    compute_min_instance_size  = optional(string)<br/>    compute_scale_down_enabled = optional(bool)<br/>    disk_gb_enabled            = optional(bool)<br/>  })</pre> | `null` | no |
| <a name="input_backup_enabled"></a> [backup\_enabled](#input\_backup\_enabled) | Flag that indicates whether the cluster can perform backups. If set to `true`, the cluster can perform backups. You must set this value to `true` for NVMe clusters. Backup uses [Cloud Backups](https://docs.atlas.mongodb.com/backup/cloud-backup/overview/) for dedicated clusters and [Shared Cluster Backups](https://docs.atlas.mongodb.com/backup/shared-tier/overview/) for tenant clusters. If set to `false`, the cluster doesn't use backups. | `bool` | `true` | no |
| <a name="input_bi_connector_config"></a> [bi\_connector\_config](#input\_bi\_connector\_config) | Settings needed to configure the MongoDB Connector for Business Intelligence for this cluster. | <pre>object({<br/>    enabled         = optional(bool)<br/>    read_preference = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_cloud_backup_schedule"></a> [cloud\_backup\_schedule](#input\_cloud\_backup\_schedule) | duplicate of the one in modules/cloud\_backup\_schedule/variables.tf | <pre>object({<br/>    auto_export_enabled                      = optional(bool)<br/>    reference_hour_of_day                    = optional(number)<br/>    reference_minute_of_hour                 = optional(number)<br/>    restore_window_days                      = optional(number)<br/>    update_snapshots                         = optional(bool)<br/>    use_org_and_group_names_in_export_prefix = optional(bool)<br/>    copy_settings = optional(list(object({<br/>      cloud_provider     = optional(string) # "AWS" | "GCP" | "AZURE"<br/>      frequencies        = optional(list(string))<br/>      region_name        = optional(string)<br/>      should_copy_oplogs = optional(bool)<br/>      zone_id            = optional(string)<br/>    })))<br/>    export = optional(list(object({<br/>      export_bucket_id = optional(string)<br/>      frequency_type   = optional(string)<br/>    })))<br/>    policy_item_daily = optional(list(object({<br/>      frequency_interval = number<br/>      retention_unit     = string<br/>      retention_value    = number<br/>    })))<br/>    policy_item_hourly = optional(list(object({<br/>      frequency_interval = number<br/>      retention_unit     = string<br/>      retention_value    = number<br/>    })))<br/>    policy_item_monthly = optional(list(object({<br/>      frequency_interval = number<br/>      retention_unit     = string<br/>      retention_value    = number<br/>    })))<br/>    policy_item_weekly = optional(list(object({<br/>      frequency_interval = number<br/>      retention_unit     = string<br/>      retention_value    = number<br/>    })))<br/>    policy_item_yearly = optional(list(object({<br/>      frequency_interval = number<br/>      retention_unit     = string<br/>      retention_value    = number<br/>    })))<br/>  })</pre> | `null` | no |
| <a name="input_cloud_backup_schedule_enabled"></a> [cloud\_backup\_schedule\_enabled](#input\_cloud\_backup\_schedule\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_cluster_type"></a> [cluster\_type](#input\_cluster\_type) | Inferred if not set. REPLICASET/SHARDED/GEOSHARDED | `string` | `null` | no |
| <a name="input_config_server_management_mode"></a> [config\_server\_management\_mode](#input\_config\_server\_management\_mode) | Config Server Management Mode for creating or updating a sharded cluster.<br/><br/>When configured as ATLAS\_MANAGED, atlas may automatically switch the cluster's config server type for optimal performance and savings.<br/><br/>When configured as FIXED\_TO\_DEDICATED, the cluster will always use a dedicated config server. | `string` | `null` | no |
| <a name="input_delete_on_create_timeout"></a> [delete\_on\_create\_timeout](#input\_delete\_on\_create\_timeout) | Flag that indicates whether to delete the cluster if the cluster creation times out. Default is false. | `bool` | `null` | no |
| <a name="input_disk_size_gb"></a> [disk\_size\_gb](#input\_disk\_size\_gb) | Storage capacity of instance data volumes expressed in gigabytes. Increase this number to add capacity.<br/><br/> This value must be equal for all shards and node types.<br/><br/> This value is not configurable on M0/M2/M5 clusters.<br/><br/> MongoDB Cloud requires this parameter if you set **replicationSpecs**.<br/><br/> If you specify a disk size below the minimum (10 GB), this parameter defaults to the minimum disk size value. <br/><br/> Storage charge calculations depend on whether you choose the default value or a custom value.<br/><br/> The maximum value for disk storage cannot exceed 50 times the maximum RAM for the selected cluster. If you require more storage space, consider upgrading your cluster to a higher tier. | `number` | `null` | no |
| <a name="input_encryption_at_rest_provider"></a> [encryption\_at\_rest\_provider](#input\_encryption\_at\_rest\_provider) | Cloud service provider that manages your customer keys to provide an additional layer of encryption at rest for the cluster. To enable customer key management for encryption at rest, the cluster **replicationSpecs[n].regionConfigs[m].{type}Specs.instanceSize** setting must be `M10` or higher and `"backupEnabled" : false` or omitted entirely. | `string` | `null` | no |
| <a name="input_global_cluster_self_managed_sharding"></a> [global\_cluster\_self\_managed\_sharding](#input\_global\_cluster\_self\_managed\_sharding) | Set this field to configure the Sharding Management Mode when creating a new Global Cluster.<br/><br/>When set to false, the management mode is set to Atlas-Managed Sharding. This mode fully manages the sharding of your Global Cluster and is built to provide a seamless deployment experience.<br/><br/>When set to true, the management mode is set to Self-Managed Sharding. This mode leaves the management of shards in your hands and is built to provide an advanced and flexible deployment experience.<br/><br/>This setting cannot be changed once the cluster is deployed. | `bool` | `null` | no |
| <a name="input_instance_size"></a> [instance\_size](#input\_instance\_size) | Default instance\_size in electable/read-only specs. Do not set if using auto\_scaling. | `string` | `null` | no |
| <a name="input_instance_size_analytics"></a> [instance\_size\_analytics](#input\_instance\_size\_analytics) | Default instance\_size in analytics specs. Do not set if using auto\_scaling\_analytics. | `string` | `null` | no |
| <a name="input_mongo_db_major_version"></a> [mongo\_db\_major\_version](#input\_mongo\_db\_major\_version) | MongoDB major version of the cluster.<br/><br/>On creation: Choose from the available versions of MongoDB, or leave unspecified for the current recommended default in the MongoDB Cloud platform. The recommended version is a recent Long Term Support version. The default is not guaranteed to be the most recently released version throughout the entire release cycle. For versions available in a specific project, see the linked documentation or use the API endpoint for [project LTS versions endpoint](#tag/Projects/operation/getProjectLTSVersions).<br/><br/> On update: Increase version only by 1 major version at a time. If the cluster is pinned to a MongoDB feature compatibility version exactly one major version below the current MongoDB version, the MongoDB version can be downgraded to the previous major version. | `string` | `null` | no |
| <a name="input_paused"></a> [paused](#input\_paused) | Flag that indicates whether the cluster is paused. | `bool` | `null` | no |
| <a name="input_pinned_fcv"></a> [pinned\_fcv](#input\_pinned\_fcv) | Pins the Feature Compatibility Version (FCV) to the current MongoDB version with a provided expiration date. To unpin the FCV the `pinned_fcv` attribute must be removed. This operation can take several minutes as the request processes through the MongoDB data plane. Once FCV is unpinned it will not be possible to downgrade the `mongo_db_major_version`. It is advised that updates to `pinned_fcv` are done isolated from other cluster changes. If a plan contains multiple changes, the FCV change will be applied first. If FCV is unpinned past the expiration date the `pinned_fcv` attribute must be removed. The following [knowledge hub article](https://kb.corp.mongodb.com/article/000021785/) and [FCV documentation](https://www.mongodb.com/docs/atlas/tutorial/major-version-change/#manage-feature-compatibility--fcv--during-upgrades) can be referenced for more details. | <pre>object({<br/>    expiration_date = string<br/>  })</pre> | `null` | no |
| <a name="input_pit_enabled"></a> [pit\_enabled](#input\_pit\_enabled) | Flag that indicates whether the cluster uses continuous cloud backups. | `bool` | `null` | no |
| <a name="input_provider_name"></a> [provider\_name](#input\_provider\_name) | AWS/AZURE/GCP, setting this on the root level, will use it inside of each `region` | `string` | `null` | no |
| <a name="input_redact_client_log_data"></a> [redact\_client\_log\_data](#input\_redact\_client\_log\_data) | Enable or disable log redaction.<br/><br/>This setting configures the `mongod` or `mongos` to redact any document field contents from a message accompanying a given log event before logging.This prevents the program from writing potentially sensitive data stored on the database to the diagnostic log. Metadata such as error or operation codes, line numbers, and source file names are still visible in the logs.<br/><br/>Use `redactClientLogData` in conjunction with Encryption at Rest and TLS/SSL (Transport Encryption) to assist compliance with regulatory requirements.<br/><br/>*Note*: changing this setting on a cluster will trigger a rolling restart as soon as the cluster is updated. | `bool` | `null` | no |
| <a name="input_replica_set_scaling_strategy"></a> [replica\_set\_scaling\_strategy](#input\_replica\_set\_scaling\_strategy) | Set this field to configure the replica set scaling mode for your cluster.<br/><br/>By default, Atlas scales under WORKLOAD\_TYPE. This mode allows Atlas to scale your analytics nodes in parallel to your operational nodes.<br/><br/>When configured as SEQUENTIAL, Atlas scales all nodes sequentially. This mode is intended for steady-state workloads and applications performing latency-sensitive secondary reads. | `string` | `null` | no |
| <a name="input_replication_specs"></a> [replication\_specs](#input\_replication\_specs) | List of settings that configure your cluster regions. This array has one object per shard representing node configurations in each shard. For replica sets there is only one object representing node configurations. | <pre>list(object({<br/>    region_configs = list(object({<br/>      analytics_auto_scaling = optional(object({<br/>        compute_enabled            = optional(bool)<br/>        compute_max_instance_size  = optional(string)<br/>        compute_min_instance_size  = optional(string)<br/>        compute_scale_down_enabled = optional(bool)<br/>        disk_gb_enabled            = optional(bool)<br/>      }))<br/>      analytics_specs = optional(object({<br/>        disk_iops       = optional(number)<br/>        disk_size_gb    = optional(number)<br/>        ebs_volume_type = optional(string)<br/>        instance_size   = optional(string)<br/>        node_count      = optional(number)<br/>      }))<br/>      auto_scaling = optional(object({<br/>        compute_enabled            = optional(bool)<br/>        compute_max_instance_size  = optional(string)<br/>        compute_min_instance_size  = optional(string)<br/>        compute_scale_down_enabled = optional(bool)<br/>        disk_gb_enabled            = optional(bool)<br/>      }))<br/>      backing_provider_name = optional(string)<br/>      electable_specs = optional(object({<br/>        disk_iops       = optional(number)<br/>        disk_size_gb    = optional(number)<br/>        ebs_volume_type = optional(string)<br/>        instance_size   = optional(string)<br/>        node_count      = optional(number)<br/>      }))<br/>      priority      = number<br/>      provider_name = string<br/>      read_only_specs = optional(object({<br/>        disk_iops       = optional(number)<br/>        disk_size_gb    = optional(number)<br/>        ebs_volume_type = optional(string)<br/>        instance_size   = optional(string)<br/>        node_count      = optional(number)<br/>      }))<br/>      region_name = string<br/>    }))<br/>    zone_name = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_retain_backups_enabled"></a> [retain\_backups\_enabled](#input\_retain\_backups\_enabled) | Flag that indicates whether to retain backup snapshots for the deleted dedicated cluster. | `bool` | `true` | no |
| <a name="input_root_cert_type"></a> [root\_cert\_type](#input\_root\_cert\_type) | Root Certificate Authority that MongoDB Cloud cluster uses. MongoDB Cloud supports Internet Security Research Group. | `string` | `null` | no |
| <a name="input_search_deployment"></a> [search\_deployment](#input\_search\_deployment) | n/a | <pre>object({<br/>    specs = list(object({<br/>      instance_size = string<br/>      node_count    = number<br/>    }))<br/>    delete_on_create_timeout = optional(bool, true)<br/>    skip_wait_on_update      = optional(bool, false)<br/>    timeouts = optional(object({<br/>      create = optional(string)<br/>      delete = optional(string)<br/>      update = optional(string)<br/>    }))<br/>  })</pre> | `null` | no |
| <a name="input_search_deployment_enabled"></a> [search\_deployment\_enabled](#input\_search\_deployment\_enabled) | # CONDITIONAL RESOURCES | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map that contains key-value pairs between 1 to 255 characters in length for tagging and categorizing the cluster. | `map(any)` | `null` | no |
| <a name="input_termination_protection_enabled"></a> [termination\_protection\_enabled](#input\_termination\_protection\_enabled) | Flag that indicates whether termination protection is enabled on the cluster. If set to `true`, MongoDB Cloud won't delete the cluster. If set to `false`, MongoDB Cloud will delete the cluster. | `bool` | `null` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | Timeouts for create/update/delete operations. | <pre>object({<br/>    create = optional(string)<br/>    delete = optional(string)<br/>    update = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_version_release_system"></a> [version\_release\_system](#input\_version\_release\_system) | Method by which the cluster maintains the MongoDB versions. If value is `CONTINUOUS`, you must not specify **mongoDBMajorVersion**. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | Unique 24-hexadecimal digit string that identifies the cluster. |
| <a name="output_config_server_type"></a> [config\_server\_type](#output\_config\_server\_type) | Describes a sharded cluster's config server type. |
| <a name="output_connection_strings"></a> [connection\_strings](#output\_connection\_strings) | Collection of Uniform Resource Locators that point to the MongoDB database. |
| <a name="output_create_date"></a> [create\_date](#output\_create\_date) | Date and time when MongoDB Cloud created this cluster. This parameter expresses its value in ISO 8601 format in UTC. |
| <a name="output_mongo_db_version"></a> [mongo\_db\_version](#output\_mongo\_db\_version) | Version of MongoDB that the cluster runs. |
| <a name="output_state_name"></a> [state\_name](#output\_state\_name) | Human-readable label that indicates the current operating condition of this cluster. |
<!-- END_TF_DOCS -->
