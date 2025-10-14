#!/usr/bin/env bash
load_config() {
  local cfg_file="$ROOTDIR/config/config.env"
  if [[ ! -f "$cfg_file" ]]; then
    return 1
  fi
  source "$cfg_file"
  return 0
}
csv_field() {
  local line="$1"
  local n="$2"
  echo "$line" | awk -F',' -v idx="$n" '{ gsub(/^[[:space:]]+|[[:space:]]+$/, "", $idx); print $idx }'
}
