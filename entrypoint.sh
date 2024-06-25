#!/bin/bash
set -euo pipefail

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

echo "Running Qodana with args:" "${args[@]}"

exec qodana.orig "${args[@]}"
