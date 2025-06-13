#!/bin/bash

source ../config/config.env
source ../modules/functions.sh

submissions_file="../assets/submissions.txt"

echo "Assignment: $ASSIGNMENT"
echo "Days left to submit: $DAYS_REMAINING"
echo "-------------------------"

check_submissions "$submissions_file"
