# codegen atlas-init-marker-start
import json
import sys
from dataclasses import asdict, dataclass
from typing import Optional, List, Set, ClassVar, Union


@dataclass
class DeliveryTypeConfig:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = set()
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    automated: Optional[bool] = None
    download: Optional[bool] = None
    oplog_inc: Optional[float] = None
    oplog_ts: Optional[float] = None
    point_in_time: Optional[bool] = None
    point_in_time_utc_seconds: Optional[float] = None
    target_cluster_name: Optional[str] = None
    target_project_id: Optional[str] = None


@dataclass
class Resource:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = {"delivery_type_config"}
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"delivery_url", "delivery_type_config"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"cluster_name", "project_id"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {
        "cancelled",
        "delivery_url",
        "expired",
        "expires_at",
        "failed",
        "finished_at",
        "snapshot_restore_job_id",
        "timestamp",
    }
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    cancelled: Optional[bool] = None
    cluster_name: Optional[str] = None
    delivery_url: Optional[List[str]] = None
    expired: Optional[bool] = None
    expires_at: Optional[str] = None
    failed: Optional[bool] = None
    finished_at: Optional[str] = None
    project_id: Optional[str] = None
    snapshot_id: Optional[str] = None
    snapshot_restore_job_id: Optional[str] = None
    timestamp: Optional[str] = None
    delivery_type_config: Optional[List[DeliveryTypeConfig]] = None

    def __post_init__(self):
        if self.delivery_type_config is not None:
            self.delivery_type_config = [
                x if isinstance(x, DeliveryTypeConfig) else DeliveryTypeConfig(**x) for x in self.delivery_type_config
            ]


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
