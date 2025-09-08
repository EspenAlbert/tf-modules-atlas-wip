# codegen atlas-init-marker-start
import json
import sys
from dataclasses import asdict, dataclass
from typing import Optional, Set, ClassVar, Union


@dataclass
class Resource:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"project_id", "type"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    api_key: Optional[str] = None
    channel_name: Optional[str] = None
    enabled: Optional[bool] = None
    microsoft_teams_webhook_url: Optional[str] = None
    password: Optional[str] = None
    project_id: Optional[str] = None
    region: Optional[str] = None
    routing_key: Optional[str] = None
    secret: Optional[str] = None
    send_collection_latency_metrics: Optional[bool] = None
    send_database_metrics: Optional[bool] = None
    send_user_provided_resource_tags: Optional[bool] = None
    service_discovery: Optional[str] = None
    service_key: Optional[str] = None
    team_name: Optional[str] = None
    type: Optional[str] = None
    url: Optional[str] = None
    user_name: Optional[str] = None


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
