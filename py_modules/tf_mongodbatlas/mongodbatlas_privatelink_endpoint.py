# codegen atlas-init-marker-start
import json
import sys
from dataclasses import asdict, dataclass
from typing import Optional, List, Set, ClassVar, Union


@dataclass
class Timeout:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = set()
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    create: Optional[str] = None
    delete: Optional[str] = None


@dataclass
class Resource:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = {"timeouts"}
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {
        "endpoint_group_names",
        "interface_endpoints",
        "private_endpoints",
        "service_attachment_names",
        "timeouts",
    }
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"project_id", "provider_name", "region"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {
        "endpoint_group_names",
        "endpoint_service_name",
        "error_message",
        "interface_endpoints",
        "private_endpoints",
        "private_link_id",
        "private_link_service_name",
        "private_link_service_resource_id",
        "region_name",
        "service_attachment_names",
        "status",
    }
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    delete_on_create_timeout: Optional[bool] = None
    endpoint_group_names: Optional[List[str]] = None
    endpoint_service_name: Optional[str] = None
    error_message: Optional[str] = None
    interface_endpoints: Optional[List[str]] = None
    private_endpoints: Optional[List[str]] = None
    private_link_id: Optional[str] = None
    private_link_service_name: Optional[str] = None
    private_link_service_resource_id: Optional[str] = None
    project_id: Optional[str] = None
    provider_name: Optional[str] = None
    region: Optional[str] = None
    region_name: Optional[str] = None
    service_attachment_names: Optional[List[str]] = None
    status: Optional[str] = None
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
