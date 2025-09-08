# codegen atlas-init-marker-start
import json
import sys
from dataclasses import asdict, dataclass
from typing import Optional, List, Set, ClassVar, Union


@dataclass
class AwsKmsConfig:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = set()
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {"valid"}
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    access_key_id: Optional[str] = None
    customer_master_key_id: Optional[str] = None
    enabled: Optional[bool] = None
    region: Optional[str] = None
    require_private_networking: Optional[bool] = None
    role_id: Optional[str] = None
    secret_access_key: Optional[str] = None
    valid: Optional[bool] = None


@dataclass
class AzureKeyVaultConfig:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = set()
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {"valid"}
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    azure_environment: Optional[str] = None
    client_id: Optional[str] = None
    enabled: Optional[bool] = None
    key_identifier: Optional[str] = None
    key_vault_name: Optional[str] = None
    require_private_networking: Optional[bool] = None
    resource_group_name: Optional[str] = None
    secret: Optional[str] = None
    subscription_id: Optional[str] = None
    tenant_id: Optional[str] = None
    valid: Optional[bool] = None


@dataclass
class GoogleCloudKmsConfig:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = set()
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {"valid"}
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    enabled: Optional[bool] = None
    key_version_resource_id: Optional[str] = None
    role_id: Optional[str] = None
    service_account_key: Optional[str] = None
    valid: Optional[bool] = None


@dataclass
class Resource:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = {"aws_kms_config", "azure_key_vault_config", "google_cloud_kms_config"}
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"aws_kms_config", "azure_key_vault_config", "google_cloud_kms_config"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"project_id"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    enabled_for_search_nodes: Optional[bool] = None
    project_id: Optional[str] = None
    aws_kms_config: Optional[List[AwsKmsConfig]] = None
    azure_key_vault_config: Optional[List[AzureKeyVaultConfig]] = None
    google_cloud_kms_config: Optional[List[GoogleCloudKmsConfig]] = None

    def __post_init__(self):
        if self.aws_kms_config is not None:
            self.aws_kms_config = [x if isinstance(x, AwsKmsConfig) else AwsKmsConfig(**x) for x in self.aws_kms_config]
        if self.azure_key_vault_config is not None:
            self.azure_key_vault_config = [
                x if isinstance(x, AzureKeyVaultConfig) else AzureKeyVaultConfig(**x)
                for x in self.azure_key_vault_config
            ]
        if self.google_cloud_kms_config is not None:
            self.google_cloud_kms_config = [
                x if isinstance(x, GoogleCloudKmsConfig) else GoogleCloudKmsConfig(**x)
                for x in self.google_cloud_kms_config
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
