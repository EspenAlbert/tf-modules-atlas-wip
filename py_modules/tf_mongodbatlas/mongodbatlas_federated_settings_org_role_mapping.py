# codegen atlas-init-marker-start
import json
import sys
from dataclasses import asdict, dataclass
from typing import Optional, List, Set, ClassVar, Union


@dataclass
class RoleAssignment:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"roles"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = set()
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    group_id: Optional[str] = None
    org_id: Optional[str] = None
    roles: Optional[List[str]] = None


@dataclass
class Resource:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = {"role_assignments"}
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"role_assignments"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {
        "external_group_name",
        "federation_settings_id",
        "org_id",
        "role_assignments",
    }
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {"role_mapping_id"}
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    external_group_name: Optional[str] = None
    federation_settings_id: Optional[str] = None
    org_id: Optional[str] = None
    role_mapping_id: Optional[str] = None
    role_assignments: Optional[Set[RoleAssignment]] = None

    def __post_init__(self):
        if self.role_assignments is not None and not isinstance(self.role_assignments, RoleAssignment):
            assert isinstance(self.role_assignments, dict), (
                f"Expected role_assignments to be a RoleAssignment or a dict, got {type(self.role_assignments)}"
            )
            self.role_assignments = RoleAssignment(**self.role_assignments)


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
