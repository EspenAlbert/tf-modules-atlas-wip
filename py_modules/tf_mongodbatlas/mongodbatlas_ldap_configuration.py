# codegen atlas-init-marker-start
import json
import sys
from dataclasses import asdict, dataclass
from typing import Optional, List, Set, ClassVar, Union


@dataclass
class UserToDnMapping:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = set()
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    ldap_query: Optional[str] = None
    match: Optional[str] = None
    substitution: Optional[str] = None


@dataclass
class Resource:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = {"user_to_dn_mapping"}
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"user_to_dn_mapping"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {
        "authentication_enabled",
        "bind_password",
        "bind_username",
        "hostname",
        "project_id",
    }
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    authentication_enabled: Optional[bool] = None
    authorization_enabled: Optional[bool] = None
    authz_query_template: Optional[str] = None
    bind_password: Optional[str] = None
    bind_username: Optional[str] = None
    ca_certificate: Optional[str] = None
    hostname: Optional[str] = None
    port: Optional[float] = None
    project_id: Optional[str] = None
    user_to_dn_mapping: Optional[List[UserToDnMapping]] = None

    def __post_init__(self):
        if self.user_to_dn_mapping is not None:
            self.user_to_dn_mapping = [
                x if isinstance(x, UserToDnMapping) else UserToDnMapping(**x) for x in self.user_to_dn_mapping
            ]


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
