# codegen atlas-init-marker-start
import json
import sys
from dataclasses import asdict, dataclass
from typing import Optional, Dict, Any, Set, ClassVar, Union


@dataclass
class BackupSetting:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = set()
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {"enabled"}
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    enabled: Optional[bool] = None


@dataclass
class ConnectionString:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = set()
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {"standard", "standard_srv"}
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    standard: Optional[str] = None
    standard_srv: Optional[str] = None


@dataclass
class ProviderSetting:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"backing_provider_name", "region_name"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {"disk_size_gb", "provider_name"}
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    backing_provider_name: Optional[str] = None
    disk_size_gb: Optional[float] = None
    provider_name: Optional[str] = None
    region_name: Optional[str] = None


@dataclass
class Resource:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"backup_settings", "connection_strings", "provider_settings", "tags"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"name", "project_id", "provider_settings"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {
        "backup_settings",
        "cluster_type",
        "connection_strings",
        "create_date",
        "mongo_db_version",
        "state_name",
        "version_release_system",
    }
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    backup_settings: Optional[BackupSetting] = None
    cluster_type: Optional[str] = None
    connection_strings: Optional[ConnectionString] = None
    create_date: Optional[str] = None
    mongo_db_version: Optional[str] = None
    name: Optional[str] = None
    project_id: Optional[str] = None
    provider_settings: Optional[ProviderSetting] = None
    state_name: Optional[str] = None
    tags: Optional[Dict[str, Any]] = None
    termination_protection_enabled: Optional[bool] = None
    version_release_system: Optional[str] = None

    def __post_init__(self):
        if self.backup_settings is not None and not isinstance(self.backup_settings, BackupSetting):
            assert isinstance(self.backup_settings, dict), (
                f"Expected backup_settings to be a BackupSetting or a dict, got {type(self.backup_settings)}"
            )
            self.backup_settings = BackupSetting(**self.backup_settings)
        if self.connection_strings is not None and not isinstance(self.connection_strings, ConnectionString):
            assert isinstance(self.connection_strings, dict), (
                f"Expected connection_strings to be a ConnectionString or a dict, got {type(self.connection_strings)}"
            )
            self.connection_strings = ConnectionString(**self.connection_strings)
        if self.provider_settings is not None and not isinstance(self.provider_settings, ProviderSetting):
            assert isinstance(self.provider_settings, dict), (
                f"Expected provider_settings to be a ProviderSetting or a dict, got {type(self.provider_settings)}"
            )
            self.provider_settings = ProviderSetting(**self.provider_settings)


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
