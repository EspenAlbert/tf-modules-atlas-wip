# codegen atlas-init-marker-start
import json
import sys
from dataclasses import asdict, dataclass
from typing import Optional, List, Any, Set, ClassVar, Union


@dataclass
class Timeout:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = set()
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    create: Optional[str] = None


@dataclass
class Resource:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = {"timeouts"}
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"snapshot_ids", "timeouts"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"cluster_name", "description", "project_id", "retention_in_days"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {
        "cloud_provider",
        "created_at",
        "expires_at",
        "master_key_uuid",
        "members",
        "mongod_version",
        "replica_set_name",
        "snapshot_id",
        "snapshot_ids",
        "snapshot_type",
        "status",
        "storage_size_bytes",
        "type",
    }
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    cloud_provider: Optional[str] = None
    cluster_name: Optional[str] = None
    created_at: Optional[str] = None
    description: Optional[str] = None
    expires_at: Optional[str] = None
    master_key_uuid: Optional[str] = None
    members: Optional[Any] = None
    mongod_version: Optional[str] = None
    project_id: Optional[str] = None
    replica_set_name: Optional[str] = None
    retention_in_days: Optional[float] = None
    snapshot_id: Optional[str] = None
    snapshot_ids: Optional[List[str]] = None
    snapshot_type: Optional[str] = None
    status: Optional[str] = None
    storage_size_bytes: Optional[float] = None
    type: Optional[str] = None
    timeouts: Optional[Timeout] = None

    def __post_init__(self):
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
