# codegen atlas-init-marker-start
import json
import sys
from dataclasses import asdict, dataclass
from typing import Optional, Set, ClassVar, Union


@dataclass
class Label:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = set()
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    key: Optional[str] = None
    value: Optional[str] = None


@dataclass
class Role:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"database_name", "role_name"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    collection_name: Optional[str] = None
    database_name: Optional[str] = None
    role_name: Optional[str] = None


@dataclass
class Scope:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = set()
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    name: Optional[str] = None
    type: Optional[str] = None


@dataclass
class Resource:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = {"labels", "roles", "scopes"}
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"labels", "roles", "scopes"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"auth_database_name", "project_id", "username"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    auth_database_name: Optional[str] = None
    aws_iam_type: Optional[str] = None
    description: Optional[str] = None
    ldap_auth_type: Optional[str] = None
    oidc_auth_type: Optional[str] = None
    password: Optional[str] = None
    project_id: Optional[str] = None
    username: Optional[str] = None
    x509_type: Optional[str] = None
    labels: Optional[Set[Label]] = None
    roles: Optional[Set[Role]] = None
    scopes: Optional[Set[Scope]] = None

    def __post_init__(self):
        if self.labels is not None and not isinstance(self.labels, Label):
            assert isinstance(self.labels, dict), f"Expected labels to be a Label or a dict, got {type(self.labels)}"
            self.labels = Label(**self.labels)
        if self.roles is not None and not isinstance(self.roles, Role):
            assert isinstance(self.roles, dict), f"Expected roles to be a Role or a dict, got {type(self.roles)}"
            self.roles = Role(**self.roles)
        if self.scopes is not None and not isinstance(self.scopes, Scope):
            assert isinstance(self.scopes, dict), f"Expected scopes to be a Scope or a dict, got {type(self.scopes)}"
            self.scopes = Scope(**self.scopes)


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
