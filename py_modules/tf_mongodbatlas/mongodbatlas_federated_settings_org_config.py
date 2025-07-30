# codegen atlas-init-marker-start
import json
import sys
from dataclasses import asdict, dataclass
from typing import Optional, List, Any, Set, ClassVar, Union


@dataclass
class Resource:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {
        "data_access_identity_provider_ids",
        "domain_allow_list",
        "post_auth_role_grants",
    }
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"domain_restriction_enabled", "federation_settings_id", "org_id"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {"user_conflicts"}
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    data_access_identity_provider_ids: Optional[List[str]] = None
    domain_allow_list: Optional[List[str]] = None
    domain_restriction_enabled: Optional[bool] = None
    federation_settings_id: Optional[str] = None
    identity_provider_id: Optional[str] = None
    org_id: Optional[str] = None
    post_auth_role_grants: Optional[List[str]] = None
    user_conflicts: Optional[Any] = None


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
