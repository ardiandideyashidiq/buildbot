#!/usr/bin/env bash
set -uo pipefail

RED='\033[0;31m'; GRN='\033[0;32m'; YLW='\033[1;33m'; CYN='\033[0;36m'; NC='\033[0m'
log()  { printf "${CYN}[$(date +%H:%M:%S)]${NC} $*\n"; }
ok()   { printf "${GRN}[$(date +%H:%M:%S)] OK${NC} $*\n"; }
warn() { printf "${YLW}[$(date +%H:%M:%S)] WARN${NC} $*\n"; }
err()  { printf "${RED}[$(date +%H:%M:%S)] ERR${NC} $*\n"; }

preflight() {
  command -v repo >/dev/null || { err "repo not installed"; return 1; }
  command -v git  >/dev/null || { err "git not installed"; return 1; }
  local ram_kb=$(awk '/MemTotal/{print $2}' /proc/meminfo)
  local ram_gb=$((ram_kb/1024/1024))
  local disk_gb=$(df -BG --output=avail "${WORKDIR:-$HOME}" | tail -1 | tr -dc '0-9')
  [[ $ram_gb  -ge $MIN_RAM_GB  ]] || warn "RAM ${ram_gb}GB < recommended ${MIN_RAM_GB}GB"
  [[ $disk_gb -ge $MIN_DISK_GB ]] || { err "disk ${disk_gb}GB < ${MIN_DISK_GB}GB required"; return 1; }
  ok "preflight: ram=${ram_gb}GB disk=${disk_gb}GB"
}

rom_root() { echo "${WORKDIR}/${1}"; }

LOGDIR="${LOGDIR:-$HERE/logs}"; mkdir -p "$LOGDIR"
STATUSDIR="${STATUSDIR:-$HERE/status}"; mkdir -p "$STATUSDIR"
rom_log()      { echo "$LOGDIR/$1.log"; }
set_state()    { echo "$2" > "$STATUSDIR/$1.state"; }
get_state()    { cat "$STATUSDIR/$1.state" 2>/dev/null || echo "PENDING"; }

inject_local_manifest() {
  local rom="$1" root; root=$(rom_root "$rom")
  mkdir -p "$root/$LOCAL_MANIFEST_DIR"
  [[ -d "$root/$LOCAL_MANIFEST_DIR/.git" ]] && return 0
  git clone "$LOCAL_MANIFEST" "$root/$LOCAL_MANIFEST_DIR" || { err "local_manifest clone failed"; return 1; }
}

do_sync() {
  local rom="$1" root; root=$(rom_root "$rom")
  cd "$root" || return 1
  repo sync -c --force-sync --no-clone-bundle --no-tags 2>&1 | tail -40
  set_state "$rom" "SYNCED"
}

scan_log() {
  local log; log=$(rom_log "$1")
  [[ -f "$log" ]] || return 0
  grep -nE "FAILED:|^error:|error: |Error:|No rule to make target|already defined|No space left|OutOfMemoryError" "$log" | head -25 || true
}

