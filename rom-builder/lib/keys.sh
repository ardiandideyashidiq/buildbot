#!/usr/bin/env bash
source "${BASH_SOURCE[0]%/*}/common.sh"

setup_keys() {
  local rom="$1" root; root=$(rom_root "$rom")
  if [[ "$ENABLE_SIGNING" != "1" ]]; then
    warn "signing disabled (ENABLE_SIGNING=0) -- skipping key setup for $rom"
    return 0
  fi
  warn "signing path not implemented this session"
}
