# codegen atlas-init-marker-start
import json
import sys
from dataclasses import asdict, dataclass
from typing import Optional, List, Set, ClassVar, Union


@dataclass
class Atedbyuser:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = set()
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {"name"}
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    name: Optional[str] = None


@dataclass
class Policy:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"body"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    body: Optional[str] = None


@dataclass
class Resource:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"created_by_user", "last_updated_by_user", "policies"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"name", "org_id", "policies"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {
        "created_by_user",
        "created_date",
        "last_updated_by_user",
        "last_updated_date",
        "version",
    }
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    created_by_user: Optional[Atedbyuser] = None
    created_date: Optional[str] = None
    description: Optional[str] = None
    last_updated_by_user: Optional[Atedbyuser] = None
    last_updated_date: Optional[str] = None
    name: Optional[str] = None
    org_id: Optional[str] = None
    policies: Optional[List[Policy]] = None
    version: Optional[str] = None

    def __post_init__(self):
        if self.created_by_user is not None and not isinstance(self.created_by_user, Atedbyuser):
            assert isinstance(self.created_by_user, dict), (
                f"Expected created_by_user to be a Atedbyuser or a dict, got {type(self.created_by_user)}"
            )
            self.created_by_user = Atedbyuser(**self.created_by_user)
        if self.last_updated_by_user is not None and not isinstance(self.last_updated_by_user, Atedbyuser):
            assert isinstance(self.last_updated_by_user, dict), (
                f"Expected last_updated_by_user to be a Atedbyuser or a dict, got {type(self.last_updated_by_user)}"
            )
            self.last_updated_by_user = Atedbyuser(**self.last_updated_by_user)
        if self.policies is not None:
            self.policies = [x if isinstance(x, Policy) else Policy(**x) for x in self.policies]


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
