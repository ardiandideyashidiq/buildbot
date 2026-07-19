#!/usr/bin/env bash
source "${BASH_SOURCE[0]%/*}/common.sh"

# The vndk/ directory provides libbinder-v32 as a prebuilt .so for soong.
# hardware/lineage/compat also provides libbinder-v32 via Android.mk (make).
# If both define the same make-namespace module, the build errors.
# Fix: modify Android.bp to suppress the make-namespace export so only
# the soong definition survives — vendor blobs depend on the soong one.

vndk_fix() {
  local rom="$1" root; root=$(rom_root "$rom")
  local bp="$root/$DEVICE_TREE/vndk/Android.bp"
  [[ -f "$bp" ]] || return 0
  if grep -q "libbinder-v32" "$bp"; then
    warn "patching $DEVICE_TREE/vndk/Android.bp to avoid make-namespace conflict"
    # Comment out the module name soong-side so it doesn't collide with
    # hardware/lineage/compat's make definition. The prebuilt .so stays
    # on disk but soong won't re-export to make.
    local backup; backup="$bp.bak"
    cp "$bp" "$backup"
    sed -i 's/^    name: "libbinder-v32",/    \/\/ name: "libbinder-v32", (disabled — provided by hardware\/lineage\/compat)/' "$bp"
    ok "vndk Android.bp patched"
  fi
}

# Fallback: if the patch above doesn't work, restore original and try
# removing vndk/ entirely. Only call this if patching failed.
vndk_remove() {
  local rom="$1" root; root=$(rom_root "$rom")
  local vndk="$root/$DEVICE_TREE/vndk"
  if [[ -d "$vndk" ]]; then
    warn "removing $DEVICE_TREE/vndk/ entirely as last resort"
    rm -rf "$vndk"
    ok "vndk dir removed entirely"
  fi
}

vndk_fix_if_needed() {
  local rom="$1" log; log=$(rom_log "$rom")
  if grep -q "libbinder-v32 already defined by hardware/lineage/compat" "$log" 2>/dev/null; then
    # Try patching first
    vndk_fix "$rom"
    return 0
  fi
  return 1
}
