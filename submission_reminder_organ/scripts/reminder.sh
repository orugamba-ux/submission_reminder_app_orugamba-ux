#!/usr/bin/env bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOTDIR="$(cd "$SCRIPT_DIR/.." && pwd)"
source "$ROOTDIR/scripts/functions.sh" || { echo "Missing functions"; exit 1; }
load_config || { echo "Failed to load config"; exit 1; }
DATA_FILE="$ROOTDIR/data/submissions.txt"
if [[ ! -f "$DATA_FILE" ]]; then
  echo "Data file not found: $DATA_FILE" >&2
  exit 1
fi
ASSIGN="${ASSIGNMENT:-}"
if [[ -z "$ASSIGN" ]]; then
  echo "ASSIGNMENT not set" >&2
  exit 1
fi
echo "Checking students who have NOT submitted: '$ASSIGN'"
count_pending=0
while IFS= read -r line || [[ -n "$line" ]]; do
  [[ -z "$line" ]] && continue
  [[ "$line" =~ ^# ]] && continue
  student_id="$(csv_field "$line" 1)"
  student_name="$(csv_field "$line" 2)"
  student_email="$(csv_field "$line" 3)"
  assignment="$(csv_field "$line" 4)"
  status="$(csv_field "$line" 5 | tr '[:upper:]' '[:lower:]')"
  if [[ "$assignment" == "$ASSIGN" ]]; then
    if [[ "$status" != "submitted" ]]; then
      printf "ID:%s  Name:%s  Email:%s  Status:%s\n" "$student_id" "$student_name" "$student_email" "$status"
      count_pending=$((count_pending + 1))
    fi
  fi
done < "$DATA_FILE"
if [[ "$count_pending" -eq 0 ]]; then
  echo "All students have submitted '$ASSIGN'."
else
  echo "Total pending/not-submitted for '$ASSIGN': $count_pending"
fi
