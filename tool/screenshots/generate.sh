#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repository_root="$(cd "$script_dir/../.." && pwd)"
mode="${1:-all}"

case "$mode" in
  all | --raw-only | --process-only) ;;
  *)
    echo "Usage: $0 [--raw-only|--process-only]" >&2
    exit 2
    ;;
esac

cd "$repository_root"

if [[ "$mode" != "--process-only" ]]; then
  flutter test \
    --reporter=compact \
    --dart-define=STOPCORN_SCREENSHOTS=true \
    test/screenshots_test.dart
fi

if [[ "$mode" != "--raw-only" ]]; then
  dart run tool/screenshots/process.dart
fi
