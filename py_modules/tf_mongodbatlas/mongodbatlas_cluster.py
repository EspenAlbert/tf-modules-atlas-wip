# codegen atlas-init-marker-start
import json
import sys
from dataclasses import asdict, dataclass
from typing import Optional, List, Any, Set, ClassVar, Union


@dataclass
class AdvancedConfiguration:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"custom_openssl_cipher_config_tls12"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = set()
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    change_stream_options_pre_and_post_images_expire_after_seconds: Optional[float] = None
    custom_openssl_cipher_config_tls12: Optional[List[str]] = None
    default_max_time_ms: Optional[float] = None
    default_write_concern: Optional[str] = None
    javascript_enabled: Optional[bool] = None
    minimum_enabled_tls_protocol: Optional[str] = None
    no_table_scan: Optional[bool] = None
    oplog_min_retention_hours: Optional[float] = None
    oplog_size_mb: Optional[float] = None
    sample_refresh_interval_bi_connector: Optional[float] = None
    sample_size_bi_connector: Optional[float] = None
    tls_cipher_config_mode: Optional[str] = None
    transaction_lifetime_limit_seconds: Optional[float] = None


@dataclass
class BiConnectorConfig:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = set()
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    enabled: Optional[bool] = None
    read_preference: Optional[str] = None


@dataclass
class Label:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = set()
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    key: Optional[str] = None
    value: Optional[str] = None


@dataclass
class PinnedFcv:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"expiration_date"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {"version"}
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    expiration_date: Optional[str] = None
    version: Optional[str] = None


@dataclass
class RegionsConfig:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"region_name"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    analytics_nodes: Optional[float] = None
    electable_nodes: Optional[float] = None
    priority: Optional[float] = None
    read_only_nodes: Optional[float] = None
    region_name: Optional[str] = None


@dataclass
class ReplicationSpec:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = {"regions_config"}
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"regions_config"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"num_shards"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    num_shards: Optional[float] = None
    zone_name: Optional[str] = None
    regions_config: Optional[Set[RegionsConfig]] = None

    def __post_init__(self):
        if self.regions_config is not None and not isinstance(self.regions_config, RegionsConfig):
            assert isinstance(self.regions_config, dict), (
                f"Expected regions_config to be a RegionsConfig or a dict, got {type(self.regions_config)}"
            )
            self.regions_config = RegionsConfig(**self.regions_config)


@dataclass
class Tag:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"key", "value"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    key: Optional[str] = None
    value: Optional[str] = None


@dataclass
class Timeout:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = set()
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    create: Optional[str] = None
    delete: Optional[str] = None
    update: Optional[str] = None


