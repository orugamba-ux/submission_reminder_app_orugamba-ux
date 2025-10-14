#!/usr/bin/env bash
# Function to list students who have not submitted
list_pending_students() {
  while IFS=, read -r name status; do
    if [[ "$status" == "not submitted" ]]; then
      echo "$name"
    fi
  done < "$APP_DIR/data/submissions.txt"
}
