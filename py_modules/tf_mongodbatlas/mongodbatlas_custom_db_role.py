# codegen atlas-init-marker-start
import json
import sys
from dataclasses import asdict, dataclass
from typing import Optional, List, Set, ClassVar, Union


@dataclass
class ResourceElem:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = set()
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    cluster: Optional[bool] = None
    collection_name: Optional[str] = None
    database_name: Optional[str] = None


@dataclass
class Action:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = {"resources"}
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"resources"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"action", "resources"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    action: Optional[str] = None
    resources: Optional[Set[ResourceElem]] = None

    def __post_init__(self):
        if self.resources is not None and not isinstance(self.resources, ResourceElem):
            assert isinstance(self.resources, dict), (
                f"Expected resources to be a ResourceElem or a dict, got {type(self.resources)}"
            )
            self.resources = ResourceElem(**self.resources)


@dataclass
class InheritedRole:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"database_name", "role_name"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    database_name: Optional[str] = None
    role_name: Optional[str] = None


@dataclass
class Resource:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = {"actions", "inherited_roles"}
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"actions", "inherited_roles"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"project_id", "role_name"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    project_id: Optional[str] = None
    role_name: Optional[str] = None
    actions: Optional[List[Action]] = None
    inherited_roles: Optional[Set[InheritedRole]] = None

    def __post_init__(self):
        if self.actions is not None:
            self.actions = [x if isinstance(x, Action) else Action(**x) for x in self.actions]
        if self.inherited_roles is not None and not isinstance(self.inherited_roles, InheritedRole):
            assert isinstance(self.inherited_roles, dict), (
                f"Expected inherited_roles to be a InheritedRole or a dict, got {type(self.inherited_roles)}"
            )
            self.inherited_roles = InheritedRole(**self.inherited_roles)


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
