# codegen atlas-init-marker-start
import json
import sys
from dataclasses import asdict, dataclass
from typing import Optional, List, Any, Set, ClassVar, Union


@dataclass
class Aws:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"iam_assumed_role_arn"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    iam_assumed_role_arn: Optional[str] = None


@dataclass
class Azure:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"atlas_azure_app_id", "service_principal_id", "tenant_id"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    atlas_azure_app_id: Optional[str] = None
    service_principal_id: Optional[str] = None
    tenant_id: Optional[str] = None


@dataclass
class Resource:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = {"aws", "azure"}
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"aws", "azure"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"project_id", "role_id"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {"authorized_date", "feature_usages", "gcp"}
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    authorized_date: Optional[str] = None
    feature_usages: Optional[Any] = None
    gcp: Optional[Any] = None
    project_id: Optional[str] = None
    role_id: Optional[str] = None
    aws: Optional[List[Aws]] = None
    azure: Optional[List[Azure]] = None

    def __post_init__(self):
        if self.aws is not None:
            self.aws = [x if isinstance(x, Aws) else Aws(**x) for x in self.aws]
        if self.azure is not None:
            self.azure = [x if isinstance(x, Azure) else Azure(**x) for x in self.azure]


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
