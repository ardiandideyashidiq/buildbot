#!/usr/bin/env bash
source "${BASH_SOURCE[0]%/*}/common.sh"

TREE_EDIT_ROMS="lumine|voltage|alphadroid|matrixx|bliss|pixelos|genesis|clover|halcyon|infinity|yaap|superior"

adapt_tree() {
  local rom="$1" root; root=$(rom_root "$rom")
  local dt="$root/$DEVICE_TREE"
  [[ -d "$dt" ]] || return 1
  local romlc; romlc=$(echo "$rom" | tr '[:upper:]' '[:lower:]')
  local pref="${ROM_PREFIX:-$romlc}"

  # Restore device tree to pristine state before editing
  git -C "$dt" reset HEAD -- . 2>/dev/null
  git -C "$dt" checkout -- . 2>/dev/null
  git -C "$dt" clean -fd 2>/dev/null

  if [[ -f "$dt/lineage_${DEVICE}.mk" && "$rom" =~ ^($TREE_EDIT_ROMS)$ ]]; then
    git -C "$dt" mv "lineage_${DEVICE}.mk" "${pref}_${DEVICE}.mk" 2>/dev/null || \
      mv "$dt/lineage_${DEVICE}.mk" "$dt/${pref}_${DEVICE}.mk"
    sed -i "s|lineage_${DEVICE}|${pref}_${DEVICE}|g" "$dt/AndroidProducts.mk" 2>/dev/null || true
    ok "renamed lineage_${DEVICE}.mk -> ${pref}_${DEVICE}.mk"
  fi

  # Use pref for vendor path check (some ROMs like alphadroid use alpha not alphadroid)
  local vcheck="$root/vendor/${pref}/config"
  [[ ! -d "$vcheck" && "$pref" != "$romlc" ]] && vcheck="$root/vendor/${romlc}/config"
  if [[ -d "$vcheck" ]]; then
    local vdir; vdir=$(basename "$(dirname "$vcheck")")
    for mk in "$dt"/*.mk "$dt"/BoardConfig.mk; do
      [[ -f "$mk" ]] || continue
      sed -i "s|vendor/lineage/config|vendor/${vdir}/config|g" "$mk"
      sed -i "s|device/lineage/|device/${vdir}/|g" "$mk"
    done
    ok "rewrote vendor/lineage/config -> vendor/${vdir}/config"
  fi

  # Fix sepolicy path in BoardConfig.mk for MediaTek devices
  if [[ -d "$root/device/${romlc}/sepolicy/libperfmgr" && -f "$dt/BoardConfig.mk" ]]; then
    local bc="$dt/BoardConfig.mk"
    if grep -q "device/mediatek/sepolicy_vndr/SEPolicy.mk" "$bc"; then
      sed -i "s|include device/mediatek/sepolicy_vndr/SEPolicy.mk|include device/${romlc}/sepolicy/libperfmgr/sepolicy.mk|" "$bc"
      ok "rewrote sepolicy path in BoardConfig.mk"
    fi
  fi
}
