# codegen atlas-init-marker-start
import json
import sys
from dataclasses import asdict, dataclass
from typing import Optional, List, Set, ClassVar, Union


@dataclass
class ProjectAssignment:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"role_names"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"project_id", "role_names"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    project_id: Optional[str] = None
    role_names: Optional[List[str]] = None


@dataclass
class Resource:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = {"project_assignment"}
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"project_assignment"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"description", "project_assignment"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {"api_key_id", "private_key", "public_key"}
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    api_key_id: Optional[str] = None
    description: Optional[str] = None
    private_key: Optional[str] = None
    public_key: Optional[str] = None
    project_assignment: Optional[Set[ProjectAssignment]] = None

    def __post_init__(self):
        if self.project_assignment is not None and not isinstance(self.project_assignment, ProjectAssignment):
            assert isinstance(self.project_assignment, dict), (
                f"Expected project_assignment to be a ProjectAssignment or a dict, got {type(self.project_assignment)}"
            )
            self.project_assignment = ProjectAssignment(**self.project_assignment)


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
