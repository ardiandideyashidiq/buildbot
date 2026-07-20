#!/usr/bin/env bash
set -uo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$HERE/config/device.conf"
source "$HERE/lib/common.sh"

ROMS=(lineage axion evolution derpfest lumine voltage alphadroid matrixx \
      lunaris bliss avium mist pixelos genesis clover yaap halcyon \
      infinity crdroid superior)

load_rom() { source "$HERE/roms/$1.sh"; }

usage() {
  cat <<EOF
rom-builder -- build custom ROMs for $DEVICE ($CODENAME)
  build <rom>          full pipeline: sync -> gapps -> tree -> build + upload
  build-all            sequential build of every ROM (one at a time)
  skip   <rom>         mark ROM as skipped (no build possible)
  upload <rom>         re-upload last built ZIP to gofile
  status               show state of every ROM
  urls                 show download URLs for all ROMs
  logs   <rom>         tail + grep actionable lines from last build
  list                 list registered ROMs
  help                 this message
EOF
}

clean_prev_source() {
  local rom="$1"
  if [[ -f "$HERE/.last_rom" ]]; then
    local prev; prev=$(cat "$HERE/.last_rom")
    if [[ "$prev" != "$rom" && -d "$(rom_root "$prev")" ]]; then
      warn "cleaning previous source: $prev"
      rm -rf "$(rom_root "$prev")"
    fi
  fi
  echo "$rom" > "$HERE/.last_rom"
}

cmd_build() {
  local rom="$1"
  clean_prev_source "$rom"
  load_rom "$rom"
  "build_${rom}" "$rom" || { err "$rom FAILED"; return 1; }
}

cmd_build_all() {
  local failed=() built=()
  for r in "${ROMS[@]}"; do
    log "=== building $r ==="
    if cmd_build "$r"; then built+=("$r"); else failed+=("$r"); fi
  done
  ok "BUILT: ${built[*]:-none}"
  [[ ${#failed[@]} -gt 0 ]] && err "FAILED: ${failed[*]}"
  rm -f "$HERE/.last_rom"
}

cmd_status() {
  printf "%-12s %-8s %s\n" "ROM" "STATE" "URL"
  for r in "${ROMS[@]}"; do
    local s; s=$(get_state "$r")
    local u; u=$(cat "$STATUSDIR/$r.url" 2>/dev/null || echo "-")
    printf "%-12s %-8s %s\n" "$r" "$s" "$u"
  done
}

cmd_upload() {
  local rom="$1" root zip; root=$(rom_root "$rom")
  zip=$(ls "$root/out/target/product/$DEVICE/"*.zip 2>/dev/null | head -1)
  [[ -z "$zip" ]] && { err "no built ZIP found for $rom"; return 1; }
  source "$HERE/lib/upload.sh"
  upload_to_gofile "$rom" "$zip"
}

cmd_skip() {
  local rom="$1"
  clean_prev_source "$rom"
  set_state "$rom" "SKIPPED"
  local track="$HERE/BUILD_TRACKING.md"
  printf "| %s | %s | SKIPPED | - | - | - | %s |\n" "$(date +%Y-%m-%d)" "$rom" "unbuildable - ROM source edit required" >> "$track"
  warn "$rom marked SKIPPED"
}

cmd_logs() { scan_log "$1"; }

[[ $# -lt 1 ]] && { usage; exit 1; }
case "$1" in
  build)      cmd_build "$2" ;;
  build-all)  cmd_build_all ;;
  skip)       cmd_skip "$2" ;;
  upload)     cmd_upload "$2" ;;
  status)     cmd_status ;;
  urls)       for f in "$STATUSDIR"/*.url; do echo "$(basename "$f" .url): $(cat "$f")"; done ;;
  logs)       cmd_logs "$2" ;;
  list)       printf '%s\n' "${ROMS[@]}" ;;
  help|*)     usage ;;
esac
