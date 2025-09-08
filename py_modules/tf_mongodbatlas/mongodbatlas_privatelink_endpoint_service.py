# codegen atlas-init-marker-start
import json
import sys
from dataclasses import asdict, dataclass
from typing import Optional, List, Set, ClassVar, Union


@dataclass
class Endpoint:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = set()
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {"status"}
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    endpoint_name: Optional[str] = None
    ip_address: Optional[str] = None
    status: Optional[str] = None


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
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = {"endpoints", "timeouts"}
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"endpoints", "timeouts"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"endpoint_service_id", "private_link_id", "project_id", "provider_name"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {
        "aws_connection_status",
        "azure_status",
        "delete_requested",
        "endpoint_group_name",
        "error_message",
        "gcp_status",
        "interface_endpoint_id",
        "private_endpoint_connection_name",
        "private_endpoint_resource_id",
    }
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    aws_connection_status: Optional[str] = None
    azure_status: Optional[str] = None
    delete_on_create_timeout: Optional[bool] = None
    delete_requested: Optional[bool] = None
    endpoint_group_name: Optional[str] = None
    endpoint_service_id: Optional[str] = None
    error_message: Optional[str] = None
    gcp_project_id: Optional[str] = None
    gcp_status: Optional[str] = None
    interface_endpoint_id: Optional[str] = None
    private_endpoint_connection_name: Optional[str] = None
    private_endpoint_ip_address: Optional[str] = None
    private_endpoint_resource_id: Optional[str] = None
    private_link_id: Optional[str] = None
    project_id: Optional[str] = None
    provider_name: Optional[str] = None
    endpoints: Optional[List[Endpoint]] = None
    timeouts: Optional[Timeout] = None

    def __post_init__(self):
        if self.endpoints is not None:
            self.endpoints = [x if isinstance(x, Endpoint) else Endpoint(**x) for x in self.endpoints]
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
