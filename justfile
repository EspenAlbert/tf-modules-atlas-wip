set dotenv-load


default:
    just --list

check-env-vars:
  export STATIC_DIR="{{justfile_directory()}}/static"; \
  export CACHE_DIR="{{justfile_directory()}}/cache"; \
  export REPO_OUT_PATH="{{justfile_directory()}}"; \
  echo "Justfile directory is: {{justfile_directory()}}"; \
  echo "Static directory is: $STATIC_DIR"; \
  echo "Cache directory is: $CACHE_DIR"; \
  mkdir -p $STATIC_DIR; \
  mkdir -p $CACHE_DIR; \
  uv run tf-ext check-env-vars

resource-modules:
  export STATIC_DIR="{{justfile_directory()}}/static"; \
  export CACHE_DIR="{{justfile_directory()}}/cache"; \
  export REPO_OUT_PATH="{{justfile_directory()}}"; \
  uv run tf-ext mod-gen-provider

resource-module name:
  export STATIC_DIR="{{justfile_directory()}}/static"; \
  export CACHE_DIR="{{justfile_directory()}}/cache"; \
  export REPO_OUT_PATH="{{justfile_directory()}}"; \
  uv run tf-ext mod-gen-provider --include-only {{name}}

tflint:
  cd resource_modules && tflint -f compact --recursive --minimum-failure-severity=warning

fmt:
  terraform fmt -recursive ./examples && \
  terraform fmt -recursive ./modules

[positional-arguments]
example-readme *args:
  export STATIC_DIR="{{justfile_directory()}}/static"; \
  export CACHE_DIR="{{justfile_directory()}}/cache"; \
  export REPO_OUT_PATH="{{justfile_directory()}}"; \
  uv run tf-ext example-readme --example-path {{args}}

[positional-arguments]
tf-ext *args:
  uv run tf-ext {{args}}
