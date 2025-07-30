# codegen atlas-init-marker-start
import json
import sys
from dataclasses import asdict, dataclass
from typing import Optional, List, Set, ClassVar, Union


@dataclass
class DataProcessRegion:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"cloud_provider", "region"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    cloud_provider: Optional[str] = None
    region: Optional[str] = None


@dataclass
class StreamConfig:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = set()
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    tier: Optional[str] = None


@dataclass
class Resource:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"data_process_region", "hostnames", "stream_config"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"data_process_region", "instance_name", "project_id"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {"hostnames"}
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    data_process_region: Optional[DataProcessRegion] = None
    hostnames: Optional[List[str]] = None
    instance_name: Optional[str] = None
    project_id: Optional[str] = None
    stream_config: Optional[StreamConfig] = None

    def __post_init__(self):
        if self.data_process_region is not None and not isinstance(self.data_process_region, DataProcessRegion):
            assert isinstance(self.data_process_region, dict), (
                f"Expected data_process_region to be a DataProcessRegion or a dict, got {type(self.data_process_region)}"
            )
            self.data_process_region = DataProcessRegion(**self.data_process_region)
        if self.stream_config is not None and not isinstance(self.stream_config, StreamConfig):
            assert isinstance(self.stream_config, dict), (
                f"Expected stream_config to be a StreamConfig or a dict, got {type(self.stream_config)}"
            )
            self.stream_config = StreamConfig(**self.stream_config)


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
