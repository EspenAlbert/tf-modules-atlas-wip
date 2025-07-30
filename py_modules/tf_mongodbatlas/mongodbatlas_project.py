# codegen atlas-init-marker-start
import json
import sys
from dataclasses import asdict, dataclass
from typing import Optional, List, Dict, Any, Set, ClassVar, Union


@dataclass
class Limit:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"name", "value"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {"current_usage", "default_limit", "maximum_limit"}
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    current_usage: Optional[float] = None
    default_limit: Optional[float] = None
    maximum_limit: Optional[float] = None
    name: Optional[str] = None
    value: Optional[float] = None


@dataclass
class Team:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"role_names"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"role_names", "team_id"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    role_names: Optional[List[str]] = None
    team_id: Optional[str] = None


@dataclass
class Resource:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = {"limits", "teams"}
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"tags", "limits", "teams"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"name", "org_id"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {"cluster_count", "created", "id"}
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    cluster_count: Optional[float] = None
    created: Optional[str] = None
    id: Optional[str] = None
    is_collect_database_specifics_statistics_enabled: Optional[bool] = None
    is_data_explorer_enabled: Optional[bool] = None
    is_extended_storage_sizes_enabled: Optional[bool] = None
    is_performance_advisor_enabled: Optional[bool] = None
    is_realtime_performance_panel_enabled: Optional[bool] = None
    is_schema_advisor_enabled: Optional[bool] = None
    name: Optional[str] = None
    org_id: Optional[str] = None
    project_owner_id: Optional[str] = None
    region_usage_restrictions: Optional[str] = None
    tags: Optional[Dict[str, Any]] = None
    with_default_alerts_settings: Optional[bool] = None
    limits: Optional[Set[Limit]] = None
    teams: Optional[Set[Team]] = None

    def __post_init__(self):
        if self.limits is not None and not isinstance(self.limits, Limit):
            assert isinstance(self.limits, dict), f"Expected limits to be a Limit or a dict, got {type(self.limits)}"
            self.limits = Limit(**self.limits)
        if self.teams is not None and not isinstance(self.teams, Team):
            assert isinstance(self.teams, dict), f"Expected teams to be a Team or a dict, got {type(self.teams)}"
            self.teams = Team(**self.teams)


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
