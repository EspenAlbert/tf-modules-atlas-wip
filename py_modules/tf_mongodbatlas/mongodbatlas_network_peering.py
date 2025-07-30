# codegen atlas-init-marker-start
import json
import sys
from dataclasses import asdict, dataclass
from typing import Optional, Set, ClassVar, Union


@dataclass
class Resource:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"container_id", "project_id", "provider_name"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {
        "atlas_id",
        "connection_id",
        "error_message",
        "error_state",
        "error_state_name",
        "peer_id",
        "status",
        "status_name",
    }
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    accepter_region_name: Optional[str] = None
    atlas_cidr_block: Optional[str] = None
    atlas_gcp_project_id: Optional[str] = None
    atlas_id: Optional[str] = None
    atlas_vpc_name: Optional[str] = None
    aws_account_id: Optional[str] = None
    azure_directory_id: Optional[str] = None
    azure_subscription_id: Optional[str] = None
    connection_id: Optional[str] = None
    container_id: Optional[str] = None
    error_message: Optional[str] = None
    error_state: Optional[str] = None
    error_state_name: Optional[str] = None
    gcp_project_id: Optional[str] = None
    network_name: Optional[str] = None
    peer_id: Optional[str] = None
    project_id: Optional[str] = None
    provider_name: Optional[str] = None
    resource_group_name: Optional[str] = None
    route_table_cidr_block: Optional[str] = None
    status: Optional[str] = None
    status_name: Optional[str] = None
    vnet_name: Optional[str] = None
    vpc_id: Optional[str] = None


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
