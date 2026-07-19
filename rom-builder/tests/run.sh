#!/usr/bin/env bash
set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TOP="$HERE/.."
PASS=0; FAIL=0

pass() { echo -e "  \e[32m✓ PASS\e[0m $1"; ((PASS = PASS + 1)) || true; }
fail() { echo -e "  \e[31m✗ FAIL\e[0m $1"; ((FAIL = FAIL + 1)) || true; }

echo "=== rom-builder test suite ==="
echo

# 1. shellcheck
echo "--- shellcheck ---"
if command -v shellcheck &>/dev/null; then
  for f in "$TOP"/rom-builder.sh "$TOP"/lib/*.sh "$TOP"/roms/*.sh; do
    shellcheck -x "$f" && pass "shellcheck $f" || fail "shellcheck $f"
  done
else
  echo "  (skipped - shellcheck not installed)"
fi
echo

# 2. bash syntax
echo "--- bash syntax ---"
for f in "$TOP"/rom-builder.sh "$TOP"/config/*.conf "$TOP"/lib/*.sh "$TOP"/roms/*.sh; do
  [[ "$f" == *.sh || "$f" == *.conf ]] || continue
  bash -n "$f" 2>/dev/null && pass "syntax $f" || fail "syntax $f"
done
echo

# 3. directory structure
echo "--- directory structure ---"
for d in config lib roms logs status; do
  [[ -d "$TOP/$d" ]] && pass "dir $d" || fail "dir $d"
done
echo

# 4. ROM definition completeness
echo "--- ROM definition completeness ---"
source "$TOP"/config/device.conf
source "$TOP"/lib/common.sh
for f in "$TOP"/roms/*.sh; do
  rom=$(basename "$f" .sh)
  unset ROM_NAME MANIFEST_URL MANIFEST_BRANCH LUNCH_CMD BUILD_CMD HAS_GAPPS NEEDS_TREE_EDIT
  BUILD_CMD="" MANIFEST_URL="" MANIFEST_BRANCH="" LUNCH_CMD="" HAS_GAPPS="" NEEDS_TREE_EDIT=""
  ok=0
  source "$f" 2>/dev/null || { fail "$rom source failed"; continue; }
  [[ -z "${ROM_NAME:-}" ]]       && { fail "$rom: ROM_NAME not set"; ok=1; }
  [[ -z "${MANIFEST_URL:-}" ]]   && { fail "$rom: MANIFEST_URL not set"; ok=1; }
  [[ -z "${MANIFEST_BRANCH:-}" ]] && { fail "$rom: MANIFEST_BRANCH not set"; ok=1; }
  [[ -z "${LUNCH_CMD:-}" ]]      && { fail "$rom: LUNCH_CMD not set"; ok=1; }
  [[ -z "${BUILD_CMD:-}" ]]      && { fail "$rom: BUILD_CMD not set"; ok=1; }
  HAS_GAPPS=${HAS_GAPPS:-}
  NEEDS_TREE_EDIT=${NEEDS_TREE_EDIT:-}
  case "$HAS_GAPPS" in 0|1) ;; *) fail "$rom: HAS_GAPPS not 0 or 1"; ok=1;; esac
  case "$NEEDS_TREE_EDIT" in 0|1) ;; *) fail "$rom: NEEDS_TREE_EDIT not 0 or 1"; ok=1;; esac
  [[ "$ok" == 0 ]] && pass "$rom definition complete"
done
echo

# 5. load test (verify each library sources cleanly)
echo "--- full load test ---"
failed=0
for lib in config/device.conf lib/common.sh lib/keys.sh lib/gapps.sh lib/telegram.sh lib/upload.sh lib/vndk_fix.sh lib/rom_adapt.sh; do
  bash -c "TOP='$TOP'; HERE=\"\$TOP\"; source \"\$TOP/$lib\"" 2>/dev/null && pass "sources $lib" || { fail "sources $lib"; ((failed++)); }
done
[[ $failed -eq 0 ]] && ok "all libraries source cleanly"
echo

# 6. count ROM files
echo "--- ROM count ---"
rom_count=$(ls -1 "$TOP"/roms/*.sh 2>/dev/null | wc -l)
[[ "$rom_count" -eq 20 ]] && pass "20 ROM files (found $rom_count)" || fail "expected 20 ROM files, found $rom_count"
echo

echo "=== results: $PASS passed, $FAIL failed ==="
exit $FAIL
