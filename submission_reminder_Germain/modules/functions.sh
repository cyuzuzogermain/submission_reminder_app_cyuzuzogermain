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
