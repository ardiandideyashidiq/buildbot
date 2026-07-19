#!/usr/bin/env bash
source "${BASH_SOURCE[0]%/*}/common.sh"

GAPPS_NATIVE_RE="axion|evolution|derpfest|matrixx|bliss|avium|alphadroid|pixelos|clover|halcyon|infinity|mist|lumine|genesis"

rom_has_gapps() { [[ "$1" =~ ^($GAPPS_NATIVE_RE)$ ]]; }

inject_gapps() {
  local rom="$1" root; root=$(rom_root "$rom")
  rom_has_gapps "$rom" && { ok "$rom ships GApps natively -- skip"; return 0; }
  local gapps_dir="$root/vendor/gapps"
  if [[ ! -d "$gapps_dir" ]]; then
    git clone https://gitlab.com/MindTheGapps/vendor_gapps -b baklava --depth 1 "$gapps_dir" || {
      err "MindTheGapps clone failed"; return 1; }
  fi
  local mk
  for mk in lineage_${DEVICE}.mk ${rom}_${DEVICE}.mk; do
    local f="$root/$DEVICE_TREE/$mk"
    [[ -f "$f" ]] || continue
    grep -qF "arm64-vendor.mk" "$f" || \
      echo '$(call inherit-product-if-exists, vendor/gapps/arm64/arm64-vendor.mk)' >> "$f"
    ok "GApps inherit line appended to $mk"
    return 0
  done
  warn "no device .mk found to append GApps -- create one manually"
}