patch_mk() {
  local rom="$1" mkfile="$2"; shift 2
  local root; root=$(rom_root "$rom")
  local f="$root/$DEVICE_TREE/$mkfile"
  if [[ ! -f "$f" ]]; then
    local fallback="$root/$DEVICE_TREE/lineage_${DEVICE}.mk"
    if [[ -f "$fallback" ]]; then
      f="$fallback"
    else
      warn "neither $mkfile nor lineage_${DEVICE}.mk found in device tree"
      return 0
    fi
  fi
  while [[ $# -gt 0 ]]; do
    grep -qF "$1" "$f" || echo "$1" >> "$f"
    shift
  done
}

patch_mk_props() {
  local rom="$1" mkfile="$2"; shift 2
  local root; root=$(rom_root "$rom")
  local f="$root/$DEVICE_TREE/$mkfile"
  if [[ ! -f "$f" ]]; then
    local fallback="$root/$DEVICE_TREE/lineage_${DEVICE}.mk"
    [[ -f "$fallback" ]] && f="$fallback" || { warn ".mk not found for props"; return 0; }
  fi
  grep -qF "PRODUCT_PROPERTY_OVERRIDES" "$f" && return 0
  { echo ""; echo "# Device properties"; echo "PRODUCT_PROPERTY_OVERRIDES += \\"; } >> "$f"
  local i=0 last=$(($# - 1))
  while [[ $# -gt 0 ]]; do
    if [[ $i -lt $last ]]; then
      echo "    $1 \\" >> "$f"
    else
      echo "    $1" >> "$f"
    fi
    ((i++))
    shift
  done
}

build_generic() {
  local rom="$1" root; root=$(rom_root "$rom")
  preflight || return 1
  mkdir -p "$root"; cd "$root" || return 1

  if [[ ! -d "$root/.repo" ]]; then
    repo init --no-repo-verify --no-clone-bundle \
      -u "$MANIFEST_URL" -b "$MANIFEST_BRANCH" \
      ${MANIFEST_GROUPS:+-g "$MANIFEST_GROUPS"} --git-lfs || return 1
  fi
  inject_local_manifest "$rom" || return 1
  do_sync "$rom" || return 1

  local libd; libd="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
  source "$libd/gapps.sh"
  source "$libd/keys.sh"
  source "$libd/vndk_fix.sh"
  source "$libd/rom_adapt.sh"

  local has_gapps="${HAS_GAPPS:-0}" needs_tree="${NEEDS_TREE_EDIT:-0}"
  [[ "$has_gapps" == 0 ]] && inject_gapps "$rom"
  [[ "$needs_tree" == 1 ]] && adapt_tree "$rom"
  setup_keys "$rom"

  local pref="${ROM_PREFIX:-$rom}"
  local mkf=("${MK_FLAGS[@]:-}") ppf=("${PROP_FLAGS[@]:-}")
  [[ ${#mkf[@]} -gt 0 ]] && patch_mk "$rom" "${pref}_${DEVICE}.mk" "${mkf[@]}"
  [[ ${#ppf[@]} -gt 0 ]] && patch_mk_props "$rom" "${pref}_${DEVICE}.mk" "${ppf[@]}"

  set_state "$rom" "BUILDING"
  BUILD_START=$SECONDS

  # Pre-build hook for ROMs needing envsetup-based sync
  if [[ -n "${PRE_BUILD:-}" ]]; then
    log "running pre-build: $PRE_BUILD"
    (set +u; cd "$root" && source build/envsetup.sh && eval "$PRE_BUILD") 2>&1 | tail -10
  fi

  run_build() {
    local rom="$1" l="$2" b="$3"
    (set +u; cd "$root" && source build/envsetup.sh && eval "$l" && eval "$b") 2>&1 | tee -a "$(rom_log "$rom")" | tail -60
    return ${PIPESTATUS[0]}
  }
  run_build "$rom" "$LUNCH_CMD" "$BUILD_CMD"

  if vndk_fix_if_needed "$rom"; then
    warn "vndk fix applied -- running installclean + rebuild"
    BUILD_START=$SECONDS
    (set +u; source build/envsetup.sh && m installclean) 2>&1 | tail -5
    run_build "$rom" "$LUNCH_CMD" "$BUILD_CMD"
  fi

  local duration=$((SECONDS - BUILD_START))
  local tg_url=""

  local track="$HERE/BUILD_TRACKING.md"
  if ls "$root/out/target/product/$DEVICE/"*.zip >/dev/null 2>&1; then
    local zip; zip=$(ls "$root/out/target/product/$DEVICE/"*.zip | head -1)
    ok "$rom built: $zip"
    set_state "$rom" "BUILT"
    if [[ "${ENABLE_UPLOAD:-0}" == 1 && -n "${GOFILE_TOKEN:-}" ]]; then
      source "$HERE/lib/upload.sh"
      upload_to_gofile "$rom" "$zip"
    fi
    tg_url=$(cat "$STATUSDIR/$rom.url" 2>/dev/null || echo "-")
    [[ "${ENABLE_TG_NOTIFY:-0}" == 1 ]] && {
      source "$HERE/lib/telegram.sh"
      send_tg_notification "$rom" "BUILT" "$tg_url" "" "$duration" "$zip"
    }
    printf "| %s | %s | %s | %s | %ss | |\n" "$(date +%Y-%m-%d)" "$rom" "BUILT" "$(basename "$zip")" "$tg_url" "$duration" >> "$track"
  else
    err "$rom build failed -- actionable lines:"
    local errlines; errlines=$(scan_log "$rom" 2>/dev/null | head -5)
    set_state "$rom" "FAILED"
    [[ "${ENABLE_TG_NOTIFY:-0}" == 1 ]] && {
      source "$HERE/lib/telegram.sh"
      send_tg_notification "$rom" "FAILED" "" "$errlines" "$duration" ""
    }
    printf "| %s | %s | FAILED | - | - | %ss | %s |\n" "$(date +%Y-%m-%d)" "$rom" "$duration" "$errlines" >> "$track"
    return 1
  fi
}
