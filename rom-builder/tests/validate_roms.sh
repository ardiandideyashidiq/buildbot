#!/usr/bin/env bash
# Standalone ROM definition validator
# Usage: ./validate_roms.sh [rom_name]
#   Without args, validates all ROMs.
#   With a rom name, validates only that one.

set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TOP="$HERE/.."

source "$TOP/config/device.conf"
source "$TOP/lib/common.sh"

validate_one() {
  local f="$1"
  local rom; rom=$(basename "$f" .sh)
  local errors=0

  unset ROM_NAME MANIFEST_URL MANIFEST_BRANCH LUNCH_CMD BUILD_CMD HAS_GAPPS NEEDS_TREE_EDIT MK_FLAGS PROP_FLAGS

  source "$f" 2>/dev/null || { echo "$rom: FAILED to source"; return 1; }

  [[ -n "${ROM_NAME:-}" ]]       || { echo "$rom: ROM_NAME not set"; ((errors++)); }
  [[ -n "${MANIFEST_URL:-}" ]]   || { echo "$rom: MANIFEST_URL not set"; ((errors++)); }
  [[ -n "${MANIFEST_BRANCH:-}" ]] || { echo "$rom: MANIFEST_BRANCH not set"; ((errors++)); }
  [[ -n "${LUNCH_CMD:-}" ]]      || { echo "$rom: LUNCH_CMD not set"; ((errors++)); }
  [[ -n "${BUILD_CMD:-}" ]]      || { echo "$rom: BUILD_CMD not set"; ((errors++)); }

  case "${HAS_GAPPS:-}" in 0|1) ;; *) echo "$rom: HAS_GAPPS=$HAS_GAPPS (expected 0/1)"; ((errors++));; esac
  case "${NEEDS_TREE_EDIT:-}" in 0|1) ;; *) echo "$rom: NEEDS_TREE_EDIT=$NEEDS_TREE_EDIT (expected 0/1)"; ((errors++));; esac

  # Verify build_<rom> function exists
  LC_ALL=C type "build_${rom}" 2>/dev/null | grep -q "function" || {
    echo "$rom: build_${rom}() function not defined"; ((errors++)); }

  # Verify source URLs look reasonable
  [[ "$MANIFEST_URL" =~ ^https?://github.com/ ]] || {
    echo "$rom: MANIFEST_URL doesn't look like a GitHub URL"; ((errors++)); }

  if [[ "$errors" -eq 0 ]]; then
    echo "$rom: valid"
    return 0
  else
    echo "$rom: $errors error(s)"
    return 1
  fi
}

if [[ $# -ge 1 ]]; then
  validate_one "$TOP/roms/$1.sh"
else
  failed=0
  for f in "$TOP"/roms/*.sh; do
    validate_one "$f" || ((failed++))
  done
  echo "---"
  [[ "$failed" -eq 0 ]] && echo "All ROMs valid" || echo "$failed ROM(s) invalid"
  exit $failed
fi
