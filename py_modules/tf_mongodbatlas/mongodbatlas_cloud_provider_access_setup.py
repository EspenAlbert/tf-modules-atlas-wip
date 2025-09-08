# codegen atlas-init-marker-start
import json
import sys
from dataclasses import asdict, dataclass
from typing import Optional, List, Any, Set, ClassVar, Union


@dataclass
class AzureConfig:
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
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = {"azure_config"}
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"azure_config"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"project_id", "provider_name"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {
        "aws_config",
        "created_date",
        "gcp_config",
        "last_updated_date",
        "role_id",
    }
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    aws_config: Optional[Any] = None
    created_date: Optional[str] = None
    gcp_config: Optional[Any] = None
    last_updated_date: Optional[str] = None
    project_id: Optional[str] = None
    provider_name: Optional[str] = None
    role_id: Optional[str] = None
    azure_config: Optional[List[AzureConfig]] = None

    def __post_init__(self):
        if self.azure_config is not None:
            self.azure_config = [x if isinstance(x, AzureConfig) else AzureConfig(**x) for x in self.azure_config]


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
