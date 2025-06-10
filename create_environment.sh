#!/bin/bash

# Prompting the user for their name
read -rp "Enter your name: " user_name

# If the input is empty the shell will exit
if [[ -z "$user_name" ]]; then
  echo "Error: You must enter a name."
  exit 1
fi

# Storing the project directory in a variable for later use
main_dir="./submission_reminder_${user_name}"

# Create the main directory and its subdirectories
mkdir -p "$main_dir"/{app,modules,assets,config} || {
  echo "Failed to create directories under $main_dir"
  exit 1
}
echo "Created directory structure under $main_dir"

# Write config.env with initial assignment data
cat > "$main_dir/config/config.env" << EOF
# Configuration file for submission reminder
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF
echo "Created $main_dir/config/config.env"

# Populate submissions.txt with sample and additional students
cat > "$main_dir/assets/submissions.txt" << EOF
student,assignment,submission status
Chinemerem,Shell Navigation,not submitted
Chiagoziem,Git,submitted
Divine,Shell Navigation,not submitted
Anissa,Shell Basics,submitted
Noel Obadiah,Shell Navigation,not submitted
Nuni Omot,Git,submitted
Chasson Randle,Shell Navigation,not submitted
Aliou Dialla,Shell Basics,not submitted
James Maye Junior,Shell Navigation,not submitted
EOF
echo "Created $main_dir/assets/submissions.txt with student records"

# Create the functions.sh script to check submissions
cat > "$main_dir/modules/functions.sh" << 'EOF'
#!/bin/bash

check_submissions() {
  local submissions_file="$1"
  echo "Checking submission status from $submissions_file"

  tail -n +2 "$submissions_file" | while IFS=, read -r student assignment status; do
    student=$(echo "$student" | xargs)
    assignment=$(echo "$assignment" | xargs)
    status=$(echo "$status" | xargs)

    if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
      echo "Reminder: $student has not submitted the $ASSIGNMENT assignment."
    fi
  done
}
EOF
echo "Created $main_dir/modules/functions.sh"

# Create reminder.sh that uses the config and functions
cat > "$main_dir/app/reminder.sh" << 'EOF'
#!/bin/bash

source ../config/config.env
source ../modules/functions.sh

submissions_file="../assets/submissions.txt"

echo "Assignment: $ASSIGNMENT"
echo "Days left to submit: $DAYS_REMAINING"
echo "-------------------------"

check_submissions "$submissions_file"
EOF
echo "Created $main_dir/app/reminder.sh"

# Create startup.sh to run the reminder app
cat > "$main_dir/startup.sh" << 'EOF'
#!/bin/bash

echo "Launching Submission Reminder App..."

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
parent_dir=$(basename "$(dirname "$SCRIPT_DIR")")

if [[ "$parent_dir" == submission_reminder_* ]]; then
  target_dir="$SCRIPT_DIR"
else
  dirs=("$SCRIPT_DIR"/submission_reminder_*)
  if [[ ${#dirs[@]} -eq 1 && -d "${dirs[0]}" ]]; then
    target_dir="${dirs[0]}"
  else
    echo "Error: Cannot locate a unique submission_reminder_* directory."
    exit 1
  fi
fi

if [[ ! -d "$target_dir" ]]; then
  echo "Error: Target directory $target_dir not found."
  exit 1
fi

source "$target_dir/config/config.env"

cd "$target_dir/app" || { echo "Cannot cd to $target_dir/app"; exit 1; }

bash ./reminder.sh || { echo "Failed to execute reminder.sh"; exit 1; }

echo "Submission Reminder App finished."
EOF
echo "Created $main_dir/startup.sh"

# Make all shell scripts executable within the project
find "$main_dir" -type f -name "*.sh" -exec chmod +x {} \;
echo "Set execute permission on all .sh files"

# Optionally run startup.sh to test setup
echo "Running startup.sh to verify setup..."
bash "$main_dir/startup.sh" || {
  echo "Error: startup.sh failed to run."
  exit 1
}
echo "Setup and test completed successfully."
