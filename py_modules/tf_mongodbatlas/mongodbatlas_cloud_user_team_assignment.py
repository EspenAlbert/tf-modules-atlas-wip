# codegen atlas-init-marker-start
import json
import sys
from dataclasses import asdict, dataclass
from typing import Optional, List, Set, ClassVar, Union


@dataclass
class ProjectRoleAssignment:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"project_roles"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = set()
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {"project_id", "project_roles"}
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    project_id: Optional[str] = None
    project_roles: Optional[List[str]] = None


@dataclass
class Role:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"org_roles", "project_role_assignments"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = set()
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {"org_roles", "project_role_assignments"}
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    org_roles: Optional[List[str]] = None
    project_role_assignments: Optional[Set[ProjectRoleAssignment]] = None

    def __post_init__(self):
        if self.project_role_assignments is not None and not isinstance(
            self.project_role_assignments, ProjectRoleAssignment
        ):
            assert isinstance(self.project_role_assignments, dict), (
                f"Expected project_role_assignments to be a ProjectRoleAssignment or a dict, got {type(self.project_role_assignments)}"
            )
            self.project_role_assignments = ProjectRoleAssignment(**self.project_role_assignments)


@dataclass
class Resource:
    BLOCK_ATTRIBUTES: ClassVar[Set[str]] = set()
    NESTED_ATTRIBUTES: ClassVar[Set[str]] = {"roles", "team_ids"}
    REQUIRED_ATTRIBUTES: ClassVar[Set[str]] = {"org_id", "team_id", "user_id"}
    COMPUTED_ONLY_ATTRIBUTES: ClassVar[Set[str]] = {
        "country",
        "created_at",
        "first_name",
        "invitation_created_at",
        "invitation_expires_at",
        "inviter_username",
        "last_auth",
        "last_name",
        "mobile_number",
        "org_membership_status",
        "roles",
        "team_ids",
        "username",
    }
    DEFAULTS_HCL_STRINGS: ClassVar[dict[str, str]] = {}
    country: Optional[str] = None
    created_at: Optional[str] = None
    first_name: Optional[str] = None
    invitation_created_at: Optional[str] = None
    invitation_expires_at: Optional[str] = None
    inviter_username: Optional[str] = None
    last_auth: Optional[str] = None
    last_name: Optional[str] = None
    mobile_number: Optional[str] = None
    org_id: Optional[str] = None
    org_membership_status: Optional[str] = None
    roles: Optional[Role] = None
    team_id: Optional[str] = None
    team_ids: Optional[List[str]] = None
    user_id: Optional[str] = None
    username: Optional[str] = None

    def __post_init__(self):
        if self.roles is not None and not isinstance(self.roles, Role):
            assert isinstance(self.roles, dict), f"Expected roles to be a Role or a dict, got {type(self.roles)}"
            self.roles = Role(**self.roles)


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
