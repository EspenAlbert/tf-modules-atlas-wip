# codegen atlas-init-marker-start
import json
import sys
from dataclasses import asdict, dataclass
from typing import Optional, List, Set, ClassVar, Union


@dataclass
class CopySetting:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"frequencies"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = set()
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    cloud_provider: Optional[str] = None
    frequencies: Optional[List[str]] = None
    region_name: Optional[str] = None
    should_copy_oplogs: Optional[bool] = None
    zone_id: Optional[str] = None


@dataclass
class Export:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = set()
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    export_bucket_id: Optional[str] = None
    frequency_type: Optional[str] = None


@dataclass
class Policyitem:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"frequency_interval", "retention_unit", "retention_value"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {"frequency_type"}
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    frequency_interval: Optional[float] = None
    frequency_type: Optional[str] = None
    retention_unit: Optional[str] = None
    retention_value: Optional[float] = None


@dataclass
class Resource:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = {
        "copy_settings",
        "export",
        "policy_item_daily",
        "policy_item_hourly",
        "policy_item_monthly",
        "policy_item_weekly",
        "policy_item_yearly",
    }
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {
        "copy_settings",
        "export",
        "policy_item_daily",
        "policy_item_hourly",
        "policy_item_monthly",
        "policy_item_weekly",
        "policy_item_yearly",
    }
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"cluster_name", "project_id"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {"cluster_id", "id_policy", "next_snapshot"}
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    auto_export_enabled: Optional[bool] = None
    cluster_id: Optional[str] = None
    cluster_name: Optional[str] = None
    id_policy: Optional[str] = None
    next_snapshot: Optional[str] = None
    project_id: Optional[str] = None
    reference_hour_of_day: Optional[float] = None
    reference_minute_of_hour: Optional[float] = None
    restore_window_days: Optional[float] = None
    update_snapshots: Optional[bool] = None
    use_org_and_group_names_in_export_prefix: Optional[bool] = None
    copy_settings: Optional[List[CopySetting]] = None
    export: Optional[List[Export]] = None
    policy_item_daily: Optional[List[Policyitem]] = None
    policy_item_hourly: Optional[List[Policyitem]] = None
    policy_item_monthly: Optional[List[Policyitem]] = None
    policy_item_weekly: Optional[List[Policyitem]] = None
    policy_item_yearly: Optional[List[Policyitem]] = None

    def __post_init__(self):
        if self.copy_settings is not None:
            self.copy_settings = [x if isinstance(x, CopySetting) else CopySetting(**x) for x in self.copy_settings]
        if self.export is not None:
            self.export = [x if isinstance(x, Export) else Export(**x) for x in self.export]
        if self.policy_item_daily is not None:
            self.policy_item_daily = [
                x if isinstance(x, Policyitem) else Policyitem(**x) for x in self.policy_item_daily
            ]
        if self.policy_item_hourly is not None:
            self.policy_item_hourly = [
                x if isinstance(x, Policyitem) else Policyitem(**x) for x in self.policy_item_hourly
            ]
        if self.policy_item_monthly is not None:
            self.policy_item_monthly = [
                x if isinstance(x, Policyitem) else Policyitem(**x) for x in self.policy_item_monthly
            ]
        if self.policy_item_weekly is not None:
            self.policy_item_weekly = [
                x if isinstance(x, Policyitem) else Policyitem(**x) for x in self.policy_item_weekly
            ]
        if self.policy_item_yearly is not None:
            self.policy_item_yearly = [
                x if isinstance(x, Policyitem) else Policyitem(**x) for x in self.policy_item_yearly
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
