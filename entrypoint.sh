#!/bin/bash
set -euo pipefail

if [[ -n "${SUBPROJECT_DIR:-}" ]]; then
  if [[ ! -d "$SUBPROJECT_DIR" ]]; then
    echo "Error: SUBPROJECT_DIR does not exist: $SUBPROJECT_DIR"
    exit 1
  fi

  declare -a args=()
  while [[ $# -gt 0 ]]; do
    case "$1" in
    --project-dir | -i)
      args+=("--project-dir" "$SUBPROJECT_DIR")
      shift 2
      ;;
    --project-dir=*)
      args+=("--project-dir" "$SUBPROJECT_DIR")
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

echo "Running Qodana with args:" "${args[@]}"

exec qodana.orig "${args[@]}"
