#!/usr/bin/env bash
source "${BASH_SOURCE[0]%/*}/common.sh"

TREE_EDIT_ROMS="lumine|voltage|alphadroid|matrixx|bliss|avium|mist|pixelos|genesis|clover|halcyon|infinity"

adapt_tree() {
  local rom="$1" root; root=$(rom_root "$rom")
  local dt="$root/$DEVICE_TREE"
  [[ -d "$dt" ]] || return 1
  local romlc; romlc=$(echo "$rom" | tr '[:upper:]' '[:lower:]')

  if [[ -f "$dt/lineage_${DEVICE}.mk" && "$rom" =~ ^($TREE_EDIT_ROMS)$ ]]; then
    git -C "$dt" mv "lineage_${DEVICE}.mk" "${romlc}_${DEVICE}.mk" 2>/dev/null || \
      mv "$dt/lineage_${DEVICE}.mk" "$dt/${romlc}_${DEVICE}.mk"
    sed -i "s|lineage_${DEVICE}|${romlc}_${DEVICE}|g" "$dt/AndroidProducts.mk" 2>/dev/null || true
    ok "renamed lineage_${DEVICE}.mk -> ${romlc}_${DEVICE}.mk"
  fi

  if [[ -d "$root/vendor/${romlc}/config" ]]; then
    local mk
    for mk in "$dt"/*.mk; do
      [[ -f "$mk" ]] || continue
      sed -i "s|vendor/lineage/config|vendor/${romlc}/config|g" "$mk"
    done
    ok "rewrote vendor/lineage/config -> vendor/${romlc}/config"
  fi
}
