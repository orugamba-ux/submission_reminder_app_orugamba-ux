#!/usr/bin/env bash

# Prompt the user for the app folder
read -p "Enter the app folder name (e.g., submission_reminder_john): " APP_FOLDER

# Check if the folder exists
if [ ! -d "$APP_FOLDER" ]; then
  echo "Folder $APP_FOLDER does not exist!"
  exit 1
fi

# Path to config file
CONFIG_FILE="$APP_FOLDER/config/config.env"

# Check if config.env exists
if [ ! -f "$CONFIG_FILE" ]; then
  echo "Config file not found in $APP_FOLDER/config/"
  exit 1
fi

# Prompt for new assignment name
read -p "Enter the new assignment name: " NEW_ASSIGNMENT

# Update ASSIGNMENT line in config.env
sed -i "s/^ASSIGNMENT=.*/ASSIGNMENT=$NEW_ASSIGNMENT/" "$CONFIG_FILE"

echo "Assignment updated to '$NEW_ASSIGNMENT' in $CONFIG_FILE"
echo "You can now run the app with ./startup.sh inside $APP_FOLDER"

