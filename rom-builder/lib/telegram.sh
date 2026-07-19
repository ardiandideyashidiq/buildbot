#!/usr/bin/env bash
source "${BASH_SOURCE[0]%/*}/common.sh"

send_tg_notification() {
  local rom="$1" status="$2" url="$3" errors="$4" duration="$5" zip_path="$6"
  [[ -z "${TG_BOT_TOKEN:-}" || -z "${TG_CHAT_ID:-}" ]] && return 0

  local emoji; [[ "$status" == "BUILT" ]] && emoji="✅" || emoji="❌"
  local zip_name="-" zip_size=""
  if [[ -n "$zip_path" && -f "$zip_path" ]]; then
    zip_name=$(basename "$zip_path")
    zip_size=$(stat -c%s "$zip_path" 2>/dev/null | numfmt --to=iec 2>/dev/null || echo "-")
  fi

  local msg
  msg="$emoji <b>$rom</b> $status"$'\n'
  msg+="📱 $CODENAME ($DEVICE)"$'\n'
  [[ "$zip_name" != "-" ]] && msg+="📦 $zip_name ($zip_size)"$'\n'
  [[ -n "$url" ]] && msg+="🔗 $url"$'\n'
  [[ -n "$duration" ]] && msg+="🕐 ${duration}s"$'\n'
  [[ -n "$errors" ]] && msg+=$'\n'"<code>$errors</code>"

  local result
  result=$(curl -s -X POST "https://api.telegram.org/bot${TG_BOT_TOKEN}/sendMessage" \
    -d "chat_id=$TG_CHAT_ID" \
    -d "parse_mode=HTML" \
    -d "text=$msg" 2>&1)

  local ok; ok=$(echo "$result" | python3 -c \
    "import sys,json; print(json.load(sys.stdin)['ok'])" 2>/dev/null)
  if [[ "$ok" != "True" ]]; then
    warn "tg notification failed: $(echo "$result" | python3 -c \
      "import sys,json; print(json.load(sys.stdin).get('description','unknown'))" 2>/dev/null)"
  fi
}
