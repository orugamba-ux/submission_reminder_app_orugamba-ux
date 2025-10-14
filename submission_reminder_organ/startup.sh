#!/usr/bin/env bash
set -euo pipefail
ROOTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
find "$ROOTDIR" -type f -name "*.sh" -exec chmod +x {} \;
echo "Running reminder application..."
"$ROOTDIR/scripts/reminder.sh"
