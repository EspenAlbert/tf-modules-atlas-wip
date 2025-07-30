# codegen atlas-init-marker-start
import json
import sys
from dataclasses import asdict, dataclass
from typing import Optional, List, Set, ClassVar, Union


@dataclass
class AwsEventbridge:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = set()
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    config_account_id: Optional[str] = None
    config_region: Optional[str] = None


@dataclass
class EventProcessor:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = {"aws_eventbridge"}
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"aws_eventbridge"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = set()
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    aws_eventbridge: Optional[List[AwsEventbridge]] = None

    def __post_init__(self):
        if self.aws_eventbridge is not None:
            self.aws_eventbridge = [
                x if isinstance(x, AwsEventbridge) else AwsEventbridge(**x) for x in self.aws_eventbridge
            ]


@dataclass
class Resource:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = {"event_processors"}
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"config_operation_types", "config_providers", "event_processors"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"app_id", "name", "project_id", "type"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {"config_schedule_type", "function_name", "trigger_id"}
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    app_id: Optional[str] = None
    config_collection: Optional[str] = None
    config_database: Optional[str] = None
    config_full_document: Optional[bool] = None
    config_full_document_before: Optional[bool] = None
    config_match: Optional[str] = None
    config_operation_type: Optional[str] = None
    config_operation_types: Optional[List[str]] = None
    config_project: Optional[str] = None
    config_providers: Optional[List[str]] = None
    config_schedule: Optional[str] = None
    config_schedule_type: Optional[str] = None
    config_service_id: Optional[str] = None
    disabled: Optional[bool] = None
    function_id: Optional[str] = None
    function_name: Optional[str] = None
    name: Optional[str] = None
    project_id: Optional[str] = None
    trigger_id: Optional[str] = None
    type: Optional[str] = None
    unordered: Optional[bool] = None
    event_processors: Optional[List[EventProcessor]] = None

    def __post_init__(self):
        if self.event_processors is not None:
            self.event_processors = [
                x if isinstance(x, EventProcessor) else EventProcessor(**x) for x in self.event_processors
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
