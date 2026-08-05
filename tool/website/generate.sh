#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repository_root="$(cd "$script_dir/../.." && pwd)"
mode="${1:-all}"

case "$mode" in
  all | --process-only) ;;
  *)
    echo "Usage: $0 [--process-only]" >&2
    exit 2
    ;;
esac

screenshots_arguments=()
if [[ "$mode" == "--process-only" ]]; then
  screenshots_arguments+=("--process-only")
fi

"$repository_root/tool/screenshots/generate.sh" "${screenshots_arguments[@]}"
"$repository_root/tool/social/generate.sh"

cd "$repository_root"
dart run tool/website/sync.dart
