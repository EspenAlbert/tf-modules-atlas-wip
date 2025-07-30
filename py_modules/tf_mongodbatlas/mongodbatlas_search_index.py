# codegen atlas-init-marker-start
import json
import sys
from dataclasses import asdict, dataclass
from typing import Optional, Set, ClassVar, Union


@dataclass
class Synonym:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"analyzer", "name", "source_collection"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    analyzer: Optional[str] = None
    name: Optional[str] = None
    source_collection: Optional[str] = None


@dataclass
class Timeout:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = set()
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    create: Optional[str] = None
    delete: Optional[str] = None
    update: Optional[str] = None


@dataclass
class Resource:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = {"synonyms", "timeouts"}
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"synonyms", "timeouts"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"cluster_name", "collection_name", "database", "name", "project_id"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {"index_id", "status"}
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    analyzer: Optional[str] = None
    analyzers: Optional[str] = None
    cluster_name: Optional[str] = None
    collection_name: Optional[str] = None
    database: Optional[str] = None
    fields: Optional[str] = None
    index_id: Optional[str] = None
    mappings_dynamic: Optional[bool] = None
    mappings_fields: Optional[str] = None
    name: Optional[str] = None
    project_id: Optional[str] = None
    search_analyzer: Optional[str] = None
    status: Optional[str] = None
    stored_source: Optional[str] = None
    type: Optional[str] = None
    wait_for_index_build_completion: Optional[bool] = None
    synonyms: Optional[Set[Synonym]] = None
    timeouts: Optional[Timeout] = None

    def __post_init__(self):
        if self.synonyms is not None and not isinstance(self.synonyms, Synonym):
            assert isinstance(self.synonyms, dict), (
                f"Expected synonyms to be a Synonym or a dict, got {type(self.synonyms)}"
            )
            self.synonyms = Synonym(**self.synonyms)
        if self.timeouts is not None and not isinstance(self.timeouts, Timeout):
            assert isinstance(self.timeouts, dict), (
                f"Expected timeouts to be a Timeout or a dict, got {type(self.timeouts)}"
            )
            self.timeouts = Timeout(**self.timeouts)


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
