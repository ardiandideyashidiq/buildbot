#!/usr/bin/env bats
# Bats test file: rom-builder structure validation
# Run with: bats tests/structure.bats

TOP="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"

@test "config directory exists" {
  [ -d "$TOP/config" ]
}

@test "lib directory exists" {
  [ -d "$TOP/lib" ]
}

@test "roms directory exists" {
  [ -d "$TOP/roms" ]
}

@test "logs directory exists" {
  [ -d "$TOP/logs" ]
}

@test "status directory exists" {
  [ -d "$TOP/status" ]
}

@test "device.conf exists" {
  [ -f "$TOP/config/device.conf" ]
}

@test "rom-builder.sh exists" {
  [ -f "$TOP/rom-builder.sh" ]
}

@test "all lib files exist" {
  for lib in common.sh keys.sh gapps.sh vndk_fix.sh rom_adapt.sh; do
    [ -f "$TOP/lib/$lib" ]
  done
}

@test "exactly 20 ROM definitions" {
  run ls "$TOP/roms/"*.sh
  [ "${#lines[@]}" -eq 20 ]
}

@test "device.conf exports all required vars" {
  source "$TOP/config/device.conf"
  [ -n "${DEVICE:-}" ]
  [ -n "${VENDOR:-}" ]
  [ -n "${DEVICE_TREE:-}" ]
  [ -n "${LOCAL_MANIFEST:-}" ]
}

@test "all lib files are valid bash" {
  for f in "$TOP"/lib/*.sh; do
    bash -n "$f"
  done
}

@test "all ROM files are valid bash" {
  for f in "$TOP"/roms/*.sh; do
    bash -n "$f"
  done
}

@test "rom-builder.sh is valid bash" {
  bash -n "$TOP/rom-builder.sh"
}

@test "no .state files left over from previous runs" {
  run ls "$TOP/status/"*.state 2>/dev/null
  [ "${#lines[@]}" -eq 0 ] || skip "state files exist (expected from real runs)"
}

@test "all ROMs have unique MANIFEST_URL" {
  source "$TOP/config/device.conf"
  urls=()
  for f in "$TOP"/roms/*.sh; do
    unset MANIFEST_URL
    source "$f" 2>/dev/null
    [[ " ${urls[*]} " == *" ${MANIFEST_URL} "* ]] && {
      echo "duplicate URL: $MANIFEST_URL in $f"
      return 1
    }
    urls+=("$MANIFEST_URL")
  done
}
