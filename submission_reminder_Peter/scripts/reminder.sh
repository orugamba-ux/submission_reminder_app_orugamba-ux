#!/usr/bin/env bash
# Reminder logic
echo "Students who have not submitted $ASSIGNMENT:"
bash "$APP_DIR/scripts/functions.sh"
list_pending_students
