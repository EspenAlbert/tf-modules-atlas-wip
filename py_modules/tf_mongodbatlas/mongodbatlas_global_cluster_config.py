# codegen atlas-init-marker-start
import json
import sys
from dataclasses import asdict, dataclass
from typing import Optional, Dict, Any, Set, ClassVar, Union


@dataclass
class CustomZoneMapping:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = set()
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    location: Optional[str] = None
    zone: Optional[str] = None


@dataclass
class ManagedNamespace:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"collection", "custom_shard_key", "db"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    collection: Optional[str] = None
    custom_shard_key: Optional[str] = None
    db: Optional[str] = None
    is_custom_shard_key_hashed: Optional[bool] = None
    is_shard_key_unique: Optional[bool] = None


@dataclass
class Resource:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = {"custom_zone_mappings", "managed_namespaces"}
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {
        "custom_zone_mapping_zone_id",
        "custom_zone_mappings",
        "managed_namespaces",
    }
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"cluster_name", "project_id"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {"custom_zone_mapping_zone_id"}
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    cluster_name: Optional[str] = None
    custom_zone_mapping_zone_id: Optional[Dict[str, Any]] = None
    project_id: Optional[str] = None
    custom_zone_mappings: Optional[Set[CustomZoneMapping]] = None
    managed_namespaces: Optional[Set[ManagedNamespace]] = None

    def __post_init__(self):
        if self.custom_zone_mappings is not None and not isinstance(self.custom_zone_mappings, CustomZoneMapping):
            assert isinstance(self.custom_zone_mappings, dict), (
                f"Expected custom_zone_mappings to be a CustomZoneMapping or a dict, got {type(self.custom_zone_mappings)}"
            )
            self.custom_zone_mappings = CustomZoneMapping(**self.custom_zone_mappings)
        if self.managed_namespaces is not None and not isinstance(self.managed_namespaces, ManagedNamespace):
            assert isinstance(self.managed_namespaces, dict), (
                f"Expected managed_namespaces to be a ManagedNamespace or a dict, got {type(self.managed_namespaces)}"
            )
            self.managed_namespaces = ManagedNamespace(**self.managed_namespaces)


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
