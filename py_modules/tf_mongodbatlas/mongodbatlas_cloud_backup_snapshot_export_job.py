# codegen atlas-init-marker-start
import json
import sys
from dataclasses import asdict, dataclass
from typing import Optional, Any, Set, ClassVar, Union


@dataclass
class CustomDatum:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"key", "value"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    key: Optional[str] = None
    value: Optional[str] = None


@dataclass
class Resource:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = {"custom_data"}
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"custom_data"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"cluster_name", "export_bucket_id", "project_id", "snapshot_id"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {
        "components",
        "created_at",
        "export_job_id",
        "export_status_exported_collections",
        "export_status_total_collections",
        "finished_at",
        "prefix",
        "state",
    }
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    cluster_name: Optional[str] = None
    components: Optional[Any] = None
    created_at: Optional[str] = None
    export_bucket_id: Optional[str] = None
    export_job_id: Optional[str] = None
    export_status_exported_collections: Optional[float] = None
    export_status_total_collections: Optional[float] = None
    finished_at: Optional[str] = None
    prefix: Optional[str] = None
    project_id: Optional[str] = None
    snapshot_id: Optional[str] = None
    state: Optional[str] = None
    custom_data: Optional[Set[CustomDatum]] = None

    def __post_init__(self):
        if self.custom_data is not None and not isinstance(self.custom_data, CustomDatum):
            assert isinstance(self.custom_data, dict), (
                f"Expected custom_data to be a CustomDatum or a dict, got {type(self.custom_data)}"
            )
            self.custom_data = CustomDatum(**self.custom_data)


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
