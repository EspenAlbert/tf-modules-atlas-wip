# codegen atlas-init-marker-start
import json
import sys
from dataclasses import asdict, dataclass
from typing import Optional, List, Set, ClassVar, Union


@dataclass
class Matcher:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"field_name", "operator", "value"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    field_name: Optional[str] = None
    operator: Optional[str] = None
    value: Optional[str] = None


@dataclass
class MetricThresholdConfig:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"metric_name"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    metric_name: Optional[str] = None
    mode: Optional[str] = None
    operator: Optional[str] = None
    threshold: Optional[float] = None
    units: Optional[str] = None


@dataclass
class Notification:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"roles"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"type_name"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {"team_name"}
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    api_token: Optional[str] = None
    channel_name: Optional[str] = None
    datadog_api_key: Optional[str] = None
    datadog_region: Optional[str] = None
    delay_min: Optional[float] = None
    email_address: Optional[str] = None
    email_enabled: Optional[bool] = None
    integration_id: Optional[str] = None
    interval_min: Optional[float] = None
    microsoft_teams_webhook_url: Optional[str] = None
    mobile_number: Optional[str] = None
    notifier_id: Optional[str] = None
    ops_genie_api_key: Optional[str] = None
    ops_genie_region: Optional[str] = None
    roles: Optional[List[str]] = None
    service_key: Optional[str] = None
    sms_enabled: Optional[bool] = None
    team_id: Optional[str] = None
    team_name: Optional[str] = None
    type_name: Optional[str] = None
    username: Optional[str] = None
    victor_ops_api_key: Optional[str] = None
    victor_ops_routing_key: Optional[str] = None
    webhook_secret: Optional[str] = None
    webhook_url: Optional[str] = None


@dataclass
class ThresholdConfig:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = set()
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = set()
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = set()
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    operator: Optional[str] = None
    threshold: Optional[float] = None
    units: Optional[str] = None


@dataclass
class Resource:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = {"matcher", "metric_threshold_config", "notification", "threshold_config"}
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"matcher", "metric_threshold_config", "notification", "threshold_config"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"event_type", "project_id"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {"alert_configuration_id", "created", "updated"}
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    alert_configuration_id: Optional[str] = None
    created: Optional[str] = None
    enabled: Optional[bool] = None
    event_type: Optional[str] = None
    project_id: Optional[str] = None
    updated: Optional[str] = None
    matcher: Optional[List[Matcher]] = None
    metric_threshold_config: Optional[List[MetricThresholdConfig]] = None
    notification: Optional[List[Notification]] = None
    threshold_config: Optional[List[ThresholdConfig]] = None

    def __post_init__(self):
        if self.matcher is not None:
            self.matcher = [x if isinstance(x, Matcher) else Matcher(**x) for x in self.matcher]
        if self.metric_threshold_config is not None:
            self.metric_threshold_config = [
                x if isinstance(x, MetricThresholdConfig) else MetricThresholdConfig(**x)
                for x in self.metric_threshold_config
            ]
        if self.notification is not None:
            self.notification = [x if isinstance(x, Notification) else Notification(**x) for x in self.notification]
        if self.threshold_config is not None:
            self.threshold_config = [
                x if isinstance(x, ThresholdConfig) else ThresholdConfig(**x) for x in self.threshold_config
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
