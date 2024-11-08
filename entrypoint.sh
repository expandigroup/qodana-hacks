#!/bin/bash
set -euo pipefail

echo "Subproject dir: ${SUBPROJECT_DIR:-}"

if [[ -n "${SUBPROJECT_DIR:-}" ]]; then
  if [[ ! -d "$SUBPROJECT_DIR" ]]; then
    echo "Error: SUBPROJECT_DIR does not exist: $SUBPROJECT_DIR"
    exit 1
  fi

  args=("--project-dir" "$SUBPROJECT_DIR")

  while [[ $# -gt 0 ]]; do
    case "$1" in
    --project-dir | -i)
      shift 2
      ;;
    --project-dir=*)
      shift
      ;;
    *)
      args+=("$1")
      shift
      ;;
    esac
  done
else
  args=("$@")
fi

# Make sure Qodana prefers the virtualenv Python
if [[ "${LINTER:-}" == "python" ]]; then
  VENV_BIN_DIR="/data/project/${SUBPROJECT_DIR:-}/.venv/bin"
  echo "Adding virtualenv directory to PATH: $VENV_BIN_DIR"
  export PATH="$VENV_BIN_DIR:$PATH"
fi

echo "Running Qodana with args:" "${args[@]}"

exec qodana.orig "${args[@]}"
