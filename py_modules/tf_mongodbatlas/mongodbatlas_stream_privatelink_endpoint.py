# codegen atlas-init-marker-start
import json
import sys
from dataclasses import asdict, dataclass
from typing import Optional, List, Set, ClassVar, Union


@dataclass
class Resource:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"dns_sub_domain"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"project_id", "provider_name", "vendor"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {
        "error_message",
        "interface_endpoint_id",
        "interface_endpoint_name",
        "provider_account_id",
        "state",
    }
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    arn: Optional[str] = None
    dns_domain: Optional[str] = None
    dns_sub_domain: Optional[List[str]] = None
    error_message: Optional[str] = None
    interface_endpoint_id: Optional[str] = None
    interface_endpoint_name: Optional[str] = None
    project_id: Optional[str] = None
    provider_account_id: Optional[str] = None
    provider_name: Optional[str] = None
    region: Optional[str] = None
    service_endpoint_id: Optional[str] = None
    state: Optional[str] = None
    vendor: Optional[str] = None


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
