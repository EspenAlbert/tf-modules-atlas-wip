# codegen atlas-init-marker-start
import json
import sys
from dataclasses import asdict, dataclass
from typing import Optional, List, Set, ClassVar, Union


@dataclass
class Aws:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"role_id", "test_s3_bucket"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {"external_id", "iam_assumed_role_arn", "iam_user_arn"}
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    external_id: Optional[str] = None
    iam_assumed_role_arn: Optional[str] = None
    iam_user_arn: Optional[str] = None
    role_id: Optional[str] = None
    test_s3_bucket: Optional[str] = None


@dataclass
class Azure:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"role_id"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {"atlas_app_id", "service_principal_id", "tenant_id"}
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    atlas_app_id: Optional[str] = None
    role_id: Optional[str] = None
    service_principal_id: Optional[str] = None
    tenant_id: Optional[str] = None


@dataclass
class CloudProviderConfig:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = {"aws", "azure"}
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"aws", "azure"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = set()
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    aws: Optional[List[Aws]] = None
    azure: Optional[List[Azure]] = None

    def __post_init__(self):
        if self.aws is not None:
            self.aws = [x if isinstance(x, Aws) else Aws(**x) for x in self.aws]
        if self.azure is not None:
            self.azure = [x if isinstance(x, Azure) else Azure(**x) for x in self.azure]


@dataclass
class DataProcessRegion:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"cloud_provider", "region"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    cloud_provider: Optional[str] = None
    region: Optional[str] = None


@dataclass
class DataSource:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"urls"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = set()
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    allow_insecure: Optional[bool] = None
    collection: Optional[str] = None
    collection_regex: Optional[str] = None
    database: Optional[str] = None
    database_regex: Optional[str] = None
    dataset_name: Optional[str] = None
    default_format: Optional[str] = None
    path: Optional[str] = None
    provenance_field_name: Optional[str] = None
    store_name: Optional[str] = None
    urls: Optional[List[str]] = None


@dataclass
class Collection:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = {"data_sources"}
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"data_sources"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = set()
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    name: Optional[str] = None
    data_sources: Optional[Set[DataSource]] = None

    def __post_init__(self):
        if self.data_sources is not None and not isinstance(self.data_sources, DataSource):
            assert isinstance(self.data_sources, dict), (
                f"Expected data_sources to be a DataSource or a dict, got {type(self.data_sources)}"
            )
            self.data_sources = DataSource(**self.data_sources)


@dataclass
class View:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = set()
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {"name", "pipeline", "source"}
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    name: Optional[str] = None
    pipeline: Optional[str] = None
    source: Optional[str] = None


@dataclass
class StorageDatabase:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = {"collections", "views"}
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"collections", "views"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = set()
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {"max_wildcard_collections"}
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    max_wildcard_collections: Optional[float] = None
    name: Optional[str] = None
    collections: Optional[Set[Collection]] = None
    views: Optional[Set[View]] = None

    def __post_init__(self):
        if self.collections is not None and not isinstance(self.collections, Collection):
            assert isinstance(self.collections, dict), (
                f"Expected collections to be a Collection or a dict, got {type(self.collections)}"
            )
            self.collections = Collection(**self.collections)
        if self.views is not None and not isinstance(self.views, View):
            assert isinstance(self.views, dict), f"Expected views to be a View or a dict, got {type(self.views)}"
            self.views = View(**self.views)


@dataclass
class Tag:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = set()
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    name: Optional[str] = None
    value: Optional[str] = None


@dataclass
class TagSet:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = {"tags"}
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"tags"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"tags"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    tags: Optional[List[Tag]] = None

    def __post_init__(self):
        if self.tags is not None:
            self.tags = [x if isinstance(x, Tag) else Tag(**x) for x in self.tags]


@dataclass
class ReadPreference:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = {"tag_sets"}
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"tag_sets"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = set()
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    max_staleness_seconds: Optional[float] = None
    mode: Optional[str] = None
    tag_sets: Optional[List[TagSet]] = None

    def __post_init__(self):
        if self.tag_sets is not None:
            self.tag_sets = [x if isinstance(x, TagSet) else TagSet(**x) for x in self.tag_sets]


@dataclass
class StorageStore:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = {"read_preference"}
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"additional_storage_classes", "urls", "read_preference"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = set()
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    additional_storage_classes: Optional[List[str]] = None
    allow_insecure: Optional[bool] = None
    bucket: Optional[str] = None
    cluster_name: Optional[str] = None
    default_format: Optional[str] = None
    delimiter: Optional[str] = None
    include_tags: Optional[bool] = None
    name: Optional[str] = None
    prefix: Optional[str] = None
    project_id: Optional[str] = None
    provider: Optional[str] = None
    public: Optional[str] = None
    region: Optional[str] = None
    urls: Optional[List[str]] = None
    read_preference: Optional[List[ReadPreference]] = None

    def __post_init__(self):
        if self.read_preference is not None:
            self.read_preference = [
                x if isinstance(x, ReadPreference) else ReadPreference(**x) for x in self.read_preference
            ]


@dataclass
class Resource:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = {
        "cloud_provider_config",
        "data_process_region",
        "storage_databases",
        "storage_stores",
    }
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {
        "hostnames",
        "cloud_provider_config",
        "data_process_region",
        "storage_databases",
        "storage_stores",
    }
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"name", "project_id"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {"hostnames", "state"}
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    hostnames: Optional[List[str]] = None
    name: Optional[str] = None
    project_id: Optional[str] = None
    state: Optional[str] = None
    cloud_provider_config: Optional[List[CloudProviderConfig]] = None
    data_process_region: Optional[List[DataProcessRegion]] = None
    storage_databases: Optional[Set[StorageDatabase]] = None
    storage_stores: Optional[Set[StorageStore]] = None

    def __post_init__(self):
        if self.cloud_provider_config is not None:
            self.cloud_provider_config = [
                x if isinstance(x, CloudProviderConfig) else CloudProviderConfig(**x)
                for x in self.cloud_provider_config
            ]
        if self.data_process_region is not None:
            self.data_process_region = [
                x if isinstance(x, DataProcessRegion) else DataProcessRegion(**x) for x in self.data_process_region
            ]
        if self.storage_databases is not None and not isinstance(self.storage_databases, StorageDatabase):
            assert isinstance(self.storage_databases, dict), (
                f"Expected storage_databases to be a StorageDatabase or a dict, got {type(self.storage_databases)}"
            )
            self.storage_databases = StorageDatabase(**self.storage_databases)
        if self.storage_stores is not None and not isinstance(self.storage_stores, StorageStore):
            assert isinstance(self.storage_stores, dict), (
                f"Expected storage_stores to be a StorageStore or a dict, got {type(self.storage_stores)}"
            )
            self.storage_stores = StorageStore(**self.storage_stores)


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
