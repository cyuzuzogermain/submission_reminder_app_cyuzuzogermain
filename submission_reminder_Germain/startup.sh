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
