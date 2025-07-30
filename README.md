# Terraform MongoDB Atlas Modules WIP

**Note**: Use at your own risk! This project is a work in progress and only meant for demo usage. No support is provided.

A comprehensive collection of auto-generated Terraform modules for MongoDB Atlas resources.

## 🚀 Features

- **Auto-Generated**: Modules are automatically generated from provider specifications
- **Type Safety**: Strongly typed variables with comprehensive validation

### Resource Module Variants

- **Single Variable** (`*_single`): Use a single variable `mongodbatlas_{name}` to define the resource
- **Attribute Variables**: Use one variable per attribute `mongodbatlas_{name}.{attribute}` to define the resource

## 📁 Project Structure

```
tf-modules-atlas-wip/
├── resource_modules/mongodbatlas/    # Generated Terraform modules
│   ├── advanced_cluster/             # Attribute-variable variant
│   ├── advanced_cluster_single/      # Single-variable variant
│   ├── project/
│   ├── database_user/
│   └── ... (100+ modules)
├── config/
│   └── mongodbatlas.yaml            # Module generation configuration
├── py_modules/                      # Python tooling modules
├── cache/                          # Build cache (.gitignored)
├── static/                         # Static assets (.gitignored)
├── justfile                        # Automation commands
├── pyproject.toml                  # Python project configuration
└── uv.lock                         # Dependency lock file
```

## 🛠️ Prerequisites

- **uv**: Python package manager for dependency management
- **just**: Command runner for automation tasks
- **Terraform 1.0+**: For using the generated modules
- **tflint**: For linting Terraform code (optional but recommended)

## 📦 Developer Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/EspenAlbert/tf-modules-atlas-wip.git
   cd tf-modules-atlas-wip
   ```

2. **Install Python dependencies**:
   ```bash
   uv sync
   ```

3. **Set up environment variables**:
   ```bash
   code/surf/vim .env
   REPO_PATH_ATLAS_PROVIDER=/YOUR_PATH_TO/code/go/src/github.com/mongodb/terraform-provider-mongodbatlas
   ```

## 🔧 Usage

### Using resource_modules

Each module in `resource_modules/mongodbatlas/` can be used directly in your Terraform configurations:

```hcl
# Example: Using the project_single module
module "mongodb_project" {
  source = "./resource_modules/mongodbatlas/project_single"
  
  mongodbatlas_project = {
    name   = "my-project"
    org_id = var.org_id
    
    teams = [{
      team_id    = var.team_id
      role_names = ["GROUP_OWNER"]
    }]
    
    limits = [{
      name  = "atlas.project.deployment.clusters"
      value = 10
    }]
  }
}
```

## 🔨 Development

### Available Commands

Use `just` to run common tasks:

```bash
# List all available commands
just

# Check environment variables
just check-env-vars

# Generate all resource modules
just resource-modules

# Generate a specific module
just resource-module advanced_cluster

# Run Terraform linting
just tflint

# Run tf-ext commands directly
just tf-ext --help
```

### Module Generation

Modules are auto-generated from the MongoDB Atlas Terraform provider using the `tf-ext` tool:

1. **Configuration**: Edit `config/mongodbatlas.yaml` to customize generation
2. **Generate**: Run `just resource-modules` to regenerate all modules
3. **Validate**: Run `just tflint` to validate generated Terraform code

### Configuration

The `config/mongodbatlas.yaml` file controls module generation:

```yaml
provider_path: mongodb/mongodbatlas
resources:
- name: mongodbatlas_advanced_cluster
  attribute_default_hcl_strings:
    minimum_enabled_tls_protocol: '"TLS1_2"'
    backup_enabled: "true"
  required_variables:
    - project_id
    - name
```

### Development Guidelines

- All modules are auto-generated - modify `config/mongodbatlas.yaml` instead of individual modules
- Follow the existing naming conventions

## 🔗 Related Projects

- [MongoDB Atlas Terraform Provider](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest)
- [atlas-init](../atlas-init) - Core initialization tooling
- [MongoDB Atlas Documentation](https://docs.atlas.mongodb.com/)