@dataclass
class Resource:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = {
        "advanced_configuration",
        "bi_connector_config",
        "labels",
        "pinned_fcv",
        "replication_specs",
        "tags",
        "timeouts",
    }
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {
        "advanced_configuration",
        "bi_connector_config",
        "labels",
        "pinned_fcv",
        "replication_specs",
        "tags",
        "timeouts",
    }
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"name", "project_id", "provider_instance_size_name", "provider_name"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {
        "cluster_id",
        "connection_strings",
        "container_id",
        "mongo_db_version",
        "mongo_uri",
        "mongo_uri_updated",
        "mongo_uri_with_options",
        "provider_encrypt_ebs_volume_flag",
        "snapshot_backup_policy",
        "srv_address",
        "state_name",
    }
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    accept_data_risks_and_force_replica_set_reconfig: Optional[str] = None
    auto_scaling_compute_enabled: Optional[bool] = None
    auto_scaling_compute_scale_down_enabled: Optional[bool] = None
    auto_scaling_disk_gb_enabled: Optional[bool] = None
    backing_provider_name: Optional[str] = None
    backup_enabled: Optional[bool] = None
    cloud_backup: Optional[bool] = None
    cluster_id: Optional[str] = None
    cluster_type: Optional[str] = None
    connection_strings: Optional[Any] = None
    container_id: Optional[str] = None
    disk_size_gb: Optional[float] = None
    encryption_at_rest_provider: Optional[str] = None
    mongo_db_major_version: Optional[str] = None
    mongo_db_version: Optional[str] = None
    mongo_uri: Optional[str] = None
    mongo_uri_updated: Optional[str] = None
    mongo_uri_with_options: Optional[str] = None
    name: Optional[str] = None
    num_shards: Optional[float] = None
    paused: Optional[bool] = None
    pit_enabled: Optional[bool] = None
    project_id: Optional[str] = None
    provider_auto_scaling_compute_max_instance_size: Optional[str] = None
    provider_auto_scaling_compute_min_instance_size: Optional[str] = None
    provider_disk_iops: Optional[float] = None
    provider_disk_type_name: Optional[str] = None
    provider_encrypt_ebs_volume_flag: Optional[bool] = None
    provider_instance_size_name: Optional[str] = None
    provider_name: Optional[str] = None
    provider_region_name: Optional[str] = None
    provider_volume_type: Optional[str] = None
    redact_client_log_data: Optional[bool] = None
    replication_factor: Optional[float] = None
    retain_backups_enabled: Optional[bool] = None
    snapshot_backup_policy: Optional[Any] = None
    srv_address: Optional[str] = None
    state_name: Optional[str] = None
    termination_protection_enabled: Optional[bool] = None
    version_release_system: Optional[str] = None
    advanced_configuration: Optional[List[AdvancedConfiguration]] = None
    bi_connector_config: Optional[List[BiConnectorConfig]] = None
    labels: Optional[Set[Label]] = None
    pinned_fcv: Optional[List[PinnedFcv]] = None
    replication_specs: Optional[Set[ReplicationSpec]] = None
    tags: Optional[Set[Tag]] = None
    timeouts: Optional[Timeout] = None

    def __post_init__(self):
        if self.advanced_configuration is not None:
            self.advanced_configuration = [
                x if isinstance(x, AdvancedConfiguration) else AdvancedConfiguration(**x)
                for x in self.advanced_configuration
            ]
        if self.bi_connector_config is not None:
            self.bi_connector_config = [
                x if isinstance(x, BiConnectorConfig) else BiConnectorConfig(**x) for x in self.bi_connector_config
            ]
        if self.labels is not None and not isinstance(self.labels, Label):
            assert isinstance(self.labels, dict), f"Expected labels to be a Label or a dict, got {type(self.labels)}"
            self.labels = Label(**self.labels)
        if self.pinned_fcv is not None:
            self.pinned_fcv = [x if isinstance(x, PinnedFcv) else PinnedFcv(**x) for x in self.pinned_fcv]
        if self.replication_specs is not None and not isinstance(self.replication_specs, ReplicationSpec):
            assert isinstance(self.replication_specs, dict), (
                f"Expected replication_specs to be a ReplicationSpec or a dict, got {type(self.replication_specs)}"
            )
            self.replication_specs = ReplicationSpec(**self.replication_specs)
        if self.tags is not None and not isinstance(self.tags, Tag):
            assert isinstance(self.tags, dict), f"Expected tags to be a Tag or a dict, got {type(self.tags)}"
            self.tags = Tag(**self.tags)
        if self.timeouts is not None and not isinstance(self.timeouts, Timeout):
            assert isinstance(self.timeouts, dict), (
                f"Expected timeouts to be a Timeout or a dict, got {type(self.timeouts)}"
            )
            self.timeouts = Timeout(**self.timeouts)


def format_primitive(value: Union[str, float, bool, int, None]):
    if value is None:
        return None
    if value is True:
        return "true"
    if value is False:
        return "false"
    return str(value)


def main():
    input_data = sys.stdin.read()
    # Parse the input as JSON
    params = json.loads(input_data)
    input_json = params["input_json"]
    resource = Resource(**json.loads(input_json))
    error_message = ""
    primitive_types = (str, float, bool, int)
    output = {
        key: format_primitive(value) if value is None or isinstance(value, primitive_types) else json.dumps(value)
        for key, value in asdict(resource).items()
    }
    output["error_message"] = error_message
    json_str = json.dumps(output)
    print(json_str)


# codegen atlas-init-marker-end

if __name__ == "__main__":
    main()
