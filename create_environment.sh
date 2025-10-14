#!/usr/bin/env bash

# Prompt for user name
read -p "Enter your name: " USER_NAME

# Create main directory
APP_DIR="submission_reminder_$USER_NAME"
mkdir -p "$APP_DIR"

# Create subdirectories
mkdir -p "$APP_DIR/config"
mkdir -p "$APP_DIR/data"
mkdir -p "$APP_DIR/scripts"
mkdir -p "$APP_DIR/assets"

# Create config.env
cat > "$APP_DIR/config/config.env" <<'EOF'
ASSIGNMENT=Assignment 1
EOF

# Create submissions.txt with 5 sample students + 5 more
cat > "$APP_DIR/data/submissions.txt" <<'EOF'
John Doe,submitted
Jane Smith,not submitted
Alice Johnson,submitted
Bob Brown,not submitted
Charlie White,submitted
David Black,not submitted
Eve Green,submitted
Frank Blue,not submitted
Grace Red,submitted
Hank Yellow,not submitted
EOF

# Create functions.sh
cat > "$APP_DIR/scripts/functions.sh" <<'EOF'
#!/usr/bin/env bash
# Function to list students who have not submitted
list_pending_students() {
  while IFS=, read -r name status; do
    if [[ "$status" == "not submitted" ]]; then
      echo "$name"
    fi
  done < "$APP_DIR/data/submissions.txt"
}
EOF

# Create reminder.sh
cat > "$APP_DIR/scripts/reminder.sh" <<'EOF'
#!/usr/bin/env bash
# Reminder logic
echo "Students who have not submitted $ASSIGNMENT:"
bash "$APP_DIR/scripts/functions.sh"
list_pending_students
EOF

# Create startup.sh
cat > "$APP_DIR/startup.sh" <<'EOF'
#!/usr/bin/env bash
# Load config
source config/config.env
# Run the reminder
bash scripts/reminder.sh
EOF

# Touch an image placeholder
touch "$APP_DIR/assets/image.png"

# Make all scripts executable
chmod +x "$APP_DIR/scripts/"*.sh
chmod +x "$APP_DIR/startup.sh"

echo "Environment created successfully in $APP_DIR"

