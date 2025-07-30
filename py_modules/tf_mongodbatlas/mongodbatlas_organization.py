# codegen atlas-init-marker-start
import json
import sys
from dataclasses import asdict, dataclass
from typing import Optional, List, Set, ClassVar, Union


@dataclass
class Resource:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"role_names"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"description", "name", "org_owner_id", "role_names"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {"org_id", "private_key", "public_key"}
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    api_access_list_required: Optional[bool] = None
    description: Optional[str] = None
    federation_settings_id: Optional[str] = None
    gen_ai_features_enabled: Optional[bool] = None
    multi_factor_auth_required: Optional[bool] = None
    name: Optional[str] = None
    org_id: Optional[str] = None
    org_owner_id: Optional[str] = None
    private_key: Optional[str] = None
    public_key: Optional[str] = None
    restrict_employee_access: Optional[bool] = None
    role_names: Optional[List[str]] = None
    security_contact: Optional[str] = None
    skip_default_alerts_settings: Optional[bool] = None


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
