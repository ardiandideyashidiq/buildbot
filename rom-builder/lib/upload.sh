#!/usr/bin/env bash
source "${BASH_SOURCE[0]%/*}/common.sh"

GOFILE_API="https://api.gofile.io"

upload_to_gofile() {
  local rom="$1" zip_path="$2"
  [[ ! -f "$zip_path" ]] && { err "ZIP not found: $zip_path"; return 1; }

  local server
  server=$(curl -s "$GOFILE_API/servers" | python3 -c \
    "import sys,json; print(json.load(sys.stdin)['data']['servers'][0]['name'])" 2>/dev/null)
  [[ -z "$server" ]] && { err "failed to get gofile server"; return 1; }

  local curl_args=(-s -X POST "https://${server}.gofile.io/contents/uploadfile" -F "file=@$zip_path")
  [[ -n "${GOFILE_TOKEN:-}" ]] && curl_args+=(-b "accountToken=$GOFILE_TOKEN")

  log "uploading $rom to $server ..."
  local result
  result=$(curl "${curl_args[@]}")

  local status
  status=$(echo "$result" | python3 -c \
    "import sys,json; print(json.load(sys.stdin)['status'])" 2>/dev/null)
  if [[ "$status" != "ok" ]]; then
    err "gofile upload failed: $result"
    return 1
  fi

  local url
  url=$(echo "$result" | python3 -c \
    "import sys,json; print(json.load(sys.stdin)['data']['downloadPage'])" 2>/dev/null)
  echo "$url" > "$STATUSDIR/$rom.url"
  ok "$rom uploaded: $url"
}
