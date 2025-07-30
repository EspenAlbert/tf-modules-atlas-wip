# codegen atlas-init-marker-start
import json
import sys
from dataclasses import asdict, dataclass
from typing import Optional, Dict, Any, Set, ClassVar, Union


@dataclass
class Authentication:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = set()
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    mechanism: Optional[str] = None
    password: Optional[str] = None
    username: Optional[str] = None


@dataclass
class Aws:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"role_arn"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    role_arn: Optional[str] = None


@dataclass
class DbRoleToExecute:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"role", "type"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    role: Optional[str] = None
    type: Optional[str] = None


@dataclass
class Access:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"type"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    connection_id: Optional[str] = None
    type: Optional[str] = None


@dataclass
class Networking:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"access"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"access"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    access: Optional[Access] = None

    def __post_init__(self):
        if self.access is not None and not isinstance(self.access, Access):
            assert isinstance(self.access, dict), f"Expected access to be a Access or a dict, got {type(self.access)}"
            self.access = Access(**self.access)


@dataclass
class Security:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = set()
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    broker_public_certificate: Optional[str] = None
    protocol: Optional[str] = None


@dataclass
class Resource:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {
        "authentication",
        "aws",
        "config",
        "db_role_to_execute",
        "headers",
        "networking",
        "security",
    }
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"connection_name", "instance_name", "project_id", "type"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    authentication: Optional[Authentication] = None
    aws: Optional[Aws] = None
    bootstrap_servers: Optional[str] = None
    cluster_name: Optional[str] = None
    cluster_project_id: Optional[str] = None
    config: Optional[Dict[str, Any]] = None
    connection_name: Optional[str] = None
    db_role_to_execute: Optional[DbRoleToExecute] = None
    headers: Optional[Dict[str, Any]] = None
    instance_name: Optional[str] = None
    networking: Optional[Networking] = None
    project_id: Optional[str] = None
    security: Optional[Security] = None
    type: Optional[str] = None
    url: Optional[str] = None

    def __post_init__(self):
        if self.authentication is not None and not isinstance(self.authentication, Authentication):
            assert isinstance(self.authentication, dict), (
                f"Expected authentication to be a Authentication or a dict, got {type(self.authentication)}"
            )
            self.authentication = Authentication(**self.authentication)
        if self.aws is not None and not isinstance(self.aws, Aws):
            assert isinstance(self.aws, dict), f"Expected aws to be a Aws or a dict, got {type(self.aws)}"
            self.aws = Aws(**self.aws)
        if self.db_role_to_execute is not None and not isinstance(self.db_role_to_execute, DbRoleToExecute):
            assert isinstance(self.db_role_to_execute, dict), (
                f"Expected db_role_to_execute to be a DbRoleToExecute or a dict, got {type(self.db_role_to_execute)}"
            )
            self.db_role_to_execute = DbRoleToExecute(**self.db_role_to_execute)
        if self.networking is not None and not isinstance(self.networking, Networking):
            assert isinstance(self.networking, dict), (
                f"Expected networking to be a Networking or a dict, got {type(self.networking)}"
            )
            self.networking = Networking(**self.networking)
        if self.security is not None and not isinstance(self.security, Security):
            assert isinstance(self.security, dict), (
                f"Expected security to be a Security or a dict, got {type(self.security)}"
            )
            self.security = Security(**self.security)


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
