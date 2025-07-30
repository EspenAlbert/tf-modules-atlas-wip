# codegen atlas-init-marker-start
import json
import sys
from dataclasses import asdict, dataclass
from typing import Optional, List, Set, ClassVar, Union


@dataclass
class Resource:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"associated_domains", "requested_scopes"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"federation_settings_id", "issuer_uri", "name"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {"idp_id", "okta_idp_id"}
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    associated_domains: Optional[List[str]] = None
    audience: Optional[str] = None
    authorization_type: Optional[str] = None
    client_id: Optional[str] = None
    description: Optional[str] = None
    federation_settings_id: Optional[str] = None
    groups_claim: Optional[str] = None
    idp_id: Optional[str] = None
    idp_type: Optional[str] = None
    issuer_uri: Optional[str] = None
    name: Optional[str] = None
    okta_idp_id: Optional[str] = None
    protocol: Optional[str] = None
    request_binding: Optional[str] = None
    requested_scopes: Optional[List[str]] = None
    response_signature_algorithm: Optional[str] = None
    sso_debug_enabled: Optional[bool] = None
    sso_url: Optional[str] = None
    status: Optional[str] = None
    user_claim: Optional[str] = None


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
