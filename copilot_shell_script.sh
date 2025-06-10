#!/bin/bash

# Prompt the user for the assignment name
read -rp "Enter the new assignment name: " new_assignment

if [[ -z "$new_assignment" ]]; then
  echo "Error: Assignment name cannot be empty."
  exit 1
fi

# Define the path to config.env
CONFIG_FILE="./config/config.env"

# Check if config.env exists
if [[ ! -f "$CONFIG_FILE" ]]; then
  echo "Error: $CONFIG_FILE not found. Run the setup script first."
  exit 1
fi

# Use sed to replace the ASSIGNMENT value in config.env
# This assumes ASSIGNMENT is on a line like: ASSIGNMENT="oldValue"
sed -i.bak -E "s/^ASSIGNMENT=.*/ASSIGNMENT=\"$new_assignment\"/" "$CONFIG_FILE"

if [[ $? -ne 0 ]]; then
  echo "Error: Failed to update assignment name in $CONFIG_FILE"
  exit 1
fi

echo "Updated assignment name to \"$new_assignment\" in $CONFIG_FILE."

# Remove backup file created by sed (on macOS sed creates .bak, on Linux you may want to adjust)
rm -f "${CONFIG_FILE}.bak"

# Run startup.sh to check for non-submitted students for the new assignment
if [[ ! -x ./startup.sh ]]; then
  echo "Making startup.sh executable..."
  chmod +x ./startup.sh
fi

echo "Running startup.sh..."
./startup.sh || {
  echo "Error: Failed to run startup.sh"
  exit 1
}

echo "Done."


