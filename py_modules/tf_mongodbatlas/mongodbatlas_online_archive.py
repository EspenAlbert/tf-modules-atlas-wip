# codegen atlas-init-marker-start
import json
import sys
from dataclasses import asdict, dataclass
from typing import Optional, List, Set, ClassVar, Union


@dataclass
class Criterium:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"type"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    date_field: Optional[str] = None
    date_format: Optional[str] = None
    expire_after_days: Optional[float] = None
    query: Optional[str] = None
    type: Optional[str] = None


@dataclass
class DataExpirationRule:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"expire_after_days"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    expire_after_days: Optional[float] = None


@dataclass
class DataProcessRegion:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = set()
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    cloud_provider: Optional[str] = None
    region: Optional[str] = None


@dataclass
class PartitionField:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"field_name", "order"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {"field_type"}
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    field_name: Optional[str] = None
    field_type: Optional[str] = None
    order: Optional[float] = None


@dataclass
class Schedule:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"type"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    day_of_month: Optional[float] = None
    day_of_week: Optional[float] = None
    end_hour: Optional[float] = None
    end_minute: Optional[float] = None
    start_hour: Optional[float] = None
    start_minute: Optional[float] = None
    type: Optional[str] = None


@dataclass
class Timeout:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = set()
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    create: Optional[str] = None


@dataclass
class Resource:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = {
        "criteria",
        "data_expiration_rule",
        "data_process_region",
        "partition_fields",
        "schedule",
        "timeouts",
    }
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {
        "criteria",
        "data_expiration_rule",
        "data_process_region",
        "partition_fields",
        "schedule",
        "timeouts",
    }
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"cluster_name", "coll_name", "db_name", "project_id", "criteria"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {"archive_id", "state"}
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    archive_id: Optional[str] = None
    cluster_name: Optional[str] = None
    coll_name: Optional[str] = None
    collection_type: Optional[str] = None
    db_name: Optional[str] = None
    delete_on_create_timeout: Optional[bool] = None
    paused: Optional[bool] = None
    project_id: Optional[str] = None
    state: Optional[str] = None
    sync_creation: Optional[bool] = None
    criteria: Optional[List[Criterium]] = None
    data_expiration_rule: Optional[List[DataExpirationRule]] = None
    data_process_region: Optional[List[DataProcessRegion]] = None
    partition_fields: Optional[List[PartitionField]] = None
    schedule: Optional[List[Schedule]] = None
    timeouts: Optional[Timeout] = None

    def __post_init__(self):
        if self.criteria is not None:
            self.criteria = [x if isinstance(x, Criterium) else Criterium(**x) for x in self.criteria]
        if self.data_expiration_rule is not None:
            self.data_expiration_rule = [
                x if isinstance(x, DataExpirationRule) else DataExpirationRule(**x) for x in self.data_expiration_rule
            ]
        if self.data_process_region is not None:
            self.data_process_region = [
                x if isinstance(x, DataProcessRegion) else DataProcessRegion(**x) for x in self.data_process_region
            ]
        if self.partition_fields is not None:
            self.partition_fields = [
                x if isinstance(x, PartitionField) else PartitionField(**x) for x in self.partition_fields
            ]
        if self.schedule is not None:
            self.schedule = [x if isinstance(x, Schedule) else Schedule(**x) for x in self.schedule]
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
