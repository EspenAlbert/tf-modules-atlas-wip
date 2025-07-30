# codegen atlas-init-marker-start
import json
import sys
from dataclasses import asdict, dataclass
from typing import Optional, Set, ClassVar, Union


@dataclass
class Resource:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"cloud_provider", "project_id", "region_name"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {"error_message", "private_endpoint_connection_name", "status"}
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    cloud_provider: Optional[str] = None
    error_message: Optional[str] = None
    private_endpoint_connection_name: Optional[str] = None
    project_id: Optional[str] = None
    region_name: Optional[str] = None
    status: Optional[str] = None


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
