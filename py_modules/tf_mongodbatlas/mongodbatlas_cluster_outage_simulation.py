# codegen atlas-init-marker-start
import json
import sys
from dataclasses import asdict, dataclass
from typing import Optional, List, Set, ClassVar, Union


@dataclass
class OutageFilter:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"cloud_provider", "region_name"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {"type"}
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    cloud_provider: Optional[str] = None
    region_name: Optional[str] = None
    type: Optional[str] = None


@dataclass
class Timeout:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = set()
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    delete: Optional[str] = None


@dataclass
class Resource:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = {"outage_filters", "timeouts"}
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"outage_filters", "timeouts"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"cluster_name", "project_id", "outage_filters"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {"simulation_id", "start_request_date", "state"}
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    cluster_name: Optional[str] = None
    project_id: Optional[str] = None
    simulation_id: Optional[str] = None
    start_request_date: Optional[str] = None
    state: Optional[str] = None
    outage_filters: Optional[List[OutageFilter]] = None
    timeouts: Optional[Timeout] = None

    def __post_init__(self):
        if self.outage_filters is not None:
            self.outage_filters = [x if isinstance(x, OutageFilter) else OutageFilter(**x) for x in self.outage_filters]
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
