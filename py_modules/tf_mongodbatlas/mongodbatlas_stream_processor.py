# codegen atlas-init-marker-start
import json
import sys
from dataclasses import asdict, dataclass
from typing import Optional, Set, ClassVar, Union


@dataclass
class Dlq:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"coll", "connection_name", "db"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    coll: Optional[str] = None
    connection_name: Optional[str] = None
    db: Optional[str] = None


@dataclass
class Option:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"dlq"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"dlq"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    dlq: Optional[Dlq] = None

    def __post_init__(self):
        if self.dlq is not None and not isinstance(self.dlq, Dlq):
            assert isinstance(self.dlq, dict), f"Expected dlq to be a Dlq or a dict, got {type(self.dlq)}"
            self.dlq = Dlq(**self.dlq)


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
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"options", "timeouts"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"instance_name", "pipeline", "processor_name", "project_id"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {"stats"}
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    delete_on_create_timeout: Optional[bool] = None
    instance_name: Optional[str] = None
    options: Optional[Option] = None
    pipeline: Optional[str] = None
    processor_name: Optional[str] = None
    project_id: Optional[str] = None
    state: Optional[str] = None
    stats: Optional[str] = None
    timeouts: Optional[Timeout] = None

    def __post_init__(self):
        if self.options is not None and not isinstance(self.options, Option):
            assert isinstance(self.options, dict), (
                f"Expected options to be a Option or a dict, got {type(self.options)}"
            )
            self.options = Option(**self.options)
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
